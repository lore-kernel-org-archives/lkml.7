Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F817C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503782073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pN8Vw//n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfLJKhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:37:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLJKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Pk6fpOAs1zSSn4uGzDdXFp1KU2QDahtOIvZD6vEWak=; b=pN8Vw//nXw/J1ZpW6zbXebw9r
        3O48iCaw57kz+I/1T+kauz+XWS/o6O/445wKuqKmaej/huO89KLJD1I/fQbXEDoQLdY7k8a6K5YEs
        JSh/sgd3akyRO7GLjMnUBKkSQTloU4tMNb8lmpRB50x06XIS0cy+6FIsDfgjqI9k6wkd9pvbg62g4
        Dy1zPNy46Du7r3pUWD0ya/wVDm0iOSozpmgNUtR9jqw5O7DHmUkQ8/Rp5AXdP28+gi3C5o0LP8P8J
        qP1StmNyXpHsXK6OPhutJZiw34qzhqlw0VTBptZkfI+LIzPCGitXb/qIYhiy2rzxFp9W7ISqJ0mXj
        HhTWn9Suw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iectE-00082e-UL; Tue, 10 Dec 2019 10:37:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FCFA305FD1;
        Tue, 10 Dec 2019 11:35:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13A212010F13C; Tue, 10 Dec 2019 11:37:10 +0100 (CET)
Date:   Tue, 10 Dec 2019 11:37:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     roman.sudarikov@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexander.antonov@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] perf x86: Add compaction function for uncore
 attributes
Message-ID: <20191210103710.GM2844@hirez.programming.kicks-ass.net>
References: <20191210091451.6054-1-roman.sudarikov@linux.intel.com>
 <20191210091451.6054-3-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210091451.6054-3-roman.sudarikov@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:14:50PM +0300, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> 
> In current design, there is an implicit assumption that array of pointers
> to uncore type attributes is NULL terminated. However, not all attributes
> are mandatory for each Uncore unit type, e.g. "events" is required for
> IMC but doesn't exist for CHA. That approach correctly supports only one
> optional attribute which also must be the last in the row.
> The patch removes limitation by safely removing embedded NULL elements.
> 
> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 24e120289018..a05352c4fc01 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -923,6 +923,22 @@ static void uncore_types_exit(struct intel_uncore_type **types)
>  		uncore_type_exit(*types);
>  }
>  
> +static void uncore_type_attrs_compaction(struct intel_uncore_type *type)
> +{
> +	int i, j;
> +	int size = ARRAY_SIZE(type->attr_groups);
> +
> +	for (i = 0, j = 0; i < size; i++) {
> +		if (!type->attr_groups[i])
> +			continue;
> +		if (i > j) {
> +			type->attr_groups[j] = type->attr_groups[i];
> +			type->attr_groups[i] = NULL;
> +		}
> +		j++;
> +	}
> +}

GregKH had objections to us playing silly games like that and made us
use is_visible() for the regular PMU driver. Also see commit:

  baa0c83363c7 ("perf/x86: Use the new pmu::update_attrs attribute group")
