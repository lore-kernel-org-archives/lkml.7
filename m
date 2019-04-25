Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FAC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9422520717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2Y0UXdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbfDYUoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:44:09 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53812 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbfDYUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:44:09 -0400
Received: by mail-it1-f194.google.com with SMTP id z4so2359116itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9T6Hh/gfaAIMuibwKFS2lWem2Wt7fkhHXq9vbgpXfiI=;
        b=X2Y0UXdYtsf1r8qUOurjsJI9eewtbXZBIc9FX3ykI64j+N6JDnvmPQgxohph6tOAzh
         7oT8+8CwhPf9xiD3Jz16lMZwg6HYfEE8hmUoI3+5Q24DAvTT3LMS318fjKrafBTKMLdp
         /QCm5H30eeFrFQyoJqAQU6mLKhoOiFOFRKOys6WzC7PITt6PGmRIb68eV+Q9vbOIF8Lp
         dqqIBIsuqZsLmIJYgH7ifXN/C6bkykkP+VnH630efhebTaBgEkxtI5L/ops1ha0ExfBP
         J1iXAkZ/9AP474L4907G3yTct2zTI6Gj5ZWvtNVMWWSZmkuBm4Tepf10tdXxOFJ9VNkb
         ZKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9T6Hh/gfaAIMuibwKFS2lWem2Wt7fkhHXq9vbgpXfiI=;
        b=f+lbsuBANOFDdkn45IwRwFmUymw+P3hnzdHN2ddvJVqrR2QgJiK1tKDfQ5nUX91j+U
         dBX1pQiR5bddHKrCnF7PgnQt4FmO9F7f4+/wkRgtrqX7K3AjzY96kWY9R1URJRzXmOuU
         gbytJTa6sRXhJ3TEqOti0DZFAS6yJHcoOLl/2QTZdfk9BrqnZHcvsnvwBOWNBdWu6mWg
         tm4mxI0cmhw/6LIZepwC5DLAHNtFL6FpJJXssl/rD2Qa19yxwOh5uLQ4stHZDCZ0cfEY
         +v/bmLbfjdONJk/GVJJ5RcFdn7xduFJyCTv2hPsXZ78DSM2PTBYBJDv0UItA0fZjiIXz
         lRNw==
X-Gm-Message-State: APjAAAVtMQNL8sUXmRqWMOYE04wYdbj78zH3UgB8iLdthoZmGtzh1S9y
        VRYzqFPrDf8Jdvb0ZZ5D7OxwEkHQvPeIl+4cokHydg==
X-Google-Smtp-Source: APXvYqxUbgSe5G0v+X+ayIdnr1/C14jU5CTpxKyeEQxe4lKH3qBoI0CAJN7yD+zzO60X6w4ddn4L7c2JaoYQn+CBs54=
X-Received: by 2002:a24:eb04:: with SMTP id h4mr3421463itj.16.1556225048269;
 Thu, 25 Apr 2019 13:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com> <20190425121410.GC1144@dhcp22.suse.cz>
 <CAG48ez0x6QiFpqXbimB9ZV-jS5UJJWhzg9XiAWncQL+phfKkPA@mail.gmail.com>
In-Reply-To: <CAG48ez0x6QiFpqXbimB9ZV-jS5UJJWhzg9XiAWncQL+phfKkPA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 25 Apr 2019 13:43:57 -0700
Message-ID: <CACdnJuu__NS3Py+heKPDdTJSe53Wr9AP-oArO7mVRky2wqMp2g@mail.gmail.com>
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
To:     Jann Horn <jannh@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 5:43 AM Jann Horn <jannh@google.com> wrote:
> An interesting effect of this is that it will be possible to set this
> on a CoW anon VMA in a fork() child, and then the semantics in the
> parent will be subtly different - e.g. if the parent vmsplice()d a
> CoWed page into a pipe, then forked an unprivileged child, the child
> set MADV_WIPEONRELEASE on its VMA, the parent died somehow, and then
> the child died, the page in the pipe would be zeroed out. A child
> should not be able to affect its parent like this, I think. If this
> was an mmap() flag instead of a madvise() command, that issue could be
> avoided. Alternatively, if adding more mmap() flags doesn't work,
> perhaps you could scan the VMA and ensure that it contains no pages
> yet, or something like that?

I /think/ my argument here would be not to do that? I agree that it's
unexpected, but I guess the other alternative would be to force a copy
on any existing COW pages in the VMA at madvise() time, and maybe also
at fork() time (sort of like the behaviour of MADV_WIPEONFORK, but
copying the page rather than providing a new zero page)

> I think all the callers have a reference to the VMA, so perhaps you
> could add a VMA parameter to page_remove_rmap() and then look at the
> VMA in there?

I'll dig into that, thanks!
