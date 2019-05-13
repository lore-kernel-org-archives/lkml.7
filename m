Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D97C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F7220873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jMab3g4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfEMJfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:35:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FcMY4YUT4uobbgoLicP78NanuUZ4LxL7aRKcOLrjB5w=; b=jMab3g4e6CNdXuYPLVxeZHuUB
        glTWasqG5qcFTgqhW9kPx+sqJV/4zuPfeLvI8nOAms3TMa2RhwT4jZzERHRP7muvHoCqp7HUpwjB0
        b7Us9hS671MTv41ooEORU5dFDHJ24WQn3gBa4aaR3hUOmrtnHeQgcO4SPnjvP6wixlMIyjAqd/yoH
        qEmVEq03fSnYSxx2B9dwkDZhB8a+BdE3gCTKh3bRXwSQahu4HtnObcnEItN1dRZ+9DZX3ujtTooXZ
        OTIMdacfhWuighgoBhbnNsRKf439s+yPApD6RHF8+xrMDTC8OHCaO9bDB8rljTLR8MM5DzXIhDJVR
        GIORxMd7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ7N5-0005jg-7S; Mon, 13 May 2019 09:35:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CBF82029F888; Mon, 13 May 2019 11:35:45 +0200 (CEST)
Date:   Mon, 13 May 2019 11:35:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 9/9] perf/x86: Use update attribute groups for default
 attributes
Message-ID: <20190513093545.GM2623@hirez.programming.kicks-ass.net>
References: <20190512155518.21468-1-jolsa@kernel.org>
 <20190512155518.21468-10-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512155518.21468-10-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 05:55:18PM +0200, Jiri Olsa wrote:
> Using the new pmu::update_attrs attribute group for default
> attributes - freeze_on_smi, allow_tsx_force_abort.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 7db858c3bbec..e721be25abfb 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3888,8 +3888,6 @@ static __initconst const struct x86_pmu core_pmu = {
>  	.check_period		= intel_pmu_check_period,
>  };
>  
> -static struct attribute *intel_pmu_attrs[];
> -
>  static __initconst const struct x86_pmu intel_pmu = {
>  	.name			= "Intel",
>  	.handle_irq		= intel_pmu_handle_irq,
> @@ -3921,8 +3919,6 @@ static __initconst const struct x86_pmu intel_pmu = {
>  	.format_attrs		= intel_arch3_formats_attr,
>  	.events_sysfs_show	= intel_event_sysfs_show,
>  
> -	.attrs			= intel_pmu_attrs,
> -
>  	.cpu_prepare		= intel_pmu_cpu_prepare,
>  	.cpu_starting		= intel_pmu_cpu_starting,
>  	.cpu_dying		= intel_pmu_cpu_dying,
> @@ -4449,6 +4445,10 @@ static struct attribute_group group_format_extra_skl = {
>  	.is_visible = exra_is_visible,
>  };
>  
> +static struct attribute_group group_default = {
> +	.attrs = intel_pmu_attrs,
> +};
> +
>  static const struct attribute_group *attr_update[] = {
>  	&group_events_td,
>  	&group_events_mem,
> @@ -4457,6 +4457,7 @@ static const struct attribute_group *attr_update[] = {
>  	&group_caps_lbr,
>  	&group_format_extra,
>  	&group_format_extra_skl,
> +	&group_default,
>  	NULL,
>  };


Ah, I would have expected to see this somewhat dodgy hack go away too:

	static struct attribute *intel_pmu_attrs[] = {
		&dev_attr_freeze_on_smi.attr,
		NULL, /* &dev_attr_allow_tsx_force_abort.attr.attr */
		NULL,
	};

	intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;


That just begs for a .visislbe too, right?
