Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D67CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E242086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3SMuVHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfKASVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:21:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33675 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfKASVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:21:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id 71so11590942qkl.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfChniPxmFbZU2S4qrE7c3GqiFqrYlUdrzoxXGWQIRg=;
        b=I3SMuVHnefRGev7pKBa/p/vIdpNEst8AexAfUrQVntypTFJVSOseXJZcgDIgmsGXAu
         cmQ89JtTQy3tV7nJmJSSSCu2kN5AbiWclNGyInwZ+03vGsEw1Fht3wC53e4eokh/j8Zb
         JrI0B+PU7qmLMAlxCXiYY3BNoX9XEZZkHyvUEErAI8XoNu4k12MUMDK81fyYkVKRsDf/
         v3GW+n4KTacJVvKZKAnnUsAmfx8KxoCBiCZBCxf0XGxn/EWOVRDtHsGFN7hwzQXWjAht
         TJiML7FmEkeePOp6uv6E7gPfPfdrLtkU23vwXgdnNWyy9n5D9Q8/CG/+76SzYZV8eLCL
         F23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfChniPxmFbZU2S4qrE7c3GqiFqrYlUdrzoxXGWQIRg=;
        b=XReIYmQB3r7ozsHwHxLihXfVgSKD79zISTIUPp/IUs5xvj4KK2NK93zRN/z+po3Kzh
         if4Q6p7qnBAkY67wEQHaqzhbBJ5XUHMc0wzbEsMT05Rsne3blYwd0qe5FEC6KBkiFvF0
         d/5+RtwsagH0POJjkE3SS3j7xdySgNfZfQbdHq3WyZSMuTdpmS77C89zII6XNvAdJQwj
         nIhOt4pg/l166Mt1ozwXt4l+yggyAWgH+84UbSgVXoMJbHzaPF87ijnfpKlmqyWQeHWk
         8oILywVS2XwIaauyEZofm+LdvdnPX8ypAzq/vnSXVA1pAxGGVB5enAeTt2vbx34kwoIK
         mMRg==
X-Gm-Message-State: APjAAAULW496fFiea+cmdzPbGVXTc8sRQ/qLfUwrwwvOWG9WTTHp0P4l
        hYpyMX443uEynTsoRfG7LvO/ra3m2Es=
X-Google-Smtp-Source: APXvYqxZY/z0KLt1SybUGNSm28l8yCtxJuvO7dV3LGq7qbkBb//5NCQ5JlrS/35+dRQm18m56FMylg==
X-Received: by 2002:a37:b046:: with SMTP id z67mr1749300qke.343.1572632480189;
        Fri, 01 Nov 2019 11:21:20 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-84-14.wifi.ic.unicamp.br. [177.220.84.14])
        by smtp.gmail.com with ESMTPSA id x38sm5106688qtc.64.2019.11.01.11.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 11:21:19 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] drm/vkms: Fix typo in function documentation
Date:   Fri,  1 Nov 2019 15:21:02 -0300
Message-Id: <20191101182102.30358-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in word 'blend' in function 'compute_crc' documentation.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index d5585695c64d..15efccdcce1b 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -43,7 +43,7 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 }
 
 /**
- * blend - belnd value at vaddr_src with value at vaddr_dst
+ * blend - blend value at vaddr_src with value at vaddr_dst
  * @vaddr_dst: destination address
  * @vaddr_src: source address
  * @dest_composer: destination framebuffer's metadata
-- 
2.20.1

