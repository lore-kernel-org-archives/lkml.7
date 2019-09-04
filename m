Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5795522DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfIDKok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:44:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49509 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfIDKok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:44:40 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i5SmA-0001Xk-H3; Wed, 04 Sep 2019 10:44:34 +0000
Date:   Wed, 4 Sep 2019 12:44:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hridya Valsaraju <hridya@google.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3 2/2] binder: Validate the default binderfs device
 names.
Message-ID: <20190904104431.ehzyllugr6fr2vjz@wittgenstein>
References: <20190808222727.132744-1-hridya@google.com>
 <20190808222727.132744-3-hridya@google.com>
 <20190809145508.GD16262@kroah.com>
 <20190809181439.qrs2k7l23ot4am4s@wittgenstein>
 <CA+wgaPPK0fY2a+pCEFHrw8p8WCb459yw41s_6xppWFfEa=P7Og@mail.gmail.com>
 <20190904071929.GA19830@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904071929.GA19830@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:19:29AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 09, 2019 at 11:41:12AM -0700, Hridya Valsaraju wrote:
> > On Fri, Aug 9, 2019 at 11:14 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > On Fri, Aug 09, 2019 at 04:55:08PM +0200, Greg Kroah-Hartman wrote:
> > > > On Thu, Aug 08, 2019 at 03:27:26PM -0700, Hridya Valsaraju wrote:
> > > > > Length of a binderfs device name cannot exceed BINDERFS_MAX_NAME.
> > > > > This patch adds a check in binderfs_init() to ensure the same
> > > > > for the default binder devices that will be created in every
> > > > > binderfs instance.
> > > > >
> > > > > Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > > > > ---
> > > > >  drivers/android/binderfs.c | 12 ++++++++++++
> > > > >  1 file changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > > > index aee46dd1be91..55c5adb87585 100644
> > > > > --- a/drivers/android/binderfs.c
> > > > > +++ b/drivers/android/binderfs.c
> > > > > @@ -570,6 +570,18 @@ static struct file_system_type binder_fs_type = {
> > > > >  int __init init_binderfs(void)
> > > > >  {
> > > > >     int ret;
> > > > > +   const char *name;
> > > > > +   size_t len;
> > > > > +
> > > > > +   /* Verify that the default binderfs device names are valid. */
> > > >
> > > > And by "valid" you only mean "not bigger than BINDERFS_MAX_NAME, right?
> > > >
> > > > > +   name = binder_devices_param;
> > > > > +   for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > > > > +           if (len > BINDERFS_MAX_NAME)
> > > > > +                   return -E2BIG;
> > > > > +           name += len;
> > > > > +           if (*name == ',')
> > > > > +                   name++;
> > > > > +   }
> > > >
> > > > We already tokenize the binderfs device names in binder_init(), why not
> > > > check this there instead?  Parsing the same string over and over isn't
> > > > the nicest.
> > >
> > > non-binderfs binder devices do not have their limit set to
> > > BINDERFS_NAME_MAX. That's why the check has likely been made specific to
> > > binderfs binder devices which do have that limit.
> > 
> > 
> > Thank you Greg and Christian, for taking another look. Yes,
> > non-binderfs binder devices not having this limitation is the reason
> > why the check was made specific to binderfs devices. Also, when
> > CONFIG_ANDROID_BINDERFS is set, patch 1/2 disabled the same string
> > being parsed in binder_init().
> > 
> > >
> > > But, in practice, 255 is the standard path-part limit that no-one really
> > > exceeds especially not for stuff such as device nodes which usually have
> > > rather standard naming schemes (e.g. binder, vndbinder, hwbinder, etc.).
> > > So yes, we can move that check before both the binderfs binder device
> > > and non-binderfs binder device parsing code and treat it as a generic
> > > check.
> > > Then we can also backport that check as you requested in the other mail.
> > > Unless Hridya or Todd have objections, of course.
> > 
> > I do not have any objections to adding a generic check in binder_init() instead.
> 
> Was this patchset going to be redone based on this?

No, we decided to leave this check specific to binderfs for now because
the length limit only applies to binderfs devices. If you really want to
have this check in binder we can send a follow-up. I would prefer to
take the series as is.

Btw, for the two binderfs series from Hridya, do you want me to get a
branch ready and send you a PR for both of them together?

Christian
