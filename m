Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B51C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B6E22387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfGXLkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:40:35 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:55115 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727378AbfGXLkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:40:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 0582A83777ED;
        Wed, 24 Jul 2019 11:40:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shape98_3ee351f3c5a54
X-Filterd-Recvd-Size: 2144
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 11:40:32 +0000 (UTC)
Message-ID: <b88ca439f5b2d578888a1cd39b30acb8121d422c.camel@perches.com>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Kitt <steve@sk2.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 24 Jul 2019 04:40:30 -0700
In-Reply-To: <201907231435.FABB1CC@keescook>
References: <cover.1563841972.git.joe@perches.com>
         <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
         <201907231435.FABB1CC@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 14:36 -0700, Kees Cook wrote:
> On Mon, Jul 22, 2019 at 05:38:15PM -0700, Joe Perches wrote:
> > Several uses of strlcpy and strscpy have had defects because the
> > last argument of each function is misused or typoed.
> > 
> > Add macro mechanisms to avoid this defect.
> > 
> > stracpy (copy a string to a string array) must have a string
> > array as the first argument (to) and uses sizeof(to) as the
> > size.
> > 
> > These mechanisms verify that the to argument is an array of
> > char or other compatible types like u8 or unsigned char.
> > 
> > A BUILD_BUG is emitted when the type of to is not compatible.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> I think Rasmus's suggestion would make sense:
> 
> 	BUILD_BUG_ON(!__same_type(typeof(to), char[]))

I think Rasmus had an excellent suggestion.
I liked it and submitted it as V2.

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks.


