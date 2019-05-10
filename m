Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C810C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC17D21852
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C/zZPD33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfEJVYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:24:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41430 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfEJVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:24:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so3583190pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=Ht7ftENytry8iLdjfON93hG8IOVq7xHiHUNG0B8Cq0Y=;
        b=C/zZPD33t+80hCt103zWOGGjxmmkR+8z+LazeEaU4ZX2PPxkLxNL29kA7CqI2lV+5M
         sqSL/uR8q7GIvD0drctcWk8CJ+nZb6xsbgD0rpNFc6kGLHjq9eBRh/WtvvPE67weo4yZ
         YOQxFcEG7iRU/w4JjmEUz0f0AaCozoEKzkVQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=Ht7ftENytry8iLdjfON93hG8IOVq7xHiHUNG0B8Cq0Y=;
        b=WU0lm5MC5I/jTS0e9WRG8KGf0uqRFDlWQ4ESlsv0zqmgwTFa8P6xHMw2wqfkgWgdCG
         ePYfn06Xw994A32gLbw67AXOLRUA8++lPiHm5AGgF7DS72gdfuHBy9NvMmXQ+xVx3R1F
         DqXoBMOXiJUGajik7B0yMu4Lpifx364aqP/W7YHoDru98VGbLBQgYhK/QCTT3StF7gEw
         KDvVqNpJP9wIajvhXCPuLIo0is+Tnb+tg1Y0rTk85MUYPd9dGdvrJdJB8CAY0PyxvA/5
         sl3PIaBQRJekt7lUJXYqXvW529Fd/o0/oDkafiOdbDSzmgDeIXzrGVxbncyUhxNzVvAw
         i8Vw==
X-Gm-Message-State: APjAAAV3BJVIZppgH3PuCC0swVq7BoL+XhKQNTIi/pOBwEhNuoJeOu4R
        319v0YufTn3nCDRoKyrfr8AnERX4gCN4Lw==
X-Google-Smtp-Source: APXvYqx3slvyEUa7J0TfDFeqPbGJSvoOA0ayYKfIpk9Tj5LO9EXcCJWkOnLGRw3pFT8HzGja6oriTg==
X-Received: by 2002:a63:4710:: with SMTP id u16mr5496241pga.447.1557523494573;
        Fri, 10 May 2019 14:24:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i27sm17037346pfk.162.2019.05.10.14.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 14:24:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190510180151.115254-3-swboyd@chromium.org>
References: <20190510180151.115254-1-swboyd@chromium.org> <20190510180151.115254-3-swboyd@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 2/5] firmware: google: memconsole: Use devm_memremap()
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <155752349303.14659.3560946140992031740@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 10 May 2019 14:24:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm version of memremap so that we can delete the unmapping
code in driver remove, but more importantly so that we can unmap this
memory region if memconsole_sysfs_init() errors out for some reason.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Quoting Stephen Boyd (2019-05-10 11:01:48)
> diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firm=
ware/google/memconsole-coreboot.c
> index 86331807f1d5..0b29b27b86f5 100644
> --- a/drivers/firmware/google/memconsole-coreboot.c
> +++ b/drivers/firmware/google/memconsole-coreboot.c
> @@ -85,7 +85,7 @@ static int memconsole_probe(struct coreboot_device *dev)
> =20
>         /* Read size only once to prevent overrun attack through /dev/mem=
. */
>         cbmem_console_size =3D tmp_cbmc->size_dont_access_after_boot;
> -       cbmem_console =3D memremap(dev->cbmem_ref.cbmem_addr,
> +       cbmem_console =3D devm_memremap(&dev->dev, dev->cbmem_ref.cbmem_a=
ddr,

Whoops, this returns an error pointer now. Here's an updated patch.

 drivers/firmware/google/memconsole-coreboot.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmwa=
re/google/memconsole-coreboot.c
index 86331807f1d5..cc3797f1ba85 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -85,13 +85,13 @@ static int memconsole_probe(struct coreboot_device *dev)
=20
 	/* Read size only once to prevent overrun attack through /dev/mem. */
 	cbmem_console_size =3D tmp_cbmc->size_dont_access_after_boot;
-	cbmem_console =3D memremap(dev->cbmem_ref.cbmem_addr,
+	cbmem_console =3D devm_memremap(&dev->dev, dev->cbmem_ref.cbmem_addr,
 				 cbmem_console_size + sizeof(*cbmem_console),
 				 MEMREMAP_WB);
 	memunmap(tmp_cbmc);
=20
-	if (!cbmem_console)
-		return -ENOMEM;
+	if (IS_ERR(cbmem_console))
+		return PTR_ERR(cbmem_console);
=20
 	memconsole_setup(memconsole_coreboot_read);
=20
@@ -102,9 +102,6 @@ static int memconsole_remove(struct coreboot_device *de=
v)
 {
 	memconsole_exit();
=20
-	if (cbmem_console)
-		memunmap(cbmem_console);
-
 	return 0;
 }
=20

base-commit: e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
prerequisite-patch-id: b7c2a1e21fb108364f0e8cfaf1970cbc7903c750
--=20
Sent by a computer through tubes
