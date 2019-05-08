Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35936C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C85D20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfEHV7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:59:52 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:42754 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726837AbfEHV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:59:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 69C172C12;
        Wed,  8 May 2019 21:59:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dirt93_72df139f4a755
X-Filterd-Recvd-Size: 2459
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 21:59:49 +0000 (UTC)
Message-ID: <4ce8826150026abd7649acb7b9fc143a033b7720.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add command-line option for TAB size
From:   Joe Perches <joe@perches.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 08 May 2019 14:59:48 -0700
In-Reply-To: <AT5PR8401MB1169149078CDB1274A259703AB320@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190508174356.13952-1-borneo.antonio@gmail.com>
         <AT5PR8401MB1169149078CDB1274A259703AB320@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 21:14 +0000, Elliott, Robert (Servers) wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
> > Antonio Borneo
> > Sent: Wednesday, May 8, 2019 12:44 PM
> > Subject: [PATCH v2] checkpatch: add command-line option for TAB size
> ...
> > Add a command-line option "--tab-size" to let the user select a
> > TAB size value other than 8.
> > This makes easy to reuse this script by other projects with
> > different requirements in their coding style (e.g. OpenOCD [1]
> > requires TAB size of 4 characters [2]).
> ...
> > +  --tab-size=n               set the number of spaces for tab (default 8)
> ...
> > +	'tab-size=i'	=> \$tabsize,
> ...
> > -			for (; ($n % 8) != 0; $n++) {
> > +			for (; ($n % $tabsize) != 0; $n++) {
> ...
> > -			if ($indent % 8) {
> > +			if ($indent % $tabsize) {
> > -					"\t" x ($pos / 8) .
> > -					" "  x ($pos % 8);
> > +					"\t" x ($pos / $tabsize) .
> > +					" "  x ($pos % $tabsize);
> ...
> > -			    (($sindent % 8) != 0 ||
> > +			    (($sindent % $tabsize) != 0 ||
> ...
> > -			     ($sindent > $indent + 8))) {
> > +			     ($sindent > $indent + $tabsize))) {
> 
> Checking for 0 before using the value in division and modulo
> operations would be prudent.

true.

Maybe test $tabsize for <= 0 after GetOptions and error out
if so.


