Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC514C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A449E20665
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfIYEfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:35:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:42543 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfIYEfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:35:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 21:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; 
   d="scan'208";a="203528751"
Received: from pktinlab.iind.intel.com (HELO pktinlab) ([10.66.253.121])
  by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2019 21:35:35 -0700
Date:   Wed, 25 Sep 2019 09:59:18 +0530
From:   "Bharadiya,Pankaj" <pankaj.laxminarayan.bharadiya@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     pankaj.bharadiya@gmail.com, andriy.shevchenko@linux.intel.com,
        kernel-hardening@lists.openwall.com, akpm@linux-foundation.org,
        mayhs11saini@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] linux/kernel.h: Add sizeof_member macro
Message-ID: <20190925042917.GA83131@pktinlab>
References: <20190924105839.110713-1-pankaj.laxminarayan.bharadiya@intel.com>
 <20190924105839.110713-2-pankaj.laxminarayan.bharadiya@intel.com>
 <201909240920.AE3CD67E87@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909240920.AE3CD67E87@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 09:22:10AM -0700, Kees Cook wrote:
> On Tue, Sep 24, 2019 at 04:28:35PM +0530, Pankaj Bharadiya wrote:
> > At present we have 3 different macros to calculate the size of a
> > member of a struct:
> >   - SIZEOF_FIELD
> >   - FIELD_SIZEOF
> >   - sizeof_field
> > 
> > To bring uniformity in entire kernel source tree let's add
> > sizeof_member macro.
> > 
> > Replace all occurrences of above 3 macro's with sizeof_member in
> > future patches.
> > 
> > Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> > ---
> >  include/linux/kernel.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> Since stddef.h ends up needing this macro, and kernel.h includes
> stddef.h, why not put this macro in stddef.h instead? Then the
> open-coded version of it in stddef (your last patch) can use
> sizeof_member()?
> 

If I understood correctly, Andrew suggested to add such macros in kernel.h
https://www.openwall.com/lists/kernel-hardening/2019/06/11/5

Moreover similar type of other macros (like typeof_member & ARRAY_SIZE)
are defined in kernel.h
But as you pointed out, looks like stddef.h is the right place for this macro.

> Otherwise, yes, looks good. (Though I might re-order the patches so the
> last patch is the tree-wide swap -- then you don't need the exclusions,
> I think?)
>

I went through your tree. 
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/sizeof_member/full
Thank you for reordering the patches.

Thanks,
Pankaj

> -Kees
> 
> > 
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 4fa360a13c1e..0b80d8bb3978 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -79,6 +79,15 @@
> >   */
> >  #define round_down(x, y) ((x) & ~__round_mask(x, y))
> >  
> > +/**
> > + * sizeof_member - get the size of a struct's member
> > + * @T: the target struct
> > + * @m: the target struct's member
> > + * Return: the size of @m in the struct definition without having a
> > + * declared instance of @T.
> > + */
> > +#define sizeof_member(T, m) (sizeof(((T *)0)->m))
> > +
> >  /**
> >   * FIELD_SIZEOF - get the size of a struct's field
> >   * @t: the target struct
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Kees Cook
