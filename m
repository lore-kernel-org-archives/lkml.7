Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3ACC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158A820873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfGSObb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:31:31 -0400
Received: from smtprelay0249.hostedemail.com ([216.40.44.249]:59367 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727717AbfGSObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:31:31 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 2C55A18021C81
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 14:31:30 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 54241100E86C1;
        Fri, 19 Jul 2019 14:31:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: goose72_6425d86262656
X-Filterd-Recvd-Size: 2697
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jul 2019 14:31:28 +0000 (UTC)
Message-ID: <dc45dc9c8af1f1a2073de5c49283ba3cf3a0a2f0.camel@perches.com>
Subject: Re: get_maintainers.pl subsystem output
From:   Joe Perches <joe@perches.com>
To:     "Duda, Sebastian" <sebastian.duda@fau.de>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        ralf.ramsauer@oth-regensburg.de, wolfgang.mauerer@oth-regensburg.de
Date:   Fri, 19 Jul 2019 07:31:16 -0700
In-Reply-To: <6fa4aa44f343616459b17054197d0a22@fau.de>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
         <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
         <6fa4aa44f343616459b17054197d0a22@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-19 at 09:54 +0000, Duda, Sebastian wrote:
> On 2019-07-19 08:50, Joe Perches wrote:

> > > My Questions are:
> > > 1. How can I make get_maintainer's output to be more table-like?
> > 
> > I suggest adding --nogit --nogit-fallback --roles --norolestats
> 
> Unfortunately, this doesn't change the output:
>      $ scripts/get_maintainer.pl --subsystem --status --separator , 
> drivers/media/i2c/adv748x/
>      Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
> (maintainer:MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
> ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
>      Maintained,Buried alive in reporters
>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
> (V4L/DVB),THE REST

It does change the output for files that do not
have a specific maintainer.

> > > 2. How can I make get_maintainer.pl to separate each file's output?
> > 
> > Run the script with multiple invocations. once for each file
> > modified by the patch.
> 
> This is the way I'm doing it right now but this is very slow. I thought 
> calling the script only once for many files could speed up the analysis.

get_maintainer is effectively single threaded.

Averaging 10 runs:

A single file run time is ~0.135 seconds on my system.
An invocation with two files on the command line has
a run time of ~0.195 seconds.

Using something like gnu parallel would allow multiple
instances to run simulateously and would significantly
reduce overall wall-clock runtime on most systems.

https://www.gnu.org/software/parallel/


