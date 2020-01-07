Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D2C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727522073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="H/bxSDl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgAGBgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:36:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41661 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgAGBgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:36:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so27688314pgk.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 17:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HWVPU6NTGp9nzRxw5BWJeatmP8pnvZxGmvGTyfzAkRc=;
        b=H/bxSDl9ArODmhysOekCr4511LlfvhHtaBDU8GIImpRdmsvDx40o7nMg/xP6prsIR3
         W3wfDDHw7bYbaNMyMAt/CZBXvSY1qUoH2OGKUMGcoGkZjTvK/Ss3sTUWmjPTx+xUnPcB
         /Ri5nVSIBJ4fQ8uFTyem8NfwiSa8/uBW6+OJbrR+gDUtYqvj2yLwQek6ho40oG80i7c3
         utvI49OLakatRGxFuN91PBHLPNGJO+b3PNIg2CMjCDaW5r58PLezOGoGIxRgPFxmOhIr
         jmlP+7U7gJwDrjgCWKNqBW3MxgSLx2NQth3QScpuYOm1wjI7LyouHYobvzIozvvpD+8X
         AyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HWVPU6NTGp9nzRxw5BWJeatmP8pnvZxGmvGTyfzAkRc=;
        b=LOi1SBoeo8qVCcZexr/HvWH569NrAwmHWsjO3k8YVGkTq+LeEs1k+SNf433NMNH34U
         6sXamBbN5sT5FkKADJH5XFZdoE3Gx8BkihSSiNkd85i2WDFmsxujemi4WsMSy1Degu9n
         lENmerAX9tGKratkRrvERSRAGfda7IUx2BCSDrHrJikPTp8aXIEbsZQj9Qr+BUDyg9kY
         0cRYPJ2zxWMy/ev4Vsjgyl1oAnGIPoII8kVlwrNVh+EOvaQX0bu56iJyEBIJCM0srLk4
         A6NuAQl53Zyx7k0KsKj+jVueyDGBCId43xXy0DUJjUHhdLq0vOAUXdB/AFIPx8nA18yZ
         5bNA==
X-Gm-Message-State: APjAAAXDuEaVBLa4gsNI7NwHJil9skhYSTwKCvBBxZm0/a3T2FoSda7y
        U04Vwjmy8K8gCyHEKb6X1itZew==
X-Google-Smtp-Source: APXvYqwABUMpjwkXRj3CIQncBFYa4iBNoJvcnED7WOpDnd8SZzBtyrCvkbT8+x2IU2YDKmbRxbrMDw==
X-Received: by 2002:aa7:9218:: with SMTP id 24mr110748206pfo.145.1578361011553;
        Mon, 06 Jan 2020 17:36:51 -0800 (PST)
Received: from ?IPv6:2600:1013:b01b:fb95:11fc:e81d:31f1:7b96? ([2600:1013:b01b:fb95:11fc:e81d:31f1:7b96])
        by smtp.gmail.com with ESMTPSA id q12sm78770893pfh.158.2020.01.06.17.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 17:36:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
Date:   Mon, 6 Jan 2020 15:36:49 -1000
Message-Id: <DB882EE8-20B2-4631-A808-E5C968B24CEB@amacapital.net>
References: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
Cc:     "kpsingh@chromium.org" <kpsingh@chromium.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "jannh@google.com" <jannh@google.com>,
        "mjg59@google.com" <mjg59@google.com>,
        "thgarnie@chromium.org" <thgarnie@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "revest@chromium.org" <revest@chromium.org>,
        "jackmanb@chromium.org" <jackmanb@chromium.org>,
        "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "mhalcrow@google.com" <mhalcrow@google.com>,
        "andriin@fb.com" <andriin@fb.com>
In-Reply-To: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 6, 2020, at 12:25 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.com=
> wrote:
>=20
> =EF=BB=BFOn Sat, 2020-01-04 at 09:49 +0900, Andy Lutomirski wrote:
>>>> On Jan 4, 2020, at 8:47 AM, KP Singh <kpsingh@chromium.org> wrote:
>>>=20
>>> =EF=BB=BFFrom: KP Singh <kpsingh@google.com>
>>>=20
>>> The image for the BPF trampolines is allocated with
>>> bpf_jit_alloc_exe_page which marks this allocated page executable. This
>>> means that the allocated memory is W and X at the same time making it
>>> susceptible to WX based attacks.
>>>=20
>>> Since the allocated memory is shared between two trampolines (the
>>> current and the next), 2 pages must be allocated to adhere to W^X and
>>> the following sequence is obeyed where trampolines are modified:
>>=20
>> Can we please do better rather than piling garbage on top of garbage?
>>=20
>>>=20
>>> - Mark memory as non executable (set_memory_nx). While module_alloc for
>>> x86 allocates the memory as PAGE_KERNEL and not PAGE_KERNEL_EXEC, not
>>> all implementations of module_alloc do so
>>=20
>> How about fixing this instead?
>>=20
>>> - Mark the memory as read/write (set_memory_rw)
>>=20
>> Probably harmless, but see above about fixing it.
>>=20
>>> - Modify the trampoline
>>=20
>> Seems reasonable. It=E2=80=99s worth noting that this whole approach is s=
uboptimal:
>> the =E2=80=9Cmodule=E2=80=9D allocator should really be returning a list o=
f pages to be
>> written (not at the final address!) with the actual executable mapping to=
 be
>> materialized later, but that=E2=80=99s a bigger project that you=E2=80=99=
re welcome to ignore
>> for now.  (Concretely, it should produce a vmap address with backing page=
s but
>> with the vmap alias either entirely unmapped or read-only. A subsequent h=
ealer
>> would, all at once, make the direct map pages RO or not-present and make t=
he
>> vmap alias RX.)
>>> - Mark the memory as read-only (set_memory_ro)
>>> - Mark the memory as executable (set_memory_x)
>>=20
>> No, thanks. There=E2=80=99s very little excuse for doing two IPI flushes w=
hen one
>> would suffice.
>>=20
>> As far as I know, all architectures can do this with a single flush witho=
ut
>> races  x86 certainly can. The module freeing code gets this sequence righ=
t.
>> Please reuse its mechanism or, if needed, export the relevant interfaces.=

>=20
> So if I understand this right, some trampolines have been added that are
> currently set as RWX at modification time AND left that way during runtime=
? The
> discussion on the order of set_memory_() calls in the commit message made m=
e
> think that this was just a modification time thing at first.

I=E2=80=99m not sure what the status quo is.

We really ought to have a genuinely good API for allocation and initializati=
on of text.  We can do so much better than set_memory_blahblah.

FWIW, I have some ideas about making kernel flushes cheaper. It=E2=80=99s cu=
rrently blocked on finding some time and on tglx=E2=80=99s irqtrace work.

>=20
> Also, is there a reason you couldn't use text_poke() to modify the trampol=
ine
> with a single flush?
>=20

Does text_poke to an IPI these days?=
