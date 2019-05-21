Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C531C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D626D2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="O3J3IiZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfEUVzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:55:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39236 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfEUVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:55:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so137124pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rVLanPSf7IgKvhY0KijI1QM75WnUf0t3XqlmcH7VqBQ=;
        b=O3J3IiZhKiNxPSSKsaEdABEJjWCDGtEge+p5Bv74A40Lguj1fFzMPlOXMAqvdGm2Sn
         96tz8ynCDv+EKT3VBuviPObPWoOWkpQySevpTXsDTVzFRPnFYZ6iIuOwBRFqwIkv9c7q
         DcIIQa46zUIiAX8Tjig2AZUBAdLgv4+JgXIzYlBS98mcRRI2GxtedH+UGshTaeQ1eYSQ
         2KbHx0tzpNY1qQVoKdvb8pNUZaF+It3zigxRJJxBlVFyKbANJ7vlODMFdaSjjp947B0k
         q3eihZtS9A2lLpMPgLLKQ6IAvwcEQl9O/zhZpzUOn3uBzI1gEcR/1WrhPwqY7+hVN/kT
         npbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rVLanPSf7IgKvhY0KijI1QM75WnUf0t3XqlmcH7VqBQ=;
        b=Q9BhgXkvZ6Z6jRK3h+I6Ky4NaFiH/VhQSrFEZ/Q2+CANaGxBWwg15oKn04Z9/1vt0i
         zB10b8Umb2/3AI/cg264U2Cdp19o+pn3ZMkIMRQ8PNH9nsY7psg9Bxk6XqqOu8gXtv1g
         AJSIYNJMkXyDV7/cdyg4RsnF+NRVO8yrR3KFZP5RFmPJrItub7r9sqrVqY7e/foJhH5u
         tmTO/JffVPY626FQ2K3mYd+vR6aXaFT9L4K2z9XfXb4cmUfVBe6o1zLl3PvoN9aqCdCm
         g9YZmwEccSCd3BpGLy9NPyXghXjeWsTA+Ic1IDTlbB5HKhk0NvC8sIG4wSa5CeXCmUIq
         CwVA==
X-Gm-Message-State: APjAAAWmgPqS64gFxftNREu4qVZbVZcU7MxgnKiwUd0BA9uI9yGIgFqM
        HQ+Eo6qWmSilVqRvxUdjLBqb9w==
X-Google-Smtp-Source: APXvYqwy+hWodtg/yBs57pbUzk7WR6gHqZkb8c+GchzFI7Z2aIjZQmIP00cGHUzuXzTP8/Q/wEkm7Q==
X-Received: by 2002:a65:610a:: with SMTP id z10mr85831747pgu.54.1558475700862;
        Tue, 21 May 2019 14:55:00 -0700 (PDT)
Received: from [172.22.3.235] ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i12sm27186257pfd.33.2019.05.21.14.54.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 14:54:59 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
To:     Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        j-nomura@ce.jp.nec.com
Cc:     Borislav Petkov <bp@alien8.de>, kasong@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv> <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv> <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv> <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514033338.GA6612@MiWiFi-R3L-srv>
From:   Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Message-ID: <c640061a-a7c5-5bc3-87b6-0ee7af5a4b43@netronome.com>
Date:   Tue, 21 May 2019 14:53:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190514033338.GA6612@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/13/19 8:33 PM, Baoquan He wrote:
> On 05/14/19 at 11:22am, Dave Young wrote:
>> On 05/13/19 at 04:06pm, Baoquan He wrote:
>>> Hi Dave,
>>>
>>> On 05/13/19 at 09:50am, Borislav Petkov wrote:
>>>> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
>>>>> This is a critical bug which breaks memory hotplug,
>>>> Please concentrate and stop the blabla:
>>>>
>>>> 36f0c423552d ("x86/boot: Disable RSDP parsing temporarily")
>>>>
>>>> already explains what the deal is. This code was *purposefully* disabled
>>>> because we ran out of time and it broke a couple of machines. Don't make
>>> I remember your machine is the one on whihc the issue is reported. Could
>>> you also test it and confirm if these all things found ealier are
>>> cleared out?
>>>
>> I did some tests on the laptop,  thing is:
>> 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
>>     on latest Linus master branch, everything works fine.
>>
>> 2. build and test the tip/next-merge-window branch, kernel hangs early
>> without output, (both 1st boot and kexec boot)
> Thanks, Dave.
>
> Yeah, I also tested on a HP machine, problem reprodued on the current
> master branch when revert commit 52b922c3d49c.
>
> Then apply these two patches, problem solved.
>
> Tried boris's next-merge-window branch too, kexec works very well.
>
> Dirk, Junichi, feel free to add your test result if you have time.


I tested this with the patches (plus revert of the workaround) applied 
against stable 5.1 and it works fine for me there. Thanks!

Where can I find the next-merge-window tree?

I can test against that too.


Best regards

Dirk

