Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C1F218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtgdLdUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJTP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 11:27:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33279 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfJTP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:27:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so6755116pfl.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w2Zv3HNUNvEUlGbiP8S0+092JhdRJqXxS9fnpsLG4iI=;
        b=PtgdLdUwnrWFnJOz5gJvi3BiIDxy+S7gPcoCoYksIkA//BpTzN2oX+JtNk4tMmwLUO
         Etw1tquOBI0VQLbzCiNVhQO26kJvstsHisiJcmxN72pmqSpW3xUBoa35WvnXi/2sSt+K
         mhRZoLUCMcudqk6frRppSkM+nRF+PLZT1Vm+GsVLD7tTko9BkEfrExihtC4YpEGRZVsa
         22HMfMyFZjuiZyEpy69wCHrg+V+2TbDcIMh9fsq5Ss9zIoIz6koxouav4j8gbDlEAJI9
         QCIw8cpY4lSNqHILW2D5IwUZ9MC5C/rXOXm6TtZhSLkXUKpEDM4U9dYNnfkngmga++RE
         rpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w2Zv3HNUNvEUlGbiP8S0+092JhdRJqXxS9fnpsLG4iI=;
        b=SgF94T8c+OnSWvkBf9Zm9hSJBVhc263sCDICa+89sXCIbra6cmDGA1nZdjR+uRKK+9
         t8aFRbU4WCOlRU7Anj8tTFmVbaoiCKG9eNZ8DpiPS7cOBuw7VTt7SupBCmNsi3tgiQ5h
         rOi9mLC2PdYCpyIffrGL00OqmzSBxa87rFP1Tb52R0XIlYGraJcgEpJjUfdUJfgqHXeq
         mYka23IVA9Am+hPso0SnUM3vchtnXb85vO3FvIfpBppJ+265H0lQYy36stFrKrK0VPXY
         VftdCKgvnwdtjFv3UwzQOVUhr+hld402HLlyT91qTtqBlrV2Q6KAljSQaT1elqyT/oQ0
         3TSQ==
X-Gm-Message-State: APjAAAUe4RH0DiCm84DcvSNAgtD4yuB7yumjt4WGx1wGshnGqXO/0EPj
        pVbmHb76i/NVNowms5NOKR31
X-Google-Smtp-Source: APXvYqzHj2mGchufEakers/95JHOcu48NokH6SL9q1fsY1Xo9ttGYQDtdbsumhCbdlHImScX/HTZWA==
X-Received: by 2002:a17:90a:2522:: with SMTP id j31mr23189515pje.123.1571585225946;
        Sun, 20 Oct 2019 08:27:05 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:619e:9471:81c6:faf1:b3a2:6750])
        by smtp.gmail.com with ESMTPSA id h4sm13651404pfg.159.2019.10.20.08.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Oct 2019 08:27:05 -0700 (PDT)
Date:   Sun, 20 Oct 2019 20:56:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
Subject: Re: [PATCH v5 3/8] clk: Add clk_hw_unregister_composite helper
 function definition
Message-ID: <20191020152658.GC12864@Mani-XPS-13-9360>
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org>
 <20190916161447.32715-4-manivannan.sadhasivam@linaro.org>
 <20190917204042.D69A52054F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917204042.D69A52054F@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 01:40:42PM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2019-09-16 09:14:42)
> > This function has been delcared but not defined anywhere. Hence, this
> > commit adds definition for it.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Can you add a fixes tag?
> 
> Fixes: 49cb392d3639 ("clk: composite: Add hw based registration APIs")
> 

sure.

Thanks,
Mani

