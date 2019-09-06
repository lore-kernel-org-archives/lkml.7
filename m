Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935A7C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F6F21D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbfIFHEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:04:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:16950 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbfIFHEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:04:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 00:04:31 -0700
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="267279240"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 00:04:28 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 8B7272051A; Fri,  6 Sep 2019 10:04:26 +0300 (EEST)
Date:   Fri, 6 Sep 2019 10:04:26 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 09/11] lib/vsprintf: OF nodes are first and foremost,
 struct device_nodes
Message-ID: <20190906070426.GJ5475@paasikivi.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-10-sakari.ailus@linux.intel.com>
 <20190903085233.oksjcwqwdxb53eig@pathway.suse.cz>
 <20190903092816.qutqnjba7okcauim@pathway.suse.cz>
 <20190903112800.GW2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903112800.GW2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:28:00PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 03, 2019 at 11:28:16AM +0200, Petr Mladek wrote:
> > On Tue 2019-09-03 10:52:33, Petr Mladek wrote:
> > > On Mon 2019-09-02 16:57:30, Sakari Ailus wrote:
> > > > Factor out static kobject_string() function that simply calls
> > > > device_node_string(), and thus remove references to kobjects (as these are
> > > > struct device_node).
> 
> > > > -		return kobject_string(buf, end, ptr, spec, fmt);
> > > > +		return device_node_string(buf, end, ptr, spec, fmt + 1);
> > > 
> > > I know that this come from from kobject_string(). But please, modify
> > > it to follow the style used by other %p modifiers. I mean to pass
> > > "fmt" as is and then use:
> > > 
> > > 	if (fmt[1] != 'F')
> > 
> > Ah, I see that it would need more changes in device_node_string().
> > OK, let's leave the patch as is. I am sorry for the noise.
> 
> I came to the same conclusions, though can we consider to drop this patch?

It's a cleanup. I'd prefer to keep the patch.

Albeit fmt++; in device_node_string() would do the trick of avoiding fmt +
1 in the caller. That said, I'd prefer to keep the original patch as-is.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
