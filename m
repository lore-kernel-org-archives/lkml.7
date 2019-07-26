Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B114621734
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmOwl8V1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfGZFEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:04:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46711 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfGZFEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:04:15 -0400
Received: by mail-yw1-f67.google.com with SMTP id z197so19967917ywd.13;
        Thu, 25 Jul 2019 22:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BNINAL8vtmfq8NfDjx0Dmq+IVT05q0DWb+PWa71nh0=;
        b=SmOwl8V1wROFfAkIgrlEn+O0Ui9pNhekwRgt9i4amYp4tIMqUHpxlzwwEM6JDRU1iw
         epQtQK9aIaxC2/Q+hmzNUDklqXMfJQiDi5/BkCns8afIB9OPV6CPOlVkdajgn4s75HkU
         +hejw6Ez8Y7wdz83DcOrBgXJIC5kFM+7A7sZaVIFWMb1kE7GCVeYLw5Hhy+RyIa1OnEf
         orSbxdhtNil7LrN+dJmUCANece+6Clk7JYriE7zLCJf720EPHMvvwXnUMGSFIHwJu9sG
         v8rB9Vl6RJ8EHFvzJiQE0HqrYvj7JdvekuQZnaZzk9RRA0b6GjqzeVdJUcpHh+CyNrXn
         TFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BNINAL8vtmfq8NfDjx0Dmq+IVT05q0DWb+PWa71nh0=;
        b=Eg7M/BrKPWuf6UL38xcvfw/c6xq8kXI8riPQTBq7J5aDnEvHBctPmZKo7f2Zgs8jT1
         xFqIjZfeukyrN/Hir8KRTNTO6jrkMblv8tG2KU8Yh90eSkFuqF8UDGfysfCl1RPLnh3b
         W9Bdbm9o7pjgwKy78p/kmDAFmFsvOvt93QbK3Uenvc9PFRgnHDk+gsSew8p1Zalnn+X/
         /FBExG2J5J9UhJy7EN/OQrrzwZgRpgQ8fPzfJuJ0RgshQZdNekd42O3Otk+4gmr1I7f4
         pVzcN72dw7NPZymCKgYtNx5mYEYPs6T34s7ZmMeIvPzzu+A46CCiivPnbKGizxMhAWLI
         z1Mg==
X-Gm-Message-State: APjAAAUMTWlmxiANeaP2JyCHJOBpbbuI7F/J5caGkOd4+WXCDQoq4TA9
        YVPb2zyilX66Qct8GB44oT0ZSL1/ZRmjalnWQVo=
X-Google-Smtp-Source: APXvYqycEuetYlg8eMDjrLKNUCeBJY1btcEg9V/v3DFIathxqeL4dQ/DUoEzHgjsOnkTepzD/cD2+FI+JKkB5VlFnjI=
X-Received: by 2002:a81:50d5:: with SMTP id e204mr54057700ywb.379.1564117454607;
 Thu, 25 Jul 2019 22:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190724195719.218307-1-salyzyn@android.com> <20190724195719.218307-4-salyzyn@android.com>
 <CAOQ4uxjizC1RhmLe3qmfASk2M-Y+QEiyLL1yJXa4zXAEby7Tig@mail.gmail.com>
 <af254162-10bf-1fc5-2286-8d002a287400@android.com> <CAOQ4uxi5S9HTx+wR1U_8vQ-6nyCozykWBZbZwiHhnXBGhXRz8Q@mail.gmail.com>
 <35b70147-25ad-4c29-3972-418ebee5e7b8@android.com>
In-Reply-To: <35b70147-25ad-4c29-3972-418ebee5e7b8@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Jul 2019 08:04:03 +0300
Message-ID: <CAOQ4uxg8k=4D5_VEBy61PwBo+2pCCakUPw3uCar2oQpi3yaLmA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] overlayfs: add __get xattr method
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 7:22 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 7/25/19 8:43 AM, Amir Goldstein wrote:
> > On Thu, Jul 25, 2019 at 6:03 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >> On 7/24/19 10:48 PM, Amir Goldstein wrote:
> >>> On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >>>> Because of the overlayfs getxattr recursion, the incoming inode fails
> >>>> to update the selinux sid resulting in avc denials being reported
> >>>> against a target context of u:object_r:unlabeled:s0.
> >>> This description is too brief for me to understand the root problem.
> >>> What's wring with the overlayfs getxattr recursion w.r.t the selinux
> >>> security model?
> >> __vfs_getxattr (the way the security layer acquires the target sid
> >> without recursing back to security to check the access permissions)
> >> calls get xattr method, which in overlayfs calls vfs_getxattr on the
> >> lower layer (which then recurses back to security to check permissions)
> >> and reports back -EACCES if there was a denial (which is OK) and _no_
> >> sid copied to caller's inode security data, bubbles back to the security
> >> layer caller, which reports an invalid avc: message for
> >> u:object_r:unlabeled:s0 (the uninitialized sid instead of the sid for
> >> the lower filesystem target). The blocked access is 100% valid, it is
> >> supposed to be blocked. This does however result in a cosmetic issue
> >> that makes it impossible to use audit2allow to construct a rule that
> >> would be usable to fix the access problem.
> >>
> > Ahhh you are talking about getting the security.selinux.* xattrs?
> > I was under the impression (Vivek please correct me if I wrong)
> > that overlayfs objects cannot have individual security labels and
>
> They can, and we _need_ them for Android's use cases, upper and lower
> filesystems.
>
> Some (most?) union filesystems (like Android's sdcardfs) set sepolicy
> from the mount options, we did not need this adjustment there of course.
>
> > the only way to label overlayfs objects is by mount options on the
> > entire mount? Or is this just for lower layer objects?
> >
> > Anyway, the API I would go for is adding a @flags argument to
> > get() which can take XATTR_NOSECURITY akin to
> > FMODE_NONOTIFY, GFP_NOFS, meant to avoid recursions.
>
> I do like it better (with the following 7 stages of grief below), best
> for the future.
>
> The change in this handler's API will affect all filesystem drivers
> (well, my change affects the ABI, so it is not as-if I saved the world
> from a module recompile) touching all filesystem sources with an even
> larger audience of stakeholders. Larger audience of stakeholders, the
> harder to get the change in ;-/. This is also concerning since I would
> like this change to go to stable 4.4, 4.9, 4.14 and 4.19 where this
> regression got introduced. I can either craft specific stable patches or
> just let it go and deal with them in the android-common distributions
> rather than seeking stable merged down. ABI/API breaks are a problem for
> stable anyway ...
>

Use the memalloc_nofs_save/restore design pattern will avoid all that
grief.
As a matter of fact, this issue could and should be handled inside security
subsystem without bothering any other subsystem.
LSM have per task context right? That context could carry the recursion
flags to know that the getxattr call is made by the security subsystem itself.
The problem is not limited to union filesystems.
In general its a stacking issue. ecryptfs is also a stacking fs, out-of-tree
shiftfs as well. But it doesn't end there.
A filesystem on top of a loop device inside another filesystem could
also maybe result in security hook recursion (not sure if in practice).

Thanks,
Amir.
