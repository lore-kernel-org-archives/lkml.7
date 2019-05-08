Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C08C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F020850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc1+a6P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfEHNLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:11:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44766 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfEHNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:11:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so2842249ljl.11;
        Wed, 08 May 2019 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uPUEltEM8YnnSOYwSvRNb2803gogpOnMDSmCbmKkT28=;
        b=Oc1+a6P+tQ0R9ivDMoNUscebnkTlJegOOoekMYI9H7VfW4bVhpTv+yexL4UKe3K9JR
         zJ+5AxEkP3rB2/qgcXjvVZ0Jia/rtT6tPDM5YYy9GsxsnRBDq6Mngc1+jQW8hcgK0n9j
         W9nMjbaalkGNOTNjeLrfcz753AeTr/O7bVLshgj2If4YyTf8sLRRg2RtmwnNAQY1u8H9
         30rkG2wBiYPY7m3oPcsgEPavLEToOu/B014kju+Q0b1DdJJRLGFvxRFfHvMbBym/HWxQ
         9A+bhnH3ABZvIQsQT+Dc7/Ify8Ve1a2tDpJTRn4KoicIMCH2rcjwBJKYGLUPofEws5IX
         F59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uPUEltEM8YnnSOYwSvRNb2803gogpOnMDSmCbmKkT28=;
        b=c1u2qdiTTsdTyHRsgNEY/5y7ALHA49ZktYfJh/Ep5LqkGgGchAndcFLH1y6dHnkmsF
         LDP3bW+F1JwMTAB/i6lIfgSVmh6qWvXfxpMkFq6878Dw2yYHvoOGYXK384CA0xDf85kD
         s834zT+mfn9YhiwQz2IhYoOKdv+11IYeVGb6FdCqYWZaVqh+/AZfmto7QIU5q/hSUw+w
         xhKIqPCE/UPVWQV+UKfDtwxdDIO89DAIOWo8uzDv0HWQf0hu92e4AMd/aFA0a+Z8fwVn
         6Il6GNwFpSH4H8Gm7o2Bpi3ib67YxzO0YgJdMospT1teMTynORLOO/bUh2ql2cNdCEOB
         NY3A==
X-Gm-Message-State: APjAAAW50bZKOJRz7GiX5oaZaivtIIpZtrrF+ep0Q88F19jcZAmruiFQ
        NHQ3UTKF/ott9QlhJMHCCq1avGfr
X-Google-Smtp-Source: APXvYqzRwlyfw6KVbMu9yCCQaQLVeAxxCmeB1ATfkMgtPjRN1Vtza3wSmdh4I9mnhn99ztU+7hZi0A==
X-Received: by 2002:a2e:8846:: with SMTP id z6mr18664891ljj.98.1557321060933;
        Wed, 08 May 2019 06:11:00 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id j6sm4536133ljc.0.2019.05.08.06.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 06:10:59 -0700 (PDT)
Subject: Re: [RFC PATCH v1 5/6] soc/tegra: regulators: Add regulators coupler
 for Tegra20
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-6-digetx@gmail.com>
 <20190508075706.GW14916@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9756d8ca-0778-5185-5b6b-3168d63819ec@gmail.com>
Date:   Wed, 8 May 2019 16:10:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508075706.GW14916@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.05.2019 10:57, Mark Brown пишет:
> On Sun, Apr 14, 2019 at 08:59:38PM +0300, Dmitry Osipenko wrote:
>> Add regulators coupler for Tegra20 SoC's that performs voltage balancing
>> of a coupled regulators and thus provides voltage scaling functionality.
> 
> Can you say what the rules that this is trying to follow are?
> 

There are three regulators: CPU, CORE and RTC.

Constraints:

1) CORE and RTC have max-spread voltage of 170mV.
2) CORE and RTC voltages must be higher than the CPU voltage by at least
120mV.
