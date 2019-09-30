Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C48C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48432190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOdal9fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfI3HMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:12:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58719 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729503AbfI3HMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569827562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9PtTOzM1rgbNPgKyLzSFcLDf0NZGpY4hCXyEWTHQYw=;
        b=FOdal9fEPH+IkW5Nd080Kpkc+aCLiv97Y7rDRw3UuAYZRHHkq/2qq9ZGSi5V7zEEuvqH5F
        wQsjXxuKLSeMQ/gKjIOhvZYvSpaacZw4OFLSXWz2HK19ksD0HlzGIfjCwLDw+6nfXQmKo9
        v3F2YNPtttZHQ93oZYaN08IFvfbvCjk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-OfI7SKvHM-qqY6JxLsRQlg-1; Mon, 30 Sep 2019 03:12:41 -0400
Received: by mail-ed1-f72.google.com with SMTP id w12so5686783eda.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 00:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vU2fSiERaqwgggzkGOioKrkdDmXRo5o+Ne0c4vAR1CQ=;
        b=Cv1YVdfelRdpGWbN24oSOLIBHu51AitVlAOi5+YXIoqNIe95M33j7pcZcZllDFrWOW
         1aSy3to5DGyIg8z63fa12EKB99jJeKCHrMRhyqxVMXaCFw+cAM6av+K2BdbcZsm9NV0V
         m3XsvmesoEf11uYPYbN1a+yG5WSIBSQi7JZctsSC1MGpzDSc27UVYmyzSxkVCliacws9
         uJFbcSmkKRYkLqmu81jt8CqCnzLyz0vMPlIw+PbwLSa98HfDqkZZFwKQ+Voxms+Hf0Qt
         rBmkWXIRGZza3lawtvuvtNmfDEM8+7ijeneUj9QGB67MxANrTK5M9hKh3eaCitZkAYcA
         t0jw==
X-Gm-Message-State: APjAAAWB9wK2yv3PdDcvcBnwojqY9vG5mF7YZTtuR6TghF7GT59VxueA
        GnvKpYkp8WMiUF1BZTGSllIEh4/DCsvXKe3aENl3YlpxlfJlHXc0a0vd77biW7TyUn55E+kn7Rb
        N9/gJ8jJ5XAT+ECQrLKKaowPq
X-Received: by 2002:a17:906:7687:: with SMTP id o7mr18089163ejm.213.1569827559958;
        Mon, 30 Sep 2019 00:12:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNh0+E8XNHpdRQJY652iiF3XmuXIqVPoJcyfixU4Ze8+NVGMKBTjoBRiU+pVoLCHLti8UGUw==
X-Received: by 2002:a17:906:7687:: with SMTP id o7mr18089139ejm.213.1569827559669;
        Mon, 30 Sep 2019 00:12:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id ot24sm1368521ejb.59.2019.09.30.00.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 00:12:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4C9D518063D; Mon, 30 Sep 2019 09:12:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH] tools: libbpf: Add bpf_object__open_buffer_xattr
In-Reply-To: <CAEf4Bzb_8AJS=HLUt9QpdRrt4AzW1ME9tFyL-QTqyu=7fC-dGA@mail.gmail.com>
References: <20190927130834.18829-1-kpsingh@chromium.org> <CAEf4Bzb_8AJS=HLUt9QpdRrt4AzW1ME9tFyL-QTqyu=7fC-dGA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 30 Sep 2019 09:12:38 +0200
Message-ID: <87h84uxno9.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: OfI7SKvHM-qqY6JxLsRQlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Sep 27, 2019 at 6:11 AM KP Singh <kpsingh@chromium.org> wrote:
>>
>> From: KP Singh <kpsingh@google.com>
>>
>> Introduce struct bpf_object_open_buffer_attr and an API function,
>> bpf_object__open_xattr, as the existing API, bpf_object__open_buffer,
>> doesn't provide a way to specify neither the "needs_kver" nor
>> the "flags" parameter to the internal call to the
>> __bpf_object__open which makes it inconvenient for loading BPF
>> objects that do not require a kernel version from a buffer.
>>
>> The flags attribute in the bpf_object_open_buffer_attr is set
>> to MAPS_RELAX_COMPAT when used in bpf_object__open_buffer to
>> maintain backward compatibility as this was added to load objects
>> with non-compat map definitions in:
>>
>> commit c034a177d3c8 ("bpf: bpftool, add flag to allow non-compat map
>>                       definitions")
>>
>> and bpf_object__open_buffer was called with this flag enabled (as a
>> boolean true value).
>>
>> The existing "bpf_object__open_xattr" cannot be modified to
>> maintain API compatibility.
>>
>> Reported-by: Anton Protopopov <a.s.protopopov@gmail.com>
>> Signed-off-by: KP Singh <kpsingh@google.com>
>> ---
>>  tools/lib/bpf/libbpf.c   | 39 ++++++++++++++++++++++++++++-----------
>>  tools/lib/bpf/libbpf.h   | 10 ++++++++++
>>  tools/lib/bpf/libbpf.map |  5 +++++
>>  3 files changed, 43 insertions(+), 11 deletions(-)
>>
>> This patch is assimilates the feedback from:
>>
>>   https://lore.kernel.org/bpf/20190815000330.12044-1-a.s.protopopov@gmai=
l.com/
>>
>> I have added a "Reported-by:" tag, but please feel free to update to
>> "Co-developed-by" if it's more appropriate from an attribution perspecti=
ve.
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 2b57d7ea7836..1f1f2e92832b 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2752,25 +2752,42 @@ struct bpf_object *bpf_object__open(const char *=
path)
>>         return bpf_object__open_xattr(&attr);
>>  }
>>
>> -struct bpf_object *bpf_object__open_buffer(void *obj_buf,
>> -                                          size_t obj_buf_sz,
>> -                                          const char *name)
>> +struct bpf_object *
>> +bpf_object__open_buffer_xattr(struct bpf_object_open_buffer_attr *attr)
>
> I have few concerns w.r.t. adding API in this form and I'm going to
> use this specific case to discuss more general problem of API design,
> ABI compatibility, and extending APIs with extra optional arguments.
>
> 1. In general, I think it would be good for libbpf API usability to
> use the following pattern consistently (moving forward):
>
> T1 some_api_function(T2 mandatory_arg1, ..., TN mandatory_arg, struct
> something_opts *opts)
>
> So all the mandatory arguments that have to be provides are specified
> explicitly as function arguments. That makes it very clear what API
> expects to get always.
> opts (we use both opts and attrs, but opts seems better because its
> optional options :), on the other hand, is stuff that might be
> omitted, so if user doesn't care about tuning behavior of API and
> wants all-defaults behavior, then providing NULL here should just
> work.
>
> So in this case for bpf_object__open_buffer_xattr(), it could look like t=
his:
>
> struct bpf_object* bpf_object__open_buffer_opts(void *buf, size_t sz,
> struct bpf_object_open_opts* opts);

I like this idea! Sensible defaults that can be selected by just passing
NULL as opts is a laudable goal.

> 2. Now, we need to do something with adding new options without
> breaking ABIs. With all the existing extra attributes, when we need to
> add new field to that struct, that can break old code that's
> dynamically linked to newer versions of libbpf, because their
> attr/opts struct is too short for new code, so that could cause
> segment violation or can make libbpf read garbage for those newly
> added fields. There are basically three ways we can go about this:
>
> a. either provide the size of opts struct as an extra argument to each
> API that uses options, so:
> struct bpf_object* bpf_object__open_buffer_opts(void *buf, size_t sz,
> struct bpf_object_open_opts* opts, size_t opts_sz);
>
> b. make it mandatory that every option struct has to have as a first
> field its size, so:
>
> struct bpf_object_open_opts {
>         size_t sz;
>         /* now we can keep adding attrs */
> };
>
> Now, when options are provided, we'll read first sizeof(size_t) bytes,
> validate it for sanity and then we'll know which fields are there or
> not.
>
> Both options have downside of user needing to do extra initialization,
> but it's not too bad in either case. Especially in case b), if user
> doesn't care about extra options, then no extra steps are necessary.
> In case a, we can pass NULL, 0 at the end, so also not a big deal.
>
> c. Alternatively, we can do symbol versioning similar how xsk.c
> started doing it, and handle those options struct size differences
> transparently. But that's a lot of extra boilerplate code in libbpf
> and I'd like to avoid that, if possible.

My hunch is that we're kidding ourselves if we think we can avoid the
symbol versioning. And besides, checking struct sizes needs boilerplate
code as well, boilerplate that will fail at runtime instead of compile
time if it's done wrong.

So IMO we're better off just doing symbol version right from the
beginning.

> 3. Now, the last minor complain is about flags field. It's super
> generic. Why not have a set of boolean fields in a struct, in this
> case to allow to specify strict/compat modes. Given we solve struct
> extensibility issue, adding new bool fields is not an issue at all, so
> the benefit of flags field are gone. The downside of flags field is
> that it's very opaque integer, you have to go and read sources to
> understand all the intended use cases and possible flags, which is
> certainly not a great user experience.

This I agree with :)

-Toke

