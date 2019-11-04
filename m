Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7211ACA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E08B217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfKDBw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:52:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:57922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbfKDBw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:52:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1D9AAB89;
        Mon,  4 Nov 2019 01:52:25 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Stephan <stephanwib@googlemail.com>, linux-kernel@vger.kernel.org
Date:   Mon, 04 Nov 2019 12:52:18 +1100
Subject: Re: Process waiting on NFS transitions to uninterruptable sleep when receiving a signal with custom signal handler
In-Reply-To: <CABZpUSVC3id65o_gDxc9mzgSux_qb6NHBzU+3=yBy5yqyjTmFw@mail.gmail.com>
References: <CABZpUSVC3id65o_gDxc9mzgSux_qb6NHBzU+3=yBy5yqyjTmFw@mail.gmail.com>
Message-ID: <875zk0e7cd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Oct 28 2019, Stephan wrote:

> Hello everyone,
>
> I have asked this question on Stackoverflow a while ago but
> unfortunately nobody had an idea on this.
>
> I am currently doing some research on how we can extend the monitoring
> solution for Linux in our datacenter in order to detect inaccessible
> NFS mounts. My idea was to look for NFS mounts in /proc/self/mountinfo
> and then for each mount, call alarm(), issue a syncronous
> interruptible call via stat()/fsstat() or similar, and in case of an
> alarm, return an error in the signal handler. However, I experienced
> the following behaviour which I am not sure how to explain or debug.
>
> It turned out that when a process waiting in the stat system call on a
> mountpoint of a diconnected NFS server, it responds to signals as
> expected. For example, one can exit it pressing Strc+C, or it displays
> "Alarm clock" and ends when the alarm timer fires. The same applies
> e.g. to SIGUSR1/2, leading the program to display "User defined signal
> 1" (or "2") and end. I suspect these messages come from a general
> signal dispatcher inside glibc, but it would be nice to hear some
> details on how this works.

The messages come from your shell (e.g. bash).  The process exits with a
status that means "I was killed by signal XX", and bash reports that.

>
> In all cases in which a custom signal handler was registered, the
> process transitions to an uninterruptible sleep state when a signal
> for this custom handler is scheduled; leading to no other signal being
> processed anymore. Of course this applies to SIGALRM as well when the
> alarm() timer sends the signal. All signals show up in
> /proc/PID/status as below:

In these cases, NFS does a 'killable' wait.  That means that only way to
interrupt the wait is to kill the process (so that it dies).
One justification for this is that there is no error that POSIX allows
stat (or other calls) to return if it takes "too long".  So the
systemcall cannot just fail - instead the whole process needs to die.

So you want your monitoring process to fork, and then access the
filesystem from the child.  If that takes too long, kill the child from
the parent - or set an alarm in the child and let it kill itself.

The parent can then respond to th fact that the child didn't exit
cleanly.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2/hFMACgkQOeye3VZi
gbkDdBAAmCTQ84spYhoER+QDGJ9Xdr3bx5O7mJXJP7w+M68xt0LscdKMmsYXQD0Z
i0Ue6cpZnIrndSlF5uzZeq1Xa5uWON3L1GzPNdyojiYQb9kFl81TxZaIRWjOVhLb
kk7QipDij5zma3qmjAoyEyQjk3M4/QHxnbUo8yZCTO2uHgUdQFn0iT7IIxyhkBBb
ONZikz30Wr7ZuUzEEeTPLNFzHxt0JTaa3ViWaAT6/+z5tLsQK4ZevK47n6P993Ry
xwD5Y7lfKAB59O7KBAeRpIhxvAnrOi44T9NG1VfKj3TYxMcid6SXJpw2o39t8P0t
QKTewsUiR+TaOziHemBZOI4cd2Xll3FC0IEAinNzAMqwXpSm0x+VGhMpqcw7nlnn
vT8uKVLghZe2tFc58gM+ajvIKHq8U3Kd4ZAfVf3o/mOpLZDcaVwv1fEKDudTRe0b
Fgk6w4KU1asjM6U9iDy4PjMPWiKv1UJWt9/O6cBvng2qgS9XYiAWQHb/kF6WaOkd
OW2UxW+PISq+QdCN8RM80Q9BBlTehlGSKJJqAPKX6BVKBNX76u/B8RoCtlfIFViK
ikxJieL3QN757W4XHwSHjktAbsY9drZhwUYCTgFogI/K70V5kINbqHFFlwlHsTBM
0rVGL/cglfTZdGwvsS06JbmesUPKEfCk8RufZWVHQ5fTxiaBuvI=
=FQaN
-----END PGP SIGNATURE-----
--=-=-=--
