Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05161C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF8F217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfHJFIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:08:50 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:59365 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbfHJFIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:08:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5DCC5181D3368;
        Sat, 10 Aug 2019 05:08:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: books31_69d3a2fe60e2f
X-Filterd-Recvd-Size: 1999
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Aug 2019 05:08:47 +0000 (UTC)
Message-ID: <996bc110024500842a627ea75cb43b7cd00ef36c.camel@perches.com>
Subject: Re: [PATCH] sh: kernel: disassemble: Mark expected switch
 fall-throughs
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 09 Aug 2019 22:08:45 -0700
In-Reply-To: <20190810050153.GA13927@embeddedor>
References: <20190810050153.GA13927@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-10 at 00:01 -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> Fix the following warnings (Building: defconfig sh):
[]
> diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
[]
> @@ -477,6 +477,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  			case FD_REG_N:
>  				if (0)
>  					goto d_reg_n;

Might as well remove this if (0) goto,
remove the added comment

> +				/* else, fall through */
>  			case F_REG_N:
>  				printk("fr%d", rn);
>  				break;
> @@ -488,6 +489,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  					printk("xd%d", rn & ~1);
>  					break;
>  				}
> +				/* else, fall through */
>  			d_reg_n:

and remove this only use of d_reg_n

>  			case D_REG_N:
>  				printk("dr%d", rn);
> @@ -497,6 +499,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  					printk("xd%d", rm & ~1);
>  					break;
>  				}
> +				/* else, fall through */
>  			case D_REG_M:
>  				printk("dr%d", rm);
>  				break;

