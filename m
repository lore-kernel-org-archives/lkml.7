Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6538AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B29521917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfCVRVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:21:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:2220 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfCVRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:21:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 10:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="129307784"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 22 Mar 2019 10:21:16 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h7Nr0-00053C-RB; Fri, 22 Mar 2019 19:21:14 +0200
Date:   Fri, 22 Mar 2019 19:21:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190322172114.GY9224@smile.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322152930.16642-6-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 05:29:30PM +0200, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.

Do we encourage people to use it instead of %pOF cases where it is suitable?

> On ACPI based systems the resulting strings look like
> 
> 	\_SB.PCI0.CIO2.port@1.endpoint@0
> 
> where the nodes are separated by a dot (".") and the first three are
> ACPI device nodes and the latter two ACPI data nodes.

Do we support swnode here?

> +static noinline_for_stack
> +char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> +		    struct printf_spec spec, const char *fmt)
> +{
> +	const char * const modifiers = "fP";
> +	struct printf_spec str_spec = spec;
> +	char *buf_start = buf;
> +	bool pass;
> +
> +	str_spec.field_width = -1;
> +

> +	if ((unsigned long)fwnode < PAGE_SIZE)
> +		return string(buf, end, "(null)", spec);

Just put there a NULL pointer, we would not like to maintain duplicated strings
over the kernel.

I remember Petr has a patch series related to address space check, though I
don't remember the status of affairs.

> +
> +	/* simple case without anything any more format specifiers */
> +	fmt++;
> +	if (fmt[0] == '\0' || strcspn(fmt, modifiers) > 0)
> +		fmt = "f";
> +
> +	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {

I don't see test cases.

What would we get out of %pfwfffPPPfff?

Hint: I'm expecting above to be equivalent to %pfwf

> +		if (pass) {
> +			if (buf < end)
> +				*buf = ':';
> +			buf++;
> +		}
> +
> +		switch (*fmt) {
> +		case 'f':	/* full_name */
> +			buf = fwnode_gen_full_name(fwnode, buf, end);
> +			break;
> +		case 'P':	/* name */
> +			buf = string(buf, end, fwnode_get_name(fwnode),
> +				     str_spec);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return widen_string(buf, buf - buf_start, end, spec);
> +}

-- 
With Best Regards,
Andy Shevchenko


