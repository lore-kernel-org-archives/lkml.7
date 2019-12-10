Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4DCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6DA2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGoM1Sg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLJKSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:18:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46409 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfLJKSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:18:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so8658352pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MjJMrLdfpPJ4Sc3kZhH/VjXjH5+SHZoVHKv3pR43FLk=;
        b=aGoM1Sg4g9adkhnRSZkca8ipBYqH5zDXO6Sn8dVvkuMuBaD0+kTFKL8siM4sm9zEp7
         lGLuxvo/M9CNikbqj3KnIxLENsqlMB9CZ8PPWH5BrjONlfLYN1Pc3R5CDMeM0B96mIst
         p1VtxX7v/OfIUeBmMI+Wkm0Qnpv7Wmi0KqEBGkU9Won8QYiXe83qsocnN3L0z2o3lFyP
         8ftiMcAZXD8h9ZQkzg/OQiOYqfFuSPDH8PynDld/iot3oJPCg4ol6S+rLBR87MDV1PJB
         xCVbzdQ8FISzsF9bgU3shE4ipMBny5JTBWws2h6l2pV7y7EHlhjtTatKLqNIupIwgRnI
         JcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MjJMrLdfpPJ4Sc3kZhH/VjXjH5+SHZoVHKv3pR43FLk=;
        b=i1NHEe512IDolywS/rwHv+v+fD2+nxuruAeTUNXdIFODFvyKhqiSzTjg6yuQPu3cPS
         MSER4YidAeA0YNs3en7KvRe+FAmFESZ6c6eeJh6DJAEUCoexPZgY0uW8keNuKuwjegSz
         s9sXAmTzqWj9Y1n8mTwu4jC8Gd7ZPsDGr/ZM33EvpyS6Zx/7wG7vI2F6HnR+k27l1PYc
         GZcdpXModYYju7abVMqUSYQU9SPGMS9rT42YTIKhQxxDxY+Nm6H2AkFXmLCXSXdtnpXd
         ycu/Hofh/r57DTtrcJqMsbPDuxgdjBiMsISs2cr3YfpIQSp75xVoOedrOCLT/kF/w3aI
         JS1w==
X-Gm-Message-State: APjAAAWkCR+uKcujI+FnMdzHy2ItBPie2FPk9tgvMNXUMoqX+cG+t7JP
        YDFZ47/VETs4NLIGY4lUvTcpAQ==
X-Google-Smtp-Source: APXvYqxyHPhqMG4TPXyS2uSioe8CvqmwehPnF4vkNuYU85Y8GyvvVGdr/eAXk14Erkx4+waKABZllQ==
X-Received: by 2002:a63:e648:: with SMTP id p8mr23578874pgj.259.1575973134356;
        Tue, 10 Dec 2019 02:18:54 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id p16sm2723690pgm.8.2019.12.10.02.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:18:53 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:48:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20191210101851.gpayo7bnyf54opyu@vireshk-i7>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <20191203120002.GB4171@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203120002.GB4171@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-19, 12:00, Sudeep Holla wrote:
> I am more interested in this part. As I am aware the only 2 other
> transport being discussed is SMC/HVC and new/yet conceptual SPCI(built
> on top of SMC/HVC). There are already discussions on the list to make
> former as mailbox[1]. While I see both pros and cons with that approach,
> there's a need to converge. One main advantage I see with SMC/HVC mailbox
> is that it can be used with any other client and not just SCMI. Equally,
> the queuing in the mailbox may not be needed with fast SMC/HVC but may
> be needed for new SPCI(not yet fully analysed).
 
We were also looking for OPTEE based mailbox which is similar to SPCI.

-- 
viresh
