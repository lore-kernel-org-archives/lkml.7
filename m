Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743D3C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D1C2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f9ChIGUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfETIqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:46:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43233 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfETIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:46:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so22607769edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ktchpIaf6Qn4t/lbS5YwI1umrEsw+iYk4oGTYPAn0Z4=;
        b=f9ChIGUvlt3CGWSwsg5qPs2S81uHmGSPPzHRp7MzBDCGH8RrjqSrA1LMroNIKQn9zR
         dtEqrgctZXB0wz9jZbJGT4o7k1tdN8qO9Jo1lBRwBLbu0zBh8DgmjeeuuKkYFhR6SBWL
         XuC6TNn9EfTIz6CsUjL484mAsQk5dTlGIV0wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktchpIaf6Qn4t/lbS5YwI1umrEsw+iYk4oGTYPAn0Z4=;
        b=X76oQ470UEEaRQ2ZOfvq7Q58PEAecDzUsiGnkOf6b3KLfrOGAW1YgFmn62QnsqwQNy
         ulcSIeebFSPNN3MNU8DDqd0KRKjNSLKRJP3K29Ouy8QVNGr6cip3h5p+MVs9qtn1HDvG
         Y3/IIXW2s3DOSzTOatUrBmCEprWWZHWM2X8u7h9RBxCEQjwIjD+9i9kjgnlJ4zxALTi8
         Ltf5r31fZLoObqIrbihhNHAtsuQGOY9cfDbC9BLfLej/sqOcJ67UgPYyao82C3vwqNVc
         xiOv4jz+owvAcjnbm6C06Gj1iAIvr7eVkQu9Bd3VAOwJ3h+32NrN6PAlz7qXtA4VM/Th
         wvuw==
X-Gm-Message-State: APjAAAXSoWKvWOzWMr8UpFLXZJcObbK3dz1rcStzMXUi8BJMlJMQ2tse
        /bCaXQDeWdImvFu4CtvEBR7UEg==
X-Google-Smtp-Source: APXvYqzfRx8Bglpj6Um1+VSRWHpYxGadwLBdPJzqIpOF016M0nutxj6ki9xVjGiN6Ji39Ep9xjAXvw==
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr43042628edp.179.1558341982511;
        Mon, 20 May 2019 01:46:22 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id s57sm5294935edd.54.2019.05.20.01.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:46:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
To:     Wolfram Sang <wsa@the-dreams.de>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org> <20190519090642.GA2279@kunai>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <36cae1d3-f11c-3c71-3f04-23fdc74f8866@broadcom.com>
Date:   Mon, 20 May 2019 10:46:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190519090642.GA2279@kunai>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/2019 11:06 AM, Wolfram Sang wrote:
> 
>> Let's add an API that the SDIO card drivers can call that will
>> temporarily disable the auto-tuning functionality.  Then we can add a
>> call to this in the Broadcom WiFi driver and any other driver that
>> might have similar needs.
> 
> Can't you fix the WiFi driver to return something else than -EILSEQ
> before calling mmc_request_done() to skip the retuning?

Not really. mmc_request_done() is for the host controller driver so the 
wifi driver is not involved.

Regards,
Arend
