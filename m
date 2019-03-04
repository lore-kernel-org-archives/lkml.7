Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F661C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755F62082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfCDKCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:02:16 -0500
Received: from foss.arm.com ([217.140.101.70]:59144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfCDKCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:02:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7733EEBD;
        Mon,  4 Mar 2019 02:02:15 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0F473F703;
        Mon,  4 Mar 2019 02:02:13 -0800 (PST)
Date:   Mon, 4 Mar 2019 10:02:08 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        Lorenzo.Pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ACPI/PPTT: Simplify leaf node detection.
Message-ID: <20190304100208.GA32379@e107155-lin>
References: <20190301185221.608501-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301185221.608501-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 12:52:21PM -0600, Jeremy Linton wrote:
> ACPI 6.3 bumps the PPTT table revision and adds a LEAF_NODE flag.
> This allows us to avoid a second pass through the table to assure
> that the node in question is a leaf.
>

Reviewed-by:Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index ad31c50de3be..065c4fc245d1 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -209,6 +209,9 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
>  	struct acpi_pptt_processor *cpu_node;
>  	u32 proc_sz;
>
> +	if (table_hdr->revision > 1)
> +		return (node->flags & ACPI_PPTT_ACPI_LEAF_NODE);
> +
>  	table_end = (unsigned long)table_hdr + table_hdr->length;
>  	node_entry = ACPI_PTR_DIFF(node, table_hdr);
>  	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
> --
> 2.20.1
>

