Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A7FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9410820880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555455707;
	bh=LZ9uwWc/ANrBs+DiflZaaOrk01EHMUXlunATlb0ykKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=c+H82zRhNPArSIYyxbAtgvH89rJqvC92Y3VN1byfxVngwbgJy4BewKWfXf69ZBQ1C
	 ug8pcSzjeB/b2SXOvgnz0QrFmGYNQmB05AXAPFbZpRC8Q7keT3x4l5g6/MTexccp69
	 xyPzZB3nKMTe5lCOYPFKsvXhFrOvMl3ip2PRa5OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfDPXBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:01:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfDPXBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:01:45 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDEE0D4A;
        Tue, 16 Apr 2019 23:01:44 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:01:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com, ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 1/3] /proc/pid/status: Add support for architecture
 specific output
Message-Id: <20190416160143.8292ced993dc803aae7fa0da@linux-foundation.org>
In-Reply-To: <20190416063250.7514-1-aubrey.li@linux.intel.com>
References: <20190416063250.7514-1-aubrey.li@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 14:32:48 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:

> The architecture specific information of the running processes could
> be useful to the userland. Add support to examine process architecture
> specific information externally.

The implementation looks just fine to me.  Have you had any feedback on
the overall desirability of adding this feature?

> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -96,6 +96,11 @@
>  #include <asm/processor.h>
>  #include "internal.h"
>  
> +/* Add support for architecture specific output in /proc/pid/status */
> +#ifndef	arch_proc_pid_status
> +#define	arch_proc_pid_status(m, task)
> +#endif

To this I suggest adding

/* arch_proc_pid_status() must be defined in asm/processor.h */

Because we've regularly had different architectures defining such things
in different headers, resulting in a mess.


