Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12FFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8149F21479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389961AbfETNtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:49:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:36257 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbfETNtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:49:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 06:49:01 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2019 06:48:59 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hSiex-000507-GJ; Mon, 20 May 2019 16:48:59 +0300
Date:   Mon, 20 May 2019 16:48:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1] device property: Add helpers to count items in an
 array
Message-ID: <20190520134859.GB9224@smile.fi.intel.com>
References: <20190520123848.56422-1-andriy.shevchenko@linux.intel.com>
 <20190520133758.GG1887@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520133758.GG1887@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:37:58PM +0300, Heikki Krogerus wrote:
> On Mon, May 20, 2019 at 03:38:48PM +0300, Andy Shevchenko wrote:
> > The usual pattern to allocate the necessary space for an array of properties is
> > to count them fist using:
> > 
> >   count = device_property_read_uXX_array(dev, propname, NULL, 0);
> > 
> > Introduce helpers device_property_count_uXX() to count items by supplying hard
> > coded last two parameters to device_property_readXX_array().
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> OK by me. FWIW:
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks!

> Off topic question: Shouldn't we also be able to read the number of
> references a reference property holds? I mean, shouldn't
> fwnode_property_get_referece_args() also return the number of
> references in the property if called without the value parameter?
> 
> There can be "empty" references in the middle of the "array" of
> references which cause the function to return -ENOENT just like when
> called with index out of bounds, so the caller now has in practice
> know how many references the property actually has in advance.

The idea is good, though I'm not so familiar with reference sub-API, don't know
what would be the best approach to cover all: ACPI, DT, swnode.

-- 
With Best Regards,
Andy Shevchenko


