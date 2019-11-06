Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64D2C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBF221882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfKFIxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:53:24 -0500
Received: from smtprelay0180.hostedemail.com ([216.40.44.180]:54415 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726755AbfKFIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:53:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 76B35182CF668;
        Wed,  6 Nov 2019 08:53:23 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: books19_3a82ba9ffe32a
X-Filterd-Recvd-Size: 4543
Received: from grimm.local.home (unknown [94.155.134.143])
        (Authenticated sender: rostedt@goodmis.org)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Nov 2019 08:53:21 +0000 (UTC)
Date:   Wed, 6 Nov 2019 03:53:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
Subject: Re: [PATCH 1/2] seq_buf: Add printing formatted hex dumps
Message-ID: <20191106035317.7558e47e@grimm.local.home>
In-Reply-To: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 07:27:39 +0100
Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:

> Provided function is an analogue of print_hex_dump().
> 
> Implementing this function in seq_buf allows using for multiple
> purposes (e.g. for tracing) and therefore prevents from code duplication
> in every layer that uses seq_buf.
> 
> print_hex_dump() is an essential part of logging data to dmesg. Adding
> similar capability for other purposes is beneficial to all users.

Can you add to the change log an example output of print_hex_dump().

It makes it easier for reviewers to know if what is implemented matches
what is expected.

> 
> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  include/linux/seq_buf.h |  3 +++
>  lib/seq_buf.c           | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index aa5deb0..fb0205d 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -125,6 +125,9 @@ extern int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len);
>  extern int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
>  			      unsigned int len);
>  extern int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc);
> +extern int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str,
> +			    int prefix_type, int rowsize, int groupsize,
> +			    const void *buf, size_t len, bool ascii);
>  
>  #ifdef CONFIG_BINARY_PRINTF
>  extern int
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index bd807f5..0509706 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -328,3 +328,41 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
>  	s->readpos += cnt;
>  	return cnt;
>  }
> +

Requires a kernel doc header here.

> +int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
> +		     int rowsize, int groupsize,
> +		     const void *buf, size_t len, bool ascii)
> +{
> +	const u8 *ptr = buf;
> +	int i, linelen, remaining = len;
> +	unsigned char linebuf[32 * 3 + 2 + 32 + 1];

What do the above magic numbers mean? Should have a comment explaining
why you picked those numbers and created the length this way.

Also the preferred method of declarations is to order it by longest
first. That is, linebuf, followed by the ints, followed by ptr.


> +	int ret;
> +
> +	if (rowsize != 16 && rowsize != 32)
> +		rowsize = 16;
> +
> +	for (i = 0; i < len; i += rowsize) {
> +		linelen = min(remaining, rowsize);
> +		remaining -= rowsize;

Probably should make the above:

		remaining -= linelen;

Yeah, what you have works, but it makes a reviewer worry about using
remaining later and having it negative.

> +
> +		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> +				   linebuf, sizeof(linebuf), ascii);
> +
> +		switch (prefix_type) {
> +		case DUMP_PREFIX_ADDRESS:

I'm curious to know what uses the above type? By default, today,
pointers are pretty much obfuscated, and that will show up here too.

-- Steve

> +			ret = seq_buf_printf(s, "%s%p: %s\n",
> +			       prefix_str, ptr + i, linebuf);
> +			break;
> +		case DUMP_PREFIX_OFFSET:
> +			ret = seq_buf_printf(s, "%s%.8x: %s\n",
> +					     prefix_str, i, linebuf);
> +			break;
> +		default:
> +			ret = seq_buf_printf(s, "%s%s\n", prefix_str, linebuf);
> +			break;
> +		}
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}

