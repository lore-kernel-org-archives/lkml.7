Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1C4C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E89206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfGBQIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:08:09 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:60095 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbfGBQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:08:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 40A97282A;
        Tue,  2 Jul 2019 16:08:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cake36_63c80d15d405d
X-Filterd-Recvd-Size: 2264
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Jul 2019 16:08:05 +0000 (UTC)
Message-ID: <c26343465261e636ef029b8d0d7cb46183a23d23.camel@perches.com>
Subject: Re: [PATCH] openpromfs: Adjust three seq_printf() calls in
 property_show()
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Jul 2019 09:08:04 -0700
In-Reply-To: <22563348-fefa-8540-9d71-de37764f0596@web.de>
References: <22563348-fefa-8540-9d71-de37764f0596@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-02 at 17:40 +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jul 2019 17:24:27 +0200
> 
> A bit of information should be put into a sequence.
> Thus improve the execution speed for this data output by better usage
> of corresponding functions.
> 
> This issue was detected by using the Coccinelle software.

(wasn't Markus perma-banned?)

> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
[]
> @@ -76,14 +76,14 @@ static int property_show(struct seq_file *f, void *v)
>  		while (len > 0) {
>  			int n = strlen(pval);
> 
> -			seq_printf(f, "%s", (char *) pval);
> +			seq_puts(f, (char *) pval);
> 
>  			/* Skip over the NULL byte too.  */
>  			pval += n + 1;
>  			len -= n + 1;
> 
>  			if (len > 0)
> -				seq_printf(f, " + ");
> +				seq_puts(f, " + ");
>  		}
>  	} else {
>  		if (len & 3) {
> @@ -111,8 +111,7 @@ static int property_show(struct seq_file *f, void *v)
>  			}
>  		}
>  	}
> -	seq_printf(f, "\n");
> -
> +	seq_putc(f, '\n');
>  	return 0;
>  }

If this is really useful (and it's really not),
at least change void *pval to char *pval and
remove a bunch of useless casts.


