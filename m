Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57432C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1686A20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554763942;
	bh=c8a1hwY6u+TxWFfplKe2/XF5g4lUyh2oy7skc9WW/AY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dceJWSucLWcr/XAiqb4K4MM8FSFCbhK9/RWyKVpVwi2RzetqSMNUj6N6DbcHQwQ5R
	 aUxtghwVwxWNsoOYsgnv53oeyisI6o6dI5C9SN9KRszUwoX2+5YP3K1CNdFI9ysRJE
	 mPgqIT9wCdnoqDm53YWATyWkvcvhKVGpHCqxIRPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfDHWwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:52:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDHWwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:52:19 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E70E0CB7;
        Mon,  8 Apr 2019 22:52:18 +0000 (UTC)
Date:   Mon, 8 Apr 2019 15:52:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        idosch@mellanox.com, Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v1 bitops] bitops: Fix UBSAN undefined behavior warning
 for rotation right
Message-Id: <20190408155217.3f723554ae7fbcb34eeacb30@linux-foundation.org>
In-Reply-To: <20190407125325.24440-1-vadimp@mellanox.com>
References: <20190407125325.24440-1-vadimp@mellanox.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resend, cc Andrey)

On Sun,  7 Apr 2019 12:53:25 +0000 Vadim Pasternak <vadimp@mellanox.com> wrote:

> The warning is caused by call to rorXX(), if the second parameters of
> this function "shift" is zero. In such case UBSAN reports the warning
> for the next expression: (word << (XX - shift), where XX is
> 64, 32, 16, 8 for respectively ror64, ror32, ror16, ror8.
> Fix adds validation of this parameter - in case it's equal zero, no
> need to rotate, just original "word" is to be returned to caller.
> 
> The UBSAN undefined behavior warning has been reported for call to
> ror32():
> [   11.426543] UBSAN: Undefined behaviour in ./include/linux/bitops.h:93:33
> [   11.434045] shift exponent 32 is too large for 32-bit type 'unsigned int'

hm, do we care?

> ...
>

> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -70,6 +70,9 @@ static inline __u64 rol64(__u64 word, unsigned int shift)
>   */
>  static inline __u64 ror64(__u64 word, unsigned int shift)
>  {
> +	if (!shift)
> +		return word;
> +
>  	return (word >> shift) | (word << (64 - shift));
>  }

Is there any known architecture or compiler for which UL<<64 doesn't
reliably produce zero?  Is there any prospect that this will become a
problem in the future?

