Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBEEC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBED320835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555480520;
	bh=D+LBGto6wknu7TgMjROKbI7ENQ5rudUy2jOE5xWgznA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2RLqMbU2HR8OiUC7q2BI5rMfLHa5SPVT3qXbIvSJxKQ3r22HKh1DiFM4WQObSRvLT
	 QxGqv4ePftnJOdI+Er2E+p9t+AoOIcKVXsLQ5xWWnkQPjT7Aqbu0OJnhLH5vF1Ku3m
	 hzspOL6FrHywXPSUcfLUnxuip3XK+R3Qf/6nEllc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfDQFzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:55:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46639 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQFzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:55:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so30131369wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/Lzy+vu/eUgVOZbjEP7+yKLtjj65y3N7q2DMqdf3mg=;
        b=XbgpSC40gyRyFEEFxG7J1Gb32KZ4owlR8PVBMDf/M+mzYt8wUfyJPLtU7pY6Xa8ITI
         vpFh0bjFKV4eN+aQ3VwzWefg39jiYtsUHC0xzjRoaOQvHu4Ez/vUdc/oSxTsOfXqf0LE
         pFS/N8+ktzEow+hWyJxwSGZtbJxTLQlkJCxd1W6Nc7r51lFj9wyczGR3h4BZLOOiUukv
         g5QzIK7GiwKFCkI1pCTw9o5LbH3mmLUeKlTPN6j7nWw9f9YPW50zkFGNJl/6ag/J4xaY
         tNLgEo+hm+G1IrtQ0mKbV5ZoqtwiLrP++4kNMjlbQL6G0nRly+tK0n3vbIP1zDlCLw5s
         VzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/Lzy+vu/eUgVOZbjEP7+yKLtjj65y3N7q2DMqdf3mg=;
        b=cfB1ZtwiAA/bS9PHkgQmefRBwc9MyCyTQcda9mBYfP1yQb8znsvek+bpb7UY6HCp60
         StgkHhOd3zeEPcXKaqhDPIM5yYytL4qxHBFpKIz5Vsan+kAF5YT18mCLouOEowzvT5uS
         8bSAK8e8/7uO8JnRUycA65UZN8Hw6SMkeY8US5yi6gL7L7Q4Uu3ILwkvTFaDOL0yh6Sg
         hO4fy4KbO1M3vfnDFjMJsOecadh8/Mpy5b29W+rqXqIIUN5GqMBjXyRo75PrSeBdOCO5
         LyGS6dLQEiHRq3jE7zzLYzqpTn1iX6lLM/Ae5xh4sdJlQOLbaZOcQnE3zfYrszoF2i9Q
         advg==
X-Gm-Message-State: APjAAAXzzKzGVQXO10eN1b60fdGjkRWp4ec6ZUkdC61m1fK8+yvAFhlX
        yJSdJVkW4mjGT8LSGsKP3gA=
X-Google-Smtp-Source: APXvYqwGnz9dFLqAaPGxt+bjNjhJlnOBcXkkaHZClojzbonqFNnAyDleffcLl5DKtHCz7KNYt8GoTw==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr54996822wrn.148.1555480517479;
        Tue, 16 Apr 2019 22:55:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y18sm1123798wro.80.2019.04.16.22.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 22:55:16 -0700 (PDT)
Date:   Wed, 17 Apr 2019 07:55:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
Message-ID: <20190417055514.GA27400@gmail.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417053626.GA47282@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
> > The test results below shows 3-5% improvement in performance when
> > using the third solution compared to the default system today where
> > scheduler is unware of cpu capacity limitations due to thermal events.
> 
> The numbers look very promising!
> 
> I've rearranged the results to make the performance properties of the 
> various approaches and parameters easier to see:
> 
>                                          (seconds, lower is better)
> 
> 			                 Hackbench   Aobench   Dhrystone
>                                          =========   =======   =========
> Vanilla kernel (No Thermal Pressure)         10.21    141.58        1.14
> Instantaneous thermal pressure               10.16    141.63        1.15
> Thermal Pressure Averaging:
>       - PELT fmwk                             9.88    134.48        1.19
>       - non-PELT Algo. Decay : 500 ms         9.94    133.62        1.09
>       - non-PELT Algo. Decay : 250 ms         7.52    137.22        1.012
>       - non-PELT Algo. Decay : 125 ms         9.87    137.55        1.12

So what I forgot to say is that IMO your results show robust improvements 
over the vanilla kernel of around 5%, with a relatively straightforward 
thermal pressure metric. So I suspect we could do something like this, if 
there was a bit more measurements done to get the best decay period 
established - the 125-250-500 msecs results seem a bit coarse and not 
entirely unambiguous.

In terms of stddev: the perf stat --pre hook could be used to add a dummy 
benchmark run, to heat up the test system, to get more reliable, less 
noisy numbers?

BTW., that big improvement in hackbench results to 7.52 at 250 msecs, is 
that real, or a fluke perhaps?

Thanks,

	Ingo
