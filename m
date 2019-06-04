Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D309C24ABC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AprUw2fU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFDFsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:48:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55389 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfFDFsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:48:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 16so8990437wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 22:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d0PHWADGUTRHP3RbtVmcCFQIV5Xx7EXkRTIqij8bmTU=;
        b=AprUw2fUY0LjS5Diu/tR2Pmn7vwhaxX8wO278qS0E1kpmPhfqoJ0SXgBwesswQaVj1
         8PK7CdzlaqoLFTCdNpyPgYKJiTifXUzb7GhCqfnJ6N/EE9NUs7tNdhJ2uxK5+rDjUaBJ
         t2T42Okzeb79umghXaLPG4nfl0wp2e7t7KThJk2vD2Y6jbt5zzprKHpoAdfhMCbn1WcR
         v2cr1nwtmyUGeQfjsfAab/OslH0UZawmNrfbyyqZ1s1NEfYWnumslps++LeCw3VIhhyp
         sjPlWOQ75u6UuUF6C9guxJgimDoB9IPQFkMSHf9aYodOQwamPQubvdlKUlGoeisaMxAh
         Kwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d0PHWADGUTRHP3RbtVmcCFQIV5Xx7EXkRTIqij8bmTU=;
        b=XbGwut/4yujHzuPyNyH/laCaM+JTRoULHaEDT+It75KoVcMaSLoRrsK/2eZmXCa/n/
         lpisRor+a8Pgnd0xYG13o9IieYX5XSayuga+/BCHTXWBPmlv3IgnHhzSHxLZbFbqd/12
         kt4rYJpbgrk73fjNFIo4aqYp0A3wwI537UzYYC924vERB+R2XGevEmAhp6Dx58hhduwy
         CjDHLFJLIBKRAakVcIiSo0cC3F3VkIBqHNyw+6CM1HiuLGyJY9Zbj2AcNq4H4uJIa6Lz
         P8+vT0VF/UgIXCIErhmmMcjpbQW+Gsn9b0F85uRnXMAsoGUdIubG6P4JkTe3wgI5oHEj
         FR+g==
X-Gm-Message-State: APjAAAXpkMQDruQDX9NUldqbmwurzvKej2FWh76KwL+0I7sVXaQrLJ37
        sO7TAP61lhEQBGNo12kP0Ph3zw==
X-Google-Smtp-Source: APXvYqwIIlQozIHS1omANt46ZYA1k5oV3Ls5bT0crSJhfYkQnCeDPC78T92R6f4ncEyKrlsTMbBaHQ==
X-Received: by 2002:a1c:305:: with SMTP id 5mr17363067wmd.101.1559627287208;
        Mon, 03 Jun 2019 22:48:07 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id x8sm5149737wmc.5.2019.06.03.22.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 22:48:06 -0700 (PDT)
Date:   Tue, 4 Jun 2019 06:47:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, cychiang@chromium.org,
        tiwai@suse.com, fabien.lahoudere@collabora.com,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190604054756.GZ4797@dell>
References: <20190603183401.151408-1-gwendal@chromium.org>
 <20190603194249.GD2456@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603194249.GD2456@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jun 2019, Mark Brown wrote:

> On Mon, Jun 03, 2019 at 11:33:31AM -0700, Gwendal Grignou wrote:
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> 
> I'm not clear why I keep getting copied on this series or why it's being
> resent?

Not sure why you're copied in, but I asked him to resend.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
