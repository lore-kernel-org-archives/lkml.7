Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4344FC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E166720821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555707515;
	bh=9wDVNpO8ngML+Fb8c/rFbSYWHToYHgwwLSYRw7EPNYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PCgK3ORZeI4UywBYcmxYsip9FOVuL5bohvN0UnjE9u3m6oqAv4oy+X2cnY3BufFb2
	 pI08mIABPF/Pi0vaKoJbPCr6U3wymNBurFhpaYCCaw/KaQF356DGzzb8NJ2FpsWUSP
	 0JCHeyBXdxn+CTP6QNUIoGYjO3ZbQ/BVA5lSThzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfDSU6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:58:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDSU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:58:33 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CBA772851;
        Fri, 19 Apr 2019 20:58:31 +0000 (UTC)
Date:   Fri, 19 Apr 2019 13:58:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in
 kdb summary
Message-Id: <20190419135830.0e3273e223fb83947e5adb0d@linux-foundation.org>
In-Reply-To: <e5f29ca9b6067fff9ea68cb25e15906659cd51ad.camel@perches.com>
References: <20190323015227.245455-1-dianders@chromium.org>
        <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
        <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
        <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
        <20190418160651.40cb6a11186a6c6028e9d20d@linux-foundation.org>
        <CAK7LNAQe2uaVfKee1F6R4siVvUSCMgSaYAnUQfz8MS5PeFqpGA@mail.gmail.com>
        <e5f29ca9b6067fff9ea68cb25e15906659cd51ad.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 04:14:27 -0700 Joe Perches <joe@perches.com> wrote:

> On Fri, 2019-04-19 at 12:28 +0900, Masahiro Yamada wrote:
> > Hi Joe,
> > 
> > Can you detect redundant Cc: by checkpatch?
> > 
> > Please see below in details.
> > Thanks.
> 
> Yes, but I'm not sure why it's useful or necessary.
> git send-email using some scripts elides duplicate email addresses

Other (all?) MUAs will avoid addressing an email to a recipient more
than once.  The issue here is redundant Cc: lines in the changelog.

> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2688,6 +2688,19 @@ sub process {
>  				$signatures{$sig_nospace} = 1;
>  			}
>  
> +# Check for a cc: line with another signature -by: by the same author
> +			if ($sig_nospace =~ /^cc:/) {
> +				my $sig_email = substr($sig_nospace, 3);
> +				foreach my $sig (sort keys %signatures) {
> +					next if ($sig =~ /^cc:/);
> +					$sig =~ s/^[^:]+://;
> +					if ($sig eq $sig_email) {
> +						WARN("BAD_SIGN_OFF",
> +						     "Unnecessary CC: as there is another signature with the same name/email address\n" . $herecurr);
> +					}
> +				}
> +			}
> +
>  # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
>  			if ($sign_off =~ /^co-developed-by:$/i) {
>  				if ($email eq $author) {

Thanks.  But my checkpatch.pl is different from yours.

q:/usr/src/25> grep "immediately followed by" scripts/checkpatch.pl
q:/usr/src/25> 

