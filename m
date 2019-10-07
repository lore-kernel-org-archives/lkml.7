Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DB5C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16892133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="I3HJRjxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfJGRGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:06:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45929 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfJGRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:06:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so8552694pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Pb3uO7Vc16eJljt2wKmrwcVCszIvsw8hiSoBf84oSf4=;
        b=I3HJRjxJRRJjG7VKHs1KEvCrkgsB/RniewwwFGUBUDebBip82LpuOvj3Ze/id/wpvg
         cTlIBSaRihUk2+w9zXag2HCOK1BpZ1XHAnuwgiBtrx9OPI/Gyp8oadRwvx+BmF35IlaD
         i8PePkJwpRW2/uPBVbeZIVd31KQ3I66kBZ18uC+rT5eOPZxWapJELyH3671aTGktxqQJ
         uI7iJdnAmV3YYhXp17jbpqN2Xd6GgfwksKElGYT6OeIb8bGkDOq1OzbwZ9fKOSWTTjsw
         xVTfATKxspX8KvBcm5p5hOqVljFBIJt73toojOqqtXfqlodAiiGtT4YEs6h/756rg3Qh
         e21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Pb3uO7Vc16eJljt2wKmrwcVCszIvsw8hiSoBf84oSf4=;
        b=nN1+amQ6MTGjOxhKnmyl5jdY/6P6I0weH46DAlhcQEzahbzj3q8bnd8k0mxSQWSCXG
         GyyrJBCFgPoQ9goowB4AvNa25j8AT40mxS5pojouVab+hsQijnNHReZrykQVq+HoDmha
         cHaeDwSkVGCGg8Lz0sAvdROfZFNc/IjWRynEPspcwCqoUFOAqyHe+rQPgU0ZEye4s9Rb
         mE+/zfhO32DAgB3ee+Fx/dAIe6kwyfiPrscdFPF84NkAMlmZFvPyeA3qj/HL1CF59EOP
         BIDmPSZUkoWW1xwA5kakBpL75FDOFiOXBfbBAqGIeAB1QJHSt1CA6TXJj5xL935x72pI
         18ow==
X-Gm-Message-State: APjAAAWqau83qlm9gxYzcDWiL5/fL4y2uHN7/MZ7kSf2BeKSYTV/1OGA
        57mN2RJjp9tDqwqXV7kyKDYKPw==
X-Google-Smtp-Source: APXvYqw503Ne0S2M+wJnt2JnXkcGb3V47BzFaV4/XRdG+V4626tYfa4aSVSSwtvIUouWEMrQy+/ffg==
X-Received: by 2002:a62:2643:: with SMTP id m64mr34178671pfm.76.1570468002202;
        Mon, 07 Oct 2019 10:06:42 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id k8sm12451614pgm.14.2019.10.07.10.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:06:41 -0700 (PDT)
Subject: Re: [PATCH] mm: export cma alloc and release
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ryohei Suzuki <ryh.szk.cmnty@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peng Fan <peng.fan@nxp.com>, linux-mm@kvack.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20191002212257.196849-1-salyzyn@android.com>
 <20191003085528.GB21629@arrakis.emea.arm.com> <20191005083753.GA14691@lst.de>
 <aa1c5b2f-fa90-4390-edc6-33b87fab5e09@android.com>
 <20191007165315.GA10317@lst.de>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <22ef8c58-2595-aba7-f72e-a2319622430d@android.com>
Date:   Mon, 7 Oct 2019 10:06:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007165315.GA10317@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 9:53 AM, Christoph Hellwig wrote:
> On Mon, Oct 07, 2019 at 09:50:31AM -0700, Mark Salyzyn wrote:
>> On 10/5/19 1:37 AM, Christoph Hellwig wrote:
>>> On Thu, Oct 03, 2019 at 09:55:28AM +0100, Catalin Marinas wrote:
>>>> Aren't drivers supposed to use the DMA API for such allocations rather
>>>> than invoking cma_*() directly?
>>> Yes, they are.
>> We have an engineer assigned to rewriting the ion memory driver to use
>> dma_buf interfaces. Hopefully that effort will solve the problem of
>> requiring these interfaces to be exported so that that driver (and others)
>> can be modularized.
>>
>> Thanks for the reviews, drop this patch from the list and we will regroup,
>> and accept that standing code in the kernel can not be modularized for the
>> moment.
> How is that different from the "DMA-BUF Heaps (destaging ION)" series
> floating around?

IDK, I am asking around because I am only superficially aware of that 
effort. Please view this as the left hand does not know what the right 
hand is doing. My issue was with a series of out-of-tree drivers that 
use the calls, and noted that currently the ion driver is using them as 
well, as rationalization for a 'user' for the export. I am pushing back 
on those out-of-tree drivers to switch their CMA interfaces to a modern 
approach as a result of these reviews; the result of this review had a 
positive effect because I was considering exporting them in the Android 
distro as a minimum, and now I am soundly rejecting that approach.

Sincerely -- Mark Salyzyn

