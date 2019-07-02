Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6578FC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323C52184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562091783;
	bh=uHUZTL92LdnoiyeyNIsKdrW3LnHKW31MgQHdErGZMAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I0oyeB3muQLprmbqqZWb/n64Q+RYhPOIxUYHDnBWRp20lO6oOIYiMumEqHWVDl/og
	 a5odfm/EazrwPyS9VQRtQ3aAIi9mW3h2WQHBD6cLAy7WI2+tZkeVAuWAzAbWYBS0Q9
	 ciaA+RWbes/iCS7xjbcEo7gQ0XL50E8TRB83JZJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfGBSXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBSXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:23:01 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB3C2184B;
        Tue,  2 Jul 2019 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562091781;
        bh=uHUZTL92LdnoiyeyNIsKdrW3LnHKW31MgQHdErGZMAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8lhXrdGVEeshXHO0KIaw6jBzwotwBKbK6n8N7I94erVXoyIB+IMaphZ6AzqqnPnP
         9ZHuRIQQwQmj7dfGs76xzKhLe0hr0Q/V4gFydJ+SdFSu3CAAcP4D2dk2rq/oRAU/6C
         lcDosjNJld/LfsxlU13xAVSN4jt7UgYudHmJM4Ww=
Date:   Tue, 2 Jul 2019 11:22:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190702182258.GB110306@gmail.com>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190701164536.GA202431@gmail.com>
 <20190701182239.GA17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701182239.GA17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 07:22:39PM +0100, Al Viro wrote:
> On Mon, Jul 01, 2019 at 09:45:37AM -0700, Eric Biggers wrote:
> > On Sat, Jun 29, 2019 at 01:27:44PM -0700, Eric Biggers wrote:
> > > 
> > > Reproducer:
> > > 
> > >     #include <unistd.h>
> > > 
> > >     #define __NR_move_mount         429
> > >     #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> > > 
> > >     int main()
> > >     {
> > >     	  int fds[2];
> > > 
> > >     	  pipe(fds);
> > >         syscall(__NR_move_mount, fds[0], "", -1, "/", MOVE_MOUNT_F_EMPTY_PATH);
> > >     }
> > 
> > David, I'd like to add this as a regression test somewhere.
> > 
> > Can you point me to the tests for the new mount syscalls?
> > 
> > I checked LTP, kselftests, and xfstests, but nothing to be found.
> 
> FWIW, it's not just move_mount(2) - I'd expect
> 
> 	int fds[2];
> 	char s[80];
> 
> 	pipe(fds);
> 	sprintf(s, "/dev/fd/%d", fds[0]);
> 	mount(s, "/dev/null", NULL, MS_MOVE, 0);
> 
> to step into exactly the same thing.  mount(2) does follow symlinks -
> always had...

Sure, but the new mount syscalls still need tests.  Where are the tests?

Also, since the case of a fd with an internal mount was overlooked, probably the
man page needs to be updated clarify that move_mount(2) fails with EINVAL in
this case.  Where is the man page?

- Eric
