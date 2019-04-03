Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED49C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBED2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554314953;
	bh=gFJkThUjMrts/oAAEEMAMI32s4jxOZz+CQzmkYTGaXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gi6iP4AvIMrGSPOJKySm64svEChVcNfqz43pKpYkGvbv2sHuRmFXulckFKz1smarG
	 rfJqOgYar7wInU5bHzg/aN4cOF0O3MssLLrJqGmHkxzrrpjkYjpwfZaS4F15i9v0G3
	 3fpp+UBdoN6RaG4PklxDm8vITh9fSlUaHlf8wPOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDCSJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:09:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35829 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:09:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id j132so14392756oib.2;
        Wed, 03 Apr 2019 11:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=49kuSIN2dfz00ekq6navgfrBiWngG5gEwFp5rVG5Ab8=;
        b=IhyNVnZ8BiDdc3rDo0ss6ecy4AFduoZQdEPbia0PjcyTlm4Zjy4DQEPMRs2DvDNtHQ
         t/B8FYM86Cs8wLdO88wHDF76sa4Cupl4HR5eClZGepF5qNVlrPIeI/QrvCmkfV2Wf0ZJ
         R92aAGgKC6ZWmjyuL3MgQWPcvMG+K0RqcP2kK7iqkdmsa/7/myeCbozn7t3WRrsZ2t2J
         6vh1o5vvSWIm6K33tBfZP1sfu1fturemsvGVsoFQsrD6YueaenfW2c+qERc/oCpaWPfl
         YZMutEE1yyKxu7oEvLbk0+2vOTacpjxdjAJMiOjWYPUHpNWsiW328FGDmHTHmzSOKbtU
         CosA==
X-Gm-Message-State: APjAAAXThUg435IQUBbMgo3O0DU57oid9K9hmcR4k9LZdnWu7po3P9xZ
        PzxeaapUos/CJNp0t/MXgr7YSk3F5a0=
X-Google-Smtp-Source: APXvYqxWEc6aDE33hsUR/8pa6igDJmXwTjzdbyK6mhwS7bizFp59C8tfADbrv7ogxh0JIOuCidOHdQ==
X-Received: by 2002:aca:fd93:: with SMTP id b141mr483481oii.153.1554314950278;
        Wed, 03 Apr 2019 11:09:10 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id b17sm6854019otq.26.2019.04.03.11.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 11:09:09 -0700 (PDT)
Date:   Wed, 3 Apr 2019 11:09:09 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, atull@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 14/17] fpga: dfl: fme: add thermal management support
Message-ID: <20190403180909.GD5752@archbook>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-15-git-send-email-hao.wu@intel.com>
 <20190402145925.GA15773@archbook>
 <20190403163147.GA28570@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403163147.GA28570@hao-dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

On Thu, Apr 04, 2019 at 12:31:47AM +0800, Wu Hao wrote:
> On Tue, Apr 02, 2019 at 07:59:25AM -0700, Moritz Fischer wrote:
> > Hi Wu,
> > 
> > On Mon, Mar 25, 2019 at 11:07:41AM +0800, Wu Hao wrote:
> > > This patch adds support to thermal management private feature for DFL
> > > FPGA Management Engine (FME). As thermal throttling is handled by
> > > hardware automatically per pre-defined thresholds, this private
> > > feature driver only provides read-only sysfs interfaces for user
> > > to read temperature, thresholds, threshold policy and other info.
> > > 
> > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-platform-dfl-fme |  56 +++++++
> > >  drivers/fpga/dfl-fme-main.c                      | 202 +++++++++++++++++++++++
> > >  2 files changed, 258 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > index b8327e9..d3aeb88 100644
> > > --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > > @@ -44,3 +44,59 @@ Description:	Read-only. It returns socket_id to indicate which socket
> > >  		this FPGA belongs to, only valid for integrated solution.
> > >  		User only needs this information, in case standard numa node
> > >  		can't provide correct information.
> > > +
> > > +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/temperature
> > > +Date:		March 2019
> > > +KernelVersion:  5.2
> > > +Contact:	Wu Hao <hao.wu@intel.com>
> > > +Description:	Read-only. It returns temperature (in Celsius) of this FPGA
> > > +		device.
> > > +
> > > +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold1
> > > +Date:		March 2019
> > > +KernelVersion:  5.2
> > > +Contact:	Wu Hao <hao.wu@intel.com>
> > > +Description:	Read-only. Read this file to get the temperature threshold1
> > > +		(in Celsius).
> > > +
> > > +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold2
> > > +Date:		March 2019
> > > +KernelVersion:  5.2
> > > +Contact:	Wu Hao <hao.wu@intel.com>
> > > +Description:	Read-only. Read this file to get the temperature threshold2
> > > +		(in Celsius).
> > > +
> > > +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/trip_threshold
> > > +Date:		March 2019
> > > +KernelVersion:  5.2
> > > +Contact:	Wu Hao <hao.wu@intel.com>
> > > +Description:	Read-only. It returns trip threshold (in Celsius), once FPGA
> > > +		temperature reaches trip threshold, it triggers a fatal event
> > > +		to board management controller (BMC) to shutdown FPGA.
> > > +
> > > +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold1_status
> > > +Date:		March 2019
> > > +KernelVersion:  5.2
> > > +Contact:	Wu Hao <hao.wu@intel.com>
> > > +Description:	Read-only. It returns 1 if temperature reaches threshold1,
> > > +		otherwise 0. Once temperature reaches threshold1, hardware
> > > +		will automatically enter throttling state (AP1 - 50%
> > > +		or AP2 - 90% throttling, see 'threshold1_policy').
> > > +
> > > +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold2_status
> > > +Date:		March 2019
> > > +KernelVersion:  5.2
> > > +Contact:	Wu Hao <hao.wu@intel.com>
> > > +Description:	Read-only. It returns 1 if temperature reaches threshold2,
> > > +		otherwise 0. Once temperature reaches threshold2, hardware
> > > +		will automatically enter the deepest throttling state (AP6
> > > +		- 100% throttling).
> > > +
> > > +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold1_policy
> > > +Date:		March 2019
> > > +KernelVersion:  5.2
> > > +Contact:	Wu Hao <hao.wu@intel.com>
> > > +Description:	Read-only. Read this file to get the policy of temperature
> > > +		threshold1. It only supports two value (policy):
> > > +		    0 - AP2 state (90% throttling)
> > > +		    1 - AP1 state (50% throttling)
> > 
> > These look like they could directly map to the linux thermal framework,
> > any reason you can't use the thermal framework?
> > 
> > The trip stuff literally maps 1:1 to what a thermal driver does, I think
> > that's something you'd wanna consider.
> > 
> 
> Hi Moritz,
> 
> Thanks a lot for the suggestion, actually I feel that the trip points in thermal
> zone are used to indicate cooling actions required for thermal software either
> in kernel or userspace. But in this case, such FPGA hardware handles cooling
> automatically (yes, driver only expose Read-only sysfs for information), so
> software doesn't need to take care of this at all. For this purpose, it seems
> that we don't have to put these thresholds as trip points. And per my
> understanding, if people use such FPGA device, then they may need to know
> what's the current hardware throttling behavior, e.g. 50% vs 90%. These
> information can't be provided by standard thermal zone sysfs, so anyway user
> needs these sysfs interfaces to know it. But it seems that we still could
> create a thermal zone without trip points, it could help if user wants to
> connect some external cooling devices via userspace thermal daemon, they can
> define whatever trip points they like to activate the external cooling 
> device. I will consider this further more and come up with a new patch in
> v2 patchset.

Generally speaking extending an existing framework with the
functionality you want is preferable over rolling 100% your own.

So please look into this.

Thanks,
Moritz
