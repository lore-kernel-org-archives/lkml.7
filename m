Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1851C41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D538622CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfIDMBf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:01:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:59316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfIDMBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:01:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B37AB66A;
        Wed,  4 Sep 2019 12:01:34 +0000 (UTC)
Date:   Wed, 4 Sep 2019 14:01:34 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] w1: add 1-wire master driver for IP block found
 in SGI ASICs
Message-Id: <20190904140134.698aaf5f5ec204a5305c1177@suse.de>
In-Reply-To: <20190904114837.GA9153@kroah.com>
References: <20190831082623.15627-1-tbogendoerfer@suse.de>
        <20190831082623.15627-2-tbogendoerfer@suse.de>
        <20190904114837.GA9153@kroah.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 13:48:37 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Sat, Aug 31, 2019 at 10:26:21AM +0200, Thomas Bogendoerfer wrote:
> > Starting with SGI Origin machines nearly every new SGI ASIC contains
> > an 1-Wire master. They are used for attaching One-Wire prom devices,
> > which contain information about part numbers, revision numbers,
> > serial number etc. and MAC addresses for ethernet interfaces.
> > This patch adds a master driver to support this IP block.
> > It also adds an extra field dev_id to struct w1_bus_master, which
> > could be in used in slave drivers for creating unique device names.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > ---
> >  drivers/w1/masters/Kconfig           |   9 +++
> >  drivers/w1/masters/Makefile          |   1 +
> >  drivers/w1/masters/sgi_w1.c          | 130 +++++++++++++++++++++++++++++++++++
> >  include/linux/platform_data/sgi-w1.h |  13 ++++
> 
> Why platform data?  I thought that was the "old way", and the "proper
> way" now is to use device tree?

this machine is old and doesn't have device tree at all.

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 247165 (AG München)
Geschäftsführer: Felix Imendörffer
