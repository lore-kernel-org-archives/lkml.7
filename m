Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1032C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F6214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfCLJdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:33:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58971 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfCLJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:33:45 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 1498e6cd187dbb19; Tue, 12 Mar 2019 10:33:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-acpi@vger.kernel.org, lenb@kernel.org,
        Lorenzo.Pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/PPTT: Simplify leaf node detection.
Date:   Tue, 12 Mar 2019 10:31:59 +0100
Message-ID: <3893217.oT7ovuD9xH@aspire.rjw.lan>
In-Reply-To: <20190304100208.GA32379@e107155-lin>
References: <20190301185221.608501-1-jeremy.linton@arm.com> <20190304100208.GA32379@e107155-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 4, 2019 11:02:08 AM CET Sudeep Holla wrote:
> On Fri, Mar 01, 2019 at 12:52:21PM -0600, Jeremy Linton wrote:
> > ACPI 6.3 bumps the PPTT table revision and adds a LEAF_NODE flag.
> > This allows us to avoid a second pass through the table to assure
> > that the node in question is a leaf.
> >
> 
> Reviewed-by:Sudeep Holla <sudeep.holla@arm.com>
> 
> --
> Regards,
> Sudeep
> 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  drivers/acpi/pptt.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index ad31c50de3be..065c4fc245d1 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -209,6 +209,9 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
> >  	struct acpi_pptt_processor *cpu_node;
> >  	u32 proc_sz;
> >
> > +	if (table_hdr->revision > 1)
> > +		return (node->flags & ACPI_PPTT_ACPI_LEAF_NODE);
> > +
> >  	table_end = (unsigned long)table_hdr + table_hdr->length;
> >  	node_entry = ACPI_PTR_DIFF(node, table_hdr);
> >  	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> > --

Patch applied, thanks!

