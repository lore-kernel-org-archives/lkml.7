Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E5C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AD02084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDIUMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:12:02 -0400
Received: from namei.org ([65.99.196.166]:32992 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfDIUMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:12:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x39KBwBR007797;
        Tue, 9 Apr 2019 20:11:58 GMT
Date:   Wed, 10 Apr 2019 06:11:58 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     David Rheinsberg <david.rheinsberg@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH] apparmor: Restore Y/N in /sys for apparmor's "enabled"
In-Reply-To: <CAGXu5j+g8tPrDAYVKv26ci6zvGuvC1TMXto7weVP2QBymMRjhw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1904100611310.7633@namei.org>
References: <20190408160706.GA18786@beast> <CADyDSO4NkEY-SPT-abnyRXT9kGWhF8LbU3XQGNp-5k_15debDg@mail.gmail.com> <CAGXu5j+g8tPrDAYVKv26ci6zvGuvC1TMXto7weVP2QBymMRjhw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019, Kees Cook wrote:

> On Mon, Apr 8, 2019 at 11:21 PM David Rheinsberg
> <david.rheinsberg@gmail.com> wrote:
> >
> > Hi
> >
> > On Mon, Apr 8, 2019 at 6:07 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Before commit c5459b829b71 ("LSM: Plumb visibility into optional "enabled"
> > > state"), /sys/module/apparmor/parameters/enabled would show "Y" or "N"
> > > since it was using the "bool" handler. After being changed to "int",
> > > this switched to "1" or "0", breaking the userspace AppArmor detection
> > > of dbus-broker. This restores the Y/N output while keeping the LSM
> > > infrastructure happy.
> > >
> > > Before:
> > >         $ cat /sys/module/apparmor/parameters/enabled
> > >         1
> > >
> > > After:
> > >         $ cat /sys/module/apparmor/parameters/enabled
> > >         Y
> > >
> > > Reported-by: David Rheinsberg <david.rheinsberg@gmail.com>
> > > Link: https://lkml.kernel.org/r/CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com
> > > Fixes: c5459b829b71 ("LSM: Plumb visibility into optional "enabled" state")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > This fix, if John is okay with it, is needed in v5.1 to correct the
> > > userspace regression reported by David.
> > > ---
> > >  security/apparmor/lsm.c | 49 ++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 48 insertions(+), 1 deletion(-)
> >
> > This looks good to me. Thanks a lot! If this makes v5.1, I will leave
> > the apparmor-detection in dbus-broker as it is, unless someone asks me
> > to parse 0/1 as well?
> >
> > I cannot judge whether the apparmor_initialized check is correct, but
> > for the parameter parsing:
> >
> > Reviewed-by: David Rheinsberg <david.rheinsberg@gmail.com>
> 
> Thanks!
> 
> James, are you able to take this for v5.1 fixes?

Actually, JJ usually submits directly to Linus.  

-- 
James Morris
<jmorris@namei.org>

