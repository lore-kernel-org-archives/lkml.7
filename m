Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09332CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69C92054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PmFQYioV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502981AbfJRUiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:38:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38131 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfJRUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:38:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so3395957plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Js8UyXKzcNoEJJmDg2fB7ETZw1UXZrdaUdx46TnSzV4=;
        b=PmFQYioVvRr2wRTUyHxpUOWHMVdu2thIjey8wW+t1W0rNA8gV8xD+qzVNMJgwsoJ+s
         0vY1RJJoS5FGWiyKZ0yzgg4GvAK997c+qFIJ7rda8sls+g72uwDctwaE9TgXDCSGCNRB
         673GKj5l/F5sgl/YxgqJD3cG2/ziJBAzhM7pJFcqjOlGlgykC+mTzeLDbc/ZsX63X4NR
         JvARjArPuTkFdVl7WNt3JU/En33mF6//9NP6rkGcJ6wsBWuPfYWYI2NQxniixZcLot4g
         a7vvRgCmgXXN77Sacj+NOQVObFJHbEaZIxAqegMjy8bGOiid9UwyAJuG3Rqb3PllEgJn
         RMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Js8UyXKzcNoEJJmDg2fB7ETZw1UXZrdaUdx46TnSzV4=;
        b=AUD0ylbuVpjny6EVvLAVY2d6DFmCH34UVa8nak1zPn5QuX1FQb80FFFTwMEZVUUUMJ
         tGIt3cFl6YmNquni1jQcfQdYONGUPzmomCGRQyQR8P4VMw7LPaUkbWyFGIucc70zxWml
         gGPtJG4Ea4Q4afFY0gwULGBXAuS+B8Ee8C0I3YOBpSOQT4KuR++Vp6XtEZ7LQ4O4Gifm
         XhcMK/ZYT/s3EDFLbw/omiXUYHZwFWQVPYzEQ70pm6mpyuByWA9z1EJIgoLYAyv4YQuH
         sjsLrteuikhfOaJm/cp5v15XS3Ge/kW+8sVCZG+UIw0zDCnqhmEzR9WCXEDu3ZZOdOvx
         qErQ==
X-Gm-Message-State: APjAAAUY9kYtXgiXF02ebJT9ztXRIc0af7TMyxkQRg1mnagI8JdLXqbI
        pVtaYQ2FpovfGSXJvhUNWYziPg==
X-Google-Smtp-Source: APXvYqx2jdlimEr6T3ephzi5HPyQ4wjtemZopyPGMNsdL8fHGE93OsN+AwxNxupLGPcLH65It1Ds+g==
X-Received: by 2002:a17:902:fe04:: with SMTP id g4mr4203122plj.58.1571431089200;
        Fri, 18 Oct 2019 13:38:09 -0700 (PDT)
Received: from localhost ([152.179.112.46])
        by smtp.gmail.com with ESMTPSA id bb15sm6704697pjb.2.2019.10.18.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 13:38:08 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:38:08 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 13:36:06 PDT (-0700)
Subject:     Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is cleared
In-Reply-To: <20191016234607.626nzv5kf5fgz25x@willie-the-truck>
CC:     Justin.He@arm.com, Catalin.Marinas@arm.com, Mark.Rutland@arm.com,
        James.Morse@arm.com, maz@kernel.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, punitagrawal@gmail.com, tglx@linutronix.de,
        akpm@linux-foundation.org, hejianet@gmail.com, Kaly.Xin@arm.com,
        nd@arm.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     will@kernel.org
Message-ID: <mhng-265b415f-c8ff-4727-a8fa-2f3e51937ba6@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 16:46:08 PDT (-0700), will@kernel.org wrote:
> Hey Palmer,
>
> On Wed, Oct 16, 2019 at 04:21:59PM -0700, Palmer Dabbelt wrote:
>> On Tue, 08 Oct 2019 05:39:44 PDT (-0700), will@kernel.org wrote:
>> > On Tue, Oct 08, 2019 at 02:19:05AM +0000, Justin He (Arm Technology China) wrote:
>> > > > On Mon, Sep 30, 2019 at 09:57:40AM +0800, Jia He wrote:
>> > > > > diff --git a/mm/memory.c b/mm/memory.c
>> > > > > index b1ca51a079f2..1f56b0118ef5 100644
>> > > > > --- a/mm/memory.c
>> > > > > +++ b/mm/memory.c
>> > > > > @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
>> > > > >  					2;
>> > > > >  #endif
>> > > > >
>> > > > > +#ifndef arch_faults_on_old_pte
>> > > > > +static inline bool arch_faults_on_old_pte(void)
>> > > > > +{
>> > > > > +	return false;
>> > > > > +}
>> > > > > +#endif
>> > > >
>> > > > Kirill has acked this, so I'm happy to take the patch as-is, however isn't
>> > > > it the case that /most/ architectures will want to return true for
>> > > > arch_faults_on_old_pte()? In which case, wouldn't it make more sense for
>> > > > that to be the default, and have x86 and arm64 provide an override? For
>> > > > example, aren't most architectures still going to hit the double fault
>> > > > scenario even with your patch applied?
>> > >
>> > > No, after applying my patch series, only those architectures which don't provide
>> > > setting access flag by hardware AND don't implement their arch_faults_on_old_pte
>> > > will hit the double page fault.
>> > >
>> > > The meaning of true for arch_faults_on_old_pte() is "this arch doesn't have the hardware
>> > > setting access flag way, it might cause page fault on an old pte"
>> > > I don't want to change other architectures' default behavior here. So by default,
>> > > arch_faults_on_old_pte() is false.
>> >
>> > ...and my complaint is that this is the majority of supported architectures,
>> > so you're fixing something for arm64 which also affects arm, powerpc,
>> > alpha, mips, riscv, ...
>> >
>> > Chances are, they won't even realise they need to implement
>> > arch_faults_on_old_pte() until somebody runs into the double fault and
>> > wastes lots of time debugging it before they spot your patch.
>>
>> If I understand the semantics correctly, we should have this set to true.  I
>> don't have any context here, but we've got
>>
>>                /*
>>                 * The kernel assumes that TLBs don't cache invalid
>>                 * entries, but in RISC-V, SFENCE.VMA specifies an
>>                 * ordering constraint, not a cache flush; it is
>>                 * necessary even after writing invalid entries.
>>                 */
>>                local_flush_tlb_page(addr);
>>
>> in do_page_fault().
>
> Ok, although I think this is really about whether or not your hardware can
> make a pte young when accessed, or whether you take a fault and do it
> by updating the pte explicitly.
>
> v12 of the patches did change the default, so you should be "safe" with
> those either way:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/686030.html

OK, that fence is because we allow invalid translations to be cached, which is a 
completely different issue.

RISC-V implementations are allowed to have software managed accessed/dirty 
bits.  For some reason I thought we were relying on the firmware to handle 
this, but I can't actually find the code so I might be crazy.  Wherever it's 
done, there's no spec enforcing it so we should leave this true on RISC-V.

Thanks!

> Will
