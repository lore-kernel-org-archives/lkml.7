Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32405C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0556020842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfCELjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:39:35 -0500
Received: from foss.arm.com ([217.140.101.70]:47260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfCELjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:39:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CFDA78;
        Tue,  5 Mar 2019 03:39:34 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67E3B3F71D;
        Tue,  5 Mar 2019 03:39:33 -0800 (PST)
Date:   Tue, 5 Mar 2019 11:39:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/15] ARM: vexpress: fix a leaked reference by adding
 missing of_node_put
Message-ID: <20190305113930.GB2066@e107155-lin>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <1551785646-46173-12-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551785646-46173-12-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 07:34:03PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-vexpress/dcscb.c:150:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 145, but without a corresponding object release within this function.
> ./arch/arm/mach-vexpress/dcscb.c:160:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 145, but without a corresponding object release within this function.
> ./arch/arm/mach-vexpress/dcscb.c:171:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 145, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

I already Acked assuming you have plans to take this as series. There's
no cover letter mentioning your plans to merge this or note to individual
platform maintainers. Please let us know.

--
Regards,
Sudeep
