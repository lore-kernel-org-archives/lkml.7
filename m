Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A85FC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 08:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A70B24125
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 08:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDb1qrDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfLNIE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 03:04:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45383 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfLNIE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 03:04:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so1175920wrj.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 00:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ydH8nZUeDGS1qMU52WDZSUYSfLRq9xAkK9Otj6+cEY=;
        b=HDb1qrDcEol9+h5bZ8BsThrMRMQgi4qDThTpXn7bi1NmHAxgFXeLe+z36g3y7hWy10
         oliIxanPCsPhvX/POKSq272zI/smwUaNcV6DPgf8ucpLnLJ1MDFhWquN6FHL2Jq7Gcej
         iAqPEif3ViD3RiDUoh6DGMkBMcF935ifyPRkt4ghtanBX/FYEBaEvxH3LqI6yMkJFNCL
         oHXJwjjjqP6lb8h7kwdVcUFyUKF2Eupyimk+Juf6vQJvj4ebbeTmfWlot8xY7vwuC2uM
         elcLKtU3iqJ5lvIl4hbuj/B7thePcFF7yAblqiLR+a5jbAaHjI22KpsJ8J4sWd+DXs28
         jpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ydH8nZUeDGS1qMU52WDZSUYSfLRq9xAkK9Otj6+cEY=;
        b=nUZPGSgVs7twGCAeFjia5k1i4EzXrqCIcpEAXKRK0bWH5A3P+hnaJRiI3jajqyr/qb
         hpSaybAqIepUZdnIoMJ60D9heQkVNkWe+GOk5zbBSxE2BxGvCl+zbvOEDOQjPZgDQ3oa
         3vOZrt/AWVB3HfUlb3+nDDizUxnn4t8W9EU8BZakiSngJn3sXeCR6CTg1Dux4wZ9YJo3
         hFJ9xsB/9v7Oe8385luRENsaZuZT6QEntggC481E93tRJHa4z/7TnIZevgq2RUkGsMYQ
         88tvYHHvVll7/Gx75T5RAorDRI2rD7UGM/ZX0CUCZPgYG7n9DdPtPUnlM0BbIyWhfYXH
         gvLw==
X-Gm-Message-State: APjAAAW/cEFfX67T3PkP4qWD14CMInjg6aasfk8d/cm2h80El5GhsbZ8
        G5petzgPJskmXg5ou5S3e0M=
X-Google-Smtp-Source: APXvYqz9xg2X/ZbXsxHvOApNboSPFDBenbDeVhG/yb5h9xHLkuhQYeCRa3dD7kxvhToH4zIdOIkCJQ==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr17884417wrn.239.1576310665398;
        Sat, 14 Dec 2019 00:04:25 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d9f:bc00:601e:ad7b:3c43:35ef])
        by smtp.gmail.com with ESMTPSA id k4sm13511935wmk.26.2019.12.14.00.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 00:04:24 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3-RESEND] MAINTAINERS: mark simple firmware interface (SFI) obsolete
Date:   Sat, 14 Dec 2019 09:04:12 +0100
Message-Id: <20191214080412.9608-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown has not been active in this part since around 2010 and
confirmed that he is not maintaining this part of the kernel sources
anymore and the git log suggests that nobody is actively maintaining it.

The referenced git tree does not exist. Instead, I found an sfi branch
in Len's kernel git repository, but that has not been updated since 2014;
so that is not worth to be mentioned in MAINTAINERS now anymore either.

Len Brown expects no further systems to be shipped with SFI, so we can
mark it obsolete and schedule it for deletion.

This change was motivated after I found that I could not send any mails
to the sfi-devel mailing list, and that the mailing list does not exist
anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---

Thomas, please pick this _reworked_ patch now. thanks.

v1: https://lore.kernel.org/patchwork/patch/1033696/
  - got Acked-by: Len Brown <len.brown@intel.com>
 
v2:
  - also change status to Obsolete

v2-resend:
  - applies cleanly to v5.3-rc5 and next-20190823

v3:
  - simply remove Len Brown and do not try to find a possible
    replacement, as Thomas requested.

v3-resend:
  - applies cleanly on v5.5-rc1, current master (e31736d9fae8) and
    next-20191213

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b540ecc4e2a3..62a30f170d94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15033,11 +15033,8 @@ F:	drivers/video/fbdev/sm712*
 F:	Documentation/fb/sm712fb.rst
 
 SIMPLE FIRMWARE INTERFACE (SFI)
-M:	Len Brown <lenb@kernel.org>
-L:	sfi-devel@simplefirmware.org
 W:	http://simplefirmware.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
-S:	Supported
+S:	Obsolete
 F:	arch/x86/platform/sfi/
 F:	drivers/sfi/
 F:	include/linux/sfi*.h
-- 
2.17.1

