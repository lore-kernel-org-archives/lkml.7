Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED101CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6024222C5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 02:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1HV2wIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfJSC7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 22:59:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38338 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfJSC7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 22:59:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so4355353pgt.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2+uRH+ZKfyt86cxDF8FPbZk+BAT5hdpRwMdmmfN7ogM=;
        b=I1HV2wIYlB/eRmfzqyirQiy5WOxMTDsX6O64/uCAnuoS5yCXBnyTNJe3QDZ7DlNCyT
         RzG/6iJSDKWZip6da9We9PVBS86OX602nr0C8kjWoKGAAylamEerSrFVg8kHVF7lMXwA
         2Duum+VhYbpqCx2DWQeERJBqSFPNtIyU3cM/s2m9Bz+Bzi8QE2kpXQTftSeXOeJdH3Tj
         YrZ/FzLZCdLeoEkKnF92uJE7SXSQzCukP0CX0meQk5Z7QwhYrU3kKUXCOvNp+aMLYVBj
         VOz8+nQpKhd2gYCcjghdM1Le5t26IZH7s8yqaVi39yesYZGgBI1Z/TB2wTY7j90tbF7C
         xorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2+uRH+ZKfyt86cxDF8FPbZk+BAT5hdpRwMdmmfN7ogM=;
        b=BlNBP75Lo8jNVHCu/N29ILkIwhg5WHiXohzVjigHhFvLGgbx5QJfSp6UmT7trtPBqz
         sywFZ5mLAlkPFj82wbqBHuLEAhiw9edJg+rzXh1wFJ5rFQW5ZID3LljeuLP1ZGxX75Bb
         evd6jjfWmvKoAX2jYQuStqIUz/bArRxJfugnjBWuLctODu/uFNVMex7ZCyn/yMyM+iZW
         sWF+jkjqBmo1tE6QvVTUYAgac5pByeTMwFVSHcffeAjYTxUNzzvWYPsSYmtMxzJf7GcF
         V9m+J2Z1+PjEE8omnKc59B/VirSZCpIt9Pfhsw7FosbcNdkJSl692h+r/eGVyUynJhgw
         /EIw==
X-Gm-Message-State: APjAAAVbYDi4WhmgsRW8/hrcZ0k1IBeApg+VlkEzhafZ8WIs0hFDWyZE
        NSR8bkWHR6n5F+RPt00Fas4=
X-Google-Smtp-Source: APXvYqwUo5qntuziGSJ+94f1npjJFLL0NTPsMKVRIZ9LluEh6rPog3fPSLS/qbUFGW6O9ETfjUCi5w==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr14310962pja.83.1571453980149;
        Fri, 18 Oct 2019 19:59:40 -0700 (PDT)
Received: from [0.0.0.0] (104.129.187.94.16clouds.com. [104.129.187.94])
        by smtp.gmail.com with ESMTPSA id q30sm7759691pja.18.2019.10.18.19.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 19:59:39 -0700 (PDT)
Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
To:     Palmer Dabbelt <palmer@sifive.com>, will@kernel.org
Cc:     Justin.He@arm.com, Catalin.Marinas@arm.com, Mark.Rutland@arm.com,
        James.Morse@arm.com, maz@kernel.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, punitagrawal@gmail.com, tglx@linutronix.de,
        akpm@linux-foundation.org, Kaly.Xin@arm.com, nd@arm.com
References: <mhng-265b415f-c8ff-4727-a8fa-2f3e51937ba6@palmer-si-x1c4>
From:   Jia He <hejianet@gmail.com>
Message-ID: <c4fa5937-eef2-8932-e8fe-0ee5d9f4de1a@gmail.com>
Date:   Sat, 19 Oct 2019 10:59:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <mhng-265b415f-c8ff-4727-a8fa-2f3e51937ba6@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer

On 2019/10/19 4:38, Palmer Dabbelt wrote:
> On Wed, 16 Oct 2019 16:46:08 PDT (-0700), will@kernel.org wrote:
>> Hey Palmer,
>>
>> On Wed, Oct 16, 2019 at 04:21:59PM -0700, Palmer Dabbelt wrote:
>>> On Tue, 08 Oct 2019 05:39:44 PDT (-0700), will@kernel.org wrote:
>>> > On Tue, Oct 08, 2019 at 02:19:05AM +0000, Justin He (Arm Technology 
>>> China) wrote:
>>> > > > On Mon, Sep 30, 2019 at 09:57:40AM +0800, Jia He wrote:
>>> > > > > diff --git a/mm/memory.c b/mm/memory.c
>>> > > > > index b1ca51a079f2..1f56b0118ef5 100644
>>> > > > > --- a/mm/memory.c
>>> > > > > +++ b/mm/memory.c
>>> > > > > @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
>>> > > > >                      2;
>>> > > > >  #endif
>>> > > > >
>>> > > > > +#ifndef arch_faults_on_old_pte
>>> > > > > +static inline bool arch_faults_on_old_pte(void)
>>> > > > > +{
>>> > > > > +    return false;
>>> > > > > +}
>>> > > > > +#endif
>>> > > >
>>> > > > Kirill has acked this, so I'm happy to take the patch as-is, however 
>>> isn't
>>> > > > it the case that /most/ architectures will want to return true for
>>> > > > arch_faults_on_old_pte()? In which case, wouldn't it make more sense for
>>> > > > that to be the default, and have x86 and arm64 provide an override? For
>>> > > > example, aren't most architectures still going to hit the double fault
>>> > > > scenario even with your patch applied?
>>> > >
>>> > > No, after applying my patch series, only those architectures which 
>>> don't provide
>>> > > setting access flag by hardware AND don't implement their 
>>> arch_faults_on_old_pte
>>> > > will hit the double page fault.
>>> > >
>>> > > The meaning of true for arch_faults_on_old_pte() is "this arch doesn't 
>>> have the hardware
>>> > > setting access flag way, it might cause page fault on an old pte"
>>> > > I don't want to change other architectures' default behavior here. So 
>>> by default,
>>> > > arch_faults_on_old_pte() is false.
>>> >
>>> > ...and my complaint is that this is the majority of supported architectures,
>>> > so you're fixing something for arm64 which also affects arm, powerpc,
>>> > alpha, mips, riscv, ...
>>> >
>>> > Chances are, they won't even realise they need to implement
>>> > arch_faults_on_old_pte() until somebody runs into the double fault and
>>> > wastes lots of time debugging it before they spot your patch.
>>>
>>> If I understand the semantics correctly, we should have this set to true.  I
>>> don't have any context here, but we've got
>>>
>>>                /*
>>>                 * The kernel assumes that TLBs don't cache invalid
>>>                 * entries, but in RISC-V, SFENCE.VMA specifies an
>>>                 * ordering constraint, not a cache flush; it is
>>>                 * necessary even after writing invalid entries.
>>>                 */
>>>                local_flush_tlb_page(addr);
>>>
>>> in do_page_fault().
>>
>> Ok, although I think this is really about whether or not your hardware can
>> make a pte young when accessed, or whether you take a fault and do it
>> by updating the pte explicitly.
>>
>> v12 of the patches did change the default, so you should be "safe" with
>> those either way:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/686030.html
>
> OK, that fence is because we allow invalid translations to be cached, which 
> is a completely different issue.
>
> RISC-V implementations are allowed to have software managed accessed/dirty 
> bits.  For some reason I thought we were relying on the firmware to handle 
> this, but I can't actually find the code so I might be crazy.  Wherever it's 
> done, there's no spec enforcing it so we should leave this true on RISC-V.
>
Thanks for the confirmation. So we can keep the default arch_faults_on_old_pte 
(return true) on RISC-V.


Thanks.


---
Cheers,
Justin (Jia He)

