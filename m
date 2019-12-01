Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1126C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 21:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C565C2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 21:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jonmasters-org.20150623.gappssmtp.com header.i=@jonmasters-org.20150623.gappssmtp.com header.b="haC2yWer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfLAV62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 16:58:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40744 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLAV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 16:58:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id a137so28860034qkc.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 13:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wGf8SOslmQtXKi1QI9BMUXk6iVKg26mOeGKK2Ks7MYE=;
        b=haC2yWerrh/EPaAEWE30LtPPVcYglspCRi6YH2nLwTymB5BM0YVdLfcoNnZKG3q3Bp
         nOSJ41/CKSvenze+4GkAAoq9bgeuRouOnCj/Es44/V2bwrq26knTKVbWMzAGr0r749mb
         l9l7id8p4zBh9Bje3/MjsdxqHSo5evu/yTNVQi8BvsDS+18ao29L2rZrywVaBAa5E+Bn
         x0RXh5ocXSXB2kcnHvuNdkfBFp74hGdBEPxb3dVc9RanQywc+6L9xpOsFqptvfDXXicS
         mFu5VCz81jgRJ+DlsgqYbP8yL+YXeDjRXyJey+9AqIWUJ9fl43km/G+rUxio59oiON8g
         B+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wGf8SOslmQtXKi1QI9BMUXk6iVKg26mOeGKK2Ks7MYE=;
        b=hgDqZDOHJZZGvh3/wtkje46hGW8+08DPYGNPVTyIvTcKvHbpcgVRbV0vVweQFtfTPf
         U7Y1gAat0hjXGPLqDcFJCDeRXELpXmK37YMYSy9AwE9JDXrzG9N+ClEnY9RfHHTdP0hT
         6Ft2x/1k6juoFVMDs8QlS5fR1OtLmmmyWtAYq8gKWz7M9mrLQXGVafICGhIj2rFNwCVz
         w+1OUFMDKx8AL8K5CbDvit8CHWCWtdhtzPgcjVapgFeh9gYLBr7NVqhe9n86J9fiK0yq
         PKZmV5eN8UMMAuQbD88vEI8E7DXIcPW0RbuYtypR8Uu8f+Hm54QKymK1RGotrbFKKoVH
         Fomg==
X-Gm-Message-State: APjAAAURpGNiSglFzZiFIxsdXOrzUe/UreDo4bFxwqd7LzLMpSvXVhd2
        lKCzu7N58SC79F9sU0B72yh0Zg==
X-Google-Smtp-Source: APXvYqyneloIKBeXc5AlpZqXq7qebSG4Sm7XfSawnJmWBKgRDS3WvxrB+RD3J2nDCv0D3KoFXS2jaA==
X-Received: by 2002:a37:434d:: with SMTP id q74mr28864727qka.187.1575237507536;
        Sun, 01 Dec 2019 13:58:27 -0800 (PST)
Received: from independence.bos.jonmasters.org (24-148-33-89.s2391.c3-0.grn-cbr1.chi-grn.il.cable.rcncustomer.com. [24.148.33.89])
        by smtp.gmail.com with ESMTPSA id t38sm4905845qta.78.2019.12.01.13.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2019 13:58:27 -0800 (PST)
Subject: Re: DAX filesystem support on ARMv8
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
 <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
 <20191112220212.GC7934@bombadil.infradead.org>
 <MN2PR02MB6336070627E66ED8AE646BACA5710@MN2PR02MB6336.namprd02.prod.outlook.com>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <e01ee855-cb11-d059-6c46-836283b9e251@jonmasters.org>
Date:   Sun, 1 Dec 2019 13:54:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB6336070627E66ED8AE646BACA5710@MN2PR02MB6336.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/19 1:54 AM, Bharat Kumar Gogada wrote:
>>
>> On Tue, Nov 12, 2019 at 09:15:18AM -0800, Dan Williams wrote:
>>> On Mon, Nov 11, 2019 at 6:12 PM Bharat Kumar Gogada
>> <bharatku@xilinx.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> As per Documentation/filesystems/dax.txt
>>>>
>>>> The DAX code does not work correctly on architectures which have
>>>> virtually mapped caches such as ARM, MIPS and SPARC.
>>>>
>>>> Can anyone please shed light on dax filesystem issue w.r.t ARM architecture
>> ?
>>>
>>> The concern is VIVT caches since the kernel will want to flush pmem
>>> addresses with different virtual addresses than what userspace is
>>> using. As far as I know, ARMv8 has VIPT caches, so should not have an
>>> issue. Willy initially wrote those restrictions, but I am assuming
>>> that the concern was managing the caches in the presence of virtual
>>> aliases.
>>
>> The kernel will also access data at different virtual addresses from userspace.
>> So VIVT CPUs will be mmap/read/write incoherent, as well as being flush
>> incoherent.
> 
> Thanks a lot Wilcox and Dan for clarification.
> So the above restriction only applies to ARM architectures with VIVT caches and not
> for VIPT caches.

VMSAv8-64 (Armv8) requires that data caches behave as if they were PIPT. 
Meaning there is not a situation as described above.

Jon.

-- 
Computer Architect
