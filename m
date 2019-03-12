Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734EDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416DD2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="KPrG9Zkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfCLOmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:42:49 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39738 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbfCLOmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:42:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BD8188EE1ED;
        Tue, 12 Mar 2019 07:42:48 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id am2VP22-0qQo; Tue, 12 Mar 2019 07:42:48 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0A1E68EE0F5;
        Tue, 12 Mar 2019 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552401768;
        bh=Gbmgkyh2LGvvBeucUW1MW2SyQTqbLMrDQhmUENeD3kQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KPrG9ZkpCPP+0icyJyfRK8MvU6GLuPMHMDHT0w0nvJEwQOsACFisKmEr3REdvF6Fi
         K3X3j2F22w4g8sXO9L04C+e5nxbzWbfLQfIUWN3Az4nFMzrfTNSA9AyCq7dRz0rML+
         KVAeUMdtaRRT83D5EyhnWK8XINv2fDf2KYUYrwcA=
Message-ID: <1552401766.3083.3.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Calvin Owens <calvinowens@fb.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Date:   Tue, 12 Mar 2019 07:42:46 -0700
In-Reply-To: <20190312125028.GC9243@linux.intel.com>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
         <1552350463.23859.8.camel@HansenPartnership.com>
         <20190312125028.GC9243@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 14:50 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 11, 2019 at 05:27:43PM -0700, James Bottomley wrote:
> > On Mon, 2019-03-11 at 16:54 -0700, Calvin Owens wrote:
> > > e're having lots of problems with TPM commands timing out, and
> > > we're seeing these problems across lots of different hardware
> > > (both v1/v2).
> > > 
> > > I instrumented the driver to collect latency data, but I wasn't
> > > able to find any specific timeout to fix: it seems like many of
> > > them are too aggressive. So I tried replacing all the timeout
> > > logic with a single universal long timeout, and found that makes
> > > our TPMs 100% reliable.
> > > 
> > > Given that this timeout logic is very complex, problematic, and
> > > appears to serve no real purpose, I propose simply deleting all
> > > of it.
> > 
> > "no real purpose" is a bit strong given that all these timeouts are
> > standards mandated.  The purpose stated by the standards is that
> > there needs to be a way of differentiating the TPM crashed from the
> > TPM is taking a very long time to respond.  For a normally
> > functioning TPM it looks complex and unnecessary, but for a
> > malfunctioning one it's a lifesaver.
> 
> Standards should be only followed when they make practical sense and
> ignored when not. The range is only up to 2s anyway.

I don't disagree ... and I'm certainly not going to defend the TCG
because I do think the complexity of some of its standards contributed
to the lack of use of TPM 1.2.

However, I am saying we should root cause this problem rather than take
a blind shot at the apparent timeout complexity.  My timeout
instability is definitely related to the polling adjustments, so it's
not unreasonable to think Facebooks might be as well.

James

