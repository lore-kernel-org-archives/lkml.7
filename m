Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51676C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36E121019
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Y0u3FVWt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Y0u3FVWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfGJWSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 18:18:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48078 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbfGJWSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:18:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EC0808EE24C;
        Wed, 10 Jul 2019 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562797130;
        bh=7ArvZgcTx/R/r9b1pLkOInASVYMrLtlPUzHDaDO1z30=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y0u3FVWtv6UU0TpgTjKp5FnhPW/dfUEvAsn4hAVq0wtN+CwzzncN0Wkff3yEHCelA
         LWjI/nx6ncCA8tdv7Zx6fUNdGnBtEruHdAgDfzF82gKmKCzL0rmo46eiZeb2b1QsqW
         p2l5TXW7F7SbFxMwOt0CiYR0H5W9o8OKG6PtqqtU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o6FAVD-9GHuB; Wed, 10 Jul 2019 15:18:50 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6835A8EE147;
        Wed, 10 Jul 2019 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562797130;
        bh=7ArvZgcTx/R/r9b1pLkOInASVYMrLtlPUzHDaDO1z30=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y0u3FVWtv6UU0TpgTjKp5FnhPW/dfUEvAsn4hAVq0wtN+CwzzncN0Wkff3yEHCelA
         LWjI/nx6ncCA8tdv7Zx6fUNdGnBtEruHdAgDfzF82gKmKCzL0rmo46eiZeb2b1QsqW
         p2l5TXW7F7SbFxMwOt0CiYR0H5W9o8OKG6PtqqtU=
Message-ID: <1562797129.3213.111.camel@HansenPartnership.com>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Paul Bolle <pebolle@tiscali.nl>, intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Jul 2019 15:18:49 -0700
In-Reply-To: <a23e93d918f8be5aea4af0b87efbf9c3d143d2fb.camel@tiscali.nl>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <1562770874.3213.14.camel@HansenPartnership.com>
         <93b8a186f4c8b4dae63845a20bd49ae965893143.camel@tiscali.nl>
         <1562776339.3213.50.camel@HansenPartnership.com>
         <5245d2b3d82f11d2f988a3154814eb42dcb835c5.camel@tiscali.nl>
         <1562780135.3213.58.camel@HansenPartnership.com>
         <a23e93d918f8be5aea4af0b87efbf9c3d143d2fb.camel@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-10 at 23:59 +0200, Paul Bolle wrote:
> James Bottomley schreef op wo 10-07-2019 om 10:35 [-0700]:
> > I can get back to it this afternoon, when I'm done with the meeting
> > requirements and doing other dev stuff.
> 
> I've started bisecting using your suggestion of that drm merge:
>     $ git bisect log
>     git bisect start
>     # good: [89c3b37af87ec183b666d83428cb28cc421671a6] Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide
>     git bisect good 89c3b37af87ec183b666d83428cb28cc421671a6
>     # bad: [a2d635decbfa9c1e4ae15cb05b68b2559f7f827c] Merge tag 'drm-
> next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
>     git bisect bad a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
>     # bad: [ad2c467aa92e283e9e8009bb9eb29a5c6a2d1217] drm/i915:
> Update DRIVER_DATE to 20190417
>     git bisect bad ad2c467aa92e283e9e8009bb9eb29a5c6a2d1217
> 
> Git told me I have nine steps after this. So at two hours per step I
> might
> pinpoint the offending commit by Friday the 12th. If I'm lucky.
> (There are
> other things to do than bisecting this issue.)
> 
> If you find that commit before I do, I'll be all ears.

Sure ... I'm doing the holistic thing and looking at the tree in that
branch.  It seems to consist of 7 i915 updates

c09d39166d8a3f3788680b32dbb0a40a70de32e2 DRIVER_DATE to 20190207
47ed55a9bb9e284d46d6f2489e32a53b59152809 DRIVER_DATE to 20190220
f4ecb8ae70de86710e85138ce49af5c689951953 DRIVER_DATE to 20190311
1284ec985572232ace4817476baeb2d82b60be7a DRIVER_DATE to 20190320
a01b2c6f47d86c7d1a9fa822b3b91ec233b61784 DRIVER_DATE to 20190328
28d618e9ab86f26a31af0b235ced55beb3e343c8 DRIVER_DATE to 20190404
ad2c467aa92e283e9e8009bb9eb29a5c6a2d1217 DRIVER_DATE to 20190417

So I figured I'd see if I can locate the problem by bisection of those
plus inspection.

James

