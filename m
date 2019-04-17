Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A62EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D4D20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJIWjuhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbfDQR2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:28:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44732 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:28:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id w5so28215805qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=l3/ptb6hgyPkiX6/I9Ophsz1QYJfE/2Sa+edkYMd1f4=;
        b=EJIWjuhOtOtmT1z4rlANajIW4hV2zBdfR/QXV0oEvLtI4aSVIT728Q8bqTGd4Lb5m5
         P9hKP6qGP7SX5H9ieH6S6gZeoJF2r6ArFEzaOvjoufXiiMl/rLw75sxh3qNf9aH8Ugc8
         FE/JF90F8uul7ckXuXcYcyOKFimbd8XBCylJt/KdLMrjx5PPTs/UUZLSIoks7X2SwfKC
         urz9O6aGz6utO0AEYUC6FFvsHykholwpcfrB98+3PHkY4oBGfwTy45OigOR30NVLjVm8
         XBC2nzY8VrayR3M1XG0VlIudGZe7WkZv8J0cktw1xUHSUh9lJiov8DR9WmAnhtPjo7Vy
         k/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=l3/ptb6hgyPkiX6/I9Ophsz1QYJfE/2Sa+edkYMd1f4=;
        b=G3YLeTpTLqpUUUd60lLTD7Xz7NdM3L3JqyZu75tS8Q2uz1wAi7VuGrgmqbEsMIRSUc
         pnCQLFMZAReFFOHM+L5tVYP2H/X8yahiEUeDJVpsAZoVzKwNanYTYQ2oOvss7MALfreg
         28hC0eLMRLJieeuN2rF3Gf/Q44FUdTow/vqnsAuHl9GaPzg7YP8zHJULEHJzHawFotwP
         VVfZVGhEu9LS7y8+W3+BE8maNFltOhzR+0ehqL7zOy21pdPZI1JlvnssyirRm3/dz1qV
         RDSWYbS+iMyRDT9xNwohVNnjTjAttVHOByM7chfount9v9znKFlf9CBb3bto1obsTTf4
         qIPA==
X-Gm-Message-State: APjAAAWKsAVlAeEsfqy0ftbYIaVDQqWPgozpi7dLepwUabGqAgMo+Fu6
        88Ap+oFgYXhTsR32faCzWeyAbw==
X-Google-Smtp-Source: APXvYqwVJptF5BFpn6aBxAoE2jdhA8GIyW2pIzrDoRGhPlUzhJFr8B2DgfGPAlvgn6baW79CvLW/Vw==
X-Received: by 2002:ac8:538c:: with SMTP id x12mr69067901qtp.238.1555522102610;
        Wed, 17 Apr 2019 10:28:22 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id m18sm37360330qki.64.2019.04.17.10.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:28:21 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Ingo Molnar <mingo@kernel.org>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com> <20190417055514.GA27400@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CB76233.9080508@linaro.org>
Date:   Wed, 17 Apr 2019 13:28:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190417055514.GA27400@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2019 01:55 AM, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>>> The test results below shows 3-5% improvement in performance when
>>> using the third solution compared to the default system today where
>>> scheduler is unware of cpu capacity limitations due to thermal events.
>>
>> The numbers look very promising!
>>
>> I've rearranged the results to make the performance properties of the 
>> various approaches and parameters easier to see:
>>
>>                                          (seconds, lower is better)
>>
>> 			                 Hackbench   Aobench   Dhrystone
>>                                          =========   =======   =========
>> Vanilla kernel (No Thermal Pressure)         10.21    141.58        1.14
>> Instantaneous thermal pressure               10.16    141.63        1.15
>> Thermal Pressure Averaging:
>>       - PELT fmwk                             9.88    134.48        1.19
>>       - non-PELT Algo. Decay : 500 ms         9.94    133.62        1.09
>>       - non-PELT Algo. Decay : 250 ms         7.52    137.22        1.012
>>       - non-PELT Algo. Decay : 125 ms         9.87    137.55        1.12
> 
> So what I forgot to say is that IMO your results show robust improvements 
> over the vanilla kernel of around 5%, with a relatively straightforward 
> thermal pressure metric. So I suspect we could do something like this, if 
> there was a bit more measurements done to get the best decay period 
> established - the 125-250-500 msecs results seem a bit coarse and not 
> entirely unambiguous.

To give you the background, I started with decay period of 500 ms. No
other reason except the previous version of rt-pressure that existed in
the scheduler employed a 500 ms decay period. Then the idea was to
decrease the decay period by half and see what happens and so on. But I
agree, that it is a bit coarse. I will probably get around to
implementing some of your suggestions to capture more granular results
in the next few weeks.
> 
> In terms of stddev: the perf stat --pre hook could be used to add a dummy 
> benchmark run, to heat up the test system, to get more reliable, less 
> noisy numbers?
> 
> BTW., that big improvement in hackbench results to 7.52 at 250 msecs, is 
> that real, or a fluke perhaps?
For me, it is an anomaly. Having said that, I did rerun the tests with
this configuration at least twice(if not more) and the results were
similar. It is an anomaly because I have no explanation as to why there
is so much improvement at the 250 ms decay period.

> 
> Thanks,
> 
> 	Ingo
> 


-- 
Regards
Thara
