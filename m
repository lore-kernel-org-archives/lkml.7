Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F03C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1254120B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH6GkKqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfGASUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:20:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42723 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfGASUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:20:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so7716151plb.9;
        Mon, 01 Jul 2019 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xv1X++7+CI+KR+tJVwJzAPl/RmtdeOQuhyVLw8iciNU=;
        b=DH6GkKqOT5YLbrfoJIxW4QbU0VIhZpjq3lUNJkf3qYJHheK+Qw3FFiHXqqj/QObvjI
         ymZ8SAbIPtGCmSfLr92WLx+ve5/g1+HQmanI0flHh5YVfZWkdw77ZdB1lnVkodbJZIyo
         Q65JksjK0jc21mhT4hheYRLD0y9LU+cSxSnXTFQKx9uteHPsGPZ6iT+Ncdc5QKRw23mN
         O+BDoQV9YhR81uKWlVuVWrpkmW+myvwc87eRSDC5yRfk5a7yrgc4d8Y6W6T0eCPWJGL/
         pLuwYMkeS+74LrUzoI65KO0UwyN6sjQtTYWKkL8QxDojJfjaHOcslgma1dqG4qykDHJ9
         g7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xv1X++7+CI+KR+tJVwJzAPl/RmtdeOQuhyVLw8iciNU=;
        b=PD+W61gbhA99X2kDeDJ3DWO4qc5+VhKpDC7S7OkaIs0Stx3+PeRBoD9On9sSdQ7zHU
         T0KBQD3BXcavrA5RFzeoDOJdMLRAH9XPwtM2dOSl3MM9sQB1a0QXUVjFDYwi5Gcgb+Dt
         6IiViRaH0JISYxo5OuFeEDwoDxPs3Ju/7g1FMirAhCb2+kO43+Q90SavJ6nFcvjlSRGM
         3iCQIZh/ZLO9dLMprzEX2FRkScuFW+G987rL5m9uilzraJOO6GHOfsXkc3qhlzUk40Si
         Iban1zlVYYfVEVw4+nDbL5P1BOY+EiBQFxiZzWlo2HLhN5Am0jBGyhHMOoSEp1pad/z/
         Hi1g==
X-Gm-Message-State: APjAAAWr8vyCdKBlSSHf4Ef+Nfh3jK3dtRhglfYQ2Eke293FNwI/aBLk
        XrW77nG/L4WYcKGVNaGq/eU=
X-Google-Smtp-Source: APXvYqxcU5U+26T5lSP0rjHxG79pMm5IesRkIebm+bNQ7eNH6Kq5UKowQ1/FObBgGSwo8HC+h/fTXQ==
X-Received: by 2002:a17:902:b612:: with SMTP id b18mr14279395pls.8.1562005237182;
        Mon, 01 Jul 2019 11:20:37 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id v131sm10791495pgb.87.2019.07.01.11.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 11:20:36 -0700 (PDT)
Date:   Mon, 1 Jul 2019 23:50:31 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: gadget: function: fix issue Unneeded variable: "value"
Message-ID: <20190701182031.GA10455@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by coccicheck
drivers/usb/gadget/function/f_eem.c:169:7-12: Unneeded variable:
"value". Return "- EOPNOTSUPP" on line 179

We can not change return type of eem_setup as its registed with callback
function

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/usb/gadget/function/f_eem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/function/f_eem.c
index c13befa..b81a91d 100644
--- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -166,7 +166,6 @@ static struct usb_gadget_strings *eem_strings[] = {
 static int eem_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 {
 	struct usb_composite_dev *cdev = f->config->cdev;
-	int			value = -EOPNOTSUPP;
 	u16			w_index = le16_to_cpu(ctrl->wIndex);
 	u16			w_value = le16_to_cpu(ctrl->wValue);
 	u16			w_length = le16_to_cpu(ctrl->wLength);
@@ -176,7 +175,7 @@ static int eem_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 		w_value, w_index, w_length);
 
 	/* device either stalls (value < 0) or reports success */
-	return value;
+	return -EOPNOTSUPP;
 }
 
 
-- 
2.7.4

