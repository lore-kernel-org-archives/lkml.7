Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFC120665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802962;
	bh=Qv50IEdhAdQ+YPsNhDeNXdQwrntJtPebEZKiD6idsXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W316rv+lJ+LmxXSk0PYnjnojHYe/odQE0girgFTn4u1UdcLa8Ve7wTXI8NviC3upR
	 nKo0lEnlps0aIvRRb218jEPaJtPfZufOzaJkGuSITo7zmaNuihvZpy7qkHIuB42b3f
	 mvQ86L7CLtaoQQ2/lxWUVVuxxSxm/XmhA+lEpDog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbfHNRQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbfHNROw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:14:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 698572084D;
        Wed, 14 Aug 2019 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802891;
        bh=Qv50IEdhAdQ+YPsNhDeNXdQwrntJtPebEZKiD6idsXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rcy94BfTlApXb+Eiu5U19VT/XluvuAC6jwIljZ9gdTlRjt7g8hUVK+HmNztQkwOWH
         RtQN5QqIpODhe8pTRl1l1Qk0J1b05QGBocYco7eElZjLqzdd+vutvRqPo7IX8mlQE3
         olfrIhijxupBgCpl4yBuJ3XMr7snMButmpOYtvuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 66/69] iwlwifi: dont unmap as page memory that was mapped as single
Date:   Wed, 14 Aug 2019 19:02:04 +0200
Message-Id: <20190814165750.465849264@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 87e7e25aee6b59fef740856f4e86d4b60496c9e1 upstream.

In order to remember how to unmap a memory (as single or
as page), we maintain a bit per Transmit Buffer (TBs) in
the meta data (structure iwl_cmd_meta).
We maintain a bitmap: 1 bit per TB.
If the TB is set, we will free the memory as a page.
This bitmap was never cleared. Fix this.

Cc: stable@vger.kernel.org
Fixes: 3cd1980b0cdf ("iwlwifi: pcie: introduce new tfd and tb formats")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -401,6 +401,8 @@ static void iwl_pcie_tfd_unmap(struct iw
 					 DMA_TO_DEVICE);
 	}
 
+	meta->tbs = 0;
+
 	if (trans->cfg->use_tfh) {
 		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
 


