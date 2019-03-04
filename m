Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A151C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494E72054F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5aouGOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCDSSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:18:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45001 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCDSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:18:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so6620240wrt.11;
        Mon, 04 Mar 2019 10:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vV+EaqFjH5ne+abJs+foKJw4TQKfXvD1njkQg2X5ybU=;
        b=R5aouGOZdajmgTKkQRVCEMvoh+EcFych9fjflh8ZP9pjd5873OnBQx0ygudD/RHwMp
         2qhtCQRARNNxuWXJHHUgYqkN6WD8IGXFDgP2OnjcncPQfxhyV4vs7tHHdjcw8urEzGih
         bE2zmUewS6kaj3kvY5yCamMWz/+sDqKOUaWop7vgJeqQamS83JUkRWsAy2iIW9VZqp6j
         kLiPE91jEUQ666ljqtnU/8+QsxY3+pVhHUEUxPO1BQFrGshResHpRdBeIPHpUSecAVtm
         6xOmQvHFv3tcgE2A7F05745nrLmzEEfKZN5I2s7JiJ12sXeEq6br+Sbu5+UXsBJX9dh2
         ylUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vV+EaqFjH5ne+abJs+foKJw4TQKfXvD1njkQg2X5ybU=;
        b=NQJDmTs2MUc18E6iEd8e9loOZ1DIA1pTkoJxdjiEchQ3wvbznld94ZtMzBTUBJLVae
         DVadHMvcIzpDapzTGmqQrBvxBoT0ayjWKB4+41OFAZZ4vj4xsv4aW+t012xJGD2oQRZK
         C1D1UxYDs2HTFVunEsZaPsI2Xk3qM0fCdHPqJ8UuSOgHP8PQUelYbDalp3AY1XiazTtg
         gtq4SOW6O9M/EVTwgtka/QC30Vx5FxBDt/DVMDZETelxY0NdK9Ku9o45jJBXDP+KuT/e
         8q6goZIdFlg/N9llpbVwX5iLCE0ZKU+b56OOpYUYKyKwc0uGo1wMmQ9ZMo10HVns5tBp
         x1Bg==
X-Gm-Message-State: APjAAAVL+HI4a9m+U4OjIGpwuyNmz6d+iXlulkAjcZKbKd28/Z6yUMaP
        sQYx914hoZJDiD7i1Ej00JA=
X-Google-Smtp-Source: APXvYqxn/1XVpVbh6RbXpASMjJnDtgTYlFShiXSDbJFoEd090S+jX/f/CzuIwcwptZoo7rEiSbcmVg==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr14006827wrn.298.1551723529487;
        Mon, 04 Mar 2019 10:18:49 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:d8e4:889a:5ed6:37cb? (p200300EA8BF1E200D8E4889A5ED637CB.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:d8e4:889a:5ed6:37cb])
        by smtp.googlemail.com with ESMTPSA id w3sm6943760wrl.22.2019.03.04.10.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:18:48 -0800 (PST)
Subject: Re: [PATCH -next] net: dsa: mv88e6xxx: Fix build warning when
 CONFIG_NET_DSA_LEGACY is n
To:     Andrew Lunn <andrew@lunn.ch>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <1551703381-52115-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190304132617.GB26378@lunn.ch>
 <bc528808-2ad5-90ae-4bc0-afa47a7c4f42@hisilicon.com>
 <20190304145710.GA17097@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <74a6581e-f761-0fb0-3200-e82b7ac88e75@gmail.com>
Date:   Mon, 4 Mar 2019 19:18:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304145710.GA17097@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.2019 15:57, Andrew Lunn wrote:
> On Mon, Mar 04, 2019 at 10:16:08PM +0800, Zhangshaokun wrote:
>> Hi Andrew,
>>
>> On 2019/3/4 21:26, Andrew Lunn wrote:
>>> On Mon, Mar 04, 2019 at 08:43:01PM +0800, Shaokun Zhang wrote:
>>>> When CONFIG_NET_DSA_LEGACY is n, there is a GCC bulid warning:
>>>> drivers/net/dsa/mv88e6xxx/chip.c:4623:13: warning: ‘mv88e6xxx_ports_cmode_init’ defined but not used [-Wunused-function]
>>>> static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
>>>> Let's fix it.
>>>
>>> Hi Shaokun, Heiner
>>>
>>> Although this fixes the warning, i suspect there i something wrong
>>> with the original patch adding mv88e6390x_port_set_cmode(). It should
>>> also be used without CONFIG_NET_DSA_LEGACY.
>>
>> I checked the commit-id 2a93c1a3651f ("net: dsa: Allow compiling out legacy support") by Florian.
>> Do you mean that CONFIG_NET_DSA_LEGACY shall be removed completely? :-)
> 
> No, i suspect mv88e6390x_ports_cmode_init() is being called from the
> wrong place, or needs to be called from a second location.
> 
> [Goes and looks at the code]
> 
> Yes, it should also be called in mv88e6xxx_probe(). I would call it
> just after the call to mv88e6xxx_detect(), so that it is the same as
> in mv88e6xxx_drv_probe().
> 
> There are two ways DSA drivers can be probed. The legacy way, which is
> optional, and is slowly getting removed, and the current way. Heiner
> is new to DSA and probably missed that, and only handled the legacy
> probe method. I also missed checking when i reviewed to patch :-(
> 
Right, I missed that, will submit a fix.

I just saw that the Kconfig entry comment for NET_DSA_LEGACY says:
"This feature is scheduled for removal in 4.17."

Was forgotten to remove it or did somebody scream loud enough
"But I depend on it" ?

>    Andrew
> 
Heiner
> 
> 
> 

