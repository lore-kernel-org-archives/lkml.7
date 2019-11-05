Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5732C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B78E217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390010AbfKEPtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:49:14 -0500
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:39927 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389506AbfKEPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:49:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 98CB618224D6E;
        Tue,  5 Nov 2019 15:49:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bells35_8a71c36980a62
X-Filterd-Recvd-Size: 2812
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Nov 2019 15:49:11 +0000 (UTC)
Message-ID: <1beaa707511e1ef6b1e2fe408a61a35d4cd0b5ba.camel@perches.com>
Subject: Re: [PATCH v3 3/5] bus: hisi_lpc: Clean some types
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, xuwei5@huawei.com
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org, olof@lixom.net,
        bhelgaas@google.com, arnd@arndb.de
Date:   Tue, 05 Nov 2019 07:48:43 -0800
In-Reply-To: <d6c8521c-30c0-7a2c-b658-8734f7b180d3@huawei.com>
References: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
         <1572888139-47298-4-git-send-email-john.garry@huawei.com>
         <a391e4df7c080c6a4d7eac58708967d02f0449fa.camel@perches.com>
         <d6c8521c-30c0-7a2c-b658-8734f7b180d3@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 09:50 +0000, John Garry wrote:
> On 04/11/2019 18:39, Joe Perches wrote:
> > On Tue, 2019-11-05 at 01:22 +0800, John Garry wrote:
> > > Sparse complains of these:
> > > drivers/bus/hisi_lpc.c:82:38: warning: incorrect type in argument 1 (different address spaces)
> > > drivers/bus/hisi_lpc.c:82:38:    expected void const volatile [noderef] <asn:2>*addr
> > > drivers/bus/hisi_lpc.c:82:38:    got unsigned char *
> > > drivers/bus/hisi_lpc.c:131:35: warning: incorrect type in argument 1 (different address spaces)
> > > drivers/bus/hisi_lpc.c:131:35:    expected unsigned char *mbase
> > > drivers/bus/hisi_lpc.c:131:35:    got void [noderef] <asn:2>*membase
> > > drivers/bus/hisi_lpc.c:186:35: warning: incorrect type in argument 1 (different address spaces)
> > > drivers/bus/hisi_lpc.c:186:35:    expected unsigned char *mbase
> > > drivers/bus/hisi_lpc.c:186:35:    got void [noderef] <asn:2>*membase
> > > drivers/bus/hisi_lpc.c:228:16: warning: cast to restricted __le32
> > > drivers/bus/hisi_lpc.c:251:13: warning: incorrect type in assignment (different base types)
> > > drivers/bus/hisi_lpc.c:251:13:    expected unsigned int [unsigned] [usertype] val
> > > drivers/bus/hisi_lpc.c:251:13:    got restricted __le32 [usertype] <noident>
> > > 
> > > Clean them up.
> > 
> > OK, it might also be good to change the _in and _out functions
> > to use void * and not unsigned char * for buf
> 
> Hi Joe,

Hi John.

> In fact, using unsigned char * is the right thing to do, and really the 
> upper layer prob should not be passing void *. I'll look at this as a 
> follow up.

Maybe so, but it looks like the generic readsb and writesb routines
take void * so it might be a lot of other files to modify.

g'luck and cheers, Joe

