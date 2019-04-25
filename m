Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB16C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E54214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfDYK5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:57:06 -0400
Received: from foss.arm.com ([217.140.101.70]:40930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbfDYK5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:57:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD81EBD;
        Thu, 25 Apr 2019 03:57:06 -0700 (PDT)
Received: from queper01-ThinkPad-T460s (unknown [10.37.8.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD8A13F5C1;
        Thu, 25 Apr 2019 03:57:02 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:57:00 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
Message-ID: <20190425105658.q45cmfogrt6wwtih@queper01-ThinkPad-T460s>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Apr 2019 at 15:38:39 (-0400), Thara Gopinath wrote:
> +/* Per cpu structure to keep track of Thermal Pressure */
> +struct thermal_pressure {
> +	unsigned long scale; /* scale reflecting average cpu max capacity*/
> +	unsigned long acc_scale; /* Accumulated scale for this time window */
> +	unsigned long old_scale; /* Scale value for the previous window */
> +	unsigned long raw_scale; /* Raw max capacity */
> +	unsigned long age_stamp; /* Last time old_scale was updated */
> +	unsigned long last_update; /* Last time acc_scale was updated */
> +	spinlock_t lock; /* Lock for protecting from simultaneous access*/
> +	/* Timer for periodic update of thermal pressure */
> +	struct timer_list timer;

Do you actually need the periodic update ? You only really need to
update the 'scale' value when updating the LB stats no ? Nobody
accesses that value in between two LBs.

Thanks,
Quentin
