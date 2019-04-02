Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB56C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396E12070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HKCIiuHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfDBIum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:50:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oGd98FSkanS45RkiiD+xRdL3np6AH/9BCAwdx11DOGI=; b=HKCIiuHsWau00I3FhYUeh3Wb4
        0bFZ8qPhn03uc3Um5+/36yJK6IhF22rdPoXqWfzLtQAVAfxRuTNJ3JTU1bGViqeauy4I/ivXEiHFi
        fR0CWGA0NOKU79LsvtbQEONcJ12Riy1RvUB/tN2ePuO+AvaF77z+yKM6jCBen+LCD5CR0kHiU04l5
        JocpyHZuXoilRFHPxMR7c7wxfoGfh+EMrZ8NsF9+iAMV0GPmeVXVtWGLca8CzQ+icyse+2bfOEkTo
        mQDtJtTcHAnDqjDsBFfIAoPDolTCm+e0SzrT6+IexBSRGwOvXR542xd6ItxU6lAOn0G/M7Z6LYE24
        M07hnTC+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBF7r-0000Up-N8; Tue, 02 Apr 2019 08:50:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 761742026AEF9; Tue,  2 Apr 2019 10:50:34 +0200 (CEST)
Date:   Tue, 2 Apr 2019 10:50:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] cpufreq: schedutil: Replace default_attrs field
 with groups
Message-ID: <20190402085034.GK12232@hirez.programming.kicks-ass.net>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
 <18a50bab72e6bd326250b2bd5b5a4b414351815d.1554151487.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a50bab72e6bd326250b2bd5b5a4b414351815d.1554151487.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:51:53PM -0400, Kimberly Brown wrote:
> The kobj_type default_attrs field is being replaced by the
> default_groups field. Replace sugov_tunables_ktype's default_attrs field
> with default groups. Change "sugov_attributes" to "sugov_attrs" and use
> the ATTRIBUTE_GROUPS macro to create sugov_groups.
> 
> This patch was tested by setting the scaling governor to schedutil and
> verifying that the sysfs files for the attributes in the default groups
> were created.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Please route the patch as is most convenient.

> ---
>  kernel/sched/cpufreq_schedutil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5c41ea367422..148b60c8993d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -598,13 +598,14 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
>  
>  static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
>  
> -static struct attribute *sugov_attributes[] = {
> +static struct attribute *sugov_attrs[] = {
>  	&rate_limit_us.attr,
>  	NULL
>  };
> +ATTRIBUTE_GROUPS(sugov);
>  
>  static struct kobj_type sugov_tunables_ktype = {
> -	.default_attrs = sugov_attributes,
> +	.default_groups = sugov_groups,
>  	.sysfs_ops = &governor_sysfs_ops,
>  };
>  
> -- 
> 2.17.1
> 
