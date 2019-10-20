Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7C3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F2C21929
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfJTTwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 15:52:51 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:26445 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbfJTTwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:52:51 -0400
X-IronPort-AV: E=Sophos;i="5.67,320,1566856800"; 
   d="scan'208";a="407081613"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 21:52:48 +0200
Date:   Sun, 20 Oct 2019 21:52:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [Outreachy kernel] Re: [PATCH v1 1/5] staging: wfx: fix warnings
 of no space is necessary
In-Reply-To: <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1910202149140.10441@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com>  <20191019140719.2542-2-jbi.octave@gmail.com> <20191019142443.GH24678@kadam>  <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>  <20191019180514.GI24678@kadam>  <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
  <20191020191759.GJ24678@kadam> <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Oct 2019, Joe Perches wrote:

> On Sun, 2019-10-20 at 22:17 +0300, Dan Carpenter wrote:
> > On Sat, Oct 19, 2019 at 01:02:31PM -0700, Joe Perches wrote:
> > > diff -u -p a/rtl8723bs/core/rtw_mlme_ext.c b/rtl8723bs/core/rtw_mlme_ext.c
> []
> > > @@ -1132,7 +1132,7 @@ unsigned int OnAuthClient(struct adapter
> > >  				goto authclnt_fail;
> > >  			}
> > >
> > > -			memcpy((void *)(pmlmeinfo->chg_txt), (void *)(p + 2), len);
> > > +			memcpy((void *)(pmlmeinfo->chg_txt), (p + 2), len);
> >
> > I wonder why it didn't remove the first void cast?
>
> drivers/staging/rtl8723bs/include/sta_info.h:151:       unsigned char chg_txt[128];
>
> I think the cocci transforms for an array do not match a pointer
> and I wrote the cocci script without much care.
>
> btw;
>
> There's probably a generic cocci mechanism to check function
> prototypes and then remove uses of unnecessary void pointer casts
> in function calls.  I'm not going to try to figure out that syntax.

With the --recursive-includes option, perhaps:

@r@
identifier f;
parameter list[n] ps;
type T;
identifier i;
@@

T f(ps, void *i, ...);

@@
expression e;
identifier r.f;
expression list[r.n] es;
@@

f(es,
- (void *)(e)
+ e
  ,...)

This of course only works for functions that have prototypes, and not for
macros.  It will also run slowly.

julia


>
> > [ The rest of the email is bonus comments for outreachy developers ].
> >
> > And someone needs to check the final patch probably to remove the extra
> > parentheses around "(p + 2)".  Those were necessary when for the cast
> > but not required after the cast is gone.
> >
> > >  			pmlmeinfo->auth_seq = 3;
> > >  			issue_auth(padapter, NULL, 0);
> > >  			set_link_timer(pmlmeext, REAUTH_TO);
> >
> > It's sort of tricky to know what "one thing per patch means".
>
> It seems somewhat arbitrary and based on Greg's understanding
> of the experience of the patch submitter and also the language
> of the potential commit message.
>
> > -       memset((void *)(&(pHTInfo->SelfHTCap)), 0,
> > +       memset((&(pHTInfo->SelfHTCap)), 0,
> >                 sizeof(pHTInfo->SelfHTCap));
> >
> > Here the parentheses were never related to the cast so we should leave
> > them as is.  In other words, in the first example, if we didn't remove
> > the cast that would be "half a thing per patch" and in the second
> > example that would be "two things in one patch".
>
> For style patches, it's frequently easier and better to
> do all the code transformation at once.
>
> IMO the last should be:
>
> 	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap));
>
> like it is here:
>
> drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c:1056:       memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap));
>
> btw2:
>
> I really dislike all the code inconsistencies and
> unnecessary code duplication with miscellaneous changes
> in the rtl staging drivers....
>
> Horrid stuff.
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel%40perches.com.
>
