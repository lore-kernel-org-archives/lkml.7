Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E69C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242AF20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MKVHhXkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfDPUFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:05:55 -0400
Received: from mail.efficios.com ([167.114.142.138]:41180 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:05:55 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8DBFB1D6FC9;
        Tue, 16 Apr 2019 16:05:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id PmFNGrHV7vYt; Tue, 16 Apr 2019 16:05:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id ECBFA1D6FC5;
        Tue, 16 Apr 2019 16:05:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ECBFA1D6FC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555445153;
        bh=xCXfm0GksTeOQ3vNasxSWI3L+tslb07JX35RdVENb28=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MKVHhXkfHjSoUDb6xhbZ+yFqnXUzKYUqifa2yA0Norh+/6gh6AJjB6/R/EzziLjVN
         UTXLzaRDWBNOxwXGjmLlQT+hIuuNG4Pw39V2YttYfmfrVtLNt3p0ko72/nb+DUchQF
         Hr5b3vR41lhTaB/bQkSmDj6tmMdSfXzSj8Im+8GGMVgty1WFlRgNAesyTEOvl6qya0
         DJi1s8XLC/YLf9kHRTzhoSzYDdNYogpCqVdbil4j1PPzaQ5JUozlqeX592lkPfdTlu
         3/FlNsmnXMW4KVeBjNPgWwc4Ib6mPrtiAdXsxXNEf0br/1hcfA8r3CZfMKfuK9Q6xs
         kihNtGVNx6/SA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 33vRis1AVO1a; Tue, 16 Apr 2019 16:05:52 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C74241D6FB7;
        Tue, 16 Apr 2019 16:05:52 -0400 (EDT)
Date:   Tue, 16 Apr 2019 16:05:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Kees Cook <keescook@chromium.org>,
        kernelci <kernelci@groups.io>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Reber <adrian@lisas.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm <linux-mm@kvack.org>,
        Richard Guy Briggs <rgb@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, info <info@kernelci.org>
Message-ID: <2054840174.2796.1555445152616.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAPcyv4gxk9xbsP3YSKzxu5Yp9FTefyxHc6xC33GwZ3Zf9_eeKA@mail.gmail.com>
References: <20190215185151.GG7897@sirena.org.uk> <CAGXu5jLAPKBE-EdfXkg2AK5P=qZktW6ow4kN5Yzc0WU2rtG8LQ@mail.gmail.com> <CABXOdTdVvFn=Nbd_Anhz7zR1H-9QeGByF3HFg4ZFt58R8=H6zA@mail.gmail.com> <CAGXu5j+Sw2FyMc8L+8hTpEKbOsySFGrCmFtVP5gt9y2pJhYVUw@mail.gmail.com> <CABXOdTcXWf9iReoocaj9rZ7z17zt-62iPDuvQQSrQRtMeeZNiA@mail.gmail.com> <CAPcyv4i8xhA6B5e=YBq2Z5kooyUpYZ8Bv9qov-mvqm4Uz=KLWQ@mail.gmail.com> <CABXOdTc5=J7ZFgbiwahVind-SNt7+G_-TVO=v-Y5SBVPLdUFog@mail.gmail.com> <CAPcyv4gxk9xbsP3YSKzxu5Yp9FTefyxHc6xC33GwZ3Zf9_eeKA@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: next/master boot bisection: next-20190215 on beaglebone-black
Thread-Index: 6c8jdHB53tUcYvEQYLkcXDa+eqcbdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 16, 2019, at 2:54 PM, Dan Williams dan.j.williams@intel.com wrote:

> On Thu, Apr 11, 2019 at 1:54 PM Guenter Roeck <groeck@google.com> wrote:
> [..]
>> > > Boot tests report
>> > >
>> > > Qemu test results:
>> > >     total: 345 pass: 345 fail: 0
>> > >
>> > > This is on top of next-20190410 with CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
>> > > and the known crashes fixed.
>> >
>> > In addition to CONFIG_SHUFFLE_PAGE_ALLOCATOR=y you also need the
>> > kernel command line option "page_alloc.shuffle=1"
>> >
>> > ...so I doubt you are running with shuffling enabled. Another way to
>> > double check is:
>> >
>> >    cat /sys/module/page_alloc/parameters/shuffle
>>
>> Yes, you are right. Because, with it enabled, I see:
>>
>> Kernel command line: rdinit=/sbin/init page_alloc.shuffle=1 panic=-1
>> console=ttyAMA0,115200 page_alloc.shuffle=1
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:303
>> page_alloc_shuffle+0x12c/0x1ac
>> static_key_enable(): static key 'page_alloc_shuffle_key+0x0/0x4' used
>> before call to jump_label_init()
> 
> This looks to be specific to ARM never having had to deal with
> DEFINE_STATIC_KEY_TRUE in the past.
> 
> I am able to avoid this warning by simply not enabling JUMP_LABEL
> support in my build.

Looking into this some more, it looks like I was on the wrong track
with my large branch offset theory. Is it just possible that
page_alloc_shuffle() ends up using jump labels before they are
initialized ? Perhaps this has something to do with how early
the page_alloc.shuffle=1 kernel parameter is handled.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
