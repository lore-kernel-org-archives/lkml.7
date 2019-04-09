Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61584C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C2720883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554845805;
	bh=t7a+gD4Ceq69qM2Kx2eJY2HDB6Wf2nqNvEvFKUMkJ2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kzqRwcrtmzbNkeZ5HUcZCcy+qcUWqxGqI6kUOPlU+28p4Zi6PNDgUtyHsCHg8TljP
	 NjMdeUXJptGaFEfi5ldNepDMl2GHwkvR07DQ4L+lP8FmZkzLvBRcxydIFR1NujYQcj
	 xEVwX6zLSpxvPX9RqgUnCmwuQP9SRooZd8Dg2c7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDIVgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:36:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDIVgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:36:43 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 522A3FCB;
        Tue,  9 Apr 2019 21:36:42 +0000 (UTC)
Date:   Tue, 9 Apr 2019 14:36:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Tejun Heo <tj@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: fix double string traverse in cpumask_parse
Message-Id: <20190409143641.960ac8fae3293b2d1a834cfa@linux-foundation.org>
In-Reply-To: <20190409204208.12190-1-ynorov@marvell.com>
References: <20190409204208.12190-1-ynorov@marvell.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Apr 2019 13:42:08 -0700 Yury Norov <yury.norov@gmail.com> wrote:

> From: Yury Norov <ynorov@marvell.com>
> 
> cpumask_parse() finds first occurrence of either \n or \0 by calling
> strchr() and strlen(). We can do it better with a single call of
> strchrnul().

Fair enough.

> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -633,8 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
>   */
>  static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
>  {
> -	char *nl = strchr(buf, '\n');
> -	unsigned int len = nl ? (unsigned int)(nl - buf) : strlen(buf);
> +	unsigned int len = (unsigned int)(strchrnul(buf, '\n') - buf);

Does the cast do anything useful?  The compiler will convert a
ptrdiff_t to uint without issues, I think?

>  	return bitmap_parse(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
>  }

