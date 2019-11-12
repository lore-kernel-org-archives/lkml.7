Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40598C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FA52067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycl/pP1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKLSG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:06:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40476 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKLSG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:06:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id e3so9727258plt.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dmOmt8ByQhAHvaxxxTyNZcZ2nUfxUzBc/uGFwV4SbSU=;
        b=ycl/pP1btP14ouY7K+vcJC5xiS1I5M7qxDjCVmlocaQTQz7vi8nLfwR0QPdFz67uox
         b87uQsUvkIiGJ94d9w0dtdIxOKsI44bmgvo++It5UWCZhLSzyN0E9SgnU0+WGlS/x1dQ
         gONe3gYFNQ1nsD5u1rMIYjPzVXRNPbvWu95v+vTEd7fPsgXl0S8Z8eRiMPWv5mFpPxVO
         d4tAecCAFWmTaAHfqNX5nZvKKuNO9s7NgiFvmnPTWagcdNpZeTdo9JbapJfwz4Qp/rjL
         zlB/WxaZhxe0bEAl4GCSn9YoYJMt4ZyQpmNzVhwTeEg0Mv51wl+yqh1rp800eKl7z3MH
         yAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dmOmt8ByQhAHvaxxxTyNZcZ2nUfxUzBc/uGFwV4SbSU=;
        b=aR3ctz0m4ZxHwsLrj3jBOXy5zFhvOV8UOYROvtzOVCHOxYIavqPWeON8Td5gcD9CVY
         SdMkkNRGW69YTBp7Hg6tWKffMmXfR5WS23B8xlYAjKRXZ4OlyWzvGEnoMPMlVm1mzCt5
         w/bskuBk7d34otJFFRGT6BuYos7d2t9Lm84D7W6RlxkVILneYGn3oBHqjxINGfIa3tR7
         uQUesi8WUqBWYhd/+2PH8TR+Qtp4ylD2jha65HgYD3vNhDyzYbC3I6iDqbhQ8NoN2gDk
         R64sM3n3D7vw5+hWybfh2t6Ts9HrAeh57huNxS/JkQmt+BuABaZ8wUbY/OAhzUGImz1B
         OKtQ==
X-Gm-Message-State: APjAAAVMecWmwPbLnm5vSXPDrBSl3gSVT2xSNHSoprTer/w/m0bTjmJX
        j37y3CfdPyu9s2/85Vj+Isa0XQ==
X-Google-Smtp-Source: APXvYqzJOIqA2UQlBiELNyb5KPyThnpCF6y+0o1uy4rZHgtyGnYlzKWdVRUGip9UfAPzDdNhxTkbyw==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr24266624plo.150.1573581986157;
        Tue, 12 Nov 2019 10:06:26 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j21sm12610671pfa.58.2019.11.12.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:06:25 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:06:23 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com
Subject: Re: [PATCH 13/17] remoteproc/omap: add support for system
 suspend/resume
Message-ID: <20191112180623.GI3797@yoga>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-14-t-kristo@ti.com>
 <20191112061536.GO3108315@builder>
 <c0fe03eb-86c9-8c67-684e-b1f6f606b7ed@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fe03eb-86c9-8c67-684e-b1f6f606b7ed@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Nov 00:45 PST 2019, Tero Kristo wrote:

> On 12/11/2019 08:15, Bjorn Andersson wrote:
> > On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
> > > diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> > [..]
> > > +static int _omap_rproc_suspend(struct rproc *rproc)
> > 
> > I think it would make sense to inline this and _omap_rproc_resume() in
> > their single call sites.
> 
> Well, these get re-used in following patch for runtime PM also, so it is
> probably better leave this for compiler to decide?
> 

I didn't see that until later, this is fine.

Regards,
Bjorn

> > 
> > [..]
> > > +static int _omap_rproc_resume(struct rproc *rproc)
> > > +{
> > [..]
> > > @@ -806,6 +972,14 @@ static int omap_rproc_probe(struct platform_device *pdev)
> > >   			oproc->num_timers);
> > >   	}
> > > +	init_completion(&oproc->pm_comp);
> > > +
> > > +	oproc->fck = of_clk_get(np, 0);
> > 
> > devm_clk_get() ?
> > 
> > Otherwise I think you're lacking a clk_put() in omap_rproc_remove()
> 
> Yeah, let me replace with devm_clk_get.
> 
> -Tero
> 
> > 
> > Regards,
> > Bjorn
> > 
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
