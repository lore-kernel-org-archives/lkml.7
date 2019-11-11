Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992FAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708A22075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R07dOsYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKKJav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:30:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38646 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfKKJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:30:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so12425071wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=j4UsCyQdcZm2KCJe59FDjzH8nfUWhHJFhxVJ6xfimnY=;
        b=R07dOsYYwpCpFqth2eEc/oCIsVGaao+wJn8wLg/tmKa7DWZrLBWvdgQx9iz4t5Bou+
         NyhMN5nHtROIBDBw/J2CRYIOtN+EXzAti6P8xtElGQWvekQHtrzTT1eBZCFSPGwuzGNu
         iJOqNEoouqVKG5syT/aSf4ScmQTaC4Dm/aumuHvIxx8ScQuOYUQPsTQ8ogi05kcJA2nF
         j77KE5TGXxf7iWtwl1Vu/bowSieiJy/4G5x3mTV7Obk6ktIIcic+E42dTW3WxMSJBEB+
         68IyDuWAADrxnS4xxQ7FliuravZHxaMgwkmsk8Ogdrup6ezZyviq0N4hLN6CZ9tChZSi
         Z2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=j4UsCyQdcZm2KCJe59FDjzH8nfUWhHJFhxVJ6xfimnY=;
        b=R53CsjjTDkyft1PhCX3aGaATu4hiYww11pnIlRqNJBW5sGoZ3JYMT0EMJHs56JkzC6
         f0D2WeLN+mUC60fwfiZf7Mk8Fxl1FIrvjzdnwSSGr30HqXoDfV0O/O+xSDIqQ8hlr/lO
         gXtabm/nLZZFqYehvPCIAuk5XAb4G5lRwnNpigCFUMKj1ygzsBKR6EaYWfP4QZ0IR7fb
         qTvtsx4Mj73F0ZIhXQcyMQvxuNQO6sqg+NYh+W36JWyZ6swwY/B+gvdJ1MKMhU9DXd3l
         mt2VJgk8NyvjdMErHXxK6PWRBWE13lVP5YONP7tQotRKoXltYaH1Kgky/Nm1BaVi4kuF
         7E3w==
X-Gm-Message-State: APjAAAVWdiLNxeK3CCVlV354D3d3Tc97d37zKVeeGpO2INOTu2r9YLtX
        4awsscxtCh8WRoT0jvkN4WkoIw==
X-Google-Smtp-Source: APXvYqz0dNCJqOn51gF9WLKs0blLiqHdYKWXicmqZcGwIqo2oULL5pMRIbpJqhIRh6h98e57UR7klQ==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr18676120wme.118.1573464646982;
        Mon, 11 Nov 2019 01:30:46 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id z14sm13555064wrl.60.2019.11.11.01.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:30:45 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:30:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 38/46] video: backlight: tosa: use gpio lookup table
Message-ID: <20191111093038.GA3218@dell>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-38-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018154201.1276638-38-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Arnd Bergmann wrote:

> The driver should not require a machine specific header. Change
> it to pass the gpio line through a lookup table, and move the
> timing generator definitions into the drivers itself.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> I'm not overly confident that I got the correct device names
> for the lookup table, it would be good if someone could
> double-check.
> ---
>  arch/arm/mach-pxa/include/mach/tosa.h | 15 --------------
>  arch/arm/mach-pxa/tosa.c              | 22 +++++++++++++++++++++
>  drivers/video/backlight/tosa_bl.c     | 10 +++++-----
>  drivers/video/backlight/tosa_bl.h     |  8 ++++++++
>  drivers/video/backlight/tosa_lcd.c    | 28 ++++++++++++++++++++-------
>  5 files changed, 56 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/video/backlight/tosa_bl.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
