Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B06AC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1864720851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391616AbfEXNWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391124AbfEXNWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:22:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45FD338ABF;
        Fri, 24 May 2019 13:21:56 +0000 (UTC)
Received: from krava (unknown [10.40.205.226])
        by smtp.corp.redhat.com (Postfix) with SMTP id 44A117D57C;
        Fri, 24 May 2019 13:21:53 +0000 (UTC)
Date:   Fri, 24 May 2019 15:21:52 +0200
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
Subject: [PATCH] perf/x86/intel: Use is_visible callback for default group
Message-ID: <20190524132152.GB26617@krava>
References: <20190512155518.21468-1-jolsa@kernel.org>
 <20190512155518.21468-10-jolsa@kernel.org>
 <20190513093545.GM2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513093545.GM2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 24 May 2019 13:22:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:35:45AM +0200, Peter Zijlstra wrote:
> On Sun, May 12, 2019 at 05:55:18PM +0200, Jiri Olsa wrote:
> > Using the new pmu::update_attrs attribute group for default
> > attributes - freeze_on_smi, allow_tsx_force_abort.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 7db858c3bbec..e721be25abfb 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3888,8 +3888,6 @@ static __initconst const struct x86_pmu core_pmu = {
> >  	.check_period		= intel_pmu_check_period,
> >  };
> >  
> > -static struct attribute *intel_pmu_attrs[];
> > -
> >  static __initconst const struct x86_pmu intel_pmu = {
> >  	.name			= "Intel",
> >  	.handle_irq		= intel_pmu_handle_irq,
> > @@ -3921,8 +3919,6 @@ static __initconst const struct x86_pmu intel_pmu = {
> >  	.format_attrs		= intel_arch3_formats_attr,
> >  	.events_sysfs_show	= intel_event_sysfs_show,
> >  
> > -	.attrs			= intel_pmu_attrs,
> > -
> >  	.cpu_prepare		= intel_pmu_cpu_prepare,
> >  	.cpu_starting		= intel_pmu_cpu_starting,
> >  	.cpu_dying		= intel_pmu_cpu_dying,
> > @@ -4449,6 +4445,10 @@ static struct attribute_group group_format_extra_skl = {
> >  	.is_visible = exra_is_visible,
> >  };
> >  
> > +static struct attribute_group group_default = {
> > +	.attrs = intel_pmu_attrs,
> > +};
> > +
> >  static const struct attribute_group *attr_update[] = {
> >  	&group_events_td,
> >  	&group_events_mem,
> > @@ -4457,6 +4457,7 @@ static const struct attribute_group *attr_update[] = {
> >  	&group_caps_lbr,
> >  	&group_format_extra,
> >  	&group_format_extra_skl,
> > +	&group_default,
> >  	NULL,
> >  };
> 
> 
> Ah, I would have expected to see this somewhat dodgy hack go away too:
> 
> 	static struct attribute *intel_pmu_attrs[] = {
> 		&dev_attr_freeze_on_smi.attr,
> 		NULL, /* &dev_attr_allow_tsx_force_abort.attr.attr */
> 		NULL,
> 	};
> 
> 	intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
> 
> 
> That just begs for a .visislbe too, right?

hi,
I added the is_visible callback (below), but I dont have
the skylake to test this, so I only verified this wouldn't
break freeze_on_smi on my server..

any chance you could test this?

thanks,
jirka


---
It's preffered to use group's is_visible callback, so
we do not need to use condition attribute assignment.

Cc: Stephane Eranian <eranian@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 85afe7e98c7d..cfd61b71136d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4386,7 +4386,7 @@ static DEVICE_ATTR(allow_tsx_force_abort, 0644,
 
 static struct attribute *intel_pmu_attrs[] = {
 	&dev_attr_freeze_on_smi.attr,
-	NULL, /* &dev_attr_allow_tsx_force_abort.attr.attr */
+	&dev_attr_allow_tsx_force_abort.attr,
 	NULL,
 };
 
@@ -4414,6 +4414,15 @@ exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.version >= 2 ? attr->mode : 0;
 }
 
+static umode_t
+default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	if (attr == &dev_attr_allow_tsx_force_abort.attr)
+		return x86_pmu.flags & PMU_FL_TFA ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
 };
@@ -4450,7 +4459,8 @@ static struct attribute_group group_format_extra_skl = {
 };
 
 static struct attribute_group group_default = {
-	.attrs = intel_pmu_attrs,
+	.attrs      = intel_pmu_attrs,
+	.is_visible = default_is_visible,
 };
 
 static const struct attribute_group *attr_update[] = {
@@ -4973,7 +4983,6 @@ __init int intel_pmu_init(void)
 			x86_pmu.get_event_constraints = tfa_get_event_constraints;
 			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
 			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
-			intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
 		}
 
 		pr_cont("Skylake events, ");
-- 
2.20.1

