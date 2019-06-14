Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC19C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE82520665
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfFNKU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:20:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfFNKU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:20:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F54E8553F;
        Fri, 14 Jun 2019 10:20:20 +0000 (UTC)
Received: from krava (ovpn-204-154.brq.redhat.com [10.40.204.154])
        by smtp.corp.redhat.com (Postfix) with SMTP id BC8922CE56;
        Fri, 14 Jun 2019 10:20:17 +0000 (UTC)
Date:   Fri, 14 Jun 2019 12:20:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] perf/x86/intel: Use is_visible callback for default group
Message-ID: <20190614102017.GA4325@krava>
References: <20190512155518.21468-1-jolsa@kernel.org>
 <20190512155518.21468-10-jolsa@kernel.org>
 <20190513093545.GM2623@hirez.programming.kicks-ass.net>
 <20190524132152.GB26617@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524132152.GB26617@krava>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 14 Jun 2019 10:20:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:21:52PM +0200, Jiri Olsa wrote:

SNIP

ping

jirka

> ---
> It's preffered to use group's is_visible callback, so
> we do not need to use condition attribute assignment.
> 
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/events/intel/core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 85afe7e98c7d..cfd61b71136d 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4386,7 +4386,7 @@ static DEVICE_ATTR(allow_tsx_force_abort, 0644,
>  
>  static struct attribute *intel_pmu_attrs[] = {
>  	&dev_attr_freeze_on_smi.attr,
> -	NULL, /* &dev_attr_allow_tsx_force_abort.attr.attr */
> +	&dev_attr_allow_tsx_force_abort.attr,
>  	NULL,
>  };
>  
> @@ -4414,6 +4414,15 @@ exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>  	return x86_pmu.version >= 2 ? attr->mode : 0;
>  }
>  
> +static umode_t
> +default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> +{
> +	if (attr == &dev_attr_allow_tsx_force_abort.attr)
> +		return x86_pmu.flags & PMU_FL_TFA ? attr->mode : 0;
> +
> +	return attr->mode;
> +}
> +
>  static struct attribute_group group_events_td  = {
>  	.name = "events",
>  };
> @@ -4450,7 +4459,8 @@ static struct attribute_group group_format_extra_skl = {
>  };
>  
>  static struct attribute_group group_default = {
> -	.attrs = intel_pmu_attrs,
> +	.attrs      = intel_pmu_attrs,
> +	.is_visible = default_is_visible,
>  };
>  
>  static const struct attribute_group *attr_update[] = {
> @@ -4973,7 +4983,6 @@ __init int intel_pmu_init(void)
>  			x86_pmu.get_event_constraints = tfa_get_event_constraints;
>  			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
>  			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
> -			intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
>  		}
>  
>  		pr_cont("Skylake events, ");
> -- 
> 2.20.1
> 
