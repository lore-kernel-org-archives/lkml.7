Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C0DC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD17218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b41THDtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbfGWNmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:42:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37658 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfGWNml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:42:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so41176116ljn.4;
        Tue, 23 Jul 2019 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qq1N8CVSPqGFm8I58WXQggzafgN4IhFOgydi/MxAeD0=;
        b=b41THDtS502Cmn7ZtuEXfaHCrSLQccQrl6blamPDCYz6YWA1fcm545SwYecRV3QWqF
         e4Wimo1WmwE6MkP8FjIkhOql28bbQE42VapW4T9C5kRnjXmorz0oY3nyxyvwTbZ4p6pg
         SLSGEv4wbDH18QBJKwZNFMbGHhZEbOI/lPiMnFiIe80vXNq0GWwNClCGAGQLbXfsBVoj
         CynCiiCIgC4U9Cjw0uwCglgKR9uBM6U3z3TCNr1ox9SgkWFSsmJGyhoPz4KoTEU2XI/0
         lrQd4TK+iaaAREzFQLnL2DLtd4XCd+b4BL3bF2YUr48Bvn/Z9HXySKcXDuaHviziFEa2
         sbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qq1N8CVSPqGFm8I58WXQggzafgN4IhFOgydi/MxAeD0=;
        b=Hgv1TUczrn8wHKCqXYNEU8wMoaa5xbjKw7jl+jP6LlqkFztIMBK9UV9pa1sl+1tt4t
         nTSw/ZsEG1E6U+0+mC9mH60NljKDj+UW4PTsauKg/vYx17LdF8HfFJKOuQgqK71i+9bL
         cl5A3TcE6EQ5PbMaPAhrfqrvoBJfbN+gKnrIDoOCS2AC1uOXeUE46k1lJNqYB8T4WrlL
         qSpJtL5q54LCfQHiW4QAKdmpd40mQfvhp6OmQ654o+AiflD4RMvwitr1lRmmfON36pPC
         WIV0xkYYkvBfXxyzXkKQkhfUfTLXFYF8h7VPK2U9GmteEsqOsmhbyqTg8uQY0iudMRfk
         lIkA==
X-Gm-Message-State: APjAAAW0H7oehZ1I7FtiscBlLAFRQpRkLCo5V6JjpLKvzk3CnaLO9lUJ
        nw0S/lQOWFrFJ3f84Qq6Uf0=
X-Google-Smtp-Source: APXvYqzB10BadjwR315T5EIXqmPZyiQ/xN52SveGWGdm6yESs7mnlL5OGnz4zKgzylBo7PWV67qGOw==
X-Received: by 2002:a2e:9b57:: with SMTP id o23mr40017640ljj.67.1563889359138;
        Tue, 23 Jul 2019 06:42:39 -0700 (PDT)
Received: from localhost ([188.170.223.67])
        by smtp.gmail.com with ESMTPSA id v4sm8007751lji.103.2019.07.23.06.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 06:42:38 -0700 (PDT)
Date:   Tue, 23 Jul 2019 16:42:35 +0300
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: Apple SPI keyboard needs CRC16
Message-ID: <20190723134235.GA845@penguin>
References: <20190723115905.2092687-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723115905.2092687-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:58:45PM +0200, Arnd Bergmann wrote:
> In some rare randconfig builds, CRC16 is disabled, which leads
> to a link error:
> 
> drivers/input/keyboard/applespi.o: In function `applespi_send_cmd_msg':
> applespi.c:(.text+0x449f): undefined reference to `crc16'
> drivers/input/keyboard/applespi.o: In function `applespi_verify_crc':
> applespi.c:(.text+0x7538): undefined reference to `crc16'
> 
> This symbol is meant to be selected for each user in Kconfig,
> so do that here as well.
> 
> Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

> ---
>  drivers/input/keyboard/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 8e9c3ea9d5e7..ebb19e21473e 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -76,6 +76,7 @@ config KEYBOARD_APPLESPI
>  	depends on ACPI && EFI
>  	depends on SPI
>  	depends on X86 || COMPILE_TEST
> +	select CRC16
>  	help
>  	  Say Y here if you are running Linux on any Apple MacBook8,1 or later,
>  	  or any MacBookPro13,* or MacBookPro14,*.
> -- 
> 2.20.0
> 

-- 
Dmitry
