Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD746C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7384621904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126602;
	bh=61rSffk413KulKXs8mOpxUB2yvdPmtiHD+K7eidMAd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e5UUONIagcg39M1EcxDDRjBBHiZ9tKjABg8iIhHnUU/hZLPckwId3yTHK4/oR4Cv7
	 o7YuPIt0UNGv44PoQjzioa19fXHcqkxgLz/bmN5RPl+Ud175tnlhOBhgM7GpWzeGTH
	 LJ3CackJUjH7ot3wuNPY5D9UKTvXuBi4ncljiJ9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbfDXRXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389676AbfDXRXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:18 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF8921904;
        Wed, 24 Apr 2019 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126597;
        bh=61rSffk413KulKXs8mOpxUB2yvdPmtiHD+K7eidMAd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0ip8s47HHQlEg6b0pGw0WHQ4QNTdDNReGTgYAbUYUI01EOFfnD8vy9I9zz+1gded
         9suwOJ1mjWnotpvuoqof6Cq7Xrz8CWI/FH8z4+lve7Gv1tW28cTcuUPfviGc05B+Gi
         GyUIP0dlMh6Sgl5/ocBG8YyDxHtZ8jvekLrUXZeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 163/168] mac80211: do not call driver wake_tx_queue op during reconfig
Date:   Wed, 24 Apr 2019 19:10:07 +0200
Message-Id: <20190424170932.945927499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

commit 4856bfd230985e43e84c26473c91028ff0a533bd upstream.

There are several scenarios in which mac80211 can call drv_wake_tx_queue
after ieee80211_restart_hw has been called and has not yet completed.
Driver private structs are considered uninitialized until mac80211 has
uploaded the vifs, stations and keys again, so using private tx queue
data during that time is not safe.

The driver can also not rely on drv_reconfig_complete to figure out when
it is safe to accept drv_wake_tx_queue calls again, because it is only
called after all tx queues are woken again.

To fix this, bail out early in drv_wake_tx_queue if local->in_reconfig
is set.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/driver-ops.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1157,6 +1157,9 @@ static inline void drv_wake_tx_queue(str
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->txq.vif);
 
+	if (local->in_reconfig)
+		return;
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 


