Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F34D206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa1BlFbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfKNL35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:29:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46884 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfKNL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:29:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so6248719ljp.13;
        Thu, 14 Nov 2019 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B44Ms18JM2//6Zq8Edna/1bqfmnjwOIzYlPZT73xt9c=;
        b=Xa1BlFbimY3Jv4IpcdMRdnpxqDMU3ZlFdiEGHUFhCAoLXO/qIe+fXzYR9BP6bks1Z6
         fyx3PQ6WqvukmdGT9bJVQ1NBzuO6RSwy/VtKNlGP5lHrwPpQ1aKcw1HhjsNbhZ7mSozp
         7PZxImMNOVBECdUpuXkdlrH5ENfxAHyeu6WMJ7GeceK8MlUtuKQ3SZQN0Ny9o2dfs2ko
         kuJ4oQnIjP/o4twpXM+VKLWic3eOMmTxlZ+4KdbQlfKde9en60PHoE83TxN1AHHnzX2B
         wgh0iMVmPA4aqqmoFZInveB0vMHPCauxGniNkWMfJabfbwtN3mwFiW94C1BnyoIZgjDR
         Gyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B44Ms18JM2//6Zq8Edna/1bqfmnjwOIzYlPZT73xt9c=;
        b=sy7q8DhCikHGSejuk4Cxth+zeyR2Gw0sqlSq2O3GlJXN+ITyzKMLVL8ppn48QkquDL
         m6tNK/Xxpmx8mSF5yV3AI/uruKRYBieg3QMuhT8pWEb1kqmC96U104D/9Oyv6My9Tpa+
         k9JwkRvjQY4xVDT+j8FfnUCteSyR/2SalEO3otJvu4EBR27Oi+zdQqoZcBMqp/2MlW+n
         gVRVxp77TGymu2ghaKOl+48PiT450E/E9rB+ScfKWdSW2PulUP+llRpT3+pkFkjoGOCt
         2Aq2Dk8drLza506uVN5QuG7h8cKR0Y7+aX/s5dG84zcU9uku1kbGtq/n5k49nnP1Kem4
         QP/A==
X-Gm-Message-State: APjAAAWETHHzjSbhJjbTWI5b0m3rCM34PpQld1FXNggVJpDpoG9g0mG+
        pEjC1r8zQiQAd1fR207A6mZwuRWe
X-Google-Smtp-Source: APXvYqxand9AZBEiL1o1WGVeiytoXCIr1yxxdeQXDfbqWwdo1/KSOKiym9tizzjfZKIlXrjBoRZfTQ==
X-Received: by 2002:a2e:a410:: with SMTP id p16mr6373113ljn.46.1573730993054;
        Thu, 14 Nov 2019 03:29:53 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id m20sm2546230lfj.35.2019.11.14.03.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 03:29:52 -0800 (PST)
Subject: Re: [PATCH v2] clk: tegra: divider: Check UART's divider enable-bit
 state on rate's recalculation
To:     Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191030004813.9187-1-digetx@gmail.com>
 <20191113230303.726AE206E3@mail.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <02df00b3-5e23-441f-b2d5-b84fdb411e98@gmail.com>
Date:   Thu, 14 Nov 2019 14:29:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191113230303.726AE206E3@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.11.2019 02:03, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2019-10-29 17:48:13)
>> UART clock is divided using divisor values from DLM/DLL registers when
>> enable-bit is unset in clk register and clk's divider configuration isn't
>> taken onto account in this case. This doesn't cause any problems, but
>> let's add a check for the divider's enable-bit state, for consistency.
>>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> 
> Is this going to be picked up or should I just apply atop the tegra PR?

Looks like this patch missed the Tegra's PR by accident.

Stephen, I assume it will be easier if you could apply this patch atop.
The patch doesn't have any dependencies on any other patches, so it's
fine to apply it separately. Thanks in advance!

Thierry, please let us know if you have any objections.
