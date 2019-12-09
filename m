Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF91AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D492077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfLILPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:15:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:40231 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfLILPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:15:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 03:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="295527982"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2019 03:15:34 -0800
Received: from andy by smile with local (Exim 4.93-RC5)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ieH0n-0003w0-Ih; Mon, 09 Dec 2019 13:15:33 +0200
Date:   Mon, 9 Dec 2019 13:15:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, acme@redhat.com,
        tstoyanov@vmware.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
Subject: Re: [PATCH] libtraceevent: add __print_hex_dump support
Message-ID: <20191209111533.GE32742@smile.fi.intel.com>
References: <1575622851-26514-1-git-send-email-piotrx.maziarz@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575622851-26514-1-git-send-email-piotrx.maziarz@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 10:00:51AM +0100, Piotr Maziarz wrote:
> This allows using parsing __print_hex_dump in user space tools. Print
> format is aligned with debugfs tracing interface.

> +int hex_dump_line(const unsigned char *buf, size_t len, int rowsize,
> +		  int groupsize, struct trace_seq *s, bool ascii)
> +{
> +	unsigned long long val;
> +	int i, ret, pos = 0;
> +	const char *format;
> +	int ascii_pos = rowsize * 2 + rowsize / groupsize + 1;
> +
> +	len = min(len, (size_t)rowsize);

> +	if ((groupsize != 2 && groupsize != 4 && groupsize != 8)
> +	    || (len % groupsize) != 0) {

Tools have an implemented is_power_of_2().
I guess you may go thru tools headers and check what else can be un-open-coded
here, in this change.

> +		groupsize = 1;
> +	}
> +
> +	for (i = 0; i < len / groupsize; i++) {
> +		if (groupsize == 8) {
> +			const unsigned long long *ptr8 = (void *)buf;
> +
> +			val = *(ptr8 + i);
> +			format = "%s%16.16llx";
> +		} else if (groupsize == 4) {
> +			const unsigned int *ptr4 = (void *)buf;
> +
> +			val = *(ptr4 + i);
> +			format = "%s%8.8x";
> +		} else if (groupsize == 2) {
> +			const unsigned short *ptr2 = (void *)buf;
> +
> +			val = *(ptr2 + i);
> +			format = "%s%4.4x";
> +		} else {
> +			const unsigned char *ptr1 = (void *)buf;
> +
> +			val = *(ptr1 + i);
> +			format = "%s%2.2x";
> +		}
> +		ret = trace_seq_printf(s,
> +			       format, i ? " " : "",
> +			       val);
> +		if (ret <= 0)
> +			return ret;
> +		pos += ret;
> +	}
> +	if (!ascii)
> +		return 0;
> +	ret = trace_seq_printf(s, "%*s", ascii_pos - pos, "");
> +	if (ret <= 0)
> +		return ret;
> +	for (i = 0; i < len; i++)
> +		trace_seq_putc(s, (isprint(buf[i])) ? buf[i] : '.');
> +	return 0;
> +}
> +
> +int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
> +		       int prefix_type, int rowsize, int groupsize,
> +		       const void *buf, size_t len, int ascii)
> +{
> +	const unsigned char *ptr = buf;
> +	int i, linelen, remaining = len;
> +	int ret;
> +
> +	if (rowsize != 16 && rowsize != 32)
> +		rowsize = 16;
> +
> +	for (i = 0; i < len; i += rowsize) {
> +		linelen = min(remaining, rowsize);
> +		remaining -= linelen;
> +
> +		if (prefix_type == DUMP_PREFIX_ADDRESS)
> +			ret = trace_seq_printf(s, "%s%p: ",
> +					       prefix_str, ptr + i);
> +		else if (prefix_type == DUMP_PREFIX_OFFSET)
> +			ret = trace_seq_printf(s, "%s%.8x: ",
> +					       prefix_str, i);
> +		else
> +			ret = trace_seq_printf(s, "%s",
> +					       prefix_str);
> +		if (ret <= 0)
> +			return ret;
> +		hex_dump_line(ptr + i, linelen, rowsize, groupsize,
> +			      s, ascii);
> +		trace_seq_putc(s, '\n');
> +	}
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


