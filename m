Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90F0C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDCB2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkPKbNUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfGAGBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:01:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52477 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAGBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:01:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so14440355wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sIqxMEM0NBpHYUjlaUTenRo0pWUxlEIHY1k8C0artXY=;
        b=IkPKbNUJhDJ7otxRN+J/52FN4L95evNkjAQuxkTBfNZF5Tpz7l4qvdJIsBHPWLQ+gA
         Tj9cdLBkp59lmL2DMy4tjOpIUsVn9iYlSzwcDCmLUs6RzLpZzuoGjC3CPqCUzVCSLNO4
         1ddZsbHGoPyJpd5rIYsNNrq4OTZdHpSuawGoQfQH0K6l/2kVuKn8d3GIZxoifjiMKXPs
         A7ESIC4rA22/r9N450ArhuLnIBzCD6+R1Hxm+Um9ctrYgcm7HQUoOvzktxQ6OMuX+nff
         fVgku5iGWqGlYPnYvl9k8sOhYD9gA3seP+G/EcEDud/9eT2CobUmgEUDtdnsrJdI3seP
         7b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sIqxMEM0NBpHYUjlaUTenRo0pWUxlEIHY1k8C0artXY=;
        b=AUpyRNhj+RK403tY9AF9UjF6A62G59WqyI6WOT6Aw3xmxRM3ek+cseGHZSvF9vIn2l
         mUKHTGRlaZGM3tRSPR99CBh24LtOQkCnasw24XupbxBp15cOdn09LPavB8wEQSNbRAwX
         cqEJMiAxql9g7nB9KRSZWQbeRz7qlDHJihjB6hCv0LNNRidr3N3vO58hZjkHG1yVgA3a
         9KSg3ClqJSGqD9TvQdEU1t5GZsiTDOLr03E3rP90bqIYatuNu1dG8MmXieGzBd9RnMrJ
         vb89UJOLLBBOtSHdeH/7hhgUakYCwUEHJ3KxJlIxihedsQ76w1OmuSdNhJuNkhnzoavi
         hsNA==
X-Gm-Message-State: APjAAAVvt/7dUETjRTXrhRwGf1+zP1L+m8JewXc3CUCFooUJ/4Dv+rpA
        3EHUfaBpUhLAhnLpNsyqj4F0+A==
X-Google-Smtp-Source: APXvYqy2r1rLtjKiBIq2kC1C522JZ69v1WYz5GPfWKQ+ZuQD9SM5ypy+rMbr6Zrqt23phiXUxACSpw==
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr14313864wmh.24.1561960900531;
        Sun, 30 Jun 2019 23:01:40 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id q10sm9185975wrf.32.2019.06.30.23.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2019 23:01:39 -0700 (PDT)
Date:   Mon, 1 Jul 2019 07:01:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: Re: [PATCH v3] platform/chrome: Expose resume result via debugfs
Message-ID: <20190701060137.GB4652@dell>
References: <20190627204446.52499-1-evgreen@chromium.org>
 <CAFqH_53cmq+1Y_uL3D4-84v_vDJsoB0Qxr_zTVnOzX1XD7VEgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_53cmq+1Y_uL3D4-84v_vDJsoB0Qxr_zTVnOzX1XD7VEgQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Enric Balletbo Serra wrote:

> Hi Evan, Lee,
> 
> Missatge de Evan Green <evgreen@chromium.org> del dia dj., 27 de juny
> 2019 a les 22:46:
> >
> > For ECs that support it, the EC returns the number of slp_s0
> > transitions and whether or not there was a timeout in the resume
> > response. Expose the last resume result to usermode via debugfs so
> > that usermode can detect and report S0ix timeouts.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Lee, actually this patch depends on some patches from chrome-platform
> to apply cleanly. Once is fine with you and if you're happy to have
> this merged for 5.3, I can just carry the patch with me, shouldn't be
> any conflicts with your current changes or if you prefer I can create
> an immutable branch for you.

I won't be taking any more patches this cycle, so if you're sure that
it does not conflict, there is no need for an immutable branch.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
