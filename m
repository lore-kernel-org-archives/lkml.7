Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9776BC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC5220856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxELN7yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfILWBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:01:40 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34048 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfILWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:01:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id g14so11756225vsp.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9wRQrow4UfJ6ztoHYRc60iXbG4ypvNvP3NWX1o5yGbc=;
        b=PxELN7yrSwTB4xo+2bLpaVJfsP1CZ2XgWh4CMmNQvMkqXfQeFK5XwkVPe2b+VnYE+T
         aWltXDhAKAhl4Lo0eaUv1JtyqdJ17dnMJrI0kWwghWC4TKIlZl6BPMLwqSR9GvwnWpXL
         3dQq6KK38SlBWbbBlJ/0K+vRSQXhJOZPXgflx2PBroAmY67bxncD7pbewZaNmvtPqex1
         ePDs8fRmPHjPeXMj1NIYkGC78AZ9pL27uLr9CC3DxmsNegLlJgpSZqflsteh22E+fZe1
         CYeXys+yzL6ieW45Q6qHa8+IByR8hLKatwtP9WFg+vSd0+2i2XO+R6j8Qkp9q53J6ZWc
         TFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9wRQrow4UfJ6ztoHYRc60iXbG4ypvNvP3NWX1o5yGbc=;
        b=Z1+2G2xjrCy4rVVu7dVMzt3fqsvacAiocGp1AKBfJXQxdljUYx5KVevvLzwkVkljiK
         rIv9UMJmQrjCnR4L6ZVHp43rPDuNu21gm/Ak0+JQWLz54Qe8Cezi6FHLM9M2QCXewjlx
         h0LrWvyOzWU4Z/vfTM829WUx96H0j1lrrHauCyB8VxigJHRLn/DadrU6puWmKcwGIqm7
         0XtkMq4w6TGMhj+QZDCM1eGlh1MrwfLv37IuvhSK0bnSNWVTdvkac6InZ2pGGkk5LJ1k
         o1l2abGoqI1LvkJV4tMX2peIygUFFHJVLlv8t6aG8knXN+b+oikuHzgEDb5Ks59mVZXd
         yDZw==
X-Gm-Message-State: APjAAAV/g5cqjPrZ+m3KeThPOsXCMteiDdVHbND4xq2beh2zQLMLSK7q
        +/qvPdj3+L8nGWgBlkjWQDXPofQIx3xST7l/ih/I/g==
X-Google-Smtp-Source: APXvYqwOIR+nO2xo9jz6XlWFxYmYYiHtr3f+5//ql3mmEGAjn0NapuCi/tlDGlTL/LNaZEX6ibdgwOplPpvgIHFSOXE=
X-Received: by 2002:a67:b911:: with SMTP id q17mr22872278vsn.104.1568325698476;
 Thu, 12 Sep 2019 15:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190909223236.157099-1-samitolvanen@google.com>
 <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com>
 <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com>
 <87impzt4pu.fsf@toke.dk> <CABCJKufCwjXQ6a4oLjywDmxY2apUZ1yop-5+qty82bfwV-QTAA@mail.gmail.com>
 <87sgp1ssfk.fsf@toke.dk>
In-Reply-To: <87sgp1ssfk.fsf@toke.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 12 Sep 2019 15:01:26 -0700
Message-ID: <CABCJKufGy0aRDSUPQEOKYZ9tLjqwQDcDaTW-6im-VfjkB_gUsw@mail.gmail.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 3:52 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
> I think it would be good if you do both. I'm a bit worried that XDP
> performance will end up in a "death by a thousand paper cuts" situation,
> so I'd rather push back on even relatively small overheads like this; so
> being able to turn it off in the config would be good.

OK, thanks for the feedback. In that case, I think it's probably
better to wait until we have CFI ready for upstreaming and use the
same config for this one.

> Can you share more details about what the "future CFI checking" is
> likely to look like?

Sure, I posted an overview of CFI and what we're doing in Pixel devices her=
e:

https://android-developers.googleblog.com/2018/10/control-flow-integrity-in=
-android-kernel.html

Sami
