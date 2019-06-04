Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7689CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B44724A70
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQM6/EJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfFDHNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:13:33 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44188 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFDHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:13:33 -0400
Received: by mail-io1-f48.google.com with SMTP id s7so9137628iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Anyl5LfgBc3g4Qq9ThwWzuBDfxB1rHp0Hliwmm1saaE=;
        b=SQM6/EJdbswwlNhwv+y8Id3fvVx/4iyLP4qfZC+3BW6uS/hQpRfKnOscwF/5nkMtlu
         wP/RuvF7g/8qDceeXJJ3juses1hBi71YdrDlnzqN9CYcaKg4TPN2zP18J99DP/QbAnS5
         qM15EasngRB8DXCvUNyQc82WzxDeNV4t1EQB+tmN7olJqEodZIMWRfm0ci9SnX0ydoN3
         nSR8+XUIH7y+1DKUyix+FfriPayor5gVRpcW0/1KTJJzzh6+S6cg0KRhUM4Hg8rNUmNR
         Gp7Jgll28g9QJ/LWU6uyM38nppXr00RJSeAFhAhYmZU2q0BFoNlkpgM8qb+lZCoXZjPG
         q1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Anyl5LfgBc3g4Qq9ThwWzuBDfxB1rHp0Hliwmm1saaE=;
        b=ZFXmtkvIUj2qJMOQ25ES2G7TUOCci8UwVfMKP717PcU1xsagFCzxnrhnuv37EAMrJy
         V5px6BzS2ZDLSvCdgoy81Qfns++/x1v60BQOzXR2ydpVm5m95Zzl9c7MF9n/9loSvXBh
         WYi1EOXkNvbf0kJa9oe2QkWenl0ArT0/ZPaw58bVMvv/x4h7zc4EziUU5kqHofWYA34W
         jkNXPAKCSCTg82TZjOxgQ5Rh9cyt4uHLqBj6WSvuWZA/H16W07lAY/sknS79JE0VqTfE
         GQbJ4h2x5DEvmeyeT+dLJdajIim5cpTfzaKoItmRc2ncGv62MctAn97om/I/FMp+VL2p
         UUdA==
X-Gm-Message-State: APjAAAWLVf5eEosOul0dtAW1GPnJGGZOacihCJowszV/kll67TD46M+z
        3hZJcYoXwT1FDV4Aj/HM/SVwp96JEN+54yPkVg==
X-Google-Smtp-Source: APXvYqzzLbGvTakDXi6vbfCj78A6wjQwggKbm8stb2Ai5YrIxlb+17oF2AfZtomYgKnHaH+lWAwAHuc23uwdrVucDEg=
X-Received: by 2002:a6b:e005:: with SMTP id z5mr4088171iog.161.1559632412460;
 Tue, 04 Jun 2019 00:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com> <20190603164206.GB29719@infradead.org>
In-Reply-To: <20190603164206.GB29719@infradead.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Jun 2019 15:13:21 +0800
Message-ID: <CAFgQCTtUdeq=M=SrVwvggR15Yk+i=ndLkhkw1dxJa7miuDp_AA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 12:42 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +#if defined(CONFIG_CMA)
>
> You can just use #ifdef here.
>
OK.
> > +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
> > +     struct page **pages)
>
> Please use two instead of one tab to indent the continuing line of
> a function declaration.
>
Is it a convention? scripts/checkpatch.pl can not detect it. Could you
show me some light so later I can avoid it?

Thanks for your review.

Regards,
  Pingfan
> > +{
> > +     if (unlikely(gup_flags & FOLL_LONGTERM)) {
>
> IMHO it would be a little nicer if we could move this into the caller.
