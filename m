Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E671F21770
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A74N8nFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfK1JHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:07:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41453 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfK1JHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574932022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc+1aWU1n7L4x+QFUaTGUrJ8QZV6jxVGyjTh715dkvk=;
        b=A74N8nFoiAsXUKyDuny7Q4f2J4PTSBV3QVofw+v50hSaYIk3FKYiSm2fLn91AtWVBVG+pD
        0xFFrUTsis8eGr76w0QcOtUS01JCdksS0ywyqW/2ZSYCDMtDJ51IRdelKV4fB34JRIN/oA
        6jlmWKBt4ibMvKvEEOJu4pNmL5Srba4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-oBTcpRAdPy6lVmq27WljXQ-1; Thu, 28 Nov 2019 04:07:01 -0500
Received: by mail-lj1-f200.google.com with SMTP id n11so4837293lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 01:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DvrocL/1GRTCvaXxuQQF+aHOAoWJJA60RMKFIr0Cm60=;
        b=E/2K/HAOsaCefjw+SfYpoQKsKqtYLgysQNSiDiCkPZ0STQEADp8oxypu5t3kL+Pv3l
         YoYqoMFU/bniPoMKe5vZHw54rD4LjNgm3SikAtvt5XXweztOmJc35XE7/svSoRHilIzr
         1zPJOh7Wh4qqiRKn1reAH8WaiefS2WgIwhRrLheMZNgZGvlTcJ/AzVgaC2bDeMwPjI2J
         L7VB5R6OrVb7lzq0/SNZlWCKuMU+ugnYAzk+5Wr/njqmvLo9nUMMvSudmgEulPBjF8uA
         0LRXdYdIT8VDx40zkMfJdVhlVK1RtmtTwHbxnOYS0rzhnXGDzP2rDi6sBMUW5FzdSPPr
         7CKw==
X-Gm-Message-State: APjAAAVNXiPKiRV2V1OzFsVogYYJF3mQTgcb5EmDTaXK1cEd9iJbppp/
        FLFmIndNVh5196krW95+5k96DIfroncacNVNUiGbzFEP8pBkjrNjk6E7/Y/a2xMQvFLWHtPHObK
        zVLCEdLcC7abVmgtrMj15P/bP
X-Received: by 2002:a2e:914d:: with SMTP id q13mr7972520ljg.198.1574932019916;
        Thu, 28 Nov 2019 01:06:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwW+RawCEjX/SrVq5qTek4AHlvFYFzQbz7nhztA0ZhJ3BUPtFzw7uzugqmhWCO8ANdZ6bOJqQ==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr7972501ljg.198.1574932019671;
        Thu, 28 Nov 2019 01:06:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o26sm8079173lfi.57.2019.11.28.01.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 01:06:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2377C1818BE; Thu, 28 Nov 2019 10:06:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 0/3] perf/bpftool: Allow to link libbpf dynamically
In-Reply-To: <CAADnVQLp2VTi9JhtfkLOR9Y1ipNFObOGH9DQe5zbKxz77juhqA@mail.gmail.com>
References: <20191127094837.4045-1-jolsa@kernel.org> <CAADnVQLp2VTi9JhtfkLOR9Y1ipNFObOGH9DQe5zbKxz77juhqA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 28 Nov 2019 10:06:57 +0100
Message-ID: <87o8wwwery.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: oBTcpRAdPy6lVmq27WljXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Nov 27, 2019 at 1:48 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> hi,
>> adding support to link bpftool with libbpf dynamically,
>> and config change for perf.
>>
>> It's now possible to use:
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1
>>
>> which will detect libbpf devel package with needed version,
>> and if found, link it with bpftool.
>>
>> It's possible to use arbitrary installed libbpf:
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/tmp/libb=
pf/
>>
>> I based this change on top of Arnaldo's perf/core, because
>> it contains libbpf feature detection code as dependency.
>> It's now also synced with latest bpf-next, so Toke's change
>> applies correctly.
>
> I don't like it.
> Especially Toke's patch to expose netlink as public and stable libbpf
> api.

Figured you might say that :)

> bpftools needs to stay tightly coupled with libbpf (and statically
> linked for that reason).
> Otherwise libbpf will grow a ton of public api that would have to be stab=
le
> and will quickly become a burden.

I can see why you don't want to expose the "internal" functions as
LIBBPF_API. Doesn't *have* to mean we can't link bpftool dynamically
against the .so version of libbpf, though; will see if I can figure out
a clean way to do that...

-Toke

