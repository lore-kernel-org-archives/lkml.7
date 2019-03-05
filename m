Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EB3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513212082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfCEQ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:29:35 -0500
Received: from HSI-KBW-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52]:39597
        "EHLO mail.linutronix.de" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfCEQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:29:35 -0500
Subject: Re: [PATCH] wusb: use correct format characters
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
References: <20190228115256.5446-1-louis@kragniz.eu>
From:   Test <bornkessel@linutronix.de>
Message-ID: <aedd41c1-678e-7975-bf02-be5666dce9af@linutronix.de>
Date:   Tue, 5 Mar 2019 17:21:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190228115256.5446-1-louis@kragniz.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=bornkessel@linutronix.de smtp.mailfrom=bornkessel@linutronix.de
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test

Am 28.02.19 um 12:52 schrieb Louis Taylor:
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
>  			 ckhdid->data[0],  ckhdid->data[1],
>  			 ckhdid->data[2],  ckhdid->data[3],
>  			 ckhdid->data[4],  ckhdid->data[5],
