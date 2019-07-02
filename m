Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBFFC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8833520673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkXLcra1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGCBlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:41:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45813 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:41:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so474556lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtNNYBNm1JpUmlbSXfOacWdVL+xLaEisgn4cxAyFWvc=;
        b=XkXLcra1GETf+BjtJgZFGGJHgfnyaEAhtVwPsFzqTDtvSzk7K4cYGXdzyMAn0iXhD2
         jsNS6ZX2Aig66f9lDi2DLk1VyTpg3+i6+S6+juCkqyrX+EgUjwPPgnJtLo2kld0p2Dc8
         mCYGIjeTEDVqSC1PpMFh9xH34snfD/cCl6XZf5oCIQVG8O8rVciIhMX9NnqexpCU9HN7
         YUm7aWXL2c54UWB+iwQ6zBqf1j7H3sZwddoqOAoAy7101fVpNGN+EO/kVTsjZ8Tkk6K+
         +1/1g0WsmEjJnan0VHjp5QH1Y5+G32htVXnLNhAFEtB297GY/1rPX5IZSa01NuqSmvDs
         RDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtNNYBNm1JpUmlbSXfOacWdVL+xLaEisgn4cxAyFWvc=;
        b=gsEy+WkKkVLalu67QpfO5sbFXBZQOfZdBfGC7rl3vAyeDj222RYJDiGXF7QPyDF5eS
         8OM0mtvJiJHBaEV5hW/foiHyDaWDgybMFDHmaHwpPFtScryQNrm00MGGKSqX7tGzz/0B
         mUcmkFEueQm+42W8Yrt4aGHDrisU6fO20c8QN7Cwyw0+QJs37AKGN0q7I9g6Ol5zdUd3
         IobbGX+nGvKUMaerq2fxsq9VgHhUxHkAuAQyN05UgbbG5Xl1L73i6WcaV3vzRuLauvqG
         mXn4zEibPeXDJW99J62uYYRxvLVUJOysEGZlZUAk0R9lhZw0VkhtlXBLyynpx3M7c/ph
         oVnA==
X-Gm-Message-State: APjAAAUsA6GKAwdSAQHTO3UamXJ6baKynDDSsFLHIdkgfEAcY3JIuyyj
        Rk9TfCBPjw/36ulmPYUyV0o8dyVGi44=
X-Google-Smtp-Source: APXvYqzEF5k5CVr4U5Ts3OSMxtAglpPUPMGzRm0CSe0eCHDtkMHcNuXCddOhxidOixjNKCUNogmnDg==
X-Received: by 2002:a19:7912:: with SMTP id u18mr15034634lfc.81.1562099313342;
        Tue, 02 Jul 2019 13:28:33 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id o187sm7642lfa.88.2019.07.02.13.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 13:28:32 -0700 (PDT)
Date:   Tue, 2 Jul 2019 23:28:30 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        grygorii.strashko@ti.com, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: core: page_pool: add user refcnt and reintroduce
 page_pool_destroy
Message-ID: <20190702202829.GI4510@khorivan>
Mail-Followup-To: Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        grygorii.strashko@ti.com, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20190702153902.0e42b0b2@carbon>
 <156207778364.29180.5111562317930943530.stgit@firesoul>
 <20190702144426.GD4510@khorivan>
 <20190702165230.6caa36e3@carbon>
 <20190702145612.GF4510@khorivan>
 <20190702171029.76c60538@carbon>
 <20190702152112.GG4510@khorivan>
 <20190702202907.15fb30ce@carbon>
 <20190702185839.GH4510@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190702185839.GH4510@khorivan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:58:40PM +0300, Ivan Khoronzhuk wrote:
>On Tue, Jul 02, 2019 at 08:29:07PM +0200, Jesper Dangaard Brouer wrote:
>>On Tue, 2 Jul 2019 18:21:13 +0300
>>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>>
>>>On Tue, Jul 02, 2019 at 05:10:29PM +0200, Jesper Dangaard Brouer wrote:
>>>>On Tue, 2 Jul 2019 17:56:13 +0300
>>>>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>>>>
>>>>> On Tue, Jul 02, 2019 at 04:52:30PM +0200, Jesper Dangaard Brouer wrote:
>>>>> >On Tue, 2 Jul 2019 17:44:27 +0300
>>>>> >Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>>>>> >
>>>>> >> On Tue, Jul 02, 2019 at 04:31:39PM +0200, Jesper Dangaard Brouer wrote:
>>>>> >> >From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>>>> >> >
>>>>> >> >Jesper recently removed page_pool_destroy() (from driver invocation) and
>>>>> >> >moved shutdown and free of page_pool into xdp_rxq_info_unreg(), in-order to
>>>>> >> >handle in-flight packets/pages. This created an asymmetry in drivers
>>>>> >> >create/destroy pairs.
>>>>> >> >
>>>>> >> >This patch add page_pool user refcnt and reintroduce page_pool_destroy.
>>>>> >> >This serves two purposes, (1) simplify drivers error handling as driver now
>>>>> >> >drivers always calls page_pool_destroy() and don't need to track if
>>>>> >> >xdp_rxq_info_reg_mem_model() was unsuccessful. (2) allow special cases
>>>>> >> >where a single RX-queue (with a single page_pool) provides packets for two
>>>>> >> >net_device'es, and thus needs to register the same page_pool twice with two
>>>>> >> >xdp_rxq_info structures.
>>>>> >>
>>>>> >> As I tend to use xdp level patch there is no more reason to mention (2) case
>>>>> >> here. XDP patch serves it better and can prevent not only obj deletion but also
>>>>> >> pool flush, so, this one patch I could better leave only for (1) case.
>>>>> >
>>>>> >I don't understand what you are saying.
>>>>> >
>>>>> >Do you approve this patch, or do you reject this patch?
>>>>> >
>>>>> It's not reject, it's proposition to use both, XDP and page pool patches,
>>>>> each having its goal.
>>>>
>>>>Just to be clear, if you want this patch to get accepted you have to
>>>>reply with your Signed-off-by (as I wrote).
>>>>
>>>>Maybe we should discuss it in another thread, about why you want two
>>>>solutions to the same problem.
>>>
>>>If it solves same problem I propose to reject this one and use this:
>>>https://lkml.org/lkml/2019/7/2/651
>>
>>No, I propose using this one, and rejecting the other one.
>
>There is at least several arguments against this one (related (2) purpose)
>
>It allows:
>- avoid changes to page_pool/mlx5/netsec
>- save not only allocator obj but allocator "page/buffer flush"
>- buffer flush can be present not only in page_pool but for other allocators
> that can behave differently and not so simple solution.
>- to not limit cpsw/(potentially others) to use "page_pool" allocator only
>....
>
>This patch better leave also, as it simplifies error path for page_pool and
>have more error prone usage comparing with existent one.
>
>Please, don't limit cpsw and potentially other drivers to use only
>page_pool it can be zca or etc... I don't won't to modify each allocator.
>I propose to add both as by fact they solve different problems with common
>solution.

I can pick up this one but remove description related to (2) and add
appropriate modifications to cpsw.

-- 
Regards,
Ivan Khoronzhuk
