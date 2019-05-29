Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB4AC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA74D218D1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2+LkvmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfE2QMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:12:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45744 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfE2QMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:12:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id t24so2562120otl.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dA5y3r0aKOO17C44t4tmXUXlp1J2scPYhjFw2NUwAY=;
        b=f2+LkvmJQcoBptCBm246fDUwbMG6hdJdrT0vD4h0TvX/VMamWpYyvvexR9WXdTf6GN
         a6ndExHvujI200GIB17qHDR5BRqnNQAso0RemsqKAi9lJyGCtqCI2L/Xiq6y+2qoP8uS
         X2itQ+NkIkTjLv0mEem5m+uz4MCQeXIAN1gYQwIu9J2V9m6Q51c48uvrxu4HUmp43XeJ
         OtO0k1rezsyZvoKR2+c8omaqFkJwe1VDzKCVoRlCv14hXE85n5c+4wxlaawpMFBHUfLv
         sZ2i3sT6G5ebk20iTs9m19hqG+D4/Npi87/mxK0+2ohPzpdxVR4pPWvJg/HBrqlBaufe
         0eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dA5y3r0aKOO17C44t4tmXUXlp1J2scPYhjFw2NUwAY=;
        b=MFTEO155EUCAMOjJ624viCuhi/lJwRMHPniks1/MvW4cJXApxUllq1hXxH3/jYdPww
         hvp2wWXp2c12b6WyFvjjmPVo/inc3w6AhKUh4WMibxaeTuxpaISIsQ+wRgqkIYWxPmWY
         NHpYMWHQmUsNmG2P/IAOES6CibVqm2JmptCkIlFK8Kl2Mv9yAUWL9R/teMvhYOS7EBc8
         2xlfgFAMRH29yIIY+s+VL0gt6WIjuOR2wgXXl2D8K56bAPQrRnr6Sbi81QZydVr3fWqD
         xbl0kQlrAQElwEfqXXv+QookG83Kp4mAyFR48M4QiwmpgT737UCMIuMuVLz05LcmKwcj
         lV+Q==
X-Gm-Message-State: APjAAAXp5VYHE+rTt+6aTpyvwOsJUy5SDW0bpjkqvOQriMxLgkS/1BYf
        GMRJYPcEkLbkB909YXlFV1p6pC0JsjLYn7YSZZx/mA==
X-Google-Smtp-Source: APXvYqwaOZla10Bof+mWLbbjMk94Ufa8TbjMKTZDaEYcqsOulha4oFcPoVi9fCgSIx16NNNOnT1R2rYebkMt9uJmErs=
X-Received: by 2002:a9d:7347:: with SMTP id l7mr1571410otk.183.1559146365528;
 Wed, 29 May 2019 09:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <14347.1559127657@warthog.procyon.org.uk> <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
In-Reply-To: <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 18:12:19 +0200
Message-ID: <CAG48ez2KMrTBFzO9p8GvduXruz+FNLPyhc2YivHePsgViEoT1g@mail.gmail.com>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 5:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/29/2019 4:00 AM, David Howells wrote:
> > Jann Horn <jannh@google.com> wrote:
> >
> >>> +void post_mount_notification(struct mount *changed,
> >>> +                            struct mount_notification *notify)
> >>> +{
> >>> +       const struct cred *cred = current_cred();
> >> This current_cred() looks bogus to me. Can't mount topology changes
> >> come from all sorts of places? For example, umount_mnt() from
> >> umount_tree() from dissolve_on_fput() from __fput(), which could
> >> happen pretty much anywhere depending on where the last reference gets
> >> dropped?
> > IIRC, that's what Casey argued is the right thing to do from a security PoV.
> > Casey?
>
> You need to identify the credential of the subject that triggered
> the event. If it isn't current_cred(), the cred needs to be passed
> in to post_mount_notification(), or derived by some other means.
>
> > Maybe I should pass in NULL creds in the case that an event is being generated
> > because an object is being destroyed due to the last usage[*] being removed.
>
> You should pass the cred of the process that removed the
> last usage. If the last usage was removed by something like
> the power being turned off on a disk drive a system cred
> should be used. Someone or something caused the event. It can
> be important who it was.

The kernel's normal security model means that you should be able to
e.g. accept FDs that random processes send you and perform
read()/write() calls on them without acting as a subject in any
security checks; let alone close(). If you send a file descriptor over
a unix domain socket and the unix domain socket is garbage collected,
for example, I think the close() will just come from some random,
completely unrelated task that happens to trigger the garbage
collector?

Also, I think if someone does I/O via io_uring, I think the caller's
credentials for read/write operations will probably just be normal
kernel creds?

Here the checks probably aren't all that important, but in other
places, when people try to use an LSM as the primary line of defense,
checks that don't align with the kernel's normal security model might
lead to a bunch of problems.
