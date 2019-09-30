Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7FBC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7982B215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="GpvpfTgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbfI3VQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:16:34 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:45720 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732140AbfI3VQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:16:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id E7E6E3F549;
        Mon, 30 Sep 2019 19:38:39 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=GpvpfTgb;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hnuYuafil-f7; Mon, 30 Sep 2019 19:38:34 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id B96B63F4B6;
        Mon, 30 Sep 2019 19:38:31 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 789ED36016A;
        Mon, 30 Sep 2019 19:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1569865111; bh=Mbv8I+Cf9qo+4r4AR1GScXQE/ojfy18469i5KoNwfsg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GpvpfTgbFXewp0ygt6YF4cirkWGlnK74clrVKSVTm7q9qX01w4J2Ic0CkUN2QlXEh
         +TpoCVtuKvm2+5ivSMPVfSI3bB7XtpBXGdQ3y5+le76vg9tOoWSTvPeiNJaMXZZUcT
         GQoa1J9ueiuw5NeMW0Doyyjpevc85q+KbNJq298s=
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org>
 <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
 <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
 <20190927121754.kn46qh2crvsnw5z2@box>
 <CAHk-=whfriLqivyRtyjDPzeNr_Y3UYkC9g123Yi_yB5c8Gcmiw@mail.gmail.com>
 <20190930130357.ye3zlkbka2jtd56a@box>
 <CAHk-=wigUfYXiizFH6tBCH0Na=L+c=k7CgXGoZjwKg4K1rNJ2Q@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <2788e6e6-6916-5f95-51f5-336b8edaee2f@shipmail.org>
Date:   Mon, 30 Sep 2019 19:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wigUfYXiizFH6tBCH0Na=L+c=k7CgXGoZjwKg4K1rNJ2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 7:12 PM, Linus Torvalds wrote:
> On Mon, Sep 30, 2019 at 6:04 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>> Have you seen page_vma_mapped_walk()? I made it specifically for rmap code
>> to cover cases when a THP is mapped with PTEs. To me it's not a big
>> stretch to make it cover multiple pages too.
> I agree that is closer, but it does make for calling that big complex
> function for every iteration step.
>
> Of course, you are right that the callback approach is problematic
> too, now that we have retpoline issues, making those very expensive.
> But at least that hopefully gets fixed some day and gets to be a rare
> problem.
>
> Matter ot taste, I guess.
>
>                Linus

Matthew Wilcox suggested something similar before the pagewalk.c rewrite:

https://lore.kernel.org/lkml/20190806190937.GD30179@bombadil.infradead.org/

Still, In this case I'd opt for using the pagewalk code: In the dirty 
helpers we don't ever use a struct page, but only deal with PTE entries, 
same as the pagewalk code does, but not page_vma_mapped_walk(). The 
underlying memory may well be IO memory.

/Thomas


