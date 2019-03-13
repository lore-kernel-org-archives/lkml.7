Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB69CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB588217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QdHnZTm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCMG0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:26:40 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33136 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfCMG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:26:39 -0400
Received: by mail-vs1-f66.google.com with SMTP id z6so350316vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 23:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7xzeYD4smScVaFve0D/PWcSiHc+2ECvkTqKkXhqffA=;
        b=QdHnZTm7n3nsNFJWb4IeZSOYwii5BQ8mCPxL6xhnYymT5xzssWA70KJSDMEXd6GRCS
         h1mLXtGsKHF+1ijdtX9DLZ72skvXtCxwNY3+l1SmaUb4/GXJMx0phlmLEan3J8L0AYZt
         C/TMggSFhA5PVQYB/vTNvJFV/3tdmOxNUT8Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7xzeYD4smScVaFve0D/PWcSiHc+2ECvkTqKkXhqffA=;
        b=La8FQsVBjjrgVOTBBk3eFxVnRjgaqXC8wG9gO36rPsEe0dRdRdMW7hLUejSwXX1CHF
         WpuH1IZB0byRrwdo3uI9eDaA4EdTkg9NztM2JypvFpmFZF/sS0vhssAoCCQZVOjO8bLJ
         RDCyCE+ttahB6jehpLWQrPuWWSt04rWneVckL1sAgvDXOj2vKgfkq/+pgOCaxFojG8xz
         cdKlhVBZLjjCQERrGoGL3QSn11dsCqVwQzPpbvTwQeu7O88WGKbP0MfrUXQxlbIU84gc
         fJo2N38UHUVTJg9E9NXfxtDEorXcEw0xo5xhfLBBTFVe5hIMESXN/h+9c/+G2spLn67X
         tmEA==
X-Gm-Message-State: APjAAAVjt7DYbEXAZgNVhuOlVr7z3ivLVN1Kk8SvTiZnGlcjRAvObu8q
        A3nWWTG2iq/hIapWPZrRZWFVdRsHsGM=
X-Google-Smtp-Source: APXvYqxvG1OpVBSwtrxSfIi/GnjEMNWyrE2b57IKFhuzOnHsPL2G200IsPEdHxGqjX9bOJz5sxe98Q==
X-Received: by 2002:a67:b145:: with SMTP id z5mr21545362vsl.53.1552458397194;
        Tue, 12 Mar 2019 23:26:37 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id g4sm2528119vke.39.2019.03.12.23.26.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 23:26:35 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id m20so331982vsq.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 23:26:35 -0700 (PDT)
X-Received: by 2002:a67:fa94:: with SMTP id f20mr5954737vsq.172.1552458395001;
 Tue, 12 Mar 2019 23:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016f7d40583d79bd9@google.com>
In-Reply-To: <00000000000016f7d40583d79bd9@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Mar 2019 23:26:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
Message-ID: <CAGXu5jKjWwYk5N3mOH1A8fXX_0BT3r1At_3MzN9M+Ckg5irKXg@mail.gmail.com>
Subject: Re: WARNING: bad usercopy in fanotify_read
To:     syzbot <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cai@lca.pw,
        Chris von Recklinghausen <crecklin@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:42 PM syzbot
<syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com> wrote:
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ee410b200000
> [...]
> ------------[ cut here ]------------
> Bad or missing usercopy whitelist? Kernel memory exposure attempt detected
> from SLAB object 'fanotify_event' (offset 40, size 8)!
> [...]
>   copy_to_user include/linux/uaccess.h:151 [inline]
>   copy_fid_to_user fs/notify/fanotify/fanotify_user.c:236 [inline]
>   copy_event_to_user fs/notify/fanotify/fanotify_user.c:294 [inline]

Looks like this is the fh/ext_fh union in struct fanotify_fid, field
"fid" in struct fanotify_event. Given that "fid" is itself in a union
against a struct path, I think instead of a whitelist using
KMEM_CACHE_USERCOPY(), this should just use a bounce buffer to avoid
leaving a whitelist open for path or ext_fh exposure.

Maybe something like this (untested):

diff --git a/fs/notify/fanotify/fanotify_user.c
b/fs/notify/fanotify/fanotify_user.c
index 56992b32c6bb..b87da9580b3c 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -207,6 +207,7 @@ static int process_access_response(struct
fsnotify_group *group,
 static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
 {
        struct fanotify_event_info_fid info = { };
+       unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh;
        struct file_handle handle = { };
        size_t fh_len = event->fh_len;
        size_t len = fanotify_event_info_len(event);
@@ -233,7 +234,18 @@ static int copy_fid_to_user(struct fanotify_event
*event, char __user *buf)

        buf += sizeof(handle);
        len -= sizeof(handle);
-       if (copy_to_user(buf, fanotify_event_fh(event), fh_len))
+
+       /*
+        * For an inline fh, copy through stack to exclude the copy from
+        * usercopy hardening protections.
+        */
+       fh = fanotify_event_fh(event);
+       if (fh_len <= sizeof(bounce)) {
+               memcpy(bounce, fh, fh_len);
+               fh = bounce;
+       }
+
+       if (copy_to_user(buf, fh, fh_len))
                return -EFAULT;

        /* Pad with 0's */


-- 
Kees Cook
