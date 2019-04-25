Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577B7C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24594217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556180114;
	bh=YuUybWP2EhFp/jaOdpXOLiLuNUAfb0BeN4MBGTPDaD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L5wbpwKZOlMICAukHOTs83QebxAPXp1RbAv8AlbsK7+eZstAaGTnEAoDF82pO/OOe
	 cfnRGSSl64kLqTkJYDwQBsdaQPd/0kdIvz8HsYSyb5czu4VpwgJiSe1XobUpK0TSFE
	 hg4dIriRolwe1U3n+ZbeA+A39AHJkP2al1pFdfUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfDYIPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfDYIPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:15:12 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E45214AE;
        Thu, 25 Apr 2019 08:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556180110;
        bh=YuUybWP2EhFp/jaOdpXOLiLuNUAfb0BeN4MBGTPDaD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6wSlvvc8Q6nbFFom1CCJqJtRXy7jLJ26k6TCnhZdlAhEsqOgDmZxWz9qDDsXI5CF
         pq030iO77upJJLiX/Kt8U0x5bVf1ShuWNuj1CSaswcc8PT+N78SnPKQNiYhneDBs7R
         XTAg5m7Y2zZI3gAm/Rk0qbxNfA/BPAZWir+F3Uwg=
Date:   Thu, 25 Apr 2019 10:15:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 014/168] sysctl: handle overflow for file-max
Message-ID: <20190425081508.GC7745@kroah.com>
References: <20190424170923.452349382@linuxfoundation.org>
 <20190424170924.385228692@linuxfoundation.org>
 <CAHrFyr6w3c-hJTYPUP8uxcrg4d_2PzxRP4HAh_-zdcF5igfGWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrFyr6w3c-hJTYPUP8uxcrg4d_2PzxRP4HAh_-zdcF5igfGWg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:50:22PM +0200, Christian Brauner wrote:
> On Wed, Apr 24, 2019 at 7:16 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > [ Upstream commit 32a5ad9c22852e6bd9e74bdec5934ef9d1480bc5 ]
> >
> > Currently, when writing
> >
> >   echo 18446744073709551616 > /proc/sys/fs/file-max
> >
> > /proc/sys/fs/file-max will overflow and be set to 0.  That quickly
> > crashes the system.
> >
> > This commit sets the max and min value for file-max.  The max value is
> > set to long int.  Any higher value cannot currently be used as the
> > percpu counters are long ints and not unsigned integers.
> >
> > Note that the file-max value is ultimately parsed via
> > __do_proc_doulongvec_minmax().  This function does not report error when
> > min or max are exceeded.  Which means if a value largen that long int is
> > written userspace will not receive an error instead the old value will be
> > kept.  There is an argument to be made that this should be changed and
> > __do_proc_doulongvec_minmax() should return an error when a dedicated min
> > or max value are exceeded.  However this has the potential to break
> > userspace so let's defer this to an RFC patch.
> >
> > Link: http://lkml.kernel.org/r/20190107222700.15954-3-christian@brauner.io
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Joe Lawrence <joe.lawrence@redhat.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > [christian@brauner.io: v4]
> >   Link: http://lkml.kernel.org/r/20190210203943.8227-3-christian@brauner.io
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Hey Greg,
> 
> Just an heads-up. This patch triggered a KASAN warning and Will has
> sent a fix for that
> which is already in master.
> So if you backport this patch you likely also want to backport
> 
> 9002b21465fa4d829edfc94a5a441005cffaa972
> 
> (See  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9002b21465fa4d829edfc94a5a441005cffaa972
> )
> 
> Seems we missed a Cc: for stable in there. Sorry about that.

No problem, thanks for letting me know, now queued up everywhere.

greg k-h
