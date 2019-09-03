Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8BBC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE9D206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfICJiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:38:54 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:43643 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728550AbfICJix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:38:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id AEB3E2B347;
        Tue,  3 Sep 2019 09:38:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: geese64_4d259d89bf017
X-Filterd-Recvd-Size: 2574
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Sep 2019 09:38:50 +0000 (UTC)
Message-ID: <be9cd5d933486de9cf88a1550c2020c56348670d.camel@perches.com>
Subject: Re: [PATCH v5 00/11] Device property improvements, add %pfw format
 specifier
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Tue, 03 Sep 2019 02:38:48 -0700
In-Reply-To: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-02 at 16:57 +0300, Sakari Ailus wrote:
> Hi all,
> 
> This set adds functionality into the device property API (counting a
> node's parents as well as obtaining its name) in order to support printing
> fwnode names using a new conversion specifier "%pfw". The names that are
> produced are equivalent to its OF counterpart "%pOF" on OF systems for the
> two supported modifiers ("f" and "P").
> 
> Printing a node's name is something that's been available on OF for a long
> time and if something is converted to device property API (such as the
> V4L2 fwnode framework) it always got removed of a nice feature that was
> sometimes essential in debugging. With this set, that no longer is the
> case.

Doesn't this still have dependencies on removing all
existing %p[fF] uses?

In Linus' tree:

tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt:or events have "%pF" or "%pS" parameter in its format string. It is common to
tools/lib/traceevent/event-parse.c:             if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
tools/lib/traceevent/event-parse.c:     if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)

And these in -next:

drivers/scsi/lpfc/lpfc_hbadisc.c:                                        "3185 FIND node filter %pf DID "
drivers/scsi/lpfc/lpfc_hbadisc.c:                        "3186 FIND node filter %pf NOT FOUND.\n", filter);
drivers/scsi/lpfc/lpfc_sli.c:                           "(%d):0307 Mailbox cmd x%x (x%x/x%x) Cmpl %pf "


