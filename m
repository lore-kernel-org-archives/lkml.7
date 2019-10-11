Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2FAECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECC82089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfJKO6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:58:18 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:53639 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726331AbfJKO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:58:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E08F618224D97;
        Fri, 11 Oct 2019 14:58:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: use83_825e07cff5843
X-Filterd-Recvd-Size: 2064
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 14:58:15 +0000 (UTC)
Message-ID: <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
Subject: Re: [PATCH v1] ipmi: use %*ph to print small buffer
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Oct 2019 07:58:14 -0700
In-Reply-To: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
References: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 17:52 +0300, Andy Shevchenko wrote:
> Use %*ph format to print small buffer as hex string.
> 
> The change is safe since the specifier can handle up to 64 bytes and taking
> into account the buffer size of 100 bytes on stack the function has never been
> used to dump more than 32 bytes. Note, this also avoids potential buffer
> overflow if the length of the input buffer is bigger.
[]
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
[]
> @@ -48,14 +48,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
>  static void ipmi_debug_msg(const char *title, unsigned char *data,
>  			   unsigned int len)
>  {
> -	int i, pos;
> -	char buf[100];
> -
> -	pos = snprintf(buf, sizeof(buf), "%s: ", title);
> -	for (i = 0; i < len; i++)
> -		pos += snprintf(buf + pos, sizeof(buf) - pos,
> -				" %2.2x", data[i]);
> -	pr_debug("%s\n", buf);
> +	pr_debug("%s: %*ph\n", title, len, buf);
>  }
>  #else
>  static void ipmi_debug_msg(const char *title, unsigned char *data,

Now you might as well remove the #ifdef DEBUG above this
and the empty function in the #else too.


