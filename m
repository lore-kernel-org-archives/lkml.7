Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11300C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF0A20726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfLIM2U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:28:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52422 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfLIM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:28:19 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b0890110a24f95c9; Mon, 9 Dec 2019 13:28:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: acpi/hmat: don't mix pxm and nid when setting memory target processor_pxm
Date:   Mon, 09 Dec 2019 13:28:16 +0100
Message-ID: <2194461.MTbxYNK9MJ@kreacher>
In-Reply-To: <6f340d62-d55e-2709-8109-b99756274ff4@inria.fr>
References: <7fa832a3-743f-437a-81e4-ac82e67be649@inria.fr> <6f340d62-d55e-2709-8109-b99756274ff4@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 29, 2019 1:54:44 PM CET Brice Goglin wrote:
> Le 28/10/2019 à 10:11, Brice Goglin a écrit :
> > On systems where PXMs and nids are in different order, memory initiators
> > exposed in sysfs could be wrong: On dual-socket CLX with SNC enabled
> > (4 nodes, 1 and 2 swapped between PXMs and nids), node1 would only
> > get node2 as initiator, and node2 would only get node1.
> >
> > With this patch, we get node1 as the only initiator of itself,
> > and node2 as the only initiator of itself, as expected.
> >
> > This should likely go to stable up to 5.2.
> >
> > Signed-off-by: Brice Goglin <Brice.Goglin@inria.fr>
> >
> > diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> > index 8f9a28a870b0..3ca3c7c97ee0 100644
> > --- a/drivers/acpi/hmat/hmat.c
> > +++ b/drivers/acpi/hmat/hmat.c
> > @@ -417,7 +417,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
> >  			pr_debug("HMAT: Invalid Processor Domain\n");
> >  			return -EINVAL;
> >  		}
> > -		target->processor_pxm = p_node;
> > +		target->processor_pxm = p->processor_PD;
> >  	}
> >  
> >  	return 0;
> >
> 
> Can we have somebody please review this patch? I didn't get any reply
> from Keith since I first sent it to him in early September unfortunately.
> 
> Without this patch, memory initiators are exposed wrong on our Dell  R740.

See commit 4caa525b783b ("ACPI: HMAT: don't mix pxm and nid when setting memory
target processor_pxm") in 5.5-rc1.

Thanks!




