Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF81C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C97D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140005;
	bh=166qu/xeeVH92fpZznbg53wP6GYMbcSGIFMZQ6XsR5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0S7OZLb63klihiGfykyUrvHBUtrRSo2cEgkZBgUWRcN014PHCMSsAovqZJMbFWr1
	 Bq4tncfumP+VaHQNSWj8L01vkPw0+CEZDF4KuJsWbOOy6ipnP2tMNTWid0hQitP9So
	 7QeYBd0/pexXNyyfjru8AIPHRzENS8AgaGUPleN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfDARdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732780AbfDARdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5A6121473;
        Mon,  1 Apr 2019 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140000;
        bh=166qu/xeeVH92fpZznbg53wP6GYMbcSGIFMZQ6XsR5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrkUvQRDDwxJGW72hJt2SdVqj4RaVEp2csmrCWRb8LlUKBxGAeZJd4DVZninswflS
         XdJmYK6o2GPRYRauMwAkMDlOCe1rbtlhzi+S0buF2pXXoB/orKNebbWWCDnL78hzxv
         XPdSN3w2+SjcTfSCunZ1++6v6ZgOwFni4v5bkmzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: =?UTF-8?q?=5BPATCH=204=2E4=20075/131=5D=20=3D=3FUTF-8=3Fq=3Fmac80211=3A=3D20fix=3D20=22warning=3A=3D20=3DE2=3D80=3D98target=3D5Fmetric=3F=3D=20=3D=3FUTF-8=3Fq=3F=3DE2=3D80=3D99=3D20may=3D20be=3D20used=3D20uninitialized=22=3F=3D?=
Date:   Mon,  1 Apr 2019 19:02:25 +0200
Message-Id: <20190401170058.365659273@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b4201cc4fc6e1c57d6d306b1f787865043d60129 ]

This fixes:

net/mac80211/mesh_hwmp.c:603:26: warning: ‘target_metric’ may be used uninitialized in this function

target_metric is only consumed when reply = true so no bug exists here,
but not all versions of gcc realize it.  Initialize to 0 to remove the
warning.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh_hwmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 33d5271a9e32..466922f09d04 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -530,7 +530,7 @@ static void hwmp_preq_frame_process(struct ieee80211_sub_if_data *sdata,
 	const u8 *target_addr, *orig_addr;
 	const u8 *da;
 	u8 target_flags, ttl, flags;
-	u32 orig_sn, target_sn, lifetime, target_metric;
+	u32 orig_sn, target_sn, lifetime, target_metric = 0;
 	bool reply = false;
 	bool forward = true;
 	bool root_is_gate;
-- 
2.19.1



