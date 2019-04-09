Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9452CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592D22084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554825304;
	bh=zj5EQzGcHAp/BWcwHD/ry4NHPAaaBSRWP1h+323WtEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gcUS152o5ijtM85qUH3SS+zfKlPcRxZueFsNHpMxrAtFyCLT8X4J6qtHy8bnH+5QZ
	 TnTIs6jgIvONamsM8vqAwWwot5BDxyqSqkI69eMDDxB1o15O+ei4wpXQagPghO67su
	 k9X/TBWQSZB63F20qUFRijQ7ajF5p43FpXVoQ53c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDIPzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:55:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42616 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfDIPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:55:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so8503228pfi.9;
        Tue, 09 Apr 2019 08:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r43mAVZxYKG/YWvrUrXD7JBBbZT0Kp4TL+GPMx0nxBg=;
        b=pPWgColCShDBwWN8KTeaiSFd37Oe5s07DtDoe88cQwkCFNSKV2hhF9bZxsRCZd/h8H
         177SWOak4oWCLL+M+6o41dSFbKSU64wPmB8uYoBoLLJk5YUEziTz+Xo2bbdRGOwZJPwl
         9qjKcAvc+RAgsvHADziJ8vlzHMICwIHuE3UEbt3+mFmba3QcngaTCCOz4pDpnTIbG+qX
         Bh9OPs0AyiJDvcTYnnnft0apS0rj7hEXjU0uy46fSMCDC4G7JF88aEfdY+ECaqqLnaI/
         e2NRpAaHuMeq+zwoiypKdXZguOWFnCbVFzq5lbysdpBzilZSub42N8T4oSEzKcptjw12
         zjnA==
X-Gm-Message-State: APjAAAXhinz3VK4QAkgDNR4tHLUK5nMdS4KTUJdIvpUm0Iyq+Z7wuOjf
        5mY4kxT7ChwJt4rkkoMENCc=
X-Google-Smtp-Source: APXvYqynw1dHRrvGc5Kkd7VVXAJ4UlxWn3MvmqcEp1CUJExNe2P7140Jgxq8aVfp7sw3YFvfCUqtDw==
X-Received: by 2002:a63:6907:: with SMTP id e7mr28224535pgc.209.1554825301625;
        Tue, 09 Apr 2019 08:55:01 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id w68sm45735950pfb.176.2019.04.09.08.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:55:00 -0700 (PDT)
Date:   Tue, 9 Apr 2019 08:54:59 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>, Moritz Fischer <mdf@kernel.org>,
        "atull@kernel.org" <atull@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
Message-ID: <20190409155459.GA7617@archbook>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-2-nava.manne@xilinx.com>
 <20190408171456.GA4293@archbook>
 <9ab8f7fb-0936-3635-60fe-164402780429@xilinx.com>
 <BYAPR02MB471005801CE9F16523516611C22D0@BYAPR02MB4710.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR02MB471005801CE9F16523516611C22D0@BYAPR02MB4710.namprd02.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nava,

On Tue, Apr 09, 2019 at 08:54:34AM +0000, Nava kishore Manne wrote:
> Hi Moritz,
> 
> Thanks for the quick response.
> Please find my response inline
> 
> > -----Original Message-----
> > From: Michal Simek [mailto:michal.simek@xilinx.com]
> > Sent: Tuesday, April 9, 2019 12:04 PM
> > To: Moritz Fischer <mdf@kernel.org>; Nava kishore Manne
> > <navam@xilinx.com>
> > Cc: atull@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; Michal
> > Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; linux-fpga@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > chinnikishore369@gmail.com
> > Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
> > 
> > On 08. 04. 19 19:14, Moritz Fischer wrote:
> > > Hi Nava,
> > >
> > > On Tue, Apr 02, 2019 at 06:01:21PM +0530, Nava kishore Manne wrote:
> > >> This Patch Adds fpga API's to support the Bitstream loading by using
> > >> firmware interface.
> > >>
> > >> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > >> ---
> > >> Changes for v4:
> > >> 		-None.
> > >>
> > >> Chnages for v3:
> > >> 		-Created patches on top of 5.0-rc5.
> > >> 		 No functional changes.
> > >>
> > >> Changes for v2:
> > >> 		-Added Firmware FPGA Manager flags As suggested by
> > >> 		 Moritz.
> > >>
> > >> Changes for v1:
> > >> 		-None.
> > >>
> > >> Changes for RFC-V2:
> > >> 		-New Patch
> > >>
> > >>  drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
> > >>  include/linux/firmware/xlnx-zynqmp.h | 10 ++++++
> > >>  2 files changed, 56 insertions(+)
> > >>
> > >> diff --git a/drivers/firmware/xilinx/zynqmp.c
> > >> b/drivers/firmware/xilinx/zynqmp.c
> > >> index 98f936125643..7159a90abc44 100644
> > >> --- a/drivers/firmware/xilinx/zynqmp.c
> > >> +++ b/drivers/firmware/xilinx/zynqmp.c
> > >> @@ -537,6 +537,50 @@ static int zynqmp_pm_reset_get_status(const enum
> > zynqmp_pm_reset reset,
> > >>  	return ret;
> > >>  }
> > >>
> > >> +/*
> > >> + * zynqmp_pm_fpga_load - Perform the fpga load
> > >> + * @address:	Address to write to
> > >> + * @size:	pl bitstream size
> > >> + * @flags:
> > >> + *	BIT(0) - Bit-stream type.
> > >> + *		 0 - Full Bitstream.
> > >> + *		 1 - Partial Bitstream.

Don't you wanna call out the defines instead here that you defined in
include/linux/firmware/xlnx-zynqmp.h?

> > >> + *
> > >> + * This function provides access to pmufw. To transfer
> > >> + * the required bitstream into PL.
> > >> + *
> > >> + * Return: Returns status, either success or error+reason  */ static
> > >> +int zynqmp_pm_fpga_load(const u64 address, const u32 size,
> > >> +			       const u32 flags)
> > >> +{
> > >> +	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
> > >> +				   upper_32_bits(address), size, flags, NULL); }
> > >> +
> > >> +/**
> > >> + * zynqmp_pm_fpga_get_status - Read value from PCAP status register
> > >> + * @value: Value to read
> > >> + *
> > >> + * This function provides access to the xilfpga library to get
> > >
> > > xilfpga? Is that PMU firmware you're talking about?
> 
> Xilfpga is a library and it’s a part of PMUFW BSP.
> It will follow the below flow to configure the PL from Linux environment.
> Linux -Fpga Manager framework <--> Linux-Firmware Driver <- -smc call-->ATF <--IPI call--> PMUFW<--> Xilfpga library.

Fair enough. Was wondering if we could simplify/clarify the comment, but
also don't have a good suggestion :)
> 
> > >
> > >> + * the PCAP status
> > >> + *
> > >> + * Return: Returns status, either success or error+reason  */ static
> > >> +int zynqmp_pm_fpga_get_status(u32 *value) {
> > >> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> > >> +	int ret;
> > >> +
> > >> +	if (!value)
> > >> +		return -EINVAL;
> > >> +
> > >> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0,
> > ret_payload);
> > >> +	*value = ret_payload[1];
> > >> +
> > >> +	return ret;
> > >> +}
> > >> +
> > >>  /**
> > >>   * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
> > >>   *			       master has initialized its own power management
> > >> @@ -640,6 +684,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
> > >>  	.request_node = zynqmp_pm_request_node,
> > >>  	.release_node = zynqmp_pm_release_node,
> > >>  	.set_requirement = zynqmp_pm_set_requirement,
> > >> +	.fpga_load = zynqmp_pm_fpga_load,
> > >> +	.fpga_get_status = zynqmp_pm_fpga_get_status,
> > >>  };
> > >>
> > >>  /**
> > >> diff --git a/include/linux/firmware/xlnx-zynqmp.h
> > >> b/include/linux/firmware/xlnx-zynqmp.h
> > >> index 642dab10f65d..4df226b6ab0f 100644
> > >> --- a/include/linux/firmware/xlnx-zynqmp.h
> > >> +++ b/include/linux/firmware/xlnx-zynqmp.h
> > >> @@ -48,6 +48,12 @@
> > >>  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
> > >>  #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
> > >>
> > >> +/*
> > >> + * Firmware FPGA Manager flags
> > >> + * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration  */
> > >> +#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
> > >> +
> > >>  enum pm_api_id {
> > >>  	PM_GET_API_VERSION = 1,
> > >>  	PM_REQUEST_NODE = 13,
> > >> @@ -56,6 +62,8 @@ enum pm_api_id {
> > >>  	PM_RESET_ASSERT = 17,
> > >>  	PM_RESET_GET_STATUS,
> > >>  	PM_PM_INIT_FINALIZE = 21,
> > >> +	PM_FPGA_LOAD = 22,
> > >> +	PM_FPGA_GET_STATUS,
> > >
> > > Any reason you can't do 'PM_FPGA_GET_STATUS = 23' here? Trying to
> > > understand your reasoning. Are you planning to move them around?
> > 
> > It is 23 by design. In xilinx repo there was only the first value which is
> > recommended practice. But upstreaming is not done in the same order that's
> > why if there is a gap you need to assign values there.
> > Even that 22 can be removed in this case but it is just nit.
> > 
>  As Michal said here Assigning value of 22 is not needed. Will fix this issue in the next version.

Ok, I didn't check the Xilinx repos :) Makes sense, though.

With nits above addressed:
Reviewed-by: Moritz Fischer <mdf@kernel.org>

Thanks,
Moritz
