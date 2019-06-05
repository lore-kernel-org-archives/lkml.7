Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79209C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54326206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDfdgNba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFERTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:19:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43941 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFERTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:19:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so4821455plb.10;
        Wed, 05 Jun 2019 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=B/JvG0ZRDNEBNEcUAraBTtC7NdvBq6Iubs4NTtSOxek=;
        b=rDfdgNbauu7tZFEVYV7kQxLNvFyCSUWQ7UC3QM6R5p6bIgKreqMVDBgwWMaOEBxIDL
         96Uh5qcTkghNicBFnqtttNQKz/o2k3mU6z84h0Oz8cblIIdVoG0MosNevlA4Jx/dccUn
         DLanrfnDs7gqgu9LLefN9tkfsB1JV/0QpmvJ8TjifvOTwig5xwzpcpbNLheZ8phjhZA+
         4DIZfCocPAF0IKLy9yaO475MMkN09W9CnUFoZmI3JTuEyEnZXbOJQq81JxngkEQwOD3C
         qnz3lPZpMfku2xZ6OyZOUmgjFXFXQRN2laDJffcS0VDypmBhrIMZ1KkVL6Ah4gRSX6sc
         /QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=B/JvG0ZRDNEBNEcUAraBTtC7NdvBq6Iubs4NTtSOxek=;
        b=L/0xB1s45OjNOkc2yBszik/gD0jq7sIId7E49gIVe7GKY+bz4UzrG6kcp3bcBkaCIG
         klzyyhO7LVD5cRbyTLDEqzJWo2tamzELVPsH2aq5DBMELzywXYjsTBVPA402nYCjAVHz
         J3JtibS03WUgzHebNhIJ3z6IXZHZCGudkqXJWbaAZR9jxiBDtwXntYzCXKz6+Bc5PfM+
         DsURo3cXyJJ9VOZOM8OzKNoEUxvhnbI5bfhycw+iq86gKsG1fjnZW9qosXX0R3fQGW5Q
         Jz9X99UwrPLHYT9aCZjcbvQHmwNpwTEEnfAmdEC0BNHhIws7AVf7wJWxejD9olRFA5oL
         rVAw==
X-Gm-Message-State: APjAAAV93I77x+/QWU7fVhdoCbpTpT+R9jznwFGaX5kIBrY6GilTs26j
        5QGFhMCroyQeR31ZzUW6w+A=
X-Google-Smtp-Source: APXvYqzg6UsjNE80K0klM5VcBmYR/EAMwGMU1qa/8PwHFBWS3R8yC4dfX12VduefFKMCfQ0mxDsjkg==
X-Received: by 2002:a17:902:2aa9:: with SMTP id j38mr8317370plb.206.1559755152756;
        Wed, 05 Jun 2019 10:19:12 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id n13sm17135548pgh.6.2019.06.05.10.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:19:11 -0700 (PDT)
Date:   Wed, 5 Jun 2019 22:49:08 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: sisusbvga: Remove unneeded variable
Message-ID: <20190605171908.GA10444@hari-Inspiron-1545>
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
---
 drivers/usb/misc/sisusbvga/sisusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index ea06f1f..dfe2ed1 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -1750,7 +1750,7 @@ static int sisusb_setup_screen(struct sisusb_usb_data *sisusb,
 static int sisusb_set_default_mode(struct sisusb_usb_data *sisusb,
 		int touchengines)
 {
-	int ret = 0, i, j, modex, bpp, du;
+	int i, j, modex, bpp, du;
 	u8 sr31, cr63, tmp8;
 	static const char attrdata[] = {
 		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
@@ -1874,7 +1874,7 @@ static int sisusb_set_default_mode(struct sisusb_usb_data *sisusb,
 
 	SETIREG(SISCR, 0x34, 0x44);	/* we just set std mode #44 */
 
-	return ret;
+	return 0;
 }
 
 static int sisusb_init_gfxcore(struct sisusb_usb_data *sisusb)
-- 
2.7.4

