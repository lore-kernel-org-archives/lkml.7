Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06198C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FC92075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m+b6pmil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfI3NY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:24:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40799 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3NY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:24:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id v38so8606780edm.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NaqYC49x+t+zdQq2+wgOaHU0MBIoqBpemx5qgvwCU1A=;
        b=m+b6pmilw/JUnE9hHVh6XsOcufUTXWOJ6DpLWh8jHz9eBwSwI/PO4w97kf9GFMmj2U
         fDC88cMGcQs4/lAuZYco8frISem2cJWrxrJOQ+moJi0d0Nmvm3ki/tjJdv/r5kQnEvYM
         2yK6VxYiD1lcHItN3Ci8P0hTe7ouMHyyMOzh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NaqYC49x+t+zdQq2+wgOaHU0MBIoqBpemx5qgvwCU1A=;
        b=Kw+hWmESfMWMb31cElJznIdkuJX6OUA+Hw1l6nxpFo+DHQF/fbei0qMmlnp4vqBJcG
         b4DBxOZSMMm1VHBSAMQHOd1hFNsoH/Tu7IiObxE2+gaDUr1Sofo2B6xpeNJ5oI0MSOSW
         IJ9pyv+7Pk7AYNnbQDYHHgkF/TAWMbSVvhr7u7JcFqixnrx7EtZnMGoSi/LwAhINHYZi
         OEWmqRUC2sSiuRVYj36od7I5ACChUDen39+JWaBc/2twgGoDfVD4sr9a2IDR9Lu4ue6J
         ZQ6nzeQTrZtLD+HKuDyaC2PxxAurjkeme1dGp7ta96tUoXZ2lAa5cugWofV+sOlIzhKh
         1duw==
X-Gm-Message-State: APjAAAWMZLecZAufABlEqux61bbBE2sTYHgz0n3YyLsIJ3/zelVhIlzM
        OwK9tiz3pEoMNnQm66521In9Ww==
X-Google-Smtp-Source: APXvYqybDB+LFMnKWiJPwawWUTyJ2I0SRJxh0oCoB6UWReD6dpU5gFinF+Hx/Ow9aPPain/r8TeViA==
X-Received: by 2002:aa7:d4c5:: with SMTP id t5mr19547286edr.154.1569849893760;
        Mon, 30 Sep 2019 06:24:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:202:7df4:abcf:6db2:95b5])
        by smtp.gmail.com with ESMTPSA id e13sm1428426eje.52.2019.09.30.06.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:24:53 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 30 Sep 2019 15:24:51 +0200
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH] tools: libbpf: Add bpf_object__open_buffer_xattr
Message-ID: <20190930132451.GA27081@google.com>
References: <20190927130834.18829-1-kpsingh@chromium.org>
 <CAEf4Bzb_8AJS=HLUt9QpdRrt4AzW1ME9tFyL-QTqyu=7fC-dGA@mail.gmail.com>
 <87h84uxno9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h84uxno9.fsf@toke.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feeback!

I will be happy to update this patch once there is consensus about
the design of the API for future additions.

On 30-Sep 09:12, Toke Høiland-Jørgensen wrote:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> 
> > On Fri, Sep 27, 2019 at 6:11 AM KP Singh <kpsingh@chromium.org> wrote:
> >>
> >> From: KP Singh <kpsingh@google.com>
> >>
> >> Introduce struct bpf_object_open_buffer_attr and an API function,
> >> bpf_object__open_xattr, as the existing API, bpf_object__open_buffer,
> >> doesn't provide a way to specify neither the "needs_kver" nor
> >> the "flags" parameter to the internal call to the
> >> __bpf_object__open which makes it inconvenient for loading BPF
> >> objects that do not require a kernel version from a buffer.
> >>
> >> The flags attribute in the bpf_object_open_buffer_attr is set
> >> to MAPS_RELAX_COMPAT when used in bpf_object__open_buffer to
> >> maintain backward compatibility as this was added to load objects
> >> with non-compat map definitions in:
> >>
> >> commit c034a177d3c8 ("bpf: bpftool, add flag to allow non-compat map
> >>                       definitions")
> >>
> >> and bpf_object__open_buffer was called with this flag enabled (as a
> >> boolean true value).
> >>
> >> The existing "bpf_object__open_xattr" cannot be modified to
> >> maintain API compatibility.
> >>
> >> Reported-by: Anton Protopopov <a.s.protopopov@gmail.com>
> >> Signed-off-by: KP Singh <kpsingh@google.com>
> >> ---
> >>  tools/lib/bpf/libbpf.c   | 39 ++++++++++++++++++++++++++++-----------
> >>  tools/lib/bpf/libbpf.h   | 10 ++++++++++
> >>  tools/lib/bpf/libbpf.map |  5 +++++
> >>  3 files changed, 43 insertions(+), 11 deletions(-)
> >>
> >> This patch is assimilates the feedback from:
> >>
> >>   https://lore.kernel.org/bpf/20190815000330.12044-1-a.s.protopopov@gmail.com/
> >>
> >> I have added a "Reported-by:" tag, but please feel free to update to
> >> "Co-developed-by" if it's more appropriate from an attribution perspective.
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 2b57d7ea7836..1f1f2e92832b 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -2752,25 +2752,42 @@ struct bpf_object *bpf_object__open(const char *path)
> >>         return bpf_object__open_xattr(&attr);
> >>  }
> >>
> >> -struct bpf_object *bpf_object__open_buffer(void *obj_buf,
> >> -                                          size_t obj_buf_sz,
> >> -                                          const char *name)
> >> +struct bpf_object *
> >> +bpf_object__open_buffer_xattr(struct bpf_object_open_buffer_attr *attr)
> >
> > I have few concerns w.r.t. adding API in this form and I'm going to
> > use this specific case to discuss more general problem of API design,
> > ABI compatibility, and extending APIs with extra optional arguments.
> >
> > 1. In general, I think it would be good for libbpf API usability to
> > use the following pattern consistently (moving forward):
> >
> > T1 some_api_function(T2 mandatory_arg1, ..., TN mandatory_arg, struct
> > something_opts *opts)
> >
> > So all the mandatory arguments that have to be provides are specified
> > explicitly as function arguments. That makes it very clear what API
> > expects to get always.
> > opts (we use both opts and attrs, but opts seems better because its
> > optional options :), on the other hand, is stuff that might be
> > omitted, so if user doesn't care about tuning behavior of API and
> > wants all-defaults behavior, then providing NULL here should just
> > work.
> >
> > So in this case for bpf_object__open_buffer_xattr(), it could look like this:
> >
> > struct bpf_object* bpf_object__open_buffer_opts(void *buf, size_t sz,
> > struct bpf_object_open_opts* opts);
> 
> I like this idea! Sensible defaults that can be selected by just passing
> NULL as opts is a laudable goal.
> 
> > 2. Now, we need to do something with adding new options without
> > breaking ABIs. With all the existing extra attributes, when we need to
> > add new field to that struct, that can break old code that's
> > dynamically linked to newer versions of libbpf, because their
> > attr/opts struct is too short for new code, so that could cause
> > segment violation or can make libbpf read garbage for those newly
> > added fields. There are basically three ways we can go about this:
> >
> > a. either provide the size of opts struct as an extra argument to each
> > API that uses options, so:
> > struct bpf_object* bpf_object__open_buffer_opts(void *buf, size_t sz,
> > struct bpf_object_open_opts* opts, size_t opts_sz);
> >
> > b. make it mandatory that every option struct has to have as a first
> > field its size, so:
> >
> > struct bpf_object_open_opts {
> >         size_t sz;
> >         /* now we can keep adding attrs */
> > };
> >
> > Now, when options are provided, we'll read first sizeof(size_t) bytes,
> > validate it for sanity and then we'll know which fields are there or
> > not.
> >
> > Both options have downside of user needing to do extra initialization,
> > but it's not too bad in either case. Especially in case b), if user
> > doesn't care about extra options, then no extra steps are necessary.
> > In case a, we can pass NULL, 0 at the end, so also not a big deal.
> >
> > c. Alternatively, we can do symbol versioning similar how xsk.c
> > started doing it, and handle those options struct size differences
> > transparently. But that's a lot of extra boilerplate code in libbpf
> > and I'd like to avoid that, if possible.
> 
> My hunch is that we're kidding ourselves if we think we can avoid the
> symbol versioning. And besides, checking struct sizes needs boilerplate
> code as well, boilerplate that will fail at runtime instead of compile
> time if it's done wrong.
> 
> So IMO we're better off just doing symbol version right from the
> beginning.

I see there is already a patch for introducing symbol versioning in
libbpf:

  https://lore.kernel.org/bpf/20190928231916.3054271-1-yhs@fb.com/

- KP

> 
> > 3. Now, the last minor complain is about flags field. It's super
> > generic. Why not have a set of boolean fields in a struct, in this
> > case to allow to specify strict/compat modes. Given we solve struct
> > extensibility issue, adding new bool fields is not an issue at all, so
> > the benefit of flags field are gone. The downside of flags field is
> > that it's very opaque integer, you have to go and read sources to
> > understand all the intended use cases and possible flags, which is
> > certainly not a great user experience.
> 
> This I agree with :)
> 
> -Toke
> 
