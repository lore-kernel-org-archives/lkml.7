Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6361FC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD5620869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lnPbytdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDMNF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 09:05:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40552 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDMNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 09:05:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so6420585plr.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2TaDZeyLwhStai5T9LlXtDxV7uzqf8jNMkPgvrLw7Y4=;
        b=lnPbytdx/SP2fISLBimVzJZNDdE2C9WLskSI340PE+gCihO966ADogDdWT++mTxY31
         XrsBpnLV+WR84PcIwyxXBNTyso29BliUuUsPivrC3ZoSxwUF1x6wDyA/38lnRUC0F7xe
         L/3FlIZ24gEOG4qu4GLF2gSSxlb1LXNmTLXm2C1QZYMXik7lFqhBrKdQZ5YQsLSbrxHh
         HvoMAqldEXXVsLqrDDptINiRZJNUf8K4+/TmuHkKrYzqq2bFlbKGV1igANuC/x31jCMY
         rTzkDFgOeEKwxujHmXsBGrnS0T/p85/ttymvoGBTGgRl/aPgmMuxEqRpTki1PuPUphML
         8euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2TaDZeyLwhStai5T9LlXtDxV7uzqf8jNMkPgvrLw7Y4=;
        b=lJX+OVdfLcK1sTayo8aUW9Mo004wdnFGlJ8OAeO4NQZxEgCLXsbRbJtoAjciCPgH3r
         RxzTL9K7HPsh7INQWVufbLmjRYbojtZ3Z5LaNaJx4srlhlAtEsxKmMpr3wUD3j5z4DmP
         l1OUZ1nY7KQbCj/hH7aEZV7gVdNclJY+qx3PsIl5FF7eqqOxNS7PhlFHnZ6QBQonMMWk
         mnHP1Ln5HH77WaIsjDb+fvt3u9ri+W/QOFLDnD4VH1qhRjJ30SL7mD9MxSNfQ/cUo8Xm
         JzXQgx6T51HVoZ4SEwEfBjx8wDTYYa1Pv7VicGgQoRu39mQm1wsWhCn3d3WqJMlHAXpV
         FdmA==
X-Gm-Message-State: APjAAAWyzaEWMulmiXjBfSDJTcDisM6XZWkxYDoiNACCdXhXT8/RkpAL
        8+0CdreNOCysP02L/UCOFN/wbA==
X-Google-Smtp-Source: APXvYqz4iSZMouFVdSablzLHEPnvUu1ELlNjulLQ9SLK/vBiskh1qdFicklb/YrhANa4GY9JFI3nOg==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr7031127plb.281.1555160757763;
        Sat, 13 Apr 2019 06:05:57 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e13sm67182704pgb.37.2019.04.13.06.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 06:05:56 -0700 (PDT)
Subject: Re: [PATCH] block, Kconfig.iosched: set default value of IOSCHED_BFQ
 to yes
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Anders Roxell <anders.roxell@linaro.org>
References: <20190413091626.20286-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <802d43e0-1954-ddb8-9da6-973742e1bfb6@kernel.dk>
Date:   Sat, 13 Apr 2019 07:05:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413091626.20286-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/19 3:16 AM, Paolo Valente wrote:
> When I added bfq to Kconfig.iosched, I forgot to add the line that
> sets to yes the default value of IOSCHED_BFQ, as it is the case for
> the other two I/O schedulers. Such a piece of information is used by
> popular build systems, when making kernel configs automatically. So,
> the lack of this line for bfq makes it hard and confusing to have bfq
> in the kernel generated by these systems.
> 
> This commit adds this missing line.

This only makes sense to do for newly introduced symbols. Apart from
that, we should not default to 'y' (or 'm' for that matter) what isn't
strictly needed. Looking at the io schedulers, kyber shouldn't have had
that added.

-- 
Jens Axboe

