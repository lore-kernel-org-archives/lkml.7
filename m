Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD95CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF682077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ2w0F6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLJJln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:41:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34793 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:41:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so19106775ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R0u0ZfpArreLfqRSq8m+twJN9g+3tnH7q3PaFzvCPho=;
        b=QJ2w0F6XB+jWTFqErVdwTrlZRax0pNXGHa9u4xLwSGDuHvHKkTU4mBNCrqOBUr+9TF
         gKOAcQhCQlMxgPJHfopHvdr+/W1BKTCNzjqZIeNLSQuWE7TkvsA4tGkrxIJ/wZEgyrjg
         6rPJU8e9+rZwZiurrjhW8YrRIFe6NEp6ElXRJ1+cOsp04FZtl9S9ZkK8lvn1hnN78flp
         XhL1mATzmOU/wQTvHp+kuTIwfMXKeHhpE+clIVx5mhik4snY+6t5Vph+xDAZEGYud7H9
         zehLojMbjjN/W2bVCZswZISPQ3p4B0tsP8Ld2LerlLupRhp6064nXA/S+vJJJ20qd0PL
         ilaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R0u0ZfpArreLfqRSq8m+twJN9g+3tnH7q3PaFzvCPho=;
        b=GaZza5YD/FUwr4paLTDPhJuw2Bnk25TZOBwcv/UbkHbhfAL+pm8CPIqpuFJWM++0A1
         ObVZO2I2JuCWjCChDasmnjprvkCKRYjvEHx4y5sKUCkp6wCSF03yWPXUbIXdxJfb6LZF
         r5EZX+vPhQhc+gaDwHfp/0bsCL17Xyzf2/pXhQ3Fklf45mltvQAJWZ+gAo+BpXcR6WX0
         oMgEn7r/8lYesk9r6ZO1WIEzKzLOxCvFCX6E6VSa5yO16Y8hdQIYHGD9jv3gHOch0TJZ
         PbjroVqi0xgvMwjja13NdVoCjNWU6PASN3F+DnX65Br9ngD8lzq6p/LOy9XjL/GmYJ7c
         /36w==
X-Gm-Message-State: APjAAAWKXoIVHKS5ILyyB6K95rrilclh7ijqkcl3k4ZuTVRrL/a4wbxa
        0vBVCwS6QrL7HrbQgyYXgF8=
X-Google-Smtp-Source: APXvYqz1Nb+UwkvPHST/bB6sp74irHidhb5scmqTAg6NPlnrIAPS9Z4HOqQNMHmC3s+BVgcTaTxkLg==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr17260641ljj.148.1575970901168;
        Tue, 10 Dec 2019 01:41:41 -0800 (PST)
Received: from [192.168.68.106] ([193.119.54.228])
        by smtp.gmail.com with ESMTPSA id 30sm1696148ljv.99.2019.12.10.01.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:41:40 -0800 (PST)
Subject: Re: [Patch v2] mm/hotplug: Only respect mem= parameter during boot
 stage
To:     David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mhocko@kernel.org, jgross@suse.com,
        akpm@linux-foundation.org
References: <20191210084413.21957-1-bhe@redhat.com>
 <75188d0f-c609-5417-aa2e-354e76b7ba6e@gmail.com>
 <429622cf-f0f4-5d80-d39d-b0d8a6c6605f@redhat.com>
 <c100d74b-1424-9852-b6ee-553a2ae48771@redhat.com>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <618f5695-73e4-3f28-c874-4f12966dee51@gmail.com>
Date:   Tue, 10 Dec 2019 20:41:33 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c100d74b-1424-9852-b6ee-553a2ae48771@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/19 8:37 pm, David Hildenbrand wrote:
> On 10.12.19 10:36, David Hildenbrand wrote:
>> On 10.12.19 10:24, Balbir Singh wrote:
>>>
>>>
>>> On 10/12/19 7:44 pm, Baoquan He wrote:
>>>> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
>>>> parameter") a global varialbe global max_mem_size is added to store
>>>                   typo ^^^
>>>> the value parsed from 'mem= ', then checked when memory region is
>>>> added. This truly stops those DIMM from being added into system memory
>>>> during boot-time.
>>>>
>>>> However, it also limits the later memory hotplug functionality. Any
>>>> memory board can't be hot added any more if its region is beyond the
>>>> max_mem_size. System will print error like below:
>>>>
>>>> [  216.387164] acpi PNP0C80:02: add_memory failed
>>>> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
>>>> [  216.392187] acpi PNP0C80:02: Enumeration failure
>>>>
>>>> From document of 'mem= ' parameter, it should be a restriction during
>>>> boot, but not impact the system memory adding/removing after booting.
>>>>
>>>>   mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
>>>> 	          ...
>>>>
>>>> So fix it by also checking if it's during boot-time when restrict memory
>>>> adding. Otherwise, skip the restriction.
>>>>
>>>
>>> The fix looks reasonable, but I don't get the use case. Booting with mem= is
>>> generally a debug option, is this for debugging memory hotplug + limited memory?
>>
>> Some people/companies use "mem=" along with KVM e.g., to avoid
>> allocating memmaps for guest backing memory and to not expose it to the
>> buddy across kexec's. The excluded physical memory is then memmap into
> 
> s/memmap/mmaped/
> 
>> the hypervisor process and KVM can deal with that. I can imagine that
>> hotplug might be desirable as well for such use cases.

Makes sense, sounds hacky, but it seems like mem= is no longer a debug
option

Acked-by: Balbir Singh <bsingharora@gmail.com>

>>
>>>
>>> Balbir
>>>
>>
>>
> 
> 
