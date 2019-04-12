Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F21C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E432171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU53Q3S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDLKPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:15:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34180 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:15:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id j89so8359813ljb.1;
        Fri, 12 Apr 2019 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gndIhkgzcqcITSTt9pLyqy05c/eZw9/oj8S8kJzTxQw=;
        b=oU53Q3S5ESnjKiIUibCe2UIJax487zlbb/2c+SKzVvusxoRRRgmq+/g20mxpWxS+Eo
         er7uS8V3tsl+lCteaaN7jVHuzEjA/xvAWq43yOTwgtIcEaPjQW+7Zy7PYTqRKXasqqaV
         ArhaunXlX3x5hok0orIR7JXOPKouD3d3Y+tI8wysPwROTzvxwyNKzsVCFnHj5a/dUXrs
         EmcYfJNW36PwkP2zil/WKmSVaYaawIobc0B7lTGy4ZJUOxtwWIZFqfk27coajyizyc6D
         hZDC99svMFGaydfoL3vvDDFaGNHT9ROlpnZGeZN00rINoyGT36J+EmgYdmzhPsnQi4i5
         97qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gndIhkgzcqcITSTt9pLyqy05c/eZw9/oj8S8kJzTxQw=;
        b=M9iclscM8XPqk4Cqzp2L56k89FI8zGClWLtgfWuMoij45TR1iGQmQNEueXwY5dnBAq
         ufMokF60SSRHBgTxXtZDVmr/zFe4qBvmNsI5L2e8ojMNht9DA5M8wbjLFvehHIJ3pP4L
         MI+ZVeUCjO5YfQS6NxuPyvm0pcnHEAnHSjmc18pE+HYSYOEwBHua89Ux0XQiGpbVLxPH
         fgeLZFNpNi9xCGfgBlAhT40utWZm2mhCrvwADxwez/jJaiddYVUDDuHPUgGdPWTc68NK
         3TJLGIzFxNnGki0OLjKqg5PGHlHgh2TxnohNvTfkoRRIx0i+4+S4EHevZj8VBMWHwM68
         /Dxw==
X-Gm-Message-State: APjAAAUbgidO55BncPFxazKi27wJapEHpW4syeK8iayB4UBaYEYoEhLY
        F1/FPERmXBgXtBrhFrCUi11g+lhZ
X-Google-Smtp-Source: APXvYqyW9S5h+nVP3a0yslOowcBGq22zcFrD9OK3RDB2DNfwf7cEOPzzdLQLHiaG/M04Lax5SF2JCg==
X-Received: by 2002:a05:651c:114:: with SMTP id a20mr14608544ljb.53.1555064101468;
        Fri, 12 Apr 2019 03:15:01 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id t21sm2030285lfk.5.2019.04.12.03.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:15:00 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] PM / devfreq: tegra: Fix kHz to Hz conversion
To:     Sasha Levin <sashal@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190411222914.25539-2-digetx@gmail.com>
 <20190412013413.4D52D20818@mail.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2fd58a4d-7179-91ce-3f01-898c958abdd5@gmail.com>
Date:   Fri, 12 Apr 2019 13:14:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412013413.4D52D20818@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 4:34, Sasha Levin пишет:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.0.7, v4.19.34, v4.14.111, v4.9.168, v4.4.178, v3.18.138.
> 
> v5.0.7: Build OK!
> v4.19.34: Build OK!
> v4.14.111: Build OK!
> v4.9.168: Failed to apply! Possible dependencies:
>     0f0fe7e01327 ("PM / OPP: Manage supply's voltage/current in a separate structure")
>     37a73ec0c9bb ("PM / OPP: Add per OPP table mutex")
>     63a69ea4b88f ("PM / OPP: Rename _allocate_opp() to _opp_allocate()")
>     7034764a1e4a ("PM / OPP: Add 'struct kref' to struct dev_pm_opp")
>     8a31d9d94297 ("PM / OPP: Update OPP users to put reference")
>     947355850fcb ("PM / OPP: Separate out _generic_set_opp()")
>     969fceb3c7e6 ("PM / OPP: Add light weight _opp_free() routine")
>     ce31781a7574 ("PM / OPP: Pass struct dev_pm_opp_supply to _set_opp_voltage()")
>     dfbe4678d709 ("PM / OPP: Add infrastructure to manage multiple regulators")
> 
> v4.4.178: Failed to apply! Possible dependencies:
>     01fb4d3c39d3 ("PM / OPP: Parse 'opp-<prop>-<name>' bindings")
>     0c717d0f9cb4 ("PM / OPP: Initialize regulator pointer to an error value")
>     2c2709dc6921 ("PM / OPP: Rename structures for clarity")
>     50f8cfbd5897 ("PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings")
>     655c9df96175 ("PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()")
>     7de36b0aa51a ("PM / OPP: Parse 'opp-supported-hw' binding")
>     8a31d9d94297 ("PM / OPP: Update OPP users to put reference")
>     9f8ea969d5cf ("PM / OPP: get/put regulators from OPP core")
>     d54974c2513f ("PM / OPP: Manage device clk")
>     dc4e7b1fa20a ("PM / OPP: Add missing doc comments")
>     deaa51465105 ("PM / OPP: Add debugfs support")
> 
> v3.18.138: Failed to apply! Possible dependencies:
>     07cce74a7b25 ("PM / OPP: handle allocation of device_opp in a separate routine")
>     0fe30da2cb43 ("PM / OPP: fix warning in of_free_opp_table()")
>     11573e9132ae ("PM / devfreq: tegra: Update to v5 of the submitted patches")
>     129eec55df6a ("PM / OPP Introduce APIs to remove OPPs")
>     29df0ee1b14a ("PM / OPP: reuse find_device_opp() instead of duplicating code")
>     2c2709dc6921 ("PM / OPP: Rename structures for clarity")
>     327854c87117 ("PM / OPP: Ensure consistent naming of static functions")
>     38393409da34 ("PM / OPP mark OPPs as 'static' or 'dynamic'")
>     6234f38016ad ("PM / devfreq: tegra: add devfreq driver for Tegra Activity Monitor")
>     737002b5de3d ("PM / OPP: Relocate few routines")
>     86453b473b1f ("PM / OPP: Staticize __dev_pm_opp_remove()")
>     87b4115db023 ("PM / OPP: Protect updates to list_dev with mutex")
>     8a31d9d94297 ("PM / OPP: Update OPP users to put reference")
>     8d4d4e98acd6 ("PM / OPP: Add helpers for initializing CPU OPPs")
>     984f16c8490c ("PM / OPP: Update kernel documentation")
>     a7470db6fec4 ("PM / OPP don't match for existing OPPs when list is empty")
>     b02ded246d01 ("PM / OPP: add some lockdep annotations")
>     b4037aaa584b ("PM / OPP replace kfree_rcu() with call_srcu() in opp_set_availability()")
>     cd1a068a52ee ("PM / OPP rename 'head' as 'rcu_head' or 'srcu_head' based on its type")
>     f59d3ee8480d ("PM / OPP: Move cpu specific code to opp/cpu.c")
> 
> 
> How should we proceed with this patch?

Don't backport to v4.9 and older, it's not a critical fix at all.
