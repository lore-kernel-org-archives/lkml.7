Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E4C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8173D2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfIDQEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:04:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:44499 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731654AbfIDQEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:04:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 09:04:21 -0700
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="212446168"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 09:04:18 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id D1804204E1; Wed,  4 Sep 2019 19:04:16 +0300 (EEST)
Date:   Wed, 4 Sep 2019 19:04:16 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 00/11] Device property improvements, add %pfw format
 specifier
Message-ID: <20190904160416.GV5475@paasikivi.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <be9cd5d933486de9cf88a1550c2020c56348670d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be9cd5d933486de9cf88a1550c2020c56348670d.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Sep 03, 2019 at 02:38:48AM -0700, Joe Perches wrote:
> On Mon, 2019-09-02 at 16:57 +0300, Sakari Ailus wrote:
> > Hi all,
> > 
> > This set adds functionality into the device property API (counting a
> > node's parents as well as obtaining its name) in order to support printing
> > fwnode names using a new conversion specifier "%pfw". The names that are
> > produced are equivalent to its OF counterpart "%pOF" on OF systems for the
> > two supported modifiers ("f" and "P").
> > 
> > Printing a node's name is something that's been available on OF for a long
> > time and if something is converted to device property API (such as the
> > V4L2 fwnode framework) it always got removed of a nice feature that was
> > sometimes essential in debugging. With this set, that no longer is the
> > case.
> 
> Doesn't this still have dependencies on removing all
> existing %p[fF] uses?
> 
> In Linus' tree:
> 
> tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt:or events have "%pF" or "%pS" parameter in its format string. It is common to
> tools/lib/traceevent/event-parse.c:             if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
> tools/lib/traceevent/event-parse.c:     if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)
> 
> And these in -next:
> 
> drivers/scsi/lpfc/lpfc_hbadisc.c:                                        "3185 FIND node filter %pf DID "
> drivers/scsi/lpfc/lpfc_hbadisc.c:                        "3186 FIND node filter %pf NOT FOUND.\n", filter);
> drivers/scsi/lpfc/lpfc_sli.c:                           "(%d):0307 Mailbox cmd x%x (x%x/x%x) Cmpl %pf "

Thanks for bringing these up.

I'll submit patches to address both.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
