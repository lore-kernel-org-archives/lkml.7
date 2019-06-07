Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7C3C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 01:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4560D20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 01:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd2atQP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfFGB5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 21:57:05 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:43792 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfFGB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 21:57:04 -0400
Received: by mail-pg1-f174.google.com with SMTP id f25so266283pgv.10;
        Thu, 06 Jun 2019 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YFXox/VaEEDxs9pquSJLpjpCJcX389Fmf7dWJx9j5h8=;
        b=fd2atQP1qdoyel71qRIYtGZmyNwY3U7xfG5j5j9PFq4fbQXsrW2UMnKBeFmoEhiguC
         n9HlXRU+w0RAb+jWY4vGVguByv1Cc+fMjVTCT2u+yjFqOkDGn7MrLzJuhrWUg+uPGg4O
         qk001HgwBTacceHi4x4kObsLZv8yj6FKmFozgzLShHEZ4LdSdTwGFyPHWgHb18mkoCwp
         Vqm5287oGU0mulRrnaiz3OCyZe14Zdald/jqF67bC8QIM+EvPtQ4qDsaGd5H2Duwhant
         kf9l92zvOmaU7UbQ9a2zCXYVIY4mreFUALU59myk3XAc63iX81hb7ftawXTZePIv6/fi
         p+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YFXox/VaEEDxs9pquSJLpjpCJcX389Fmf7dWJx9j5h8=;
        b=BaZfWOU8rFMVF+N66hPsF9nwHXZ5x2DyYXALQoCrcpmkpS8ByXFIGCJRk68nhOQvdC
         FcwJ5QJx+J4oceG0tyN+hcvV5NOVcP+x7vnimIBunxAlMUE+y6YGdA6Z+Ox7G6qJuGwG
         ZRqMZUAIcEBN3ZAv/+vYXQ/5pCb0OqtjWKC1bArFdTa0YH+75uGQXV7OJs27ETfyoy7q
         vEASvv+JK/Nt7fhojBnbBuWkYgArIFuYOqdddgur+mM2CfIhhisgxIL8EIZQDiKKb9go
         uPxduwr5WhpI9CFjJLk6Ht9qV8FszDIOE1u5f9TCiHzW1YBlKQIb/aDLUczlDyaIlPRu
         YklQ==
X-Gm-Message-State: APjAAAWjP1lJFlIl2HX7UXhinDJK/SE0NXPdaUuZeeOYnmsIFFnUNmFb
        qfJPv8vxSRk+14GA5KNV4CQ=
X-Google-Smtp-Source: APXvYqwAEMKapNCPLmFfVinmGpCE+xThuCljjQZSDJL2/DOYhYvG/45KTOx+TxQuwzxQL5Vqd0PGLQ==
X-Received: by 2002:a62:a511:: with SMTP id v17mr54610684pfm.129.1559872624178;
        Thu, 06 Jun 2019 18:57:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id r77sm385030pgr.93.2019.06.06.18.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 18:57:03 -0700 (PDT)
Date:   Fri, 7 Jun 2019 07:26:58 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] USB: sisusbvga: Remove unneeded variable
Message-ID: <20190607015658.GA4113@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

drivers/usb/misc/sisusbvga/sisusb.c:1753:5-8: Unneeded variable: "ret".
Return "0" on line 1877

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
changes in v2: Change return type of sisusb_set_default_mode from int to void
               as it never fails.
---
 drivers/usb/misc/sisusbvga/sisusb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index ea06f1f..2ab9600 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -1747,10 +1747,10 @@ static int sisusb_setup_screen(struct sisusb_usb_data *sisusb,
 	return ret;
 }
 
-static int sisusb_set_default_mode(struct sisusb_usb_data *sisusb,
+static void sisusb_set_default_mode(struct sisusb_usb_data *sisusb,
 		int touchengines)
 {
-	int ret = 0, i, j, modex, bpp, du;
+	int i, j, modex, bpp, du;
 	u8 sr31, cr63, tmp8;
 	static const char attrdata[] = {
 		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
@@ -1873,8 +1873,6 @@ static int sisusb_set_default_mode(struct sisusb_usb_data *sisusb,
 	}
 
 	SETIREG(SISCR, 0x34, 0x44);	/* we just set std mode #44 */
-
-	return ret;
 }
 
 static int sisusb_init_gfxcore(struct sisusb_usb_data *sisusb)
@@ -2019,7 +2017,7 @@ static int sisusb_init_gfxcore(struct sisusb_usb_data *sisusb)
 
 		ret |= SETIREG(SISCR, 0x83, 0x00);
 
-		ret |= sisusb_set_default_mode(sisusb, 0);
+		sisusb_set_default_mode(sisusb, 0);
 
 		ret |= SETIREGAND(SISSR, 0x21, 0xdf);
 		ret |= SETIREGOR(SISSR, 0x01, 0x20);
@@ -2246,7 +2244,7 @@ static int sisusb_init_gfxdevice(struct sisusb_usb_data *sisusb, int initscreen)
 		if (sisusb_init_gfxcore(sisusb) == 0) {
 			sisusb->gfxinit = 1;
 			sisusb_get_ramconfig(sisusb);
-			ret |= sisusb_set_default_mode(sisusb, 1);
+			sisusb_set_default_mode(sisusb, 1);
 			ret |= sisusb_setup_screen(sisusb, 1, initscreen);
 		}
 	}
-- 
2.7.4

