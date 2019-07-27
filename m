Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D08C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0E520651
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXEMfZRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfG0IhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:37:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53046 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfG0IhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:37:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so49757648wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SzX7m4bwjQSdn4Mqmgypetc/V+AxipBx0rG9jo0B898=;
        b=EXEMfZRNCrK5o19CdDFNvjY8x/NPixnOmIGHa0kP0IoDeEnHssWRDbGji5jecDOJX7
         Q7Kkn0suWsfJq+MeNii4gTAOjnhEUt/9N34noz9HQ3KXZ3JwvveHToYmD0x+C1yhAOEi
         8qjnDcu4i4dgFlnqdudAwadzwDROYZrdVbVbvTVzcsrnJqF1pggjG6S25GJBbbXsJiih
         uJ6QGoFQMGt7TGQX0zuiXoSvw1bBPPjTcY2VUbB+qUsHCaNH/m/yEvXQ4k3mXBrq2zAA
         o31yf4GOMDVDMhsHH2DzKhDq6hngBDwJ7QwDIl3ywJ27SC4plc9AC1702Iy+dss4dyN6
         PN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SzX7m4bwjQSdn4Mqmgypetc/V+AxipBx0rG9jo0B898=;
        b=RLDWAg4AmfAXrQocT944e2QrgvFJoTO0Y2z0fGyjO/RXAaSPJRXhVd02krud/b7b+/
         8WDbeyn8RSFC18rDPni15/YhzL82BmyxEYtxjszvc24XEgV1mD8//sCK+/jjBlqARnT2
         dEVB8/elVV1sjGD6xvcxlnZ6+7oMq2lcuoEQ6Kq1B4S/iWG88hFC0STbex9E1HG2pP4t
         26gL5EZ/351/tN2ab8hDTkMWf4Eor1etMBIEdQeDZuW1E8sAF6wuzcpP+RLjsuaUhtK4
         zq76jb0v5/ZZ9CP1VA0MMYEuSKO1R9L2QwNp1hsOkylp4Lv04O57RpDgA1VZMJoRoF2l
         PHjw==
X-Gm-Message-State: APjAAAVIQiFxtRkD55+z5MvW3FJjoRmddOMUWtew15ELRq4F8KzNsyC/
        e/v61sOHgah7RraoVhyvsBc=
X-Google-Smtp-Source: APXvYqzuIqWCcyBbW5jro/eGOjzE9P+2FE186dnOFl7zd8DPXlIUYfzc5WmzVu8t2AUKnEJjfO39NQ==
X-Received: by 2002:a1c:6454:: with SMTP id y81mr63961053wmb.105.1564216631543;
        Sat, 27 Jul 2019 01:37:11 -0700 (PDT)
Received: from [10.230.35.19] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id m24sm33183707wmi.39.2019.07.27.01.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 01:36:56 -0700 (PDT)
Subject: Re: [RFC] ARM: bcm2835: register dmabounce on devices hooked to main
 interconnect
To:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>, mbrugger@suse.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
References: <20190723161934.4590-1-nsaenzjulienne@suse.de>
 <20190723163433.GA2234@lst.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <f15ef16e-8e5c-4e9b-1cb2-c6602b15a4ec@gmail.com>
Date:   Sat, 27 Jul 2019 10:36:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723163433.GA2234@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2019 6:34 PM, Christoph Hellwig wrote:
>> +static int bcm2835_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
> 
> Too long line..
> 
>> +void __init bcm2835_init_early(void)
>> +{
>> +	if(of_machine_is_compatible("brcm,bcm2711"))
> 
> Odd formatting.
> 
> Otherwise this looks good to me.

Is this really the right way to solve this problem? First this is ARM
32-bit specific, and second, should not we have a way to indicate via
device tree that all peripherals behind the "soc" simple-bus parent node
are limited to 32-bit of DMA masks, but the specific memory map of the
BCM283x/BCM2711 makes it that only the last 1GB (0xC000_0000 -
0xffff_ffff) (which dma-ranges conveys already) is suitable for DMA into
the VPU uncached alias?
-- 
Florian
