Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22970FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF2E20673
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tY/EFOi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKHR4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:56:39 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:16623 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKHR4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573235798; x=1604771798;
  h=date:from:to:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=36GNcpaVmpEl7Zhp6qJo1oa/lbOerM7FI0aDbeUR15E=;
  b=tY/EFOi1erhb0atSSV0Kttb00ti14eJ3jQNYMKn19u5L2SsB4L0YrqWi
   NZ0f7R3rbgdUwXmp+Xm3v1Kh19URnpElANqqwCT4oQu2Si/f9mUY5rweC
   W6cjaGj8sxic4ZUw9nIEqp6oNR3RVIiV6dOkBiqdG52RcX0n8w7evpqKE
   s=;
IronPort-SDR: FT+JWvEkbjal9LJRHGxPqO7kowufkmmmPtG1NiKDbLQo+7iFdHreVaja1aMWmHpGO2tIetqoAk
 nbiIf0mNDXEg==
X-IronPort-AV: E=Sophos;i="5.68,282,1569283200"; 
   d="scan'208";a="5653874"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 08 Nov 2019 17:56:35 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id BB709A29FE;
        Fri,  8 Nov 2019 17:56:31 +0000 (UTC)
Received: from EX13d09UWA002.ant.amazon.com (10.43.160.186) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 8 Nov 2019 17:56:31 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d09UWA002.ant.amazon.com (10.43.160.186) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 8 Nov 2019 17:56:30 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 8 Nov 2019 17:56:30 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id BB79840EDF; Fri,  8 Nov 2019 17:56:30 +0000 (UTC)
Date:   Fri, 8 Nov 2019 17:56:30 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lenb@kernel.org>, <devel@acpica.org>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Message-ID: <20191108175630.GA3970@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <CF6A88132359CE47947DB4C6E1709ED53C66675F@ORSMSX122.amr.corp.intel.com>
 <E31BA312-7B9D-4AA9-8BD5-F60E28069979@amazon.com>
 <CEC4A132-0FBC-4DC0-8C8F-84608AD8A91A@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CEC4A132-0FBC-4DC0-8C8F-84608AD8A91A@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping on this one.

--
Anchal

On Mon, Nov 04, 2019 at 09:58:16AM -0800, Agarwal, Anchal wrote:
> Apologies for resending it. Looks like it does not show in cc list it went to all mailing list however the thread do appear on lkml. 
> Thanks,
> Anchal
> ﻿    
>         + Rafael, Bob
>         
>         Also, is there a reason why this wasn't CC-ed to linux-acpi mailing list? It would be good to get feedback from there too..
>     I think I did to all the email id's generated from get_maintainer.pl. Ccing again 
>     + linux-acpi
>     
>         Thanks,
>         Erik
>         
>         > -----Original Message-----
>         > From: Anchal Agarwal <anchalag@amazon.com>
>         > Sent: Monday, October 29, 2018 10:52 AM
>         > Subject: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
>         > 
>         > Currently we do not see sleep_enable bit set after guest resumes from
>         > hibernation. Hibernation is triggered in guest on receiving a sleep trigger
>         > from the hypervisor(S4 state). We see that power button is enabled on wake
>         > up from S4 state however sleep button isn't. This causes subsequent
>         > invocation of sleep state to fail in the guest. Any environment  going through
>         > acpi_hw_legacy_wake() won't have sleep button enabled.
>         > 
>         > Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
>         > Reviewed-by: Balbir Singh <sblbir@amazon.com>
>         > Reviewed-by: Frank van der Linden <fllinden@amazon.com>
>         > ---
>         >  drivers/acpi/acpica/hwsleep.c | 11 +++++++++++
>         >  1 file changed, 11 insertions(+)
>         > 
>         > diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
>         > index b62db8ec446f..a176c7802760 100644
>         > --- a/drivers/acpi/acpica/hwsleep.c
>         > +++ b/drivers/acpi/acpica/hwsleep.c
>         > @@ -300,6 +300,17 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
>         >  				    [ACPI_EVENT_POWER_BUTTON].
>         >  				    status_register_id, ACPI_CLEAR_STATUS);
>         > 
>         > +	/* Enable sleep button */
>         > +	(void)
>         > +	      acpi_write_bit_register(acpi_gbl_fixed_event_info
>         > +				      [ACPI_EVENT_SLEEP_BUTTON].
>         > +				      enable_register_id,
>         > ACPI_ENABLE_EVENT);
>         > +
>         > +	(void)
>         > +	      acpi_write_bit_register(acpi_gbl_fixed_event_info
>         > +				      [ACPI_EVENT_SLEEP_BUTTON].
>         > +				      status_register_id, ACPI_CLEAR_STATUS);
>         > +
>         >  	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST,
>         > ACPI_SST_WORKING);
>         >  	return_ACPI_STATUS(status);
>         >  }
>         > --
>         > 2.15.3.AMZN
>         
>         
>     
>     
> 
