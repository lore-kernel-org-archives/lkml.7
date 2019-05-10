Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421FAC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC52175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="jLHV+nOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfEJKQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:16:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43330 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfEJKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:16:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id z5so4595765lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qz+stYvXt7DnxyGh7w2UEW303G1y2SoHoxPZJae/GgA=;
        b=jLHV+nOhTml6xqZeVSzwc8Wu8aDqJTmcu1Xv7gtwHbztumGmVTSlGpEcC1BS8n9Sv4
         2H5IImNYZB0Fa1OcQIKTkaU6oyD100CqNorY1NofmoQOu41UADw2RdE4iB3RHoikSuLR
         OZTZ/eYaplomf/r5/xNQg4wR3U6oH//MXvNqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qz+stYvXt7DnxyGh7w2UEW303G1y2SoHoxPZJae/GgA=;
        b=iR3UsEaG1kimNDn9RrWxnFsbyJxIzH1VSJKkezoMnSOhOH3DlQl1XHM6i1B5wxC+yB
         3YdLKWYrfmDi5WMRP+TpEs8kkhDHHfWQO/Jxj/W9ZTV0tj+sSz6IKBtVYRTUoZuQIPc7
         VRvDHDHrfvPNQEeWF2dxKjZKkWw7jpKmu3GEYT1KjSu3R5Msk6lXNwSNY5CQoPsORqgH
         dBJi/swbEOSqmjqfk/Kqa0JC8Y5fIVOKxZbWSHWy9lcVqh3zL0bSgeNfOrCSMj5iSCfy
         kAWzKg0kgz+dx9QO14p6EtEyCk1ihSj6I7PcxAdnuvYU66QtBCvwvLqRkbqaCKLuF7uD
         bgMg==
X-Gm-Message-State: APjAAAVnSTmRJ9jKLgkFFYf1UkK+la0DpAMjq6Ji83hnbH9jg92ihNy8
        9YngdbDaLDnPZEz6+vFvC7H/i+7jeLJGmit6adIr8w==
X-Google-Smtp-Source: APXvYqxGXgs/6KhQqz1+ig2tFI4SGxRD1Qo6e9m8IPG4d3RCWwLFaRHWCGd9SwM3a0SNYMyWbs4n3I5o6loG8UaIouE=
X-Received: by 2002:a2e:74f:: with SMTP id i15mr5309596ljd.156.1557483397071;
 Fri, 10 May 2019 03:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190508160859.4380-1-krzesimir@kinvolk.io> <46056c60-f106-e539-b614-498cb1e9e3d0@iogearbox.net>
In-Reply-To: <46056c60-f106-e539-b614-498cb1e9e3d0@iogearbox.net>
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
Date:   Fri, 10 May 2019 12:16:25 +0200
Message-ID: <CAGGp+cFVt_i29Sr07ZJC5zdxTuuwcc02yVy5y03=DXSB6NEr0g@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Fix undefined behavior in narrow load handling
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:30 PM Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>
> On 05/08/2019 06:08 PM, Krzesimir Nowak wrote:
> > Commit 31fd85816dbe ("bpf: permits narrower load from bpf program
> > context fields") made the verifier add AND instructions to clear the
> > unwanted bits with a mask when doing a narrow load. The mask is
> > computed with
> >
> > (1 << size * 8) - 1
> >
> > where "size" is the size of the narrow load. When doing a 4 byte load
> > of a an 8 byte field the verifier shifts the literal 1 by 32 places to
> > the left. This results in an overflow of a signed integer, which is an
> > undefined behavior. Typically the computed mask was zero, so the
> > result of the narrow load ended up being zero too.
> >
> > Cast the literal to long long to avoid overflows. Note that narrow
> > load of the 4 byte fields does not have the undefined behavior,
> > because the load size can only be either 1 or 2 bytes, so shifting 1
> > by 8 or 16 places will not overflow it. And reading 4 bytes would not
> > be a narrow load of a 4 bytes field.
> >
> > Reviewed-by: Alban Crequy <alban@kinvolk.io>
> > Reviewed-by: Iago L=C3=B3pez Galeiras <iago@kinvolk.io>
> > Fixes: 31fd85816dbe ("bpf: permits narrower load from bpf program conte=
xt fields")
> > Cc: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
> > ---
> >  kernel/bpf/verifier.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 09d5d972c9ff..950fac024fbb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7296,7 +7296,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
> >                                                                       i=
nsn->dst_reg,
> >                                                                       s=
hift);
> >                               insn_buf[cnt++] =3D BPF_ALU64_IMM(BPF_AND=
, insn->dst_reg,
> > -                                                             (1 << siz=
e * 8) - 1);
> > +                                                             (1ULL << =
size * 8) - 1);
> >                       }
>
> Makes sense, good catch & thanks for the fix!
>
> Could you also add a test case to test_verifier.c so we keep track of thi=
s?
>
> Thanks,
> Daniel

Hi,

A test for it is a bit tricky. I only found two 64bit fields that can
be loaded narrowly - `sample_period` and `addr` in `struct
bpf_perf_event_data`, so in theory I could have a test like follows:

{
    "32bit loads of a 64bit field (both least and most significant words)",
    .insns =3D {
    BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct
bpf_perf_event_data, addr)),
    BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct
bpf_perf_event_data, addr) + 4),
    BPF_MOV64_IMM(BPF_REG_0, 0),
    BPF_EXIT_INSN(),
    },
    .result =3D ACCEPT,
    .prog_type =3D BPF_PROG_TYPE_PERF_EVENT,
},

The test like this would check that the program is not rejected, but
it wasn't an issue. The test does not check if the verifier has
transformed the narrow reads properly. Ideally the BPF program would
do something like this:

/* let's assume that low and high variables get their values from narrow lo=
ad */
__u64 low =3D (__u32)perf_event->addr;
__u64 high =3D (__u32)(perf_event->addr >> 32);
__u64 addr =3D low | (high << 32);

return addr !=3D perf_event->addr;

But the test_verifier.c won't be able to run this, because
BPF_PROG_TYPE_PERF_EVENT programs are not supported by the
bpf_test_run_prog function.

Any hints how to proceed here?

Cheers,
Krzesimir
--=20
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
