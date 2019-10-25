Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9497DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C4221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlMstyT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437984AbfJYIx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:53:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45115 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437783AbfJYIx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:53:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so1322740wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xvMV2lTjYYndNFlZSogoRJwtCYarX8hEWrKlnNonIDs=;
        b=LlMstyT7/QZxxzLumyNdWSE4VwJmLeiAJrHURYPRQYk+cOdjDqJfKsnoCmT+v8xm6T
         evnmfoUIP39tkx3GIlIGiVAlfuz3340MObs713msmAEsr83J966V0DegE6U8pjmP1GKi
         BSqW5ujuWiU4bEWreWy9sQoDI6ZDinL/RepAVENyIAFBXN+vbdmNNVQxYODcTjbwOsQ+
         91jghmO/SpJqnVe7KUhKNb7olJLtZM1RbZ0V27EQaz+qtHAkc2MDXdRlEs1DOfYZds5Q
         2SKx/FA6608fZbgAqAJkhR/hzhlLAPR7z4CiqLp12GPCQeZoDePfrU3q4reKdzCT9ybB
         pM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvMV2lTjYYndNFlZSogoRJwtCYarX8hEWrKlnNonIDs=;
        b=NaDgAwWxwOZaRQzp/zifE/aXtJv8Y+WZWs5Ed+o/WtRIPrEjO7LhthO1q6RZRyxQVg
         1jv6spKzXawycCiiZWBxPx953dw4uH07XOV0VyQiYJPev7lpwBXZO9c476pM5K7IwSa/
         IRF1C4c9a+1pqwPDYqTImKfcixAVuUSln5urJI6jRC3wUm8DdnbNELVoucvRwNYiIk2j
         ThImonZKLqRYqu0P6GnmaqGb/hzzeqKfhfwfv74n2lyTGZ4kdBQdou1VngbHeSFWO41z
         47Tdkiw7xhHNVmn43SoBHgdEGYUXY+Zg9T9xn9eVrG3bj46lGYeRY1rrVlFK2ak09jng
         Yy+g==
X-Gm-Message-State: APjAAAU2748MN6o3RbTekkt2Ww7CpLWLjFYO19oejMbhm/VlnH0/Luto
        Pk+LLmN7I6qxDugllWhNgw6kwQ==
X-Google-Smtp-Source: APXvYqxaNRRvLimHjbrPbQpnVDMDxSMM55r4+JN+AELtmLfi6nxsELz7rEeeHJgXt4GJvzTzzKbsmg==
X-Received: by 2002:adf:bad3:: with SMTP id w19mr2041099wrg.17.1571993635508;
        Fri, 25 Oct 2019 01:53:55 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c189sm1479227wme.24.2019.10.25.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:53:54 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:53:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v3 06/10] x86: olpc-xo1-pm: Remove invocation of MFD's
 .enable()/.disable() call-backs
Message-ID: <20191025085353.c6o63ed54vspjxzh@holly.lan>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-7-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:38:28PM +0100, Lee Jones wrote:
> IO regions are now requested and released by this device's parent.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  arch/x86/platform/olpc/olpc-xo1-pm.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
> index e1a32062a375..f067ac780ba7 100644
> --- a/arch/x86/platform/olpc/olpc-xo1-pm.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
> @@ -12,7 +12,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/export.h>
>  #include <linux/pm.h>
> -#include <linux/mfd/core.h>
>  #include <linux/suspend.h>
>  #include <linux/olpc-ec.h>
>  
> @@ -120,16 +119,11 @@ static const struct platform_suspend_ops xo1_suspend_ops = {
>  static int xo1_pm_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> -	int err;
>  
>  	/* don't run on non-XOs */
>  	if (!machine_is_olpc())
>  		return -ENODEV;
>  
> -	err = mfd_cell_enable(pdev);
> -	if (err)
> -		return err;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "can't fetch device resource info\n");
> @@ -152,8 +146,6 @@ static int xo1_pm_probe(struct platform_device *pdev)
>  
>  static int xo1_pm_remove(struct platform_device *pdev)
>  {
> -	mfd_cell_disable(pdev);
> -
>  	if (strcmp(pdev->name, "cs5535-pms") == 0)
>  		pms_base = 0;
>  	else if (strcmp(pdev->name, "olpc-xo1-pm-acpi") == 0)
> -- 
> 2.17.1
> 
