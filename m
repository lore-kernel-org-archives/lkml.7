Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F00EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E5521E73
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MNFKeM71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbfHGNbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:31:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388486AbfHGNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=URr23O+sE34tA6sqCT0tgNJQshCDWMKEuncRKh9WKPY=; b=MNFKeM711p54uteggUKpLg1pWi
        R1gneE4fGrluSEnZpPwduTMdmyK5GPaAH+tiSGzC5U7yDVBEx65rZvazzcmQmfc3PMyw8v/0m3/oN
        EgORCXaI8pkdALWoNPr5d/7VyCyltJEy1k7OtPXwtITeJPCPn56IxYQdKpnWK/NFPEajlQywF8sYE
        8DNj18B6Y1Woaxu+q2ddiKD0UrVdhVsIOd8hW0IcorVQoLEDk//rcK/VM/adVF18oxAB4NlEc6hvY
        QKCbhx4C+7HPMF25HRe2uUFNvTO0CrAIBOAMnE51VzG48u8z6JbxQ0A1SPzfrcP5OVa7bIJqzo1i6
        yX556EXQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvM2L-00087S-K2; Wed, 07 Aug 2019 13:31:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/29] qla2xxx: remove SGI SN2 support
Date:   Wed,  7 Aug 2019 16:30:32 +0300
Message-Id: <20190807133049.20893-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807133049.20893-1-hch@lst.de>
References: <20190807133049.20893-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SGI SN2 support is about to be removed, so drops the bits
specific to it from this driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/qla2xxx/qla_init.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index da83034d4759..d4c3baec9172 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4575,20 +4575,6 @@ qla2x00_nvram_config(scsi_qla_host_t *vha)
 		rval = 1;
 	}
 
-#if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
-	/*
-	 * The SN2 does not provide BIOS emulation which means you can't change
-	 * potentially bogus BIOS settings. Force the use of default settings
-	 * for link rate and frame size.  Hope that the rest of the settings
-	 * are valid.
-	 */
-	if (ia64_platform_is("sn2")) {
-		nv->frame_payload_size = 2048;
-		if (IS_QLA23XX(ha))
-			nv->special_options[1] = BIT_7;
-	}
-#endif
-
 	/* Reset Initialization control block */
 	memset(icb, 0, ha->init_cb_size);
 
-- 
2.20.1

