Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACECC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A31520818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5RewhYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfEPNJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:09:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44126 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfEPNJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:09:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id f24so3707060qtk.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m604YgnDNw1JdvbP5m9YpO0trNgVXxCVhoiIwF24eeA=;
        b=k5RewhYu1FJVNQyxVk81O1O5FCTVv5Yx/KwAUngVI+NX7HtKhmf2dh6Pe+/19aBcpe
         C8PGygyFey637mLmQxQE5DSVW7QaYiFXMZ8SNUAMiPzGipqKUauOqATkJu/OXrJMdYIH
         YHG8oxg/FLl6y59pwPC6WapkZ3qQm2W5xtOEu2PM1EU5xNlGXhxvK6wIEDEjqfqDWfId
         PKFUsaeWJiCSjOOHIq3RrGOeQ1+gKhzn1yVGokE+aZQp68chzDs+5G5Ak7JAOKV6MK2w
         8iq89X37Nl4Xvhla7F0bAdgp14JkqU4djbRt/B2/1srsL0WL3Ot9VKoFVr3eMh7THcSI
         QlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m604YgnDNw1JdvbP5m9YpO0trNgVXxCVhoiIwF24eeA=;
        b=XQWyA4IOhH+AJERAu+E54HQgFSiK4ZpbToc2MPYUgYnQLlxg2XSWMF2Co2SZZSV77Y
         RYoiAzwrwmhF4FIxpvoH6H7Z94Rp3Vr06GX8fNMvmjYUptE9XnaZPciS+hbwHUD9iN2v
         91JPpVb/95up1aBA2AYaZLkha37sKd83KXTcw1VVx6CmArIWXqN1lGfgPn4+4sJC39li
         QDwmqA+kzW4/kdzKXyvLLTB7Rdf2h5xc1nJ5VYtj1V+1b/n5qkb/QIlVoBGzG0zQMX7q
         yEZSVupw5RU2OkLZKdqMSL7FD5aAsCW9VrwyPpc3usH0L543kz5d9VMCh+/6Gm8bWhdh
         +gMQ==
X-Gm-Message-State: APjAAAX6DV0xOkO4rKFIKtinlcGQnTyybmlWPA2guph0O2Jb5mFGh2xd
        WiJXFvhmNuuv79EIAI6rwTx9fS01LZoJlg==
X-Google-Smtp-Source: APXvYqwSTYuh5DlyJud8+eOw3PWYO+A6ZwodQ21+cjz8FgRKL4quJZEYicx8cOZcDYqHVHg7Vhk9ng==
X-Received: by 2002:ac8:375d:: with SMTP id p29mr39571875qtb.88.1558012156715;
        Thu, 16 May 2019 06:09:16 -0700 (PDT)
Received: from jfdmac.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id j29sm2472778qki.39.2019.05.16.06.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 06:09:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] w1: ds2408: Fix typo after 49695ac46861 (reset on
 output_write retry with readback)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
In-Reply-To: <20190516120116.22262-1-manio@skyboo.net>
Date:   Thu, 16 May 2019 09:09:15 -0400
Cc:     linux-kernel@vger.kernel.org, greg@kroah.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC98D7D1-ABD5-428B-879F-46E826F40FED@gmail.com>
References: <20190516120116.22262-1-manio@skyboo.net>
To:     Mariusz Bialonczyk <manio@skyboo.net>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yikes! Human after all...

> On May 16, 2019, at 08:01, Mariusz Bialonczyk <manio@skyboo.net> =
wrote:
>=20
> Fix a typo in commit:
> 49695ac46861 w1: ds2408: reset on output_write retry with readback
>=20
> Reported-by: Phil Elwell <phil@raspberrypi.org>
> Cc: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
> ---
> drivers/w1/slaves/w1_ds2408.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/w1/slaves/w1_ds2408.c =
b/drivers/w1/slaves/w1_ds2408.c
> index 92e8f0755b9a..edf0bc98012c 100644
> --- a/drivers/w1/slaves/w1_ds2408.c
> +++ b/drivers/w1/slaves/w1_ds2408.c
> @@ -138,7 +138,7 @@ static ssize_t status_control_read(struct file =
*filp, struct kobject *kobj,
> 		W1_F29_REG_CONTROL_AND_STATUS, buf);
> }
>=20
> -#ifdef fCONFIG_W1_SLAVE_DS2408_READBACK
> +#ifdef CONFIG_W1_SLAVE_DS2408_READBACK
> static bool optional_read_back_valid(struct w1_slave *sl, u8 expected)
> {
> 	u8 w1_buf[3];
> --=20
> 2.19.0.rc1
>=20

