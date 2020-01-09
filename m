Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15389C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8254206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IpkS1SiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgAIRay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:30:54 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:32904 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIRay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:30:54 -0500
Received: by mail-il1-f195.google.com with SMTP id v15so6398308iln.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twOuUpbQw49zp8/G9wABCGIBfFXQkj0331JfE2v3Btw=;
        b=IpkS1SiFTZyaeAz8LcGQFXVLSgaAWLn2D3zMJu8CW/ezuu9PLFx7/bjfx7abwWmzLe
         mH8tW0Vw5fBvvRp2ws6Un6gJxCwJoNsZZD2fl+HDzBFlm7L/9Zqd5PNw3slGZlzEiMtR
         cbe1AKq7Jcc1WxWM3FvvImDCU5swQxFhx+kks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twOuUpbQw49zp8/G9wABCGIBfFXQkj0331JfE2v3Btw=;
        b=bBx4eqlFHVXrFg53XKHlcYUwXA8soqdepSkJzvYSrmywvX3dvnb6LtFeZhhGcZl3tY
         PdkobAzG/6A4xtLiJJa2OXbGAxI4uuZ9Rn9RDILFVWeZldseZtA9Byb0yey7lHLiVwoj
         vawNh1GCt3ZZcVQOMN05uR5yhoTyN9kxJ86ZviKImq2zw8DEa3kR1G9eCqi0SjZoyFyg
         93tovFwe3u8gOVF4XF+FdZqIJDdFO0kcTfprE5sp7nRREHf31HNxcxA09z3/yllvH6fK
         I2yFL5KJ61bhdC2TkWVvc5bJthSOMWyX33QrYrK2pUUMsGGiuS+agKDePdaI/wVgo2TH
         lsoA==
X-Gm-Message-State: APjAAAUESJ3/RHSqgLTbF1+l9qGKWixXuFZAl9633MI8Lo4I2y6qSwVo
        tBLIKXXBT6BGw1r2wwh9+TOT6Q==
X-Google-Smtp-Source: APXvYqw6m3bMUlK1F5HGHoGIdsjw0E6YGiTW702ZHqWgdcajvP8XZ0JWU20bQgKzUYIiXjzvLM0l2A==
X-Received: by 2002:a92:911b:: with SMTP id t27mr9645184ild.142.1578591053869;
        Thu, 09 Jan 2020 09:30:53 -0800 (PST)
Received: from chromium.org ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id b1sm2192114ilc.33.2020.01.09.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 09:30:53 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:30:51 -0700
From:   Daniel Campello <campello@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Fix unregistration order
Message-ID: <20200109173051.GA78461@chromium.org>
References: <20200108093459.2.Ia8f971d42dcf892541a806b906414ddfbe4fea36@changeid>
 <9cf68a0b-ed58-168a-4c04-753a7a9f55bd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf68a0b-ed58-168a-4c04-753a7a9f55bd@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for helping get this in.

On Thu, Jan 09, 2020 at 10:06:37AM +0100, Enric Balletbo i Serra wrote:
> Hi Daniel,
>
> Many thanks for the patch, some comments below.
>
> On 8/1/20 17:35, Daniel Campello wrote:
> > Fixes the unregistration order on the Wilco EC core driver to follow the
> > christmas tree pattern.
> >
>
> It is logical to cleanup in remove's function in reverse order to probe, but
> that's not related to the Christmas tree pattern. I changed the commit
> description and queued for the autobuilders to play with. If all goes well will
> appear in chrome-platform-5.5
>
I got this confused. Thanks for pointing it out.
>
> > Signed-off-by: Daniel Campello <campello@chromium.org>
>
> Is this patch fixing an actual issue?
>
No issue, just style cleanup.
>
> Thanks,
>  Enric
>
> > ---
> >
> >  drivers/platform/chrome/wilco_ec/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> > index 5210c357feefd4..2d5f027d8770f8 100644
> > --- a/drivers/platform/chrome/wilco_ec/core.c
> > +++ b/drivers/platform/chrome/wilco_ec/core.c
> > @@ -137,9 +137,9 @@ static int wilco_ec_remove(struct platform_device *pdev)
> >  {
> >  	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
> >
> > +	platform_device_unregister(ec->telem_pdev);
> >  	platform_device_unregister(ec->charger_pdev);
> >  	wilco_ec_remove_sysfs(ec);
> > -	platform_device_unregister(ec->telem_pdev);
> >  	platform_device_unregister(ec->rtc_pdev);
> >  	if (ec->debugfs_pdev)
> >  		platform_device_unregister(ec->debugfs_pdev);
> > --
> > 2.24.1.735.g03f4e72817-goog
> >
