Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C16EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A99520823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfC1ShJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:37:09 -0400
Received: from mail.hallyn.com ([178.63.66.53]:43614 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1ShJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:37:09 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 149A1A74; Thu, 28 Mar 2019 13:37:08 -0500 (CDT)
Date:   Thu, 28 Mar 2019 13:37:07 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Allowing mapping supplemental groups in user namespace?
Message-ID: <20190328183707.GA16570@mail.hallyn.com>
References: <CAKdAkRQj=bSSL2Cw3gAqi5f12yP3+KsvtrMvU4Lcfta_JYxMYQ@mail.gmail.com>
 <20190328180503.GA16249@mail.hallyn.com>
 <CAKdAkRRf+7UkmwbWNEnR3cNhc2t-kspRQNy4uOYRdcwBofXwtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRRf+7UkmwbWNEnR3cNhc2t-kspRQNy4uOYRdcwBofXwtA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:30:52AM -0700, Dmitry Torokhov wrote:
> Hi Serge,
> 
> On Thu, Mar 28, 2019 at 11:05 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Thu, Feb 28, 2019 at 11:27:38AM -0800, Dmitry Torokhov wrote:
> > > Hi Eric,
> > >
> > > Currently, unless caller has CAP_SETGID in parent namespace, we can
> > > only map effective group id in the new user namespace. Would it be
> > > possible to relax this rule to also allow mapping of supplemental
> > > groups (1:1) of the caller?
> > >
> > > Thanks.
> > >
> > > --
> > > Dmitry
> >
> > Hi,
> >
> > Is there a use case where adding those to /etc/subgid is onerous?
> > (There probably is, just would like to see yours)
> 
> We on Chrome OS limit number of suid binaries installed on the system,
> so newgidmap does not have necessary privileges to carry out this

<shrug> good goal in general so long as you don't take a few huge
monolithic suid binaries instad of more simpler ones :)

> operation. Also we are looking for a solution that we can use with our
> minijail package where spawning additional binary is challenging even
> if it was suid.

Ok.  So fwiw I think what you propose should be ok.  I think you should
post a patch to do it.  It's very possible that seeing that patch will
remind us of the reason why it *is* a bad idea, but seeing the patch may
be a required shock to elicit that memory.

-serge
