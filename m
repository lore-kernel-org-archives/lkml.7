Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B177ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C4A2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfJOJl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:41:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41319 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfJOJl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:41:56 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id e98463beea6c6ad3; Tue, 15 Oct 2019 11:41:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: linux-next: build warning after merge of the pm tree
Date:   Tue, 15 Oct 2019 11:41:54 +0200
Message-ID: <12090193.Ojpx7YaiiM@kreacher>
In-Reply-To: <20191015082333.GV32742@smile.fi.intel.com>
References: <20191015100855.31b8a3d5@canb.auug.org.au> <20191015082333.GV32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 15, 2019 10:23:33 AM CEST Andy Shevchenko wrote:
> On Tue, Oct 15, 2019 at 10:08:55AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the pm tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> > 
> > In file included from include/linux/irqchip.h:14,
> >                  from arch/arm/kernel/irq.c:26:
> > include/linux/acpi.h:682:31: warning: 'struct acpi_device' declared inside parameter list will not be visible outside of this definition or declaration
> >   682 | acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
> >       |                               ^~~~~~~~~~~
> > 
> > and many more.
> > 
> > Introduced by commit
> > 
> >   d1748b57dc88 ("ACPI / utils: Introduce acpi_dev_hid_uid_match() helper")
> > 
> > CONFIG_ACPI is not set for this build.
> 
> I'm puzzled. Why it builds before?
> 
> Another function has struct acpi_device *adev in its prototype and it was
> before above mentioned commit.

Right.

The very next acpi_dev_get_first_match_dev() returns a pointer to
struct acpi_device too and it is not modified by the commit in question.

There may be a bug in there, but commit d1748b57dc88 doesn't look like the
source of it.



