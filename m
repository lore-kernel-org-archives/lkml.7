Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE222171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551355162;
	bh=TWxtlnFpjlpdcNjrJ9rGVBB39pVm6dryZjocbC044/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eeyhwhKQoAltIxspS9OmA9cFfYEvziTFGwQB05eE/FhLD0slJLilOnl1XQbGC3Kxw
	 ziFiTuo5/P0M18t0tpvAvPYIQYUIkRer0HyFwcvzUsfjxjOkYVplwU5xhNyMBFL+yG
	 NxGkVPXlZLhzY3jDXKKOpwsx7sXtdfoveqZv+DgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfB1L7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfB1L7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:59:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E6F20863;
        Thu, 28 Feb 2019 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551355159;
        bh=TWxtlnFpjlpdcNjrJ9rGVBB39pVm6dryZjocbC044/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBd5HHXV4lRrPbx44UCCRBKIK2grHvDBm0D+g/+A2NASeawqYgYJ6oP9tXkj8tVp5
         v/AJf1QHrIfx/dz0Xn045+r4u33OAH2Xi8z012s7jg4GJbV2TvGRtKskLkwKuTm9hU
         R0N9n9+R9UV9+9q2XYarqyE+0XmvROF7MjdvrOmM=
Date:   Thu, 28 Feb 2019 12:59:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Louis Taylor <louis@kragniz.eu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Subject: Re: [PATCH] wusb: use correct format characters
Message-ID: <20190228115917.GA2825@kroah.com>
References: <20190228115256.5446-1-louis@kragniz.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228115256.5446-1-louis@kragniz.eu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:52:56AM +0000, Louis Taylor wrote:
> When compiling with -Wformat, clang warns:
> 
> ./include/linux/usb/wusb.h:245:5: warning: format specifies type
> 'unsigned short' but the argument has type 'u8' (aka 'unsigned char')
> [-Wformat]
>   ckhdid->data[0],  ckhdid->data[1],
>   ^~~~~~~~~~~~~~~
> 
> ckhdid->data is unconditionally defined as `u8 data[16]`, so this patch
> updates the format characters to the correct one for unsigned char types.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  include/linux/usb/wusb.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
> index 9e4a3213f2c2..0a3cdf10972d 100644
> --- a/include/linux/usb/wusb.h
> +++ b/include/linux/usb/wusb.h
> @@ -240,8 +240,8 @@ static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
>  				   const struct wusb_ckhdid *ckhdid)
>  {
>  	return scnprintf(pr_ckhdid, size,
> -			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
> -			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
> +			 "%02hhu %02hhu %02hhu %02hhu %02hhu %02hhu %02hhu %02hhu "
> +			 "%02hhu %02hhu %02hhu %02hhu %02hhu %02hhu %02hhu %02hhu",

Why did you switch from hex to decimal in the output format?  That feels
very wrong to me.

greg k-h
