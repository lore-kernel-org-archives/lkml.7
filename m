Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD17BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF8B2238C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 23:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfGWXmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 19:42:24 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:44806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbfGWXmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:42:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 48EDC182251C0;
        Tue, 23 Jul 2019 23:42:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: arch08_31ad5a36be712
X-Filterd-Recvd-Size: 2901
Received: from XPS-9350 (172-222-149-092.dhcp.chtrptr.net [172.222.149.92])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 23:42:21 +0000 (UTC)
Message-ID: <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Jul 2019 16:42:19 -0700
In-Reply-To: <alpine.DEB.2.21.1907231546090.2551@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
         <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
         <alpine.DEB.2.21.1907231546090.2551@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 15:52 -0500, Julia Lawall wrote:
> On Mon, 22 Jul 2019, Joe Perches wrote:
> > I just sent a patch to add yet another string copy mechanism.
> > 
> > This could help avoid misuses of strscpy and strlcpy like this
> > patch set:
> > 
> > https://lore.kernel.org/lkml/cover.1562283944.git.joe@perches.com/T/
> > 
> > A possible cocci script to do conversions could be:
> > 
> >    $ cat str.cpy.cocci
> >    @@
> >    expression e1;
> >    expression e2;
> >    @@
> > 
> >    - strscpy(e1, e2, sizeof(e1))
> >    + stracpy(e1, e2)
> > 
> >    @@
> >    expression e1;
> >    expression e2;
> >    @@
> > 
> >    - strlcpy(e1, e2, sizeof(e1))
> >    + stracpy(e1, e2)
> > 
> > This obviously does not match the style of all the
> > scripts/coccinelle cocci files, but this might be
> > something that could be added improved and added.
> > 
> > This script produces:
> > 
> > $ spatch --in-place -sp-file str.cpy.cocci .
> > $ git checkout tools/
> > $ git diff --shortstat
> >  958 files changed, 2179 insertions(+), 2655 deletions(-)
> > 
> > The remainder of strlcpy and strscpy uses in the
> > kernel would generally have a form like:
> > 
> > 	strlcpy(to, from, DEFINE)
> > 
> > where DEFINE is the specified size of to
> > 
> > Could the cocci script above be updated to find
> > and correct those styles as well?
> 
> I guess it would depend on what "to" is and what DEFINE expands into.  For
> example, in cpuidle-powernv.c, I see:
> 
> strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
> 
> and by poking around I see:
> 
> struct cpuidle_state {
> 	char		name[CPUIDLE_NAME_LEN];
> 	char		desc[CPUIDLE_DESC_LEN];
> 	...
> };

Yes, ideally this case would not modify the #define for the
length but adapt the strlcpy(,,DEFINE)

There are a lot of these in drivers/hwmon using I2C_NAME_SIZE.

> I will look into it.

Thanks.


