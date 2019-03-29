Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB78218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfC2PcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:32:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:7855 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfC2PcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:32:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 08:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="126975716"
Received: from bublath-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.42.182])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2019 08:32:07 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 068F421E50; Fri, 29 Mar 2019 17:31:57 +0200 (EET)
Date:   Fri, 29 Mar 2019 17:31:57 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
Message-ID: <20190329153157.hj2b4mjgfh5q5e2q@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com>
 <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
 <20190328141036.mbns3ei4agnginsg@pathway.suse.cz>
 <20190329130436.4fxzki5kljprhyai@kekkonen.localdomain>
 <20190329141419.GY9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329141419.GY9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Mar 29, 2019 at 04:14:19PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 29, 2019 at 03:04:36PM +0200, Sakari Ailus wrote:
> > On Thu, Mar 28, 2019 at 03:10:36PM +0100, Petr Mladek wrote:
> 
> > You basically have to have a reference to a node until you're done
> > accessing it. The refcounting in the fwnode framework is based on the OF
> > API --- otherwise you couldn't access OF nodes using the framework.
> 
> > ACPI
> > does not have those (as you can't dynamically remove nodes).
> 
> What about configfs where we can load / unload tables at run time?

Hmm. I have to admit I missed this one.

Well, I guess that this feature depends on the user making sure there are
no references to the tables that are to be removed, as there is no
refcounting. Let me know if I'm missing something, but nothing appears to
prevent releasing nodes that are in use.

If that is really so, then refcounting or another mechanism to achieve
something similar should be added to make removal safe, but this isn't
related to printing the node names anymore nor such fixes belong to this
patchset.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
