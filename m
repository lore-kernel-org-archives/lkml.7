Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4ABC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C11214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389717AbfKEPLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:11:07 -0500
Received: from smtprelay0144.hostedemail.com ([216.40.44.144]:34153 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389546AbfKEPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:11:06 -0500
X-Greylist: delayed 73910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 10:11:05 EST
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CFE671801DC08;
        Tue,  5 Nov 2019 15:11:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chalk38_6091a4e45df63
X-Filterd-Recvd-Size: 3595
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Nov 2019 15:11:03 +0000 (UTC)
Message-ID: <ec20c751ac1e4156aca0b02dfa0cef4b70cb8ec5.camel@perches.com>
Subject: Re: spdxcheck.py complains about the second OR?
From:   Joe Perches <joe@perches.com>
To:     "Zavras, Alexios" <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 05 Nov 2019 07:10:52 -0800
In-Reply-To: <CY4PR1101MB2360AB7647D9E2FA15044EE4897E0@CY4PR1101MB2360.namprd11.prod.outlook.com>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
         <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
         <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
         <CY4PR1101MB2360AB7647D9E2FA15044EE4897E0@CY4PR1101MB2360.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 10:11 +0000, Zavras, Alexios wrote:
> This is not correct.
> Since the grammar includes the production "expr: expr OR expr",
> there is absolutely no need to add a rule with more than two operands --
> it will be handled recursively.

You sure about the recursion?

It does work and spdxcheck no longer emits a message for
these two files.

> -- zvr
> 
> -----Original Message-----
> From: linux-spdx-owner@vger.kernel.org <linux-spdx-owner@vger.kernel.org> On Behalf Of Joe Perches
> Sent: Monday, 4 November, 2019 23:24
> To: Thomas Gleixner <tglx@linutronix.de>; Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-spdx@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: spdxcheck.py complains about the second OR?
> 
> On Mon, 2019-11-04 at 23:11 +0100, Thomas Gleixner wrote:
> > On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> > > scripts/spdxcheck.py warns the following two files.
> > > 
> > > $ ./scripts/spdxcheck.py
> > > drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: 
> > > OR
> > > drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: 
> > > OR
> > > 
> > > I do not understand what is wrong with them.
> > > 
> > > I think "A OR B OR C" is sane.
> > 
> > Yes it is, but obviously we did not expect files with 3 possible 
> > alternative licenses.
> 
> Perhaps just this, but the generic logic obviously isn't complete.
> ---
>  scripts/spdxcheck.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py index 6374e0..00be34 100755
> --- a/scripts/spdxcheck.py
> +++ b/scripts/spdxcheck.py
> @@ -150,6 +150,7 @@ class id_parser(object):
>                  | ID WITH EXC
>                  | expr AND expr
>                  | expr OR expr
> +                | expr OR expr OR expr
>                  | LPAR expr RPAR'''
>          pass
>  
> 
> 
> Intel Deutschland GmbH
> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
> Tel: +49 89 99 8853-0, www.intel.de
> Managing Directors: Christin Eisenschmid, Gary Kershaw
> Chairperson of the Supervisory Board: Nicole Lau
> Registered Office: Munich
> Commercial Register: Amtsgericht Muenchen HRB 186928
> 

