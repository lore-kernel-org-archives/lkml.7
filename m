Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE923C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EA72187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfGCQeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:34:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:31024 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfGCQeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:34:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 09:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="154809293"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2019 09:33:59 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 5/9] intel_th: msu: Introduce buffer driver interface
In-Reply-To: <20190703155547.GA32438@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com> <20190627125152.54905-6-alexander.shishkin@linux.intel.com> <20190703155547.GA32438@kroah.com>
Date:   Wed, 03 Jul 2019 19:33:58 +0300
Message-ID: <87h883t6vd.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>> +	/*
>> +	 * ->assign() called when buffer 'mode' is set to this driver
>> +	 *   (aka mode_store())
>> +	 * @device:	struct device * of the msc
>> +	 * @mode:	allows the driver to set HW mode (see the enum above)
>> +	 * Returns:	a pointer to a private structure associated with this
>> +	 *		msc or NULL in case of error. This private structure
>> +	 *		will then be passed into all other callbacks.
>> +	 */
>> +	void	*(*assign)(struct device *dev, int *mode);
>> +	/* ->unassign():	some other mode is selected, clean up */
>> +	void	(*unassign)(void *priv);
>> +	/*
>> +	 * ->alloc_window(): allocate memory for the window of a given
>> +	 *		size
>> +	 * @sgt:	pointer to sg_table, can be overridden by the buffer
>> +	 *		driver, or kept intact
>> +	 * Returns:	number of sg table entries <= number of pages;
>> +	 *		0 is treated as an allocation failure.
>> +	 */
>> +	int	(*alloc_window)(void *priv, struct sg_table **sgt,
>> +				size_t size);
>> +	void	(*free_window)(void *priv, struct sg_table *sgt);
>> +	/* ->activate():	trace has started */
>> +	void	(*activate)(void *priv);
>> +	/* ->deactivate():	trace is about to stop */
>> +	void	(*deactivate)(void *priv);
>> +	/*
>> +	 * ->ready():	window @sgt is filled up to the last block OR
>> +	 *		tracing is stopped by the user; this window contains
>> +	 *		@bytes data. The window in question transitions into
>> +	 *		the "LOCKED" state, indicating that it can't be used
>> +	 *		by hardware. To clear this state and make the window
>> +	 *		available to the hardware again, call
>> +	 *		intel_th_msc_window_unlock().
>> +	 */
>> +	int	(*ready)(void *priv, struct sg_table *sgt, size_t bytes);
>> +};
>
> Why isn't this based off of 'struct driver'?

It's not a real driver, in a sense that there's no underlying
device. None of the usual driver stuff applies. It's still a set of
callbacks, though. Should this be an elaborate comment, should I replace
the word "driver" with something else?

I'd really like to avoid shoehorning the whole 'struct device' + 'struct
driver' here.

Thanks,
--
Alex
