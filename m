Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E17C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1050206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfDBROw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:14:52 -0400
Received: from muru.com ([72.249.23.125]:44030 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbfDBROw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:14:52 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D4000805F;
        Tue,  2 Apr 2019 17:15:06 +0000 (UTC)
Date:   Tue, 2 Apr 2019 10:14:49 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     nsekhar@ti.com, s-anna@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] bus: ti-sysc: Add generic enable/disable
 functions
Message-ID: <20190402171449.GN49658@atomide.com>
References: <20190402133752.6912-1-rogerq@ti.com>
 <20190402133752.6912-3-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402133752.6912-3-rogerq@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190402 13:38]:
> For non legacy cases, add generic sysc_enable_module()
> and sysc_disable_module() functions.

Looks OK to me. Can you please add a comment mentioning that we're
not currently blocking clockdomain autoidle? See clkdm_deny_idle()
use in omap_hwmod.c.

> +	if (idlemodes & BIT(SYSC_IDLE_SMART_WKUP)) {
> +		best_mode = SYSC_IDLE_SMART_WKUP;
> +	} else if (idlemodes & BIT(SYSC_IDLE_SMART)) {
> +		best_mode = SYSC_IDLE_SMART;
> +	} else if (idlemodes & SYSC_IDLE_FORCE) {
> +		best_mode = SYSC_IDLE_FORCE;
> +	} else {
> +		dev_err(dev, "%s: invalid midlemode\n", __func__);
> +		return -EINVAL;
> +	}
...

> +	if (idlemodes & BIT(SYSC_IDLE_SMART_WKUP)) {
> +		best_mode = SYSC_IDLE_SMART_WKUP;
> +	} else if (idlemodes & BIT(SYSC_IDLE_SMART)) {
> +		best_mode = SYSC_IDLE_SMART;
> +	} else if (idlemodes & SYSC_IDLE_FORCE) {
> +		best_mode = SYSC_IDLE_FORCE;
> +	} else {
> +		dev_err(dev, "%s: invalid sidlemode\n", __func__);
> +		return -EINVAL;
> +	}

Can you please add a helper function for getting the best
idle mode?

Regards,

Tony
