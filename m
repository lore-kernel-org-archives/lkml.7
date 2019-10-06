Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D910EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A2E2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 12:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfJFMPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 08:15:39 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:41257 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfJFMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 08:15:39 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 10C0D1005D063;
        Sun,  6 Oct 2019 14:15:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BDDED29FBEE; Sun,  6 Oct 2019 14:15:36 +0200 (CEST)
Date:   Sun, 6 Oct 2019 14:15:36 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/22] thunderbolt: Add helper macros to iterate over
 switch ports
Message-ID: <20191006121536.6u7noudvfiri5h3s@wunner.de>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-6-mika.westerberg@linux.intel.com>
 <1570025874.2472.14.camel@suse.com>
 <20191002142859.GF2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002142859.GF2819@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 05:28:59PM +0300, Mika Westerberg wrote:
> On Wed, Oct 02, 2019 at 04:17:54PM +0200, Oliver Neukum wrote:
> > Am Dienstag, den 01.10.2019, 14:38 +0300 schrieb Mika Westerberg:
> > > @@ -1975,10 +1972,8 @@ void tb_switch_suspend(struct tb_switch *sw)
> > >         if (err)
> > >                 return;
> > >  
> > > -       for (i = 1; i <= sw->config.max_port_number; i++) {
> > > -               if (tb_port_has_remote(&sw->ports[i]))
> > > -                       tb_switch_suspend(sw->ports[i].remote->sw);
> > > -       }
> > > +       tb_switch_for_each_remote_port(sw, i)
> > > +               tb_switch_suspend(sw->ports[i].remote->sw);
> > 
> > This macro looks a bit prone to misunderstanding.
> > I guess the function would be better if the test could be seen.
> 
> The macro does not really save too many lines so I think I can just drop
> this patch for now and keep these open-coded.

Introducing a macro is fine.

However instead of using an index "i" as iterator, I'd suggest using a
pointer to struct tb_port.  This reduces the horizontal width of the
code because you can replace the "sw->ports[i]" with just "port".

In most of the loops this also saves 1 line for an assignment:
"struct tb_port *port = &sw->ports[i];"

In fact, I've already proposed such a macro more than a year ago
but it never got merged:

https://lore.kernel.org/patchwork/patch/983863/ 

/**
 * tb_sw_for_each_port() - iterate over ports on a switch
 * @switch: pointer to struct tb_switch over whose ports shall be iterated
 * @port: pointer to struct tb_port which shall be used as the iterator
 *
 * Excludes port 0, which is the switch itself and therefore irrelevant for
 * most iterations.
 */
#define tb_sw_for_each_port(switch, port)				 \
	for (port = &(switch)->ports[1];				 \
	     port <= &(switch)->ports[(switch)->config.max_port_number]; \
	     port++)

Thanks,

Lukas
