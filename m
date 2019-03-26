Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C902070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfCZPNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:13:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:55182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZPNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:13:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C11CAD55;
        Tue, 26 Mar 2019 15:13:08 +0000 (UTC)
Date:   Tue, 26 Mar 2019 16:13:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190326151307.erqyps6wfvf4on2d@pathway.suse.cz>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322152930.16642-6-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-22 17:29:30, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.
> 
> On ACPI based systems the resulting strings look like
> 
> 	\_SB.PCI0.CIO2.port@1.endpoint@0
> 
> where the nodes are separated by a dot (".") and the first three are
> ACPI device nodes and the latter two ACPI data nodes.
> 
> Depends-on: ("vsprintf: Remove support for %pF and %pf in favour of %pS and %ps")

Reusing obsolete modifiers is dangerous from many reasons:

   + people might miss the change of the meaning
   + backporting mistakes
   + 3rd party modules

It might be acceptable if the long term gain is bigger
than a short time difficulties. But it would be better
to it a safe way when possible.

Fortunately, we could keep the backward compatibility
for "%pf" and handle only "%pfw*" with the fwnode api.

Best Regards,
Petr
