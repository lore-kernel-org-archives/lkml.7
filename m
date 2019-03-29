Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16283C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF2921773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfC2XEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:04:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41998 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbfC2XEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:04:16 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 38e0105983f9a327; Sat, 30 Mar 2019 00:04:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>
Subject: Re: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Date:   Sat, 30 Mar 2019 00:02:12 +0100
Message-ID: <1774302.IF6vfKfJ7U@aspire.rjw.lan>
In-Reply-To: <SN6PR12MB26399489011DD026910B6049F85A0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <cover.1553285718.git.Janakarajan.Natarajan@amd.com> <f3a749646c66a84e17383204385d8c73750d4813.camel@intel.com> <SN6PR12MB26399489011DD026910B6049F85A0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 29, 2019 9:18:04 PM CET Ghannam, Yazen wrote:
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org> On Behalf Of Pandruvada, Srinivas
> > Sent: Wednesday, March 27, 2019 10:48 AM
> > To: linux-kernel@vger.kernel.org; devel@acpica.org; Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>; linux-
> > acpi@vger.kernel.org; linux-pm@vger.kernel.org
> > Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; lenb@kernel.org; viresh.kumar@linaro.org; Moore, Robert
> > <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; rjw@rjwysocki.net
> > Subject: Re: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
> > 
> > On Fri, 2019-03-22 at 20:26 +0000, Natarajan, Janakarajan wrote:
> > > From: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > >
> > > Newer AMD processors support a subset of the optional CPPC registers.
> > > Create show, store and helper routines for supported CPPC registers.
> > >
> > > Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > > [ carved out into a patch, cleaned up, productized ]
> > > Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> > >
> > 
> > [..]
> > 
> > > +	/* desired_perf is the only mandatory value in perf_ctrls */
> > > +	if (cpc_read(cpu, desired_reg, &desired))
> > > +		ret = -EFAULT;
> > > +
> > > +	if (CPC_SUPPORTED(max_reg) && cpc_read(cpu, max_reg, &max))
> > > +		ret = -EFAULT;
> > > +
> > We should create and use different macro other than CPPC_SUPPORTED.
> > CPC_SUPPORTED doesn't validate the correctness of object type for a
> > field. For example "Maximum Performance Register" can only be buffer
> > not integer. In this way invalid field definitions can be ignored.
> > 
> 
> So create something like "CPPC_SUPPORTED_BUFFER" for buffer-only registers?
> 
> And then buffer/integer registers will continue to use "CPPC_SUPPORTED".
> 
> These seem to be the only two cases at this time. Is this okay?

Yes, something like that.

Thanks,
Rafael

