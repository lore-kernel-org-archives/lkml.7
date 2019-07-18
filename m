Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02BAC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0F92053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419134;
	bh=lD9OqQc2mRSNgykSipBy5wuaBor9EoomcHkZdwZRgEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=knIPLGJXgdAigb3PAXsC1FM/1iKPamrtr/kkI7wTACyA/TA3ER35xoLOCLl1IJnDx
	 Y1nBF3nDrW8LgJ3yPU6OPWNxNAtK/+7RPptrD5+BxZewrjpX+/KaqGjlYkN1iVTWku
	 aRRM3h6ZazvlEBEiWWzAAxGgeHCQhp94EUwYRZvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbfGRDFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389964AbfGRDFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:05:30 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2401F2173B;
        Thu, 18 Jul 2019 03:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419129;
        bh=lD9OqQc2mRSNgykSipBy5wuaBor9EoomcHkZdwZRgEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UiwgGKjQ+eUU3L+DlH5oHITla/0+/adkGwQBqE0e/WBvDRLPOwzzDud1f9NhKopzt
         4/lDIkPXntiRfM3ToND96f26mBAag2cJAsHd8IZbJdV911OBfYX0/qIKAcNjWUQZxr
         ksAOpaL0CoucfR3GdU5Tplg3oB1/l8QFhMkKriks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 22/54] ppp: mppe: Add softdep to arc4
Date:   Thu, 18 Jul 2019 12:01:17 +0900
Message-Id: <20190718030055.083166383@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030053.287374640@linuxfoundation.org>
References: <20190718030053.287374640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aad1dcc4f011ea409850e040363dff1e59aa4175 ]

The arc4 crypto is mandatory at ppp_mppe probe time, so let's put a
softdep line, so that the corresponding module gets prepared
gracefully.  Without this, a simple inclusion to initrd via dracut
failed due to the missing dependency, for example.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_mppe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ppp/ppp_mppe.c b/drivers/net/ppp/ppp_mppe.c
index 7ccdc62c6052..06d620b10704 100644
--- a/drivers/net/ppp/ppp_mppe.c
+++ b/drivers/net/ppp/ppp_mppe.c
@@ -63,6 +63,7 @@ MODULE_AUTHOR("Frank Cusack <fcusack@fcusack.com>");
 MODULE_DESCRIPTION("Point-to-Point Protocol Microsoft Point-to-Point Encryption support");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("ppp-compress-" __stringify(CI_MPPE));
+MODULE_SOFTDEP("pre: arc4");
 MODULE_VERSION("1.0.2");
 
 static unsigned int
-- 
2.20.1



