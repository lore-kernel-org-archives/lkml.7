Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C76C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851E921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfFNMJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:09:14 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33031 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfFNMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:09:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbl14-0008PK-Qq; Fri, 14 Jun 2019 06:09:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbl13-0006O8-Pj; Fri, 14 Jun 2019 06:09:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
        <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
        <20190613132250.u65yawzvf4voifea@brauner.io>
        <871rzxwcz7.fsf@xmission.com>
        <CAJfpegvZwDY+zoWjDTrPpMCS01rzQgeE-_z-QtGfvcRnoamzgg@mail.gmail.com>
        <878su5tadf.fsf@xmission.com>
        <20190613233706.6k6struu7valxaxy@brauner.io>
Date:   Fri, 14 Jun 2019 07:08:50 -0500
In-Reply-To: <20190613233706.6k6struu7valxaxy@brauner.io> (Christian Brauner's
        message of "Fri, 14 Jun 2019 01:37:07 +0200")
Message-ID: <87zhmks71p.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hbl13-0006O8-Pj;;;mid=<87zhmks71p.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+nu1rlfDeT0vRdAuoC9NuBUv4wwvDPKbw=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Regression for MS_MOVE on kernel v5.1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Thu, Jun 13, 2019 at 04:59:24PM -0500, Eric W. Biederman wrote:
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>> 
>> > On Thu, Jun 13, 2019 at 8:35 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >>
>> >> Christian Brauner <christian@brauner.io> writes:
>> >>
>> >> > On Wed, Jun 12, 2019 at 06:00:39PM -1000, Linus Torvalds wrote:
>> >> >> On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
>> >> >> >
>> >> >> > The commit changes the internal logic to lock mounts when propagating
>> >> >> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
>> >> >> > to fail at:
>> >> >>
>> >> >> You mean 'do_move_mount()'.
>> >> >>
>> >> >> > if (old->mnt.mnt_flags & MNT_LOCKED)
>> >> >> >         goto out;
>> >> >> >
>> >> >> > If that's indeed the case we should either revert this commit (reverts
>> >> >> > cleanly, just tested it) or find a fix.
>> >> >>
>> >> >> Hmm.. I'm not entirely sure of the logic here, and just looking at
>> >> >> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
>> >> >> cross-userns copies") doesn't make me go "Ahh" either.
>> >> >>
>> >> >> Al? My gut feel is that we need to just revert, since this was in 5.1
>> >> >> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
>> >> >> don't be silly, this is easily fixed with this one-liner".
>> >> >
>> >> > David and I have been staring at that code today for a while together.
>> >> > I think I made some sense of it.
>> >> > One thing we weren't absolutely sure is if the old MS_MOVE behavior was
>> >> > intentional or a bug. If it is a bug we have a problem since we quite
>> >> > heavily rely on this...
>> >>
>> >> It was intentional.
>> >>
>> >> The only mounts that are locked in propagation are the mounts that
>> >> propagate together.  If you see the mounts come in as individuals you
>> >> can always see/manipulate/work with the underlying mount.
>> >>
>> >> I can think of only a few ways for MNT_LOCKED to become set:
>> >> a) unshare(CLONE_NEWNS)
>> >> b) mount --rclone /path/to/mnt/tree /path/to/propagation/point
>> >> c) mount --move /path/to/mnt/tree /path/to/propgation/point
>> >>
>> >> Nothing in the target namespace should be locked on the propgation point
>> >> but all of the new mounts that came across as a unit should be locked
>> >> together.
>> >
>> > Locked together means the root of the new mount tree doesn't have
>> > MNT_LOCKED set, but all mounts below do have MNT_LOCKED, right?
>> >
>> > Isn't the bug here that the root mount gets MNT_LOCKED as well?
>
> Yes, we suspected this as well. We just couldn't pinpoint where the
> surgery would need to start.
>
>> 
>> Yes, and the code to remove MNT_LOCKED is still sitting there in
>> propogate_one right after it calls copy_tree.  It should be a trivial
>> matter of moving that change to after the lock_mnt_tree call.
>> 
>> Now that I have been elightened about anonymous mount namespaces
>> I am suspecting that we want to take the user_namespace of the anonymous
>> namespace into account when deciding to lock the mounts.
>> 
>> >> Then it breaking is definitely a regression that needs to be fixed.
>> >>
>> >> I believe the problematic change as made because the new mount
>> >> api allows attaching floating mounts.  Or that was the plan last I
>> >> looked.   Those floating mounts don't have a mnt_ns so will result
>> >> in a NULL pointer dereference when they are attached.
>> >
>> > Well, it's called anonymous namespace.  So there *is* an mnt_ns, and
>> > its lifetime is bound to the file returned by fsmount().
>> 
>> Interesting.  That has changed since I last saw the patches.
>> 
>> Below is what will probably be a straight forward fix for the regression.
>
> Tested the patch just now applied on top of v5.1. It fixes the
> regression.
> Can you please send a proper patch, Eric?
>
> Tested-by: Christian Brauner <christian@brauner.io>
> Acked-by: Christian Brauner <christian@brauner.io>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

I will let Al or whoever take this over the finish line.
I am too sleep deprived at the moment to say anything about the quality
of my patch.

Eric

>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index ffb13f0562b0..a39edeecbc46 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -2105,6 +2105,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>>                 /* Notice when we are propagating across user namespaces */
>>                 if (child->mnt_parent->mnt_ns->user_ns != user_ns)
>>                         lock_mnt_tree(child);
>> +               child->mnt.mnt_flags &= ~MNT_LOCKED;
>>                 commit_tree(child);
>>         }
>>         put_mountpoint(smp);
>> diff --git a/fs/pnode.c b/fs/pnode.c
>> index 7ea6cfb65077..012be405fec0 100644
>> --- a/fs/pnode.c
>> +++ b/fs/pnode.c
>> @@ -262,7 +262,6 @@ static int propagate_one(struct mount *m)
>>         child = copy_tree(last_source, last_source->mnt.mnt_root, type);
>>         if (IS_ERR(child))
>>                 return PTR_ERR(child);
>> -       child->mnt.mnt_flags &= ~MNT_LOCKED;
>>         mnt_set_mountpoint(m, mp, child);
>>         last_dest = m;
>>         last_source = child;
>> 
>> 
