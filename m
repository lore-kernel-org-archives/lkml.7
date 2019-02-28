Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AB6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5805F218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfB1Vxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:53:37 -0500
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:43535 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbfB1Vxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:53:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8B157100E86C1;
        Thu, 28 Feb 2019 21:53:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sack82_7660e8beb3f32
X-Filterd-Recvd-Size: 3143
Received: from XPS-9350 (unknown [172.58.19.222])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Feb 2019 21:53:33 +0000 (UTC)
Message-ID: <15c6689389503a82394bccb9204650bf20a7a6d3.camel@perches.com>
Subject: Re: [PATCH v2] wusb: use correct format characters
From:   Joe Perches <joe@perches.com>
To:     Louis Taylor <louis@kragniz.eu>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Date:   Thu, 28 Feb 2019 13:53:31 -0800
In-Reply-To: <20190228122417.9318-1-louis@kragniz.eu>
References: <20190228115256.5446-1-louis@kragniz.eu>
         <20190228122417.9318-1-louis@kragniz.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 12:24 +0000, Louis Taylor wrote:
> When compiling with -Wformat, clang warns:
> ./include/linux/usb/wusb.h:245:5: warning: format specifies type
> 'unsigned short' but the argument has type 'u8' (aka 'unsigned char')
> [-Wformat]
>   ckhdid->data[0],  ckhdid->data[1],
>   ^~~~~~~~~~~~~~~

I think the message is somewhat misguided as all the
vararg arguments have implicit integer promotions.

> ckhdid->data is unconditionally defined as `u8 data[16]`, so this patch
> updates the format characters to the correct one for unsigned char types.
[]
> diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
[]
> @@ -240,8 +240,8 @@ static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
>  				   const struct wusb_ckhdid *ckhdid)
>  {
>  	return scnprintf(pr_ckhdid, size,
> -			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
> -			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
> +			 "%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx "
> +			 "%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx",
>  			 ckhdid->data[0],  ckhdid->data[1],
>  			 ckhdid->data[2],  ckhdid->data[3],
>  			 ckhdid->data[4],  ckhdid->data[5],

Better to use the vsprintf %ph extension insead.
---
 include/linux/usb/wusb.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
index 9e4a3213f2c2..8c39ddf62951 100644
--- a/include/linux/usb/wusb.h
+++ b/include/linux/usb/wusb.h
@@ -239,17 +239,7 @@ enum {
 static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
 				   const struct wusb_ckhdid *ckhdid)
 {
-	return scnprintf(pr_ckhdid, size,
-			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
-			 "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
-			 ckhdid->data[0],  ckhdid->data[1],
-			 ckhdid->data[2],  ckhdid->data[3],
-			 ckhdid->data[4],  ckhdid->data[5],
-			 ckhdid->data[6],  ckhdid->data[7],
-			 ckhdid->data[8],  ckhdid->data[9],
-			 ckhdid->data[10], ckhdid->data[11],
-			 ckhdid->data[12], ckhdid->data[13],
-			 ckhdid->data[14], ckhdid->data[15]);
+	return scnprintf(pr_ckhdid, size, "%16ph", ckhdid->data);
 }
 
 /*


