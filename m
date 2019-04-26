Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E83C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D148C2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOF+nEDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDZSKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:10:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41455 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfDZSKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:10:35 -0400
Received: by mail-io1-f67.google.com with SMTP id r10so3658749ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+1TnrYeykZ4uHOkP1fnZ3zoGVUTu6KjEnh502A5YIM=;
        b=cOF+nEDnMUUOqxE73YvBiwt86yz8lSrgN7pJFcFltp7Szi/juxPAOUEjPFkZe0St7U
         tfrBCfFodDqWr51SR3SPHuVR0ZEp5+2JiGpL+Th9c1wFPnGCRLzquk974x+tmBeaSM7u
         DCvtl15T4RdTgXMnV4LkzxBThQm/I6NRmwUcQSHQWa1MeGJcdyM2a1IAueWcOI40lPBM
         AsiOaGphER60exUeIGBFZ5uY7MU6oo6GdoiqDJp2EQ28fn23FlV2OHZPlJwxJInSbzHC
         9p+aH6qWKQuAOz+gPW++vz5QKeqqTsHMFoAto/VhJsPqfPkvnyEtSd3zxojZFNFiccRp
         6V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+1TnrYeykZ4uHOkP1fnZ3zoGVUTu6KjEnh502A5YIM=;
        b=Ga6moKcIpLyX05GPWQunC/oEhPn0r0XvbRuMJJtxhTqaWEm1mOzzt3inZ2Q5nulXB9
         HX8zubCYOrVyZhsLiF/PLvLmq/7vijIMkyof3ZPX+78YPA8DykSbX6lmPxSk6tVD5Ctc
         /DKHWS9kqP4x46vz+0vvMOcNOrrtSEr9KtZy1x/YtoM9onU0j/NugCa5+HD1M6sjMr4j
         xmyoUfNknwk68Jj3cIl6PSK8dlW6Tv4akC3KOoVTol7fMKYGAHpVRsrU3Ptjh/kjvRHs
         dEekzR6dNIxL3q2X/yXRErFemY/GKpGrcXh5VADGjLpHznVGC8j1B8+cvcP2bt/qH0UL
         Ohhw==
X-Gm-Message-State: APjAAAVwFvl6Zwq2YCpTO1QgOeCGwxx5bx7LxDX8/TwfepBwHH3SCln2
        Uq+foHbg/YehycDvL4j3oCT1xQhBbU6yQlZL6L2wgdZApnY=
X-Google-Smtp-Source: APXvYqw9FqsrcyyRhofNPMOp0DaWFEzjGmXZ0ypA/9YtxC7xYINHKyX0ZOVcOKvPw9yYKmyTAEH16t3P1q/qOzodMVc=
X-Received: by 2002:a5e:8348:: with SMTP id y8mr29478399iom.88.1556302233694;
 Fri, 26 Apr 2019 11:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190425225828.212472-1-matthewgarrett@google.com> <d058d1ef-994f-ea6b-b6b4-bcd838a9fe2f@suse.cz>
In-Reply-To: <d058d1ef-994f-ea6b-b6b4-bcd838a9fe2f@suse.cz>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 26 Apr 2019 11:10:22 -0700
Message-ID: <CACdnJuuVBb8bOUGGq0H+Ask_ufT3X9YH42o5nAGQK0TCf+aKWg@mail.gmail.com>
Subject: Re: [PATCH V3] mm: Allow userland to request that the kernel clear
 memory on release
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:45 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/26/19 12:58 AM, Matthew Garrett wrote:
> > Updated based on feedback from Jann - for now let's just prevent setting
> > the flag on anything that has already mapped some pages, which avoids
> > child processes being able to interfere with the parent. In addition,
>
> That makes the API quite tricky and different from existing madvise()
> modes that don't care. One would for example have to call
> madvise(MADV_WIPEONRELEASE) before mlock(), otherwise mlock() would
> fault the pages in (unless MLOCK_ONFAULT). As such it really looks like
> a mmap() flag, but that's less flexible.
>
> How bout just doing the CoW on any such pre-existing pages as part of
> the madvise(MADV_WIPEONRELEASE) call?

I'll look into the easiest way to do that.
