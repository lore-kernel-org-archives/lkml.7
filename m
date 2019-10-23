Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF05CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E092084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwTjN6vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbfJWIhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:37:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35810 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389949AbfJWIhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:37:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so31202729qtq.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lz7pb4FteEgyJv9IPQ/OLCtPnphrxWGvxhOP9Cg5xg=;
        b=JwTjN6vydN0+Zf4u7pB30rwoE59an2gXmw4CK43Gw2mUgwv6sHB8dRu5ef+CPKrKi9
         t37NRMXY7Pqn+GOXFnQVRUhDon6l/NVQ8pA0BemeHOS2xV5gnJeOluyURTVwqiqciHLr
         qDsbygaUpKyOoJQGtYGQCZ1Z1qPmuIERBA+CkHYIsho9310tefDA69PATQdcjEBUxKvZ
         zccwGPi/rBKb1ABlUBTM4DzoW7/ny0B2e4mksE9SWdW/VXPMMYWRkgwBwgTZmF6XoI/2
         9Klci3Rpbj2E75wUXAhDRIwV2xUCPGOaB+CkTyurziCQ8SokD8YBhlXIMeY8vmxGNMh9
         CpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lz7pb4FteEgyJv9IPQ/OLCtPnphrxWGvxhOP9Cg5xg=;
        b=jSJpe/TvVBonNpypSNYKbL6MXnICHyxBwo3MlX/tn89O8NFz5vaKEvK5XSI4hjrsvi
         5wtg4Sa5LEGOnBwfjR50jlDV2KsqwkL0m+fWTYgvVRdN3KQO7L4EN2kJT11uq7Z4IZLp
         L8STw7PNxWQtWVYbJy8ICxM9Y4KRwPuire73nP9QfE7sYX6cWJBSl8IeVih9PPusp4xn
         NOIogAZv3V1Wbg4QryN5Lynz96F33MM4jz+91Gay2TLi+7ebbn2Xf4pcP1YbZ8wIMO3N
         h+n82siq5McCpaFvbr45kcIohaN0X7CA8YvA4b5PTAT0Nv/bZGzNNDGLSQ5kKw7Aa6TI
         oFdQ==
X-Gm-Message-State: APjAAAWOEQmrs0zD5zDfviSZ1e+8uMaRrIfr00UKcrzOCknJjGGdubDp
        p9M3tA3ymMtuX7tZWzKaD3Cbcm+itDCZU57JNMFbEQ==
X-Google-Smtp-Source: APXvYqzx+Vk1M8As38RQ4hIHR6mJF2kC4m1fQbj0srob4XtBiTnVVZbS/2BQAN6f9QjBuuoyoWNpTyhH+FFLQW+4r9s=
X-Received: by 2002:a0c:fec3:: with SMTP id z3mr7697922qvs.122.1571819843712;
 Wed, 23 Oct 2019 01:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571762488.git.andreyknvl@google.com>
In-Reply-To: <cover.1571762488.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 23 Oct 2019 10:37:12 +0200
Message-ID: <CACT4Y+aUf5_+U90BD=1FsS1vVFrH=kskkUJWFyg2cdeRjL1LVw@mail.gmail.com>
Subject: Re: [PATCH 0/3] kcov: collect coverage from usb and vhost
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 6:46 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patchset extends kcov to allow collecting coverage from the USB
> subsystem and vhost workers. See the first patch description for details
> about the kcov extension. The other two patches apply this kcov extension
> to USB and vhost.
>
> These patches have been used to enable coverage-guided USB fuzzing with
> syzkaller for the last few years, see the details here:
>
> https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md
>
> This patchset has been pushed to the public Linux kernel Gerrit instance:
>
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/1524

Oh, so much easier to review with side-by-side diffs, context and
smart in-line colouring!

> Changes from RFC v1:
> - Remove unnecessary #ifdef's from drivers/vhost/vhost.c.
> - Reset t->kcov when area allocation fails in kcov_remote_start().
> - Use struct_size to calculate array size in kcov_ioctl().
> - Add a limit on area_size in kcov_remote_arg.
> - Added kcov_disable() helper.
> - Changed encoding of kcov remote handle ids, see the documentation.
> - Added a comment reference for kcov_sequence task_struct field.
> - Change common_handle type to u32.
> - Add checks for handle validity into kcov_ioctl_locked() and
>     kcov_remote_start().
> - Updated documentation to reflect the changes.
>
> Andrey Konovalov (3):
>   kcov: remote coverage support
>   usb, kcov: collect coverage from hub_event
>   vhost, kcov: collect coverage from vhost_worker
>
>  Documentation/dev-tools/kcov.rst | 120 ++++++++
>  drivers/usb/core/hub.c           |   5 +
>  drivers/vhost/vhost.c            |   6 +
>  drivers/vhost/vhost.h            |   1 +
>  include/linux/kcov.h             |   6 +
>  include/linux/sched.h            |   6 +
>  include/uapi/linux/kcov.h        |  20 ++
>  kernel/kcov.c                    | 464 ++++++++++++++++++++++++++++---
>  8 files changed, 593 insertions(+), 35 deletions(-)
>
> --
> 2.23.0.866.gb869b98d4c-goog
>
