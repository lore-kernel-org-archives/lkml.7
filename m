Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491B7ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2724D20640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbfJANOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:14:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:22256 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfJANOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:14:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205061963"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 06:14:45 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 16:14:44 +0300
Date:   Tue, 1 Oct 2019 16:14:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/22] thunderbolt: Add default linking between ports
 if not provided by DROM
Message-ID: <20191001131444.GP2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-8-mika.westerberg@linux.intel.com>
 <20191001123911.GB2954373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001123911.GB2954373@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:39:11PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2019 at 02:38:15PM +0300, Mika Westerberg wrote:
> > Some cases the DROM information is not correct or is simply missing.
> 
> What is "DROM"?

It is "Device ROM". Essentially per-device information. I will spell it
out in next version.

> > This prevents establishing lane bonding even if it would be possible
> > otherwise. To make this work better provide default linking between
> > ports if DROM has not provided that information.
> > 
> > This works with legacy devices where ports 1 and 2, and 3 and 4 are
> > linked together and also with USB4.
> 
> "linked together" as in "bonded"?  Or something else?  Names are getting
> confusing here :(

Here linked together means the both port in dual link so ports 1, 2 and
ports 3 and 4. There are always two pairs of ports (lanes) that go out
of physical connector. Here we just link them in software. I'll try to
clarify this in the next version.
