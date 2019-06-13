Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684C320896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfFMSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:35:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57340 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfFMSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:35:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbUZ5-000421-61; Thu, 13 Jun 2019 12:35:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hbUZ4-0007q5-8w; Thu, 13 Jun 2019 12:35:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
        <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
        <20190613132250.u65yawzvf4voifea@brauner.io>
Date:   Thu, 13 Jun 2019 13:34:52 -0500
In-Reply-To: <20190613132250.u65yawzvf4voifea@brauner.io> (Christian Brauner's
        message of "Thu, 13 Jun 2019 15:22:51 +0200")
Message-ID: <871rzxwcz7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hbUZ4-0007q5-8w;;;mid=<871rzxwcz7.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+JzB9Pk1jfWwta+BptGM8qAR+dHIiNwEY=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: Regression for MS_MOVE on kernel v5.1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Wed, Jun 12, 2019 at 06:00:39PM -1000, Linus Torvalds wrote:
>> On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
>> >
>> > The commit changes the internal logic to lock mounts when propagating
>> > mounts (user+)mount namespaces and - I believe - causes do_mount_move()
>> > to fail at:
>> 
>> You mean 'do_move_mount()'.
>> 
>> > if (old->mnt.mnt_flags & MNT_LOCKED)
>> >         goto out;
>> >
>> > If that's indeed the case we should either revert this commit (reverts
>> > cleanly, just tested it) or find a fix.
>> 
>> Hmm.. I'm not entirely sure of the logic here, and just looking at
>> that commit 3bd045cc9c4b ("separate copying and locking mount tree on
>> cross-userns copies") doesn't make me go "Ahh" either.
>> 
>> Al? My gut feel is that we need to just revert, since this was in 5.1
>> and it's getting reasonably late in 5.2 too. But maybe you go "guys,
>> don't be silly, this is easily fixed with this one-liner".
>
> David and I have been staring at that code today for a while together.
> I think I made some sense of it.
> One thing we weren't absolutely sure is if the old MS_MOVE behavior was
> intentional or a bug. If it is a bug we have a problem since we quite
> heavily rely on this...

It was intentional.

The only mounts that are locked in propagation are the mounts that
propagate together.  If you see the mounts come in as individuals you
can always see/manipulate/work with the underlying mount.

I can think of only a few ways for MNT_LOCKED to become set:
a) unshare(CLONE_NEWNS)
b) mount --rclone /path/to/mnt/tree /path/to/propagation/point
c) mount --move /path/to/mnt/tree /path/to/propgation/point

Nothing in the target namespace should be locked on the propgation point
but all of the new mounts that came across as a unit should be locked
together.

> So this whole cross-user+mnt namespace propagation mechanism comes with
> a big hammer that Eric indeed did introduce a while back which is
> MNT_LOCKED (cf. [1] for the relevant commit).
>
> Afaict, MNT_LOCKED is (among other cases) supposed to prevent a user+mnt
> namespace pair to get access to a mount that is hidden underneath an
> additional mount. Consider the following scenario:
>
> sudo mount -t tmpfs tmpfs /mnt
> sudo mount --make-rshared /mnt
> sudo mount -t tmpfs tmpfs /mnt
> sudo mount --make-rshared /mnt
> unshare -U -m --map-root --propagation=unchanged
>
> umount /mnt
> # or
> mount --move -mnt /opt
>
> The last umount/MS_MOVE is supposed to fail since the mount is locked
> with MNT_LOCKED since umounting or MS_MOVing the mount would reveal the
> underlying mount which I didn't have access to prior to the creation of
> my user+mnt namespace pair.
> (Whether or not this is a reasonable security mechanism is a separate
> discussion.)
>
> But now consider the case where from the ancestor user+mnt namespace
> pair I do:
>
> # propagate the mount to the user+mount namespace pair                 
> sudo mount -t tmpfs tmpfs /mnt
> # switch to the child user+mnt namespace pair
> umount /mnt
> # or
> mount --move /mnt /opt
>
> That umount/MS_MOVE should work since that mount was propagated to the
> unprivileged task after the user+mnt namespace pair was created.
> Also, because I already had access to the underlying mount in the first
> place and second because this is literally the only way - we know of -
> to inject a mount cross mount namespaces and this is a must have feature
> that quite a lot of users rely on.

Then it breaking is definitely a regression that needs to be fixed.

I believe the problematic change as made because the new mount
api allows attaching floating mounts.  Or that was the plan last I
looked.   Those floating mounts don't have a mnt_ns so will result
in a NULL pointer dereference when they are attached.

So I suspect fixing this is not as simple as reverting a single patch.

Eric
