Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229CC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A813B21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqvWBYuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfISHSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:18:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50739 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388129AbfISHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:18:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so3037933wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QxxMjRHDm4APH+b9Qt4ViRoWngYsX/vt7D8wYhdjHVk=;
        b=zqvWBYuBH8eox6D7Km0km27clVLH3Llm4JnMONtyosn7vywtzkHr53r9E1LxbiZ0o/
         UIQQWmQALHPUfReMCSbkzW6HCUitoUzYG/iGa2jKjPuxUuiX7mXJeQsLvT8LJdOFecsb
         zlm9Ys4MJDbLejfsBoN1KZuke10QbOf+a+4eSpD4iY7ddAKrlWMR+47t/RFlmmCt+Lax
         Z184WRfa2xdLHbsq6JWlhUPVz5CXHq48D5osmpxF9BeEvNHoHfcyNyR7Hss2uuxIql9H
         RnuDrjTJvby3fPqca1n5d4xsBlGyVVIlPEIbIicvbZ/HbFccdJLN1ZlWvJdi7roxUf7H
         CPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QxxMjRHDm4APH+b9Qt4ViRoWngYsX/vt7D8wYhdjHVk=;
        b=iT76Vs+F3hNmAQUE2BwA3SS7PzA3u+BHnDSh0PCfBFnb+T8gL17cs7kCKA2NxxK89X
         +WC2icLEOtFQov03MYpVv6ySwDevXaCRlc9GMJB/cM3Spc1bgh5omF9omQPiwpau8ZQm
         uSML4PIcg/twedisN1TOuwhjJqXw+gw5est+AZWWe0J8//BQ+UylEsCQBWDAKV9eNR0d
         sg9sKUCX/PdIFmFg1XOH2+JQRfq5z3/8aHhMmxbWpO7NVBRoJHV5n1PSaGplebqZ7y8P
         G8qB/6T9Z1Eyq5toB/srxsJtpFGzfmdEdsThaYpbe2JKb2HH6WHYL7Y9Z1L+SVrg5w3y
         Ojcg==
X-Gm-Message-State: APjAAAX93U2S7kW39+JCeP65ocF1Q8yB4YC3wCuPYugcFhnFi7MeplZY
        fFcnIqz5tyJ4bsFCjp9EhbRfmg==
X-Google-Smtp-Source: APXvYqzxUtDkzlPONyaEJEn/HK8YbIui9AV6lxGKSRcCGcU6JS44vJWS1cokRMHnD98RW1d/P9gblQ==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr1438947wmz.88.1568877522052;
        Thu, 19 Sep 2019 00:18:42 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id t1sm988908wrn.57.2019.09.19.00.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 00:18:41 -0700 (PDT)
Date:   Thu, 19 Sep 2019 08:18:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com
Subject: Re: [PATCH] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20190919071828.GC5016@dell>
References: <1568801744-21380-1-git-send-email-gene.chen.richtek@gmail.com>
 <20190918105121.GB5016@dell>
 <CAE+NS37XG+kfbj6yJrL5A-d2O_aiRU90yV5TUk3Kfa0Rv7dWmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS37XG+kfbj6yJrL5A-d2O_aiRU90yV5TUk3Kfa0Rv7dWmw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2019年9月18日 週三 下午6:51寫道：
> >
> > On Wed, 18 Sep 2019, Gene Chen wrote:
> >
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Add mfd driver for mt6360 pmic chip include
> > > Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> > >
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com
> > > ---
> >
> > This looks different from the one you sent before, but I don't see a
> > version bump or any changelog in this space.  Please re-submit with
> > the differences noted.
> >
> 
> the change is
> 1. add missing include file
> 2. modify commit message
> 
> this patch is regarded as version 1

It's different to the first one you sent to the list, so it needs a
version bump and a change log.  There also appears to still be issues
with it, if the auto-builders are to be believed.

Do ensure you thoroughly test your patches before sending upstream.

Please fix the issues and resubmit your v3 with a nice changelog.

> > >  drivers/mfd/Kconfig                |  12 +
> > >  drivers/mfd/Makefile               |   1 +
> > >  drivers/mfd/mt6360-core.c          | 463 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/mt6360-private.h | 279 ++++++++++++++++++++++
> > >  include/linux/mfd/mt6360.h         |  33 +++
> > >  5 files changed, 788 insertions(+)
> > >  create mode 100644 drivers/mfd/mt6360-core.c
> > >  create mode 100644 include/linux/mfd/mt6360-private.h
> > >  create mode 100644 include/linux/mfd/mt6360.h
> >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
