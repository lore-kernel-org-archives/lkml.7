Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130F4C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB4121479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCN9X2D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfGBO4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:56:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38879 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGBO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:56:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so17212774ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7rK7qDKEwGgygAo6exJfMYowjRvJTz2OfqB0lXA6Pfg=;
        b=PCN9X2D/JW/E7t0T4zSJTdmG1LASGkY2AXb3iTdWBl644wY1XW1wMWZx2DP2Z/7KHI
         3FJIpNnyGXhQsq+k3+NYCBfzwP9WdvqY75RlPTDw4pbqNOD/6m8H3qw/qg0N18SQ/wPt
         4c4uLlo1rPSeaYy0OMQOej73UvqLzO8XZcxw5AYlPCAfA6XdXD25Or/zz8kahtocP9k1
         HP6k/DoZ2d5hSz4DPGbHfR7v85tgbjBOzfay3uzxZnKkWtBdzfzfn1GjSUTwNq4YXCRj
         FEh7jnHkPs4vr0tyZ+XMoXSHKnN/Cf8+zUif3+xZqPp/bBUyCM7u5iwhWe6jUlRv/UeN
         Wf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7rK7qDKEwGgygAo6exJfMYowjRvJTz2OfqB0lXA6Pfg=;
        b=CEvsNPFCTMpH7cLGf0Lem/RcEKnJMDsZuFrtuBAAymkehZBJrOTjV6XlDaNAccdMN8
         e2uteHRPoMgBg1hLNAEb3GBDQfTt1T1U3uiQmSgLxlYtkaciEuVNUi504AI8FRuaTp26
         e7sqC+2JuPDyfVxL/0E9aghzZXt9tQPpntHbJl/zPnRB4b9h4NGLKgPz+rFECbWU/koq
         7Ua/vI9jlfRHaGBR1mfrxyDZRzXBYefNNzffisSNXKD94fiz5kO0vY6O5H8h60KKjVlf
         OETEIS47BuR8RtSomncDwFfdNBm3z+RpYFJ1prrs+5RSFK1SBHNwwgNNJ0yux2JC+jwA
         t6Jg==
X-Gm-Message-State: APjAAAWc74zaaqykE1E7Do+Le0grG9Z2sAFp+PrKEGeIY2Sm0O9c9TKo
        hWGfw1JKtno0n+IioAo/MM0Lrg==
X-Google-Smtp-Source: APXvYqxOMQT0G6y7V2pn2t8I+DIDfhNyZFaiJCq4TFQLkjR1uetJemhwCrBPg9N3EDdg7uo1Fm1J1w==
X-Received: by 2002:a2e:5302:: with SMTP id h2mr17005806ljb.47.1562079375922;
        Tue, 02 Jul 2019 07:56:15 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id v202sm241305lfa.28.2019.07.02.07.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 07:56:15 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:56:13 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        grygorii.strashko@ti.com, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: core: page_pool: add user refcnt and reintroduce
 page_pool_destroy
Message-ID: <20190702145612.GF4510@khorivan>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190702165230.6caa36e3@carbon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 04:52:30PM +0200, Jesper Dangaard Brouer wrote:
>On Tue, 2 Jul 2019 17:44:27 +0300
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>
>> On Tue, Jul 02, 2019 at 04:31:39PM +0200, Jesper Dangaard Brouer wrote:
>> >From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> >
>> >Jesper recently removed page_pool_destroy() (from driver invocation) and
>> >moved shutdown and free of page_pool into xdp_rxq_info_unreg(), in-order to
>> >handle in-flight packets/pages. This created an asymmetry in drivers
>> >create/destroy pairs.
>> >
>> >This patch add page_pool user refcnt and reintroduce page_pool_destroy.
>> >This serves two purposes, (1) simplify drivers error handling as driver now
>> >drivers always calls page_pool_destroy() and don't need to track if
>> >xdp_rxq_info_reg_mem_model() was unsuccessful. (2) allow special cases
>> >where a single RX-queue (with a single page_pool) provides packets for two
>> >net_device'es, and thus needs to register the same page_pool twice with two
>> >xdp_rxq_info structures.
>>
>> As I tend to use xdp level patch there is no more reason to mention (2) case
>> here. XDP patch serves it better and can prevent not only obj deletion but also
>> pool flush, so, this one patch I could better leave only for (1) case.
>
>I don't understand what you are saying.
>
>Do you approve this patch, or do you reject this patch?
>
It's not reject, it's proposition to use both, XDP and page pool patches,
each having its goal.

-- 
Regards,
Ivan Khoronzhuk
