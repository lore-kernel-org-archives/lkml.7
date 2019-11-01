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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F88CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ABE21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVxuR3zJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKAVtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:49:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:47075 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAVtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:49:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so14862400qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=teI1DLghbkzO5wLL0GxrdEtPxcMPjOo+NKTZqVKi+SE=;
        b=gVxuR3zJe7/on/OD92OUcrkCSlejDtRr92hn2Dsdd4c/1Bh4pmhEr/n2988Emyt7Vq
         ZN5xaEPUenefaszAE2d11Li1/MDzl8yzFDrRc+/AoeuRbs951t/ZELIfMflUiR7dfurn
         ZZlw22wpXYFQfv+5DGNVYi8TP+WbKlnlvVSLReO/Sk9Lx3zyrnwmJfX81J42y/o45Yoz
         PqPbgg+NLRcpGtSbne1AIw+zC5+72NNAbF00+lrWE3ypqxM9EzyzG6S1rudd0gBnOSbH
         rN0ZJNrAcPyuoQnIBwN0sQcOe1kyoQtU+xdmCJ2OnXxyW22ZFqDlJPCOMJNkR8W8g5er
         yLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=teI1DLghbkzO5wLL0GxrdEtPxcMPjOo+NKTZqVKi+SE=;
        b=Qyh9+JufSboyjG+Koo+gWxG32S1WvGT/q+3knQUbAR/gjDwCbrOZAPAeVIl8laWXWk
         pZZ2Xns/NWcOevXUZwzXDRhOREjrI3QouSzpJ7I/IEJN9CfytZmWrxxVF4mTc9CFbqOp
         5BGfWLegMpDzJXYU2dAVwAQsxatx8Ei4TYZQhX3fMOI3AvLhR/owyDW1mzzwxpfH+szY
         dNckoXiV4FomSTX9dgfGF7wacLOHzH7fXTs3x9obcUrCFNO8CXZSaZAY3n33vnv/6ZgQ
         R4nNiA4ENcp+poJmtyi8QzHxNh6qrlG504urWXwaD67AZuHcbuCw+iLTVYsM4/aLrnpw
         CAFw==
X-Gm-Message-State: APjAAAVCSYd5/oQ1gAXcVFsd/36j4dpgB7JPNjtAr0MGsEEK9Ko4x+PG
        2a7gUoC1DrAShcIjpbI96ho=
X-Google-Smtp-Source: APXvYqzxXFjy6vj9cmkGY99TAQKijOReHqrYWkUSrAM6xdplggLgFqSITuGi43RFl9fKXdkgFnlxPg==
X-Received: by 2002:aed:24c1:: with SMTP id u1mr1711622qtc.29.1572644941501;
        Fri, 01 Nov 2019 14:49:01 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-84-14.wifi.ic.unicamp.br. [177.220.84.14])
        by smtp.gmail.com with ESMTPSA id w24sm5482300qta.44.2019.11.01.14.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:49:00 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v2 VKMS 1/2] drm/vkms: Fix typo and preposion in function documentation
Date:   Fri,  1 Nov 2019 18:48:47 -0300
Message-Id: <20191101214848.7574-2-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101214848.7574-1-gabrielabittencourt00@gmail.com>
References: <20191101214848.7574-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in word 'blend' and in the word 'destination' and change
preposition 'at' to 'of' in function 'blend' documentation.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

---

Changes in v2:
- Add fixing typo in word 'destination'
- Add change of the preposition
- In v1 the name of the function was wrong, fix it in this version
---
 drivers/gpu/drm/vkms/vkms_composer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index d5585695c64d..88890ddfc4bd 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -43,16 +43,16 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
 }
 
 /**
- * blend - belnd value at vaddr_src with value at vaddr_dst
+ * blend - blend value at vaddr_src with value at vaddr_dst
  * @vaddr_dst: destination address
  * @vaddr_src: source address
  * @dest_composer: destination framebuffer's metadata
  * @src_composer: source framebuffer's metadata
  *
  * Blend value at vaddr_src with value at vaddr_dst.
- * Currently, this function write value at vaddr_src on value
+ * Currently, this function write value of vaddr_src on value
  * at vaddr_dst using buffer's metadata to locate the new values
- * from vaddr_src and their distenation at vaddr_dst.
+ * from vaddr_src and their destination at vaddr_dst.
  *
  * Todo: Use the alpha value to blend vaddr_src with vaddr_dst
  *	 instead of overwriting it.
-- 
2.20.1

