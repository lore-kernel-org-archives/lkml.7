Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71805C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D57021901
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfCUOdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:33:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38325 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfCUOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:33:39 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6yl8-0006ZO-Hv; Thu, 21 Mar 2019 15:33:30 +0100
Date:   Thu, 21 Mar 2019 15:33:30 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] b/arch/x86/mm/pti.c - make local symbols static
In-Reply-To: <36d37d88-4460-e2bb-4f09-07693ddb5831@intel.com>
Message-ID: <alpine.DEB.2.21.1903211528530.1784@nanos.tec.linutronix.de>
References: <27680.1552376873@turing-police> <36d37d88-4460-e2bb-4f09-07693ddb5831@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019, Dave Hansen wrote:

> > Make both variables static.
> 
> "pti_set_kernel_image_nonglobal(void)" is an awfully funny looking
> variable. ;)
> 
> > Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> > 
> > ---
> > diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> > index 4fee5c3003ed..139b28a01ce4 100644
> > --- a/arch/x86/mm/pti.c
> > +++ b/arch/x86/mm/pti.c
> > @@ -77,7 +77,7 @@ static void __init pti_print_if_secure(const char *reason)
> >  		pr_info("%s\n", reason);
> >  }
> >  
> > -enum pti_mode {
> > +static enum pti_mode {
> 
> I'm struggling to figure out why we would want to do this.  If there's a
> really good reason, I think we probably need to do it en masse:

Because its:

enum pti_mode {
 ....
} pti_mode;

So that's both enum and variable declaration. 

> $ grep -r '^enum.{' arch/x86/ | wc -l
> 48

In the other cases it's a enum declaration without declaring a variable at
the same time. Making them static would be obviously bogus.

Thanks,

	tglx

 
