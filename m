Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE45C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FCD21850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LwB7iZ62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfI0NMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:12:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38408 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfI0NMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:12:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id l21so2287504edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r/YlMd+ABdbFqVfQSuisclIe5RaTInuYhTyrlp7UJqI=;
        b=LwB7iZ62Q3MzwaxIUnSj4Pzy98gBm+A1KMiJbjObU2r9JHOq5qvX1sRJr7OzQ50a/1
         YMxWixU8GiufOzDfTXWqBl1ocb23Z+/GcUFhiS1oC8Em8zTeH/yiNIyZgbQFNuL0aOhu
         8m6Dt9Bwc4LPb34QbLXQpU2exb9l5PNJ2zedU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r/YlMd+ABdbFqVfQSuisclIe5RaTInuYhTyrlp7UJqI=;
        b=hJas3NKzVLyxrFLNRGWQITBjcRtLnrvC9Vq3dYUmalgoPNYDAdyizCKrA9qdNM4w7W
         5LX9xRWjYYntmhKQ4BFFgQxvAvhbA7MG0EIamWPn5aGeP+O1/iRTGtT4uxFVDr/T3Q6e
         An7GpNXQKnhSacivMbS83VWqnUDR+LY00Dw+Ir74+WdZ7QiiJjJx1eoNT1iKNZqr9MmL
         KD4GllXwuhjbKiJk85z0EFVxBlJ6PlZ/mQgp4k5LZnjOb25j9cPe2Z+DMNxqs7REXCZo
         DUiGQsFXtzeiijrvSLEsRHvqJFtyJ0yG5yRCkAF4t28U69d5qqSqL//GF2SjyF8zFaah
         SceA==
X-Gm-Message-State: APjAAAVn4jsreNe+mV6rpg3Rb/FTZeAFh1Yu6CmrrVz3MFx6LuYgAj2n
        FCpkEUO/CdSUhii3t5sTn6EeDQ==
X-Google-Smtp-Source: APXvYqwH0Kf3RFJvBaP6/8SQDfZmH+CT8T2b9MSPH2Qpy/XpKo0w4gLRa+nt6qL7rpKJaKcTDGVDUg==
X-Received: by 2002:a17:907:20eb:: with SMTP id rh11mr7559558ejb.25.1569589924483;
        Fri, 27 Sep 2019 06:12:04 -0700 (PDT)
Received: from chromium.org ([2620:0:105f:fd00:440a:66a5:a253:2909])
        by smtp.gmail.com with ESMTPSA id p1sm575690ejg.10.2019.09.27.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:12:04 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 27 Sep 2019 15:12:02 +0200
To:     Song Liu <songliubraving@fb.com>
Cc:     Anton Protopopov <a.s.protopopov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] tools: libbpf: update extended attributes
 version of bpf_object__open()
Message-ID: <20190927131202.GA18934@chromium.org>
References: <20190815000330.12044-1-a.s.protopopov@gmail.com>
 <796E4DA8-4844-4708-866E-A8AE9477E94E@fb.com>
 <CAGn_itwS=bLf8NGVNbByNx8FmR_JtPWnuEnKO23ig8xnK_GYOw@mail.gmail.com>
 <9EC54605-1911-48B0-B33A-02EC46DEF3DD@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9EC54605-1911-48B0-B33A-02EC46DEF3DD@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Aug 19:24, Song Liu wrote:
> 
> 
> > On Aug 30, 2019, at 11:53 AM, Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> > 
> > чт, 29 авг. 2019 г. в 16:02, Song Liu <songliubraving@fb.com>:
> >> 
> >> 
> >> 
> >>> On Aug 14, 2019, at 5:03 PM, Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> >>> 
> >> 
> >> [...]
> >> 
> >>> 
> >>> 
> >>> int bpf_object__unload(struct bpf_object *obj)
> >>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >>> index e8f70977d137..634f278578dd 100644
> >>> --- a/tools/lib/bpf/libbpf.h
> >>> +++ b/tools/lib/bpf/libbpf.h
> >>> @@ -63,8 +63,13 @@ LIBBPF_API libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn);
> >>> struct bpf_object;
> >>> 
> >>> struct bpf_object_open_attr {
> >>> -     const char *file;
> >>> +     union {
> >>> +             const char *file;
> >>> +             const char *obj_name;
> >>> +     };
> >>>      enum bpf_prog_type prog_type;
> >>> +     void *obj_buf;
> >>> +     size_t obj_buf_sz;
> >>> };
> >> 
> >> I think this would break dynamically linked libbpf. No?
> > 
> > Ah, yes, sure. What is the right way to make changes which break ABI in libbpf?
> 
> I don't have a good idea here on the top of my head.
> 
> Maybe we need a new struct and/or function for this. 


I incorporated the suggested fixes and sent a new patch for this as we
ran into pretty much the same issue. (i.e. not being able to set
needs_kver / flags).

https://lore.kernel.org/bpf/20190927130834.18829-1-kpsingh@chromium.org/T/#u

- KP

>  
> > 
> > BTW, does the commit ddc7c3042614 ("libbpf: implement BPF CO-RE offset
> > relocation algorithm") which adds a new field to the struct
> > bpf_object_load_attr also break ABI?
> 
> I think this change was in the same release, so it is OK. 
> 
> Thanks,
> Song
