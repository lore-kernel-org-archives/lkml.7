Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C80C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A7221D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8qWJZPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLSCc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:32:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44611 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSCc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 21:32:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id 195so1431497pfw.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 18:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8EZFQxOfL//tqCMEZCkA+NRJmjPQMfyGk5WDlydLVjY=;
        b=V8qWJZPShBfgpsj9kSAQ/lE5x3lQQegNHXTDsRWig45BKvkSlIgBKTiBRSWHofdUJu
         J9CptSMNzOdmXVTu/ZGHqhk37V7ZYXOhx/s6csYL37tMSiwbb+HI1MB/aFhwf/LkqmDd
         RXAa5xG5unpA/5z9t2dENaPpiUAgbOigj416B9NN0auczlEglNq4rVTlim/j8IWvWjib
         h6H16TuC1OkplXiwV5dlJWP8i+MzEV6qh6kMWzlB9k62h7Z3Z0IWttpo+i4ckmOwbxFI
         SzVu/uhqyzv5LsDHOpVdVNbnTEoTStezBDtYLpscgPBNOC2EU5HU5ZquAH4AS7+TpKZf
         KNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8EZFQxOfL//tqCMEZCkA+NRJmjPQMfyGk5WDlydLVjY=;
        b=CrvV+SMXcIWqvsvuVjShgAljq5/qC71tNEXW9emqqZCn35ihRtrefu4b+OrtUWmN92
         tB9pXa8fb/t0kUdksf2pxeRN4wCdSRu5NHhYr/w4jXjYa5MuysM62lA2TNj5m8udqBSE
         zAa7JrWOdoj7HSOWVAy565ir9X1ffyNg7fXLY1M/w86l0zamwdvIw/lIAk0monL6gF1F
         o8MA7pH2akHamKnTj7vS509q7j1SDyqecSC8v88U049nCk83BIzKKymuNViLRItWQn/M
         KzyjGAES7ymyxMTAiiigJLa13BO1PorQRQVWMMui7mPxvox/TutTmU/YP7GijKx7k1vJ
         EiCg==
X-Gm-Message-State: APjAAAVK1RbIznJXZB+ICQ0+dEvewMIBV9IFTdOzo9OAWRk5TtWphXqc
        hMSu4HFIUAx5hXkwM0ubc8E+IyW5DiD52A==
X-Google-Smtp-Source: APXvYqxxLsiRvz7mROTRQgANP21D4Toxi9TuYC+WXkmwNoWB6cb/Tj2l7lGtVbeXHf/fWzTR0eOuJg==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr6718941pfq.138.1576722745170;
        Wed, 18 Dec 2019 18:32:25 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.116? ([2402:f000:1:1501:200:5efe:a66f:8b74])
        by smtp.gmail.com with ESMTPSA id x4sm5309685pff.143.2019.12.18.18.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 18:32:24 -0800 (PST)
Subject: Re: [PATCH] mtd: maps: pcmciamtd: fix possible
 sleep-in-atomic-context bugs in pcmciamtd_set_vpp()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191218140552.12249-1-baijiaju1990@gmail.com>
 <20191218172813.GA338501@light.dominikbrodowski.net>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <42939a91-baab-54ad-bb4c-8a77e4418f2f@gmail.com>
Date:   Thu, 19 Dec 2019 10:32:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191218172813.GA338501@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/19 1:28, Dominik Brodowski wrote:
> On Wed, Dec 18, 2019 at 10:05:52PM +0800, Jia-Ju Bai wrote:
>> The driver may sleep while holding a spinlock.
>> The function call path (from bottom to top) in Linux 4.19 is:
>>
>> drivers/pcmcia/pcmcia_resource.c, 312:
>> 	mutex_lock in pcmcia_fixup_vpp
>> drivers/mtd/maps/pcmciamtd.c, 309:
>> 	pcmcia_fixup_vpp in pcmciamtd_set_vpp
>> drivers/mtd/maps/pcmciamtd.c, 306:
>> 	_raw_spin_lock_irqsave in pcmciamtd_set_vpp
>>
>> drivers/pcmcia/pcmcia_resource.c, 312:
>> 	mutex_lock in pcmcia_fixup_vpp
>> drivers/mtd/maps/pcmciamtd.c, 312:
>> 	pcmcia_fixup_vpp in pcmciamtd_set_vpp
>> drivers/mtd/maps/pcmciamtd.c, 306:
>> 	_raw_spin_lock_irqsave in pcmciamtd_set_vp
>>
>> mutex_lock() may sleep at runtime.
> Thanks for noticing this issue.
>
>> To fix these bugs, pcmcia_fixup_vpp() is called without holding the
>> spinlock.
> I don't think that this is the right approach here -- we lose the protection
> against races in calls to pcmcia_fixup_vpp(). Instead, we should change the
> spinlock to a mutex, which seems to be sufficient here. Could you prepare
> such a patch, please?

Okay, thanks for the advice :)
I will send a new patch.


Best wishes,
Jia-Ju Bai
