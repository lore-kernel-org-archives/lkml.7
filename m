Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A8C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476E4206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578472918;
	bh=PXWKCUXCMzVMdtKOBwvy5/oEvTcWRUdl1Vb3OkpTR5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z0bo23bUbCeGBb2NHY7j/ta3MTfszvvJ2FHsrMh4p6P4RFQMWFoeyCDJUYOcoRH+H
	 ZzTLBPwk88DVBkKpWaRksxTve+Qvr6vsv+Z2cACOEps1RzboX9Av3oRFJGqCkZzMtk
	 u2DTBdXQJazIf6yRHCF+DO++BM96+U8xuWzvKv3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgAHIl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:41:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAHIl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:41:56 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656742075D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578472915;
        bh=PXWKCUXCMzVMdtKOBwvy5/oEvTcWRUdl1Vb3OkpTR5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M9aBQBAFTIEBSLVIQXPNQIx5xRl6tnG/w3q7ncmKz18laMS58AwmCyudHt7Qg8sHU
         wAJInX4TicDjT7rDP7P/3lyWC/WIIRxyDuEly0J4sPtTb/jQ8fHh4KuLct3rHblfVC
         00D/ugrWbEdzQ/AqiuuqnUiFnZgoHR2yuW8MSmUg=
Received: by mail-wm1-f51.google.com with SMTP id p9so1529386wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:41:55 -0800 (PST)
X-Gm-Message-State: APjAAAXbT4vL4L3IBf8hgleyKwwK74AK2RrzeXToA1Sp4CRsANx5B9C6
        FpmnHLS7CjwB5KM61TmoaD3xbiETM+u/tTZbakU+nQ==
X-Google-Smtp-Source: APXvYqzt1cPoPFTMpvv8naNX973P9NV0bYWBJukID4v73DLtgoV6pd86vv2LMqwu+M/KA1E78eCU3sePwfHYc8Tqidg=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr2335219wma.95.1578472913806;
 Wed, 08 Jan 2020 00:41:53 -0800 (PST)
MIME-Version: 1.0
References: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
 <DB882EE8-20B2-4631-A808-E5C968B24CEB@amacapital.net> <cdd157ef011efda92c9434f76141fc3aef174d85.camel@intel.com>
In-Reply-To: <cdd157ef011efda92c9434f76141fc3aef174d85.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 8 Jan 2020 00:41:42 -0800
X-Gmail-Original-Message-ID: <CALCETrV_tGk=B3Hw0h9viW45wMqB_W+rwWzx6LnC3-vSATOUOA@mail.gmail.com>
Message-ID: <CALCETrV_tGk=B3Hw0h9viW45wMqB_W+rwWzx6LnC3-vSATOUOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "mjg59@google.com" <mjg59@google.com>,
        "thgarnie@chromium.org" <thgarnie@chromium.org>,
        "kpsingh@chromium.org" <kpsingh@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "revest@chromium.org" <revest@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "namit@vmware.com" <namit@vmware.com>,
        "jackmanb@chromium.org" <jackmanb@chromium.org>,
        "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "mhalcrow@google.com" <mhalcrow@google.com>,
        "andriin@fb.com" <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 7, 2020, at 9:01 AM, Edgecombe, Rick P <rick.p.edgecombe@intel.com=
> wrote:
>
> =EF=BB=BFCC Nadav and Jessica.
>
> On Mon, 2020-01-06 at 15:36 -1000, Andy Lutomirski wrote:
>>> On Jan 6, 2020, at 12:25 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.=
com>
>>> wrote:
>>>
>>> =EF=BB=BFOn Sat, 2020-01-04 at 09:49 +0900, Andy Lutomirski wrote:
>>>>>>> On Jan 4, 2020, at 8:47 AM, KP Singh <kpsingh@chromium.org> wrote:
>>>>>>
>>>>>> =EF=BB=BFFrom: KP Singh <kpsingh@google.com>
>>>>>>
>>>>>> The image for the BPF trampolines is allocated with
>>>>>> bpf_jit_alloc_exe_page which marks this allocated page executable. T=
his
>>>>>> means that the allocated memory is W and X at the same time making i=
t
>>>>>> susceptible to WX based attacks.
>>>>>>
>>>>>> Since the allocated memory is shared between two trampolines (the
>>>>>> current and the next), 2 pages must be allocated to adhere to W^X an=
d
>>>>>> the following sequence is obeyed where trampolines are modified:
>>>>>
>>>>> Can we please do better rather than piling garbage on top of garbage?
>>>>>
>>>>>>
>>>>>> - Mark memory as non executable (set_memory_nx). While module_alloc =
for
>>>>>> x86 allocates the memory as PAGE_KERNEL and not PAGE_KERNEL_EXEC, no=
t
>>>>>> all implementations of module_alloc do so
>>>>>
>>>>> How about fixing this instead?
>>>>>
>>>>>> - Mark the memory as read/write (set_memory_rw)
>>>>>
>>>>> Probably harmless, but see above about fixing it.
>>>>>
>>>>>> - Modify the trampoline
>>>>>
>>>>> Seems reasonable. It=E2=80=99s worth noting that this whole approach =
is
>>>>> suboptimal:
>>>>> the =E2=80=9Cmodule=E2=80=9D allocator should really be returning a l=
ist of pages to be
>>>>> written (not at the final address!) with the actual executable mappin=
g to
>>>>> be
>>>>> materialized later, but that=E2=80=99s a bigger project that you=E2=
=80=99re welcome to
>>>>> ignore
>>>>> for now.  (Concretely, it should produce a vmap address with backing =
pages
>>>>> but
>>>>> with the vmap alias either entirely unmapped or read-only. A subseque=
nt
>>>>> healer
>>>>> would, all at once, make the direct map pages RO or not-present and m=
ake
>>>>> the
>>>>> vmap alias RX.)
>>>>>> - Mark the memory as read-only (set_memory_ro)
>>>>>> - Mark the memory as executable (set_memory_x)
>>>>>
>>>>> No, thanks. There=E2=80=99s very little excuse for doing two IPI flus=
hes when one
>>>>> would suffice.
>>>>>
>>>>> As far as I know, all architectures can do this with a single flush
>>>>> without
>>>>> races  x86 certainly can. The module freeing code gets this sequence
>>>>> right.
>>>>> Please reuse its mechanism or, if needed, export the relevant interfa=
ces.
>>>
>>> So if I understand this right, some trampolines have been added that ar=
e
>>> currently set as RWX at modification time AND left that way during runt=
ime?
>>> The
>>> discussion on the order of set_memory_() calls in the commit message ma=
de me
>>> think that this was just a modification time thing at first.
>>
>> I=E2=80=99m not sure what the status quo is.
>>
>> We really ought to have a genuinely good API for allocation and initiali=
zation
>> of text.  We can do so much better than set_memory_blahblah.
>>
>> FWIW, I have some ideas about making kernel flushes cheaper. It=E2=80=99=
s currently
>> blocked on finding some time and on tglx=E2=80=99s irqtrace work.
>>
>
> Makes sense to me. I guess there are 6 types of text allocations now:
> - These two BPF trampolines
> - BPF JITs
> - Modules
> - Kprobes
> - Ftrace
>
> All doing (or should be doing) pretty much the same thing. I believe Jess=
ica had
> said at one point that she didn't like all the other features using
> module_alloc() as it was supposed to be just for real modules. Where woul=
d the
> API live?

New header?  This shouldn=E2=80=99t matter that much.

Here are two strawman proposals.  All of this is very rough -- the
actual data structures and signatures are likely problematic for
multiple reasons.

--- First proposal ---

struct text_allocation {
  void *final_addr;
  struct page *pages;
  int npages;
};

int text_alloc(struct text_allocation *out, size_t size);

/* now final_addr is not accessible and pages is writable. */

int text_freeze(struct text_allocation *alloc);

/* now pages are not accessible and final_addr is RO.  Alternatively,
pages are RO and final_addr is unmapped. */

int text_finish(struct text_allocation *alloc);

/* now final_addr is RX.  All done. */

This gets it with just one flush and gives a chance to double-check in
case of race attacks from other CPUs.  Double-checking is annoying,
though.

--- Second proposal ---

struct text_allocation {
  void *final_addr;
  /* lots of opaque stuff including an mm_struct */
  /* optional: list of struct page, but this isn't obviously useful */
};

int text_alloc(struct text_allocation *out, size_t size);

/* Memory is allocated.  There is no way to access it at all right
now.  The memory is RO or not present in the direct map. */

void __user *text_activate_mapping(struct text_allocation *out);

/* Now the text is RW at *user* address given by return value.
Preemption is off if required by use_temporary_mm().  Real user memory
cannot be accessed. */

void text_deactivate_mapping(struct text_allocation *alloc);

/* Now the memory is inaccessible again. */

void text_finalize(struct text_allocation *alloc);

/* Now it's RX or XO at the final address. */


Pros of second approach:

 - Inherently immune to cross-CPU attack.  No double-check.

 - If we ever implement a cache of non-direct-mapped, unaliased pages,
then it works with no flushes at all.  We could even relax it a bit to
allow non-direct-mapped pages that may have RX / XO aliases but no W
aliases.

 - Can easily access without worrying about page boundaries.

Cons:

 - The use of a temporary mm is annoying -- you can't copy from user
memory, for example.
