Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3540CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891C021A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfJTTgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 15:36:54 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:58675 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbfJTTgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:36:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9D95852C6;
        Sun, 20 Oct 2019 19:36:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: place89_1ebe01dc52621
X-Filterd-Recvd-Size: 3658
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Oct 2019 19:36:51 +0000 (UTC)
Message-ID: <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
Subject: Re: [PATCH v1 1/5] staging: wfx: fix warnings of no space is
 necessary
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Jules Irenge <jbi.octave@gmail.com>, devel@driverdev.osuosl.org,
        outreachy-kernel@googlegroups.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Date:   Sun, 20 Oct 2019 12:36:50 -0700
In-Reply-To: <20191020191759.GJ24678@kadam>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
         <20191019140719.2542-2-jbi.octave@gmail.com> <20191019142443.GH24678@kadam>
         <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
         <20191019180514.GI24678@kadam>
         <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
         <20191020191759.GJ24678@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-10-20 at 22:17 +0300, Dan Carpenter wrote:
> On Sat, Oct 19, 2019 at 01:02:31PM -0700, Joe Perches wrote:
> > diff -u -p a/rtl8723bs/core/rtw_mlme_ext.c b/rtl8723bs/core/rtw_mlme_ext.c
[]
> > @@ -1132,7 +1132,7 @@ unsigned int OnAuthClient(struct adapter
> >  				goto authclnt_fail;
> >  			}
> >  
> > -			memcpy((void *)(pmlmeinfo->chg_txt), (void *)(p + 2), len);
> > +			memcpy((void *)(pmlmeinfo->chg_txt), (p + 2), len);
> 
> I wonder why it didn't remove the first void cast?

drivers/staging/rtl8723bs/include/sta_info.h:151:       unsigned char chg_txt[128];

I think the cocci transforms for an array do not match a pointer
and I wrote the cocci script without much care.

btw;

There's probably a generic cocci mechanism to check function
prototypes and then remove uses of unnecessary void pointer casts
in function calls.  I'm not going to try to figure out that syntax.

> [ The rest of the email is bonus comments for outreachy developers ].
> 
> And someone needs to check the final patch probably to remove the extra
> parentheses around "(p + 2)".  Those were necessary when for the cast
> but not required after the cast is gone.
> 
> >  			pmlmeinfo->auth_seq = 3;
> >  			issue_auth(padapter, NULL, 0);
> >  			set_link_timer(pmlmeext, REAUTH_TO);
> 
> It's sort of tricky to know what "one thing per patch means".

It seems somewhat arbitrary and based on Greg's understanding
of the experience of the patch submitter and also the language
of the potential commit message.

> -       memset((void *)(&(pHTInfo->SelfHTCap)), 0,
> +       memset((&(pHTInfo->SelfHTCap)), 0,
>                 sizeof(pHTInfo->SelfHTCap));
> 
> Here the parentheses were never related to the cast so we should leave
> them as is.  In other words, in the first example, if we didn't remove
> the cast that would be "half a thing per patch" and in the second
> example that would be "two things in one patch".

For style patches, it's frequently easier and better to 
do all the code transformation at once.

IMO the last should be:

	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap));

like it is here:

drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c:1056:       memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap));

btw2:

I really dislike all the code inconsistencies and
unnecessary code duplication with miscellaneous changes
in the rtl staging drivers....

Horrid stuff.

