Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85828C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4804620673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHd762Ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGCBrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:47:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40852 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:47:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so568883ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EFkIeXpXPtkmklqfCJHZIPWaUa8k7rvjDvZooschSt0=;
        b=rHd762UbGnahCLryJGa1V5ZeMAyD36SkyUs4X1frl2y0FBAOLBIKwlDdCGSIX+hgSg
         7z8NSWAyAhzTaBnGoD867ymuPf7oKh1xsQ3AO/qVbuZ7CZVSe6/bXtG02w+gL3hZiVdW
         wHvLUC7q04HYqiktxHNa/1RcLQlxu9ARjJL81i5JQ9fyu6LlDsMD5PscYhUzNUw/0o+1
         8dvpVT68hyVAf+bHgmM8erO+vZEYj1j4JcRjpSl8XTFwHKw1wZX2zGB4Herk/S4pQ9QB
         c7UwBmgkfh+TznGgYrX7ROflI9fKIZIVhDky8Gd3QvzLI9Ur+jRgi8QM+sw15pXkASv9
         Uz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EFkIeXpXPtkmklqfCJHZIPWaUa8k7rvjDvZooschSt0=;
        b=U39Z2wENO3kzC6seax1a+mb1uqm2ISokaAgK9R8rKmqp16GfrSpdftOlMubZOB2wg1
         ETmqmpq3cUvHY0xfmN6g2+vaeENLXEu2IYwvc3bAgWGu6B/NClGHvyWm9hjxgeRhzOyM
         rpCq5noG/IZgW0MOWzixGODx0qbZ/x7LvGkJ33dU0KHHUpr3BOjvICcyTACZmqqmNuss
         DrTyeh4yA9ZH5JtsxNeGlEUK6TNxuv9K4EhYfFm1F+eePi+5tJgmiJdAsMiFTYV2GAO3
         8+5SdyGVEErvr5x2w9wV7BQnWxOIBUe3zXzCNHwHZmZfEORHNG4CbJKS4RTZ/H6FmA2V
         rpIg==
X-Gm-Message-State: APjAAAWCxlWSKx3EAbdI9k/vfY4xdz6lgiC9qp8EtN/unWtZ+3YJM6ak
        P5Nbhv3JTEcLBUXeA/n05qvfgg==
X-Google-Smtp-Source: APXvYqyK8XCk0LNPfZc7yl0eXnoTmmXKNuF5DgLOtCrcIhwHjVb42s/ttUXt6h2tWcidM5ZqBmX1tg==
X-Received: by 2002:a2e:80c8:: with SMTP id r8mr4089003ljg.168.1562103706177;
        Tue, 02 Jul 2019 14:41:46 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h23sm40479ljg.17.2019.07.02.14.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 14:41:45 -0700 (PDT)
Date:   Wed, 3 Jul 2019 00:41:43 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        grygorii.strashko@ti.com, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: core: page_pool: add user refcnt and reintroduce
 page_pool_destroy
Message-ID: <20190702214142.GJ4510@khorivan>
Mail-Followup-To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        grygorii.strashko@ti.com, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <156207778364.29180.5111562317930943530.stgit@firesoul>
 <20190702144426.GD4510@khorivan>
 <20190702165230.6caa36e3@carbon>
 <20190702145612.GF4510@khorivan>
 <20190702171029.76c60538@carbon>
 <20190702152112.GG4510@khorivan>
 <20190702202907.15fb30ce@carbon>
 <20190702185839.GH4510@khorivan>
 <20190702230241.3be6d787@carbon>
 <20190702211536.GA22618@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190702211536.GA22618@apalos>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:15:36AM +0300, Ilias Apalodimas wrote:
>Hi Jesper,
>Getting late here, i'll respond in detail tomorrow. One point though
>
>[...]
>>
>> This special use-case, seems confined to your driver. And Ilias told me
>> that XDP is not really a performance benefit for this driver as the HW
>> PPS-limit is hit before the XDP and netstack limit.  I ask, does it
>> make sense to add XDP to this driver, if it complicates the code for
>> everybody else?
>I think yes. This is a widely used driver on TI embedded devices so having XDP
>to play along is a nice feature. It's also the first and only armv7 we have
>supporting this. Ivan already found a couple of issues due to the 32-bit
>architecture he is trying to fix, i think there's real benefit in having that,
>performance aside.
>I fully agree we should not impact the performance of the API to support a
>special hardware though. I'll have a look on the 2 solutions tomorrow, but the
>general approach on this one should be 'the simpler the better'
>
>Cheers
>/Ilias

BTW even w/o optimization it has close to 300kpps (but with increased number of
descs) on drop which is very close to netsec measurements Ilias sent. But from
what I know there is no h/w limit on cpsw at all that this CPU can serve, so
my assumption it's rather s/w limit. But that's not main here and XDP usage
has not been estimated enough yet in embedded, where hi speed not only benefit
that can be taken from XDP.

I need more clear circumstances to send v6 ...

-- 
Regards,
Ivan Khoronzhuk
