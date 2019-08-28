Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A0CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9232D20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfH1RU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:20:28 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:50963 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726397AbfH1RU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:20:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9762B180A812D;
        Wed, 28 Aug 2019 17:20:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: road64_7821b4d3ac041
X-Filterd-Recvd-Size: 2726
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Aug 2019 17:20:25 +0000 (UTC)
Message-ID: <6b17910acdb7259b16a65265e8a6a8bbcd6c86cd.camel@perches.com>
Subject: Re: [PATCH v2 2/3] staging: rtl8192u: fix macro alignment in
 ieee80211
From:   Joe Perches <joe@perches.com>
To:     Stephen Brennan <stephen@brennan.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <me@tobin.cc>
Date:   Wed, 28 Aug 2019 10:20:24 -0700
In-Reply-To: <20190821143540.4501-3-stephen@brennan.io>
References: <20190821143540.4501-1-stephen@brennan.io>
         <20190821143540.4501-3-stephen@brennan.io>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 07:35 -0700, Stephen Brennan wrote:
> Several macros display unaligned, due to mixes of tabs and spaces. These
> can be fixed by making spacing consistent, do this.
[]
> @@ -452,18 +452,19 @@ do { if (ieee80211_debug_level & (level)) \
>    printk(KERN_DEBUG "ieee80211: " fmt, ## args); } while (0)
>  //wb added to debug out data buf
>  //if you want print DATA buffer related BA, please set ieee80211_debug_level to DATA|BA
> -#define IEEE80211_DEBUG_DATA(level, data, datalen)	\
> -	do { if ((ieee80211_debug_level & (level)) == (level))	\
> -		{	\
> -			int i;					\
> -			u8 *pdata = (u8 *) data;			\
> -			printk(KERN_DEBUG "ieee80211: %s()\n", __func__);	\
> -			for (i = 0; i < (int)(datalen); i++) {		\
> -				printk("%2x ", pdata[i]);		\
> -				if ((i + 1) % 16 == 0) printk("\n");	\
> -			}				\
> -			printk("\n");			\
> -		}					\
> +#define IEEE80211_DEBUG_DATA(level, data, datalen)                             \
> +	do { if ((ieee80211_debug_level & (level)) == (level))                 \
> +		{                                                              \
> +			int i;                                                 \
> +			u8 *pdata = (u8 *) data;                               \
> +			printk(KERN_DEBUG "ieee80211: %s()\n", __func__);      \
> +			for (i = 0; i < (int)(datalen); i++) {                 \
> +				printk("%2x ", pdata[i]);                      \
> +				if ((i + 1) % 16 == 0)                         \
> +					printk("\n");                          \
> +			}                                                      \
> +			printk("\n");                                          \

without pr_cont/KERN_CONT, this will output a terrible mess.

It's probably better to use print_hex_dump_debug


