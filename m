Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F89C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D962E26D9D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSfRpR2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfEaSDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:03:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40166 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfEaSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:03:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id a9so7218507lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Te9nW14r9oz600HemwX1PmP5UfiH0eDOXlPAanGjnDs=;
        b=XSfRpR2tO/BuTcazDlkiBewUCbPn0tL4l/aNQHFAX2+7RPe0p71r/h84aaLhjLI/nI
         anB5omipRVYMmFmVkPtXSsmYU8GE34D/nGaKQw0VdVu3ciu5gglCK30rOGq5pdEMGBQp
         rg4wzQBI7wl5JqqCvsaxxLrXLH10mFZzikcq18MI90GCv0DC5ZW9nq44BnM6wWAHMnE7
         siGh/86QBqzG7pkatKqoiErX4m/Y9F1G9moDMbXfSuQJtN8BgqBA1SnZ1fDhNciI/Cpz
         To8cL2ZZGK9RH4fClo3mlKn/Dkm3EAcNTdWlxm4h0Fs/tobJfMIAOfJP3x6IB4bdZLzg
         dQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Te9nW14r9oz600HemwX1PmP5UfiH0eDOXlPAanGjnDs=;
        b=LC4UOm/XcYDVVbS2onLX/mUvk+XO3YCSHjRDYHvJi+uXUC+oAJrgeMq3twmM4gqs82
         k4IQoRR0mr2b4KZhkmlQHqQ0eIDDxNxUDw/Km835mR6noiL7LMiflCWN8LUqOHpcVK2E
         xTypv/VQRRoqmzxst4RKD4SGiKT9BwALAp20Gis5Ldfkgm2kQdsu28ITGg1bfF8JVjBN
         fCva1JADxgkMGead29aGJ4ZuHRBIm4oSxpKcprxV+O3bp8i1PaTFV66EoyVAQEuFMlJC
         QMZEhs5yxjPdOAkAJmrjybvAD5kIMyXFdz+nZlnzygIzYcDFuClCOwO2EtDK0ellO+7O
         BzRA==
X-Gm-Message-State: APjAAAXRzjzX5CvO/OYaNPE7sTbrQHx5ozFG5yxgWjv9mmvPT+sTwmpT
        ILDkVeRF4CNjD1gYnKNaKx4l+I+ogA2S5i2S69uq4g==
X-Google-Smtp-Source: APXvYqx2YTvJsIKuSTpbAn4IyqRskLt8Gxt9pLJOMzVIcwRpPIYpOtokEJH/meHamcRY6VCzyDlDsyYJGM5IbtnLBDs=
X-Received: by 2002:a19:ca02:: with SMTP id a2mr4358970lfg.88.1559325809340;
 Fri, 31 May 2019 11:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <73fac64c-fe49-4738-49a4-0afe668eed94@canonical.com>
 <201905310740.522B3A7C1@keescook> <c80362bd-1dec-3e4f-c3e8-1c58d3a33070@canonical.com>
In-Reply-To: <c80362bd-1dec-3e4f-c3e8-1c58d3a33070@canonical.com>
From:   Ke Wu <mikewu@google.com>
Date:   Fri, 31 May 2019 11:03:17 -0700
Message-ID: <CANRnR9Q4AY1nyTebWgkVM-wUfZv7kKNLnsrchWPBH4HPbB-X6Q@mail.gmail.com>
Subject: Re: security/loadpin: Allow to exclude specific file types
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jamorris@linux.microsoft.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think Coverity is correct. Note that it's the size of
kernel_read_file_str (rather than exclude_read_files) doesn't equal to
ignore_read_file_id.

This is because READING_MAX_ID is also an element in
kernel_read_file_str, which makes the size of kernel_read_file_str to
be READING_MAX_ID+1. I will send a new patch to fix the issue. Thanks
for the  analysis!


On Fri, May 31, 2019 at 7:49 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 31/05/2019 15:44, Kees Cook wrote:
> > On Fri, May 31, 2019 at 11:46:29AM +0100, Colin Ian King wrote:
> >> Hi,
> >>
> >> Static analysis with Coverity on linux-next has found a potential issue
> >> with the following commit:
> >>
> >> commit 1633a4f04cc171fc638deb5c95af96032d3c591b
> >> Author: Ke Wu <mikewu@google.com>
> >> Date:   Thu May 30 12:22:08 2019 -0700
> >>
> >>     security/loadpin: Allow to exclude specific file types
> >>
> >>
> >> 209                for (j = 0; j < ARRAY_SIZE(kernel_read_file_str); j++) {
> >> 210                        if (strcmp(cur, kernel_read_file_str[j]) == 0) {
> >> 211                                pr_info("excluding: %s\n",
> >> 212                                        kernel_read_file_str[j]);
> >>
> >> CID 81977 (#1 of 1): Out-of-bounds write
> >> overrun-local: Overrunning array ignore_read_file_id of 8 4-byte
> >> elements at element index 8 (byte offset 35) using index j (which
> >> evaluates to 8).
> >>
> >> 213                                ignore_read_file_id[j] = 1;
> >>
> >> According to Coverity ignore_read_file_id is an array of 8 integers.
> >> However, ARRAY_SIZE(kernel_read_file_str) is 9, so we have an out of
> >> bounds write on ignore_read_file[j] when j is 8.
> >
> > What am I missing? This doesn't fail the build:
> >
> > +       BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
> > +                    ARRAY_SIZE(ignore_read_file_id));
> >
> > They have the same number of elements.
> >
>
> Yep, that's very true. I'll discuss this with Coverity as this seems
> like a weird false positive.
>
> Apologies for the noise.
>
> Colin



-- 
Ke Wu | Software Engineer | mikewu@google.com | Google Inc.
