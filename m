Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6670C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F25920836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSI/B3SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBLKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:10:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39762 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBLKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:10:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so523927wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M9H324FRjdDrfn1BGXOWUaO+bADzpYuWXteAhSQNEJU=;
        b=hSI/B3SJ9f3PcffRsqmfICqElS4D/1J7CzSsBmvkuaJw2PRnotdeyasfArFdsOXIq6
         cJgIEeuAgo5NVPOOaaR3NKjmC40YZCiSgoS+wPZlOCu23koM5nk7E1uWY+K+kUojcbwj
         mH9ozbFgwtETXk8PNOAtj2xNF/yOway+NnzdnLafo/o3VC2es8/XgGjhMvGXtH60CuUJ
         UPkyHlzqseIsj3r+WbfchZtKazOKHlc3W6CEa/e5UHy45sBu9wIUyP8gExK+GDM5ehRg
         1Yyo4EH6WUrySydDbhIbH6ajgTDlDHkalA3dKFUXBJEHS3YnkGaWsdvo62BnEq8CIwhG
         /S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M9H324FRjdDrfn1BGXOWUaO+bADzpYuWXteAhSQNEJU=;
        b=oATqqFxTym51z8APYprJt8d6Ern2wMfAq2zUOWQj9uhIvTa3ss+roFsKVF7BK6YZhh
         BAvwroEFkEDgmgQynee6gVcYOCpuWTlncTHc/2Bhi/P1Uy/W113AYnNySmoXaHW5Z1lR
         HOOxFAp9GYcbN3lBPvT+KVB35i30z408cLAxrMp4JqOAqzacfHzEGAG7PGMRSaStv0Q2
         rz0pd+8YO0+eC3BmBgEoQyMFYMB6MHLOuNDeADjjfyj9FEffgMTmTv12MFhwc2xrldK7
         vYSeNFxSb+qlvY5uj7orv74B80TuOzqavQc0QuHEuxsfXfXtz6nxTlpAF5DnyYrHA9Be
         pEYQ==
X-Gm-Message-State: APjAAAVJZPY/UA9FZcRvuXV3VP08ny3qx07SD5n5QKbh+AyY/krnTFPp
        Ctp7ETp5iA4E/JUv1nso8Uv/qg==
X-Google-Smtp-Source: APXvYqx/h/NKywgbs2fPNux/OZHTt4/o6YuD6C3CEv0y+eQOHU7oMXOUIA8dDSI8+luOIUS+dn2Nfw==
X-Received: by 2002:a1c:e28b:: with SMTP id z133mr2918147wmg.136.1562065801695;
        Tue, 02 Jul 2019 04:10:01 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id b9sm7342304wrx.57.2019.07.02.04.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 04:10:00 -0700 (PDT)
Date:   Tue, 2 Jul 2019 12:09:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Keerthy <j-keerthy@ti.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gustavo@embeddedor.com, keescook@chromium.org
Subject: Re: linux-next: build warning after merge of the mfd tree
Message-ID: <20190702110959.GF4652@dell>
References: <20190627151140.232a87e2@canb.auug.org.au>
 <1b5aa183-6e33-ee15-4c65-5b4cdf7655af@ti.com>
 <20190702184916.5f0f9e99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702184916.5f0f9e99@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jul 2019, Stephen Rothwell wrote:

> Hi all,
> 
> On Thu, 27 Jun 2019 11:29:18 +0530 Keerthy <j-keerthy@ti.com> wrote:
> >
> > On 27/06/19 10:41 AM, Stephen Rothwell wrote:
> > > Hi Lee,
> > > 
> > > After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
> > > produced this warning:
> > > 
> > > drivers/regulator/lp87565-regulator.c: In function 'lp87565_regulator_probe':
> > > drivers/regulator/lp87565-regulator.c:182:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >     max_idx = LP87565_BUCK_3210;  
> > 
> > Missed adding a break here. Can i send a patch on top of linux-next?
> > 
> > >     ~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > > drivers/regulator/lp87565-regulator.c:183:2: note: here
> > >    default:
> > >    ^~~~~~~
> > > 
> > > Introduced by commit
> > > 
> > >    7ee63bd74750 ("regulator: lp87565: Add 4-phase lp87561 regulator support")
> > > 
> > > I get these warnings because I am building with -Wimplicit-fallthrough
> > > in attempt to catch new additions early.  The gcc warning can be turned
> > > off by adding a /* fall through */ comment at the point the fall through
> > > happens (assuming that the fall through is intentional).
> > >   
> 
> I am still seeing this warning ...

Just pushed the fix for this.

Thank you Stephen.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
