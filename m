Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741FEC41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5683722CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfIDPjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:39:46 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:34192 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729316AbfIDPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:39:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C03B518224D9C;
        Wed,  4 Sep 2019 15:39:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soap07_54e0b1fef1704
X-Filterd-Recvd-Size: 2744
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Sep 2019 15:39:43 +0000 (UTC)
Message-ID: <f62dd153a23bfbe580aee9e50d87c0ff59f4d0ec.camel@perches.com>
Subject: Re: [PATCH v4 10/11] lib/vsprintf: Add %pfw conversion specifier
 for printing fwnode names
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Wed, 04 Sep 2019 08:39:42 -0700
In-Reply-To: <20190904151759.GS2680@smile.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
         <20190902083240.20367-11-sakari.ailus@linux.intel.com>
         <20190903130607.cf2qv3s3evobbd5g@pathway.suse.cz>
         <20190904150413.GU5475@paasikivi.fi.intel.com>
         <20190904151759.GS2680@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 18:17 +0300, Andy Shevchenko wrote:
> On Wed, Sep 04, 2019 at 06:04:13PM +0300, Sakari Ailus wrote:
> > On Tue, Sep 03, 2019 at 03:06:07PM +0200, Petr Mladek wrote:
> > > On Mon 2019-09-02 11:32:39, Sakari Ailus wrote:
> > > > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > > > support printing full path of the node, including its name ("f") and only
> > > > the node's name ("P") in the printk family of functions. The two flags
> > > > have equivalent functionality to existing %pOF with the same two modifiers
> > > > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > > > based systems is added by this patch.
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -5995,7 +5995,8 @@ sub process {
> > > >  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> > > >  					$specifier = $1;
> > > >  					$extension = $2;
> > > > -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> > > > +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> > > > +					    $extension =~ /^f[^w]/) {
> > > 
> > > This does not work. $extension seems to have only one character.
> > 
> > Good catch. \w indeed matches a single letter; I'll change that to \w+ and
> > change the other uses accordingly.
> 
> It's weird. \w stands for word matching. How can it match one letter only?

\w 	matches any single character classified as a “word” character (alphanumeric or “_”)

