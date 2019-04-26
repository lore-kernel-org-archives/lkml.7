Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEF3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8032084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX6xwaUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfDZMT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:19:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37056 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:19:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id b12so1547133lji.4;
        Fri, 26 Apr 2019 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U2REKTi6C3eFRunSRzv9E2Ku6HTVGxYiFcw2xLuOXgk=;
        b=FX6xwaUqdAyJyNvnaKGcnSZ7a+Flr4E7jrJm9u54makAUZh+d697Ve9xtkV38PqmfS
         +DlFHnykLQC5CEpj4YyGHb+16cMqDlVRCsD05Yu4pc1aP2ppzD2LZe/+oIXoQFMX/g5c
         YPL+Zknbz9lUT7PbIMIabesPKqa61BvTowFrY5390PVRo2LrKsJv71A5uWf3F8AdcKlN
         UNwCcW1BV3UPKyZYFKRDbNJVjiODw7qnXM1LAQT+kFWLNL99G3sbX5WIzASDVx3Ms/7R
         LFdhIElfgRrH7+xh/tCVMR6JmZd6paBf+H3byMOJcqyKYcfQJ3CSLlbzCps+Q6NVHcKD
         d7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U2REKTi6C3eFRunSRzv9E2Ku6HTVGxYiFcw2xLuOXgk=;
        b=GfkYUOXh3cPCIXo33OTpRldekpJmokRJTKRrGhsjyH7JiIo8hXpLP/3agfp/md/YLF
         ygETtpTRDtg0tKgKbzRrTpZNJFbHPuQqZ7uzlH+iYrI0UJyW03CWXSxwu/9+cqgEj9Bx
         T6XMQI3yOND591LPFLcOUD43uyb1RdwQx+lNITqItXjJxnHxfPi64x415xFvco96LyIt
         tSeBkL9cYJ2PMAI1nOboNjSOcyFFcJoWlK2IvQABPgPzpTAPo1x/SoyUA+yvpzxCxaKB
         iD9e1XhzrFxcrwDNAFqRC2KRx0PCtkzmHEwGhoMCSvHb2qafxZ0OiS5Kw+y2BzXuiowK
         fIKw==
X-Gm-Message-State: APjAAAXaAdaTqrGLGObwiGseEAJ0rheEL5l6V14XcXE9789KDxTlVUOJ
        NwstlIG58UnbxZoUwySH+yHyOU8d
X-Google-Smtp-Source: APXvYqzTIkTf5UTKPkWcchPwfve69cGcl2qRumVuuWVqoLVe/+rbpps2hNK2yoqEwZ1yWLcQwxg7Kw==
X-Received: by 2002:a2e:7503:: with SMTP id q3mr23925061ljc.190.1556281163716;
        Fri, 26 Apr 2019 05:19:23 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id a1sm1496192lfc.17.2019.04.26.05.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 05:19:23 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190424231708.21219-1-digetx@gmail.com>
 <20190426120148.GB28103@vkoul-mobl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68c342e2-5662-5632-82aa-659da0381f54@gmail.com>
Date:   Fri, 26 Apr 2019 15:19:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426120148.GB28103@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.04.2019 15:01, Vinod Koul пишет:
> On 25-04-19, 02:17, Dmitry Osipenko wrote:
>> The readl/writel functions are inserting memory barrier in order to
>> ensure that memory stores are completed. On Tegra20 and Tegra30 this
>> results in L2 cache syncing which isn't a cheapest operation. The
>> tegra20-apb-dma driver doesn't need to synchronize generic memory
>> accesses, hence use the relaxed versions of the functions.
> 
> Subsystem name is **dmaengine** not dma! Please fix that
> 

Looks like you answered to a wrong email.
