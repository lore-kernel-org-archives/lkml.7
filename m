Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A4BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B56F206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="WDSX2K6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbfCZSaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:30:11 -0400
Received: from one.firstfloor.org ([193.170.194.197]:54160 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbfCZSaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:30:07 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 35A5E86722; Tue, 26 Mar 2019 19:30:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1553625004;
        bh=38XXrpoAyr2tks/OhuPaD+DSYzTCp0iIYFGzjfjH1Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDSX2K6UEf/nzc+9lME0BZHMtJFbGug2KOv9GYnt53XuOo7dFIiQ04hjEiZ9Ti1nd
         9S/6aBw9jKjBfLSh9/nQtykhSEaI+iVRGY5358anUfr3XXfznNL+4Jzp2/RhAmoMgL
         UnLGvNWwM9HDBmIVLq3uruHxe7Ij3B5Ip/QA29zs=
Date:   Tue, 26 Mar 2019 11:30:04 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, herbert@gondor.apana.org.au
Subject: Re: [PATCH 14/17] crypto: Don't mark AES tables const and
 cacheline_aligned
Message-ID: <20190326183003.c6bcy642f5bkf6ry@two.firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-15-andi@firstfloor.org>
 <58128cae-5871-64d8-0b4a-c1e3bb354e95@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58128cae-5871-64d8-0b4a-c1e3bb354e95@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:42:13AM +0100, Rasmus Villemoes wrote:
> On 21/03/2019 23.00, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > cacheline_aligned is a special section. It cannot be const at the same
> > time because it's not read-only. It doesn't give any MMU protection.
> 
> Urgh. Perhaps this instead just wanted to use the quadruple underscore
> version, ____cacheline_aligned ? That would make these objects correctly
> aligned and still live in .rodata, no?

Yes that seems to be the right fix.

.rodata is 4K aligned, so it supports 64 bytes too.

-Andi
