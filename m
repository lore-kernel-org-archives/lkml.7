Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C984C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D875D222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570048082;
	bh=KMdwI4c6wky7rlUs/8eG1P4CxPw71KUYJg0fIqdJSLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=blKLO+4TNJA+CquirIE27KuOfnTIJC6UwB3cgz1u7JCix+MPOw/8nSF04wI7nBkJT
	 puLdlAEqA5mBeRRYuYKVFgZlBJLwOQ0L96MfaQAWehur4aO4hfKRsVpjDoDwfideLc
	 rXD4FPmQLOY4vOuCHb9lIgZTyescxM2pcBzNZxiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfJBU2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:28:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42564 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:28:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so220819lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XdihLjEHzl6Bdj0J0VKybnqHBrV7BKaKSpUBn6TrYd8=;
        b=KYUs3SsAkfuNreQPOWd8l020BqbDHgpj9kTZh1yMHxS9XVgi7DHbvGyVzHZ+0SNoXF
         ZcvynCNbqW9sTmshD9EY97xPxWMOO+506YH04ZNWdgpzm5t/SR15nnl6ka9+ZDTIp/AU
         emU5WeC6YsTuq2VNWkuBYXMY7brJ+Ydm3TMCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XdihLjEHzl6Bdj0J0VKybnqHBrV7BKaKSpUBn6TrYd8=;
        b=SqfPIPIMjzGvWxDApc0plTTjRHVrXRv4RsM4X465EQvXU0tRNZfg+Bw+JH5hRsCJOa
         AMAnQL3eyqjrNJSNrXASsV2J28ExpAFka5wvJQfjcYRKaorrxp7Blv9FMrZ/j3NNuwuB
         FkQtVNwjKy8oryOcsdjEn0wNUuLZp2WtHtd5M3Hz+q/xsvFTdJJGREwb6V1irVCwUzzE
         xMXwgEfnJG8/NpkRs5ZtcFvuXF+gaQYlslkPyJTojoyCj+Qp6JLn4YaJ/drbvnuJUY8D
         AmLEAHAEyijQMFt2uDOvqFPMt2nsAaUadYJ0v+y+uGmOFCvCREs9S+bqXnfFhMMQYs23
         UGVw==
X-Gm-Message-State: APjAAAV2SknzXJiSjU1M02pnfqFqDv9RvOda/OXC1bYNBy6Tj/MZl+sP
        q8czZnM4vkoSoWm6uRU5ZNTZ3HeIZ6g=
X-Google-Smtp-Source: APXvYqzv8Y8ZR3P6grxOmL6IVhlO+vh/QKzHU6PD1l+GE8E8aILa0fZGDOoCPIppYNUvUdF8SDPByg==
X-Received: by 2002:a2e:9d44:: with SMTP id y4mr3580766ljj.115.1570048078851;
        Wed, 02 Oct 2019 13:27:58 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o15sm28099lff.22.2019.10.02.13.27.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 13:27:57 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w6so83437lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:27:57 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr3467833lfe.79.1570048077142;
 Wed, 02 Oct 2019 13:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-4-thomas_os@shipmail.org> <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
 <516814a5-a616-b15e-ac87-26ede681da85@shipmail.org>
In-Reply-To: <516814a5-a616-b15e-ac87-26ede681da85@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Oct 2019 13:27:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgH=T5mcDxTaC6QbBN=iJD3d_amzcb2+GxbcV7XuEYL2A@mail.gmail.com>
Message-ID: <CAHk-=wgH=T5mcDxTaC6QbBN=iJD3d_amzcb2+GxbcV7XuEYL2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 12:09 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> Yes I typically tend towards using a "namespace_object_operation" naming
> scheme, with "as_dirty" being the namespace here,

We discourage that kind of mindless namespacing for core stuff.

It makes sense in a driver or a filesystem: when there are 20+
different filesystems all implementing the same operation, you can't
have descriptive and natural names that are unique. So having a
namespace prefix for the filesystem or driver makes sense. But even
then it tends ot be just a simple name, not the op it does.

> Looking at Matthew's suggestion but lining up with
> "unmap_mapping_range()", perhaps we could use "clean_mapping_range" and
> "wp_mapping_range"?

Yes, I agree with Willy that "dirty" is kind of implicit when the
operation is to clean something, so the above sounds sane to me.

The wp part I'm not entirely sure about: you're not actually
write-protecting the range. You're doing something different. You're
only doing it for shared writable mappings. And I'd rather see
separate 'struct mm_walk_ops' than shared ones that then have a flag
in a differfent structure to change behavior.

Yes, yes, some of the levels share the same logic, but that just means
that you can use the same function pointer for that level in the
different "clean" vs "wp" mm_walk_op.

Also, looking closer at this patch, this makes me go "Whaa?":

+       pte =3D (mm =3D=3D &init_mm) ?
+               pte_offset_kernel(pmd, addr) :
+               pte_offset_map_lock(mm, pmd, addr, &ptl);

because I don't think that's sensible. When do you have a vma in kernel spa=
ce?

Also, why do you loop inside the pmd_entry function, instead of just
having a pte_entry function?

           Linus
