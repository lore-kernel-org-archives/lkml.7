Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5651DC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 03:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CEB214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 03:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD+i09DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfFIDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 23:07:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43268 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfFIDH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 23:07:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so2279676plb.10;
        Sat, 08 Jun 2019 20:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9itGLtdOmBJM/1ryZSxTG0b15PTePJMrWSbb4zQK9g0=;
        b=QD+i09DKNxSMKJPjE1LYcW5lxW3wv1QXKW9pysyjlVemnMuZQBJIgRTybCYhwtlUhO
         XftQHGF+Ket4n68pLOGo7DeL0fVazfzV62O+GSa5GhemdsXQeW/xRY+SYNAuiaOQB9TF
         W1a9GGNcZDpcsiDpoVhMprv3cO9fPh1ovwrs3WK0lP8IqwP3JVmCESOzXDPrRWG+PE2A
         HmX6YvSqDW7H2FjE31URUDX1OCszGx68ycFi8WIqqW9T2JcKa+YRVkQ+aNZisEuFIC2Z
         SPh1NbO57o2ueDBuqKVjgE5zs9VInZ0t/CY6U9ArKEP0t+x/p2qY15k2r/3u6L9c2enQ
         IDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9itGLtdOmBJM/1ryZSxTG0b15PTePJMrWSbb4zQK9g0=;
        b=ZWNxNKnJvKlckHxuz6d4Egcjpm+I9Yvz/RLhdIVgyrTisWOqOwnOu5y6OrnK8bdC8I
         3kaJrEB7pJ0vmiczMkfbIEswC3c/6iGgxQZf8QH3c8TBv/iC08IrGsFR1iYgvNXp4Hcn
         dHd0Tz5fIfC+Iq14NMP64pN1xI0bj2ACvt0OSGXhgUp+6abeu693qITR1pCcSc/UydvZ
         2yzfDSsJboUc6WvVn1jM4+YHiKgkRnFcNfXqnuq2o+2moMNkbviSvsusYmIyYCGtrHM9
         8UkfWFGCsem2g6leG2poofMBpcXlJJsCnhc8RcQu5U+K56hKnwJh+en3+oyByTGkyQrg
         aDyA==
X-Gm-Message-State: APjAAAXC3/2ffzeHLbMnvy1Px2TvT4U8ixDfWovuw1K5tgkio1DQ6+Up
        pKYimkHo2kSy5APw1l3ZXx/T9/+q
X-Google-Smtp-Source: APXvYqyIWMT75YQVshaRDgY/L673h2d967CpqFM0Cc1x7TmTf/fagw1CLfC9lh1r8DisZDajDPRjPQ==
X-Received: by 2002:a17:902:d701:: with SMTP id w1mr57917621ply.12.1560049677010;
        Sat, 08 Jun 2019 20:07:57 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id x127sm6358865pfb.107.2019.06.08.20.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 20:07:56 -0700 (PDT)
Date:   Sun, 9 Jun 2019 08:37:52 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3] USB: sisusbvga: Remove unneeded variable
Message-ID: <20190609030751.GA5482@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable ret in function sisusb_set_default_mode.

Change return type of sisusb_set_default_mode from int to void
as it never fails.

Issue identified by coccicheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
changes in v2: Change return type of sisusb_set_default_mode from int to
void as it never fails

changes in v3: Update changelog
----
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

