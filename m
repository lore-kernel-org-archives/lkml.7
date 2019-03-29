Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B45C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AF02183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfC2OrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:47:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:65320 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbfC2Oq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:46:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 07:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="333219409"
Received: from bublath-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.42.182])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2019 07:46:57 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id CEAAE21E50; Fri, 29 Mar 2019 16:46:47 +0200 (EET)
Date:   Fri, 29 Mar 2019 16:46:47 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
Message-ID: <20190329144647.uogfwc7wswgbcykj@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com>
 <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
 <CAJZ5v0hi04yACD9ZzDCaxhJh-uHHpMOu=zZzVf4t5vH=ctaYBg@mail.gmail.com>
 <20190328111307.ppuywzyb3i56pw4h@kekkonen.localdomain>
 <CAJZ5v0gAM_jn-gkmyu7Av+X0W_8g9NGjBEeXC-3-q_Ncb2PEGw@mail.gmail.com>
 <20190329131507.cc4qt5oyd74nvmzt@kekkonen.localdomain>
 <20190329141549.GZ9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329141549.GZ9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Mar 29, 2019 at 04:15:49PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 29, 2019 at 03:15:07PM +0200, Sakari Ailus wrote:
> > On Thu, Mar 28, 2019 at 03:52:35PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Mar 28, 2019 at 12:13 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > > On Thu, Mar 28, 2019 at 10:38:01AM +0100, Rafael J. Wysocki wrote:
> > > > > On Wed, Mar 27, 2019 at 3:20 PM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> > > > > > > On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:
> 
> > Another option would be changing where the counting starts --- the first
> > parent. I.e.
> 
> Looks better to me, though can you put comment how parents are being counted?

To the code? The kerneldoc comment contains one, and the code below is
pretty simple.

> 
> > fwnode = fwnode_get_parent(fwnode);
> > 
> > for (count = 0; fwnode; count++)
> > 	fwnode = fwnode_get_next_parent(fwnode);
> > 
> > return count;
> 

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
