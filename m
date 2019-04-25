Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E89C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3106F2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556214381;
	bh=g8G78ovRuV9PvRG3kJpn3JJY5Nm24D9jXumtJG8YFVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XgoAPpKoLg/5mk74ZPKDoEO+kUNSnr7S/PtgbuOEj1q8Kjr8SKrg0RxOWeW+FLfEm
	 xaN83EMK0NYJ6Aqpk4Sm2v1o516usQCk8hjQQh6LFTXcs5IqbKIIFDUPfls0jBnNdT
	 qGVhLEOZeisBywgmmbd4b7BxebgPzwhW65Jahhso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfDYRqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYRqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:46:18 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D1EE20675;
        Thu, 25 Apr 2019 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556214378;
        bh=g8G78ovRuV9PvRG3kJpn3JJY5Nm24D9jXumtJG8YFVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmIf3k46qMbQedrHc7U6utwJtKYeNa6ThD6+xIAGxh3YUWCGnmctEVWhp5LUyVcSS
         0kgqMzph0XUbl4jubECrUIGh2wRFib1XIY9cNSqpHmdYi24umedFGHTUsBCADx2TvI
         KmDLRNFyJC68RQeY292rU/eow+lptwhtJvYH+ZNw=
Date:   Thu, 25 Apr 2019 19:46:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/siphash.c: mark expected switch fall-throughs
Message-ID: <20190425174615.GA8544@kroah.com>
References: <20190416172720.68e8b95f@canb.auug.org.au>
 <CAHmME9rycs66KYXhxa5t5=7B9JkrotU1MMxXDFXrxqCM27ysBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rycs66KYXhxa5t5=7B9JkrotU1MMxXDFXrxqCM27ysBw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 06:03:58PM +0900, Jason A. Donenfeld wrote:
> On Tue, Apr 16, 2019 at 4:27 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > where we are expecting to fall through.
> >
> > This patch aims to suppress up to 18 missing-break-in-switch false
> > positives on some architectures.
> >
> > Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> > Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Looks good to me, thanks for this.
> 
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Perhaps Greg can take it through his tree?

Me?  Ok, fine, I'll go queue it up...

