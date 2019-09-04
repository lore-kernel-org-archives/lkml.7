Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60307C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A622CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfIDPhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:37:13 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:48652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729773AbfIDPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:37:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B7BBF180A68D8;
        Wed,  4 Sep 2019 15:37:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tiger34_3e76a9afc5644
X-Filterd-Recvd-Size: 2411
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Sep 2019 15:37:09 +0000 (UTC)
Message-ID: <78ccab5e0f07b3acaade1dec1ca3241938ab298f.camel@perches.com>
Subject: Re: [PATCH v4 10/11] lib/vsprintf: Add %pfw conversion specifier
 for printing fwnode names
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Wed, 04 Sep 2019 08:37:08 -0700
In-Reply-To: <20190904150413.GU5475@paasikivi.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
         <20190902083240.20367-11-sakari.ailus@linux.intel.com>
         <20190903130607.cf2qv3s3evobbd5g@pathway.suse.cz>
         <20190904150413.GU5475@paasikivi.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 18:04 +0300, Sakari Ailus wrote:
> On Tue, Sep 03, 2019 at 03:06:07PM +0200, Petr Mladek wrote:
> > On Mon 2019-09-02 11:32:39, Sakari Ailus wrote:
[]
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > > @@ -5995,7 +5995,8 @@ sub process {
> > >  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> > >  					$specifier = $1;
> > >  					$extension = $2;
> > > -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> > > +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> > > +					    $extension =~ /^f[^w]/) {
> > 
> > This does not work. $extension seems to have only one character.
> 
> Good catch. \w indeed matches a single letter; I'll change that to \w+ and
> change the other uses accordingly.

If you want to make changes to checkpatch, please
send patches to the checkpatch maintainers.

Don't break other parsing of $2/#extension.

If you really need to know whatever follows the specific
extension letter use another capture group.

			while ($fmt =~  /(\%[\*\d\.]*p(\w)(\w*))/g) {
				$specifier = $1;
				$extension = $2;
				$qualifier = $3;

etc...

Then verify $qualifier or $3 is not undef if necessary


