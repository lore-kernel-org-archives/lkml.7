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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E4C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2132173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThTM9wBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGAScq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:32:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40325 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGAScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:32:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so6425114pgj.7;
        Mon, 01 Jul 2019 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vo1i346r1xOesxPoRQa7nWWhSyL2ujUWb8aG0q2okzs=;
        b=ThTM9wBxTrDRpjGI9ydlr5fF7lUNHmjx8j1Xwr+w3ReamdJ2UtrGNav7aDVtqMYFF9
         wcXs6Ax/7BE0Zmpvlx2VZhsRzpjbOJ/DOSTJcmveZu8+UK1c7ZP9e4akKEW1zmPSYyjZ
         s+QcAExW2q1wYQ1rg/zJPx/s8w4bS3Xq2EPpISBPOaPb2JbfiZsjTaeKUwUE/3WzyYmf
         MkdPlJt9jJUGpWx4DXfiEwsD/FcT4SmiZa4WtraOYw67iwyLHJCdoNZguo1reL759ro6
         vuxFdJwZAQtJEG3ATFpqV/fClwA9er9CsP8CO5hNwjDd1xscRkqS0ay0g8iMzxSvuM4N
         izFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vo1i346r1xOesxPoRQa7nWWhSyL2ujUWb8aG0q2okzs=;
        b=UjUU7dau5KE99bCC6llVzHXVrD5js+UershKD4+8oZH0jFOE0RHcum6AaPqKUdxmdS
         2OCnyVshBX+nPpBGRVzBqa9YRdCNMRoCB9v/xPP4M9lcdUo+HNazVJoxTuLZDpUHAaXI
         G7Y87jJbj5p5gMfnzOMCa6Lg5CfdnM9zV1g9b6FUZv242dTrqNDQecC5W0TBmSnjyzk5
         mVCOLl7CsKaJHzIEWkTYmLStQq+SXs7hXFKUraqyvkr8hr9M2XmjHVInpzF/UbPQKtjw
         gzgYEeksGfO9eltd6Z15GO6JXzw3hmHxA1RY4uBKRi2V31tVz5Sw5fDoDMy07JpVkXJs
         g+TA==
X-Gm-Message-State: APjAAAWYBGKZhYYKPQj8FvP42K+MmzCs1Xr9xNb/B0CTn4+P5jXJfErg
        9yFP+yLR2qYrBEfkDlAkmOQ=
X-Google-Smtp-Source: APXvYqyNdvEi1XzOHbT0sCdF/WrgGzVtPHJ4XyV3sShwO2UtR1JkYsFW7El49dK+pDP+uJBUzvhdTA==
X-Received: by 2002:a63:755e:: with SMTP id f30mr17934651pgn.246.1562005965725;
        Mon, 01 Jul 2019 11:32:45 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id br18sm216858pjb.20.2019.07.01.11.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 11:32:44 -0700 (PDT)
Date:   Tue, 2 Jul 2019 00:02:41 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] USB: gadget: function: fix issue Unneeded variable:
 "value"
Message-ID: <20190701183241.GA13275@hari-Inspiron-1545>
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

We can not change return type of eem_setup as its registered with callback
function

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v2    fix typo in commit message

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

