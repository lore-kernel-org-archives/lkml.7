Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A792620663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfJOTo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:44:56 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:35562 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727478AbfJOTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:44:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0F1A81804FAC2;
        Tue, 15 Oct 2019 19:44:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: burn23_6500a5bae7a21
X-Filterd-Recvd-Size: 1632
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 15 Oct 2019 19:44:53 +0000 (UTC)
Message-ID: <5695bc78caf94d21b760960d4c1a34411cb4cb81.camel@perches.com>
Subject: Re: [PATCH] linux/bitmap.h: fix potential sign-extension overflow
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 12:44:52 -0700
In-Reply-To: <20191015184657.GA26541@embeddedor>
References: <20191015184657.GA26541@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-15 at 13:46 -0500, Gustavo A. R. Silva wrote:
> In expression 0xff << offset, left shifting by more than 31 bits has
> undefined behavior. Notice that the shift amount, *offset*, can be as
> much as 63.
> 
> Fix this by adding suffix ULL to integer 0xFF.
[]
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
[]
> @@ -520,7 +520,7 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
>  	const size_t index = BIT_WORD(start);
>  	const unsigned long offset = start % BITS_PER_LONG;
>  
> -	map[index] &= ~(0xFF << offset);
> +	map[index] &= ~(0xFFULL << offset);

BITS_PER_LONG is 32 and 0xFFULL is 64 bit
when compiled for 32 bit arches.

This should just be 0xFFUL and not ULL.


