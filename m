Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE632186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKRRlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:41:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:60096 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbfKRRlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:41:07 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 42294378;
        Mon, 18 Nov 2019 17:41:06 +0000 (UTC)
Date:   Mon, 18 Nov 2019 10:41:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     andriy.shevchenko@intel.com, prarit@redhat.com,
        rafael.j.wysocki@intel.co, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] admin guide/pm: Admin guide for intel-speed-select
Message-ID: <20191118104105.11776f58@lwn.net>
In-Reply-To: <20191115204925.55181-1-srinivas.pandruvada@linux.intel.com>
References: <20191115204925.55181-1-srinivas.pandruvada@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 12:49:25 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Added documentation to configure servers to use Intel(R) Speed
> Select Technology using intel-speed-select tool.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks for improving the docs!  I do have a few overall comments,
though...  

>  .../admin-guide/pm/intel-speed-select.rst     | 934 ++++++++++++++++++
>  .../admin-guide/pm/working-state.rst          |   1 +
>  2 files changed, 935 insertions(+)
>  create mode 100644 Documentation/admin-guide/pm/intel-speed-select.rst
> 
> diff --git a/Documentation/admin-guide/pm/intel-speed-select.rst b/Documentation/admin-guide/pm/intel-speed-select.rst
> new file mode 100644
> index 000000000000..c2ce57ebc268
> --- /dev/null
> +++ b/Documentation/admin-guide/pm/intel-speed-select.rst
> @@ -0,0 +1,934 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================================
> +Intel® Speed Select Technology (Intel® SST) : User Guide
> +=========================================================

People give me grief when I take docs patches adding non-ascii characters.
Adding nearly 100 useless ® symbols seems likely to trigger that sort of
unicode aversion.  Can I ask you, please, to take those out?  There are
many occurrences of unadorned "Intel" in the kernel, and the world hasn't
ended yet.

> +The Intel® Speed Select Technology (Intel® SST) provides a powerful new
> +collection of features that give more granular control over CPU performance.
> +With Intel® SST, one server can be configured for power and performance for a
> +variety of diverse workload requirements.
> +
> +Refer to the links below for an overview of the technology:
> +
> +- https://www.intel.com/content/www/us/en/architecture-and-technology/speed-select-technology-article.html
> +- https://builders.intel.com/docs/networkbuilders/intel-speed-select-technology-base-frequency-enhancing-performance.pdf
> +
> +These capabilities are further enhanced in some of the newer generations of
> +server platforms where these features can be enumerated and controlled
> +dynamically without pre-configuring via BIOS setup options. This dynamic
> +configuration is done via mailbox commands to the hardware. One way to enumerate
> +and configure these features is by using the Intel® Speed Select utility.
> +
> +This document explains how to use the Intel® Speed Select tool to enumerate and
> +control Intel® SST features. This document gives example commands and explains
> +how these commands change the power and performance profile of the system under
> +test. Using this tool as an example, customers can replicate the messaging
> +implemented in the tool in their production software.
> +
> +
> +intel-speed-select configuration tool
> +-------------------------------------

The conventions for subsection markers are documented in
Documentation/doc-guide/sphinx.rst; this should be "========" rather than
hyphens. 

> +Most Linux distribution packages include the "intel-speed-select" tool. If not,
> +it can be built by downloading the Linux kernel tree from kernel.org. Once
> +downloaded, the tool can be built without building the full kernel.
> +
> +From the kernel tree, run the following commands:
> +
> +# cd tools/power/x86/intel-speed-select/
> +
> +# make
> +
> +# make install

This kind of stuff isn't going to render well in the built docs.  Can you
please change the literal text to literal blocks?  Something like:

	From the kernel tree, run the following commands::

		# cd tools/power/x86/intel-speed-select/
		# make
		# make install

Note the "::" on the first line; that introduces a literal block.  It would
be good to build the docs once you're done and be sure that you're happy
with the results.

There's a lot of these in this document.

> +
> +**Getting Help**

Since this is meant to be a section header, please mark it as such;
"------" would be the appropriate marker for a header at this level.

That's enough for a first pass.

Thanks,

jon
