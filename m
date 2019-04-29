Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C820656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfD2PY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:24:28 -0400
Received: from foss.arm.com ([217.140.101.70]:60394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbfD2PY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:24:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E4AD80D;
        Mon, 29 Apr 2019 08:24:27 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 596AC3F5C1;
        Mon, 29 Apr 2019 08:24:25 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:24:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/3] thermal: broadcom: Add Stingray thermal driver
Message-ID: <20190429152422.GC17516@e107155-lin>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
 <1527486084-4636-4-git-send-email-srinath.mannam@broadcom.com>
 <da76e12f246c3f10bfed28d8b91a3575dc73f243.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da76e12f246c3f10bfed28d8b91a3575dc73f243.camel@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 06:07:12PM +0300, David Woodhouse wrote:
> On Mon, 2018-05-28 at 11:11 +0530, Srinath Mannam wrote:
> > From: Pramod Kumar <pramod.kumar@broadcom.com>
> >
> > This commit adds stingray thermal driver to monitor six
> > thermal zones temperature and trips at critical temperature.
>
> This matches an ACPI "BRCM0500" device but then calls
> devm_thermal_zone_of_sensor_register(), which AFAICT is going to fail
> on an ACPI system because the first thing that does is call
> of_find_node_by_name(NULL, "thermal-zones") which isn't going to find a
> match.
>

Thanks David for bringing this up. I hadn't noticed that this driver is
cheekily trying to do thermal management in ACPI using crafty
acpi_device_id match. ACPI thermal objects/methods must be used in the
firmware to do thermal management.

Pramod, can you remove the ACPI support or I can go ahead and post the
patch to do the same ?

> How does this work in the ACPI case?

It can't and shouldn't work if one can make it happen :)

--
Regards,
Sudeep
