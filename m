Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF5DC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DB620693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOWlZGWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfCMPft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:35:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46767 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfCMPfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:35:48 -0400
Received: by mail-ua1-f66.google.com with SMTP id j8so791492uae.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fkZ1R4sQEMo0zPoMAkzRXZhF754qG1NDK5UVkeCsEw=;
        b=fOWlZGWEVn0MCbN4pbgoP2zKmNPjl5jA0QapjarN8eTRKf1QL/YmUvEDHR3ddi8zwy
         v8z/Bo777HByP3RdljwTtmsASTcwt5WD/WhJ2GvsthQfGrJZUz91fNQPjKwJjhFAYG5U
         DIFR23GoaBYbVRf4aCoccz6Ld4KrTT7rjPcZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fkZ1R4sQEMo0zPoMAkzRXZhF754qG1NDK5UVkeCsEw=;
        b=Pff65nVn5Wmh92RyU+acPBTlnuwK7QkOHDVU+aDKgEr/pJlP5Ij2AKh1wdlcU0wzTG
         PdVUdWexULvUVSQZfM7RGtK+ODOh2tp0mqzXjYwyhaAcp9il0LmBgfgbrlhFJU/1Km7k
         E0jbW3TLWuJbFXyFLEAP2Ht966sclaB7ULbaRgDy6P/rRf8gDZAy4GVJ86ZHuUMODIv2
         ZmyxPBwRQZM+TZHLq1qp8Wnkws6T1JNDaZJWTGRdkgBqTxQ0U/TCxmzFsj3MZp+vjVyx
         vx+Vf96Ce/Kd6VoyRHF6CvelL08meCoMOumCM4uo36orCXECh1nabSkpvAWWHF0Y0uTu
         sd1g==
X-Gm-Message-State: APjAAAVZGhMuuhabuCxQr8DddBTvust27439BD/MHAHf0zVh30BUtg99
        CkDu0CGV8jUzDyTsig4dcHNlzwVmFgA=
X-Google-Smtp-Source: APXvYqxwy7K8PQFAl+1F+cb8fEg6Xyu2wTHFCNX+insQjBqWMjqR6Cd1d/EvuxwRWv7l/hyRECJJYw==
X-Received: by 2002:ab0:6513:: with SMTP id w19mr23253555uam.19.1552491346627;
        Wed, 13 Mar 2019 08:35:46 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id q12sm4907220vkf.42.2019.03.13.08.35.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 08:35:45 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id e126so1068438vse.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 08:35:45 -0700 (PDT)
X-Received: by 2002:a67:fa94:: with SMTP id f20mr7091272vsq.172.1552491344698;
 Wed, 13 Mar 2019 08:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016f7d40583d79bd9@google.com> <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
 <20190313143503.GD9108@quack2.suse.cz>
In-Reply-To: <20190313143503.GD9108@quack2.suse.cz>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Mar 2019 08:35:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+_Ao_CU8DG9nrTbx5ioDkJUFw0cGcLBMWnvNLe_eFJ4A@mail.gmail.com>
Message-ID: <CAGXu5j+_Ao_CU8DG9nrTbx5ioDkJUFw0cGcLBMWnvNLe_eFJ4A@mail.gmail.com>
Subject: Re: WARNING: bad usercopy in fanotify_read
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, cai@lca.pw,
        Chris von Recklinghausen <crecklin@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 7:35 AM Jan Kara <jack@suse.cz> wrote:
> On Tue 12-03-19 23:26:22, Kees Cook wrote:
> > On Mon, Mar 11, 2019 at 1:42 PM syzbot
> > <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com> wrote:
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ee410b200000
> > > [...]
> > > ------------[ cut here ]------------
> > > Bad or missing usercopy whitelist? Kernel memory exposure attempt detected
> > > from SLAB object 'fanotify_event' (offset 40, size 8)!
> > > [...]
> > >   copy_to_user include/linux/uaccess.h:151 [inline]
> > >   copy_fid_to_user fs/notify/fanotify/fanotify_user.c:236 [inline]
> > >   copy_event_to_user fs/notify/fanotify/fanotify_user.c:294 [inline]
> >
> > Looks like this is the fh/ext_fh union in struct fanotify_fid, field
> > "fid" in struct fanotify_event. Given that "fid" is itself in a union
> > against a struct path, I think instead of a whitelist using
> > KMEM_CACHE_USERCOPY(), this should just use a bounce buffer to avoid
> > leaving a whitelist open for path or ext_fh exposure.
>
> Do you mean to protect it from a situation when some other code (i.e. not
> copy_fid_to_user()) would be tricked into copying ext_fh containing slab
> pointer to userspace?

Yes. That's the design around the usercopy hardening. The
"whitelisting" is either via code (with a bounce buffer, so only the
specific "expected" code path can copy it), with a
kmem_create_usercopy() range marking (generally best for areas that
are not unions or when bounce buffers would be too big/slow), or with
implicit whitelisting (via a constant copy size that cannot change at
run-time, like: copy_to_user(dst, src, 6)).

In this case, since there are multiple unions in place and
FANOTIFY_INLINE_FH_LEN is small, it seemed best to go with a bounce
buffer.

-- 
Kees Cook
