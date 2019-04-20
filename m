Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF80C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECFA2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfDTKRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:17:23 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:60663 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:17:23 -0400
Received: from bootlin.com (lfbn-tou-1-417-253.w86-206.abo.wanadoo.fr [86.206.242.253])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id ADD6A10000B;
        Sat, 20 Apr 2019 10:17:14 +0000 (UTC)
Date:   Sat, 20 Apr 2019 12:17:14 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: mvpp2: cls: Add Classification offload
 support
Message-ID: <20190420121714.387f160b@bootlin.com>
In-Reply-To: <20190419.150950.1875022930637674395.davem@davemloft.net>
References: <20190419133027.8012-1-maxime.chevallier@bootlin.com>
        <20190419.150950.1875022930637674395.davem@davemloft.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, 19 Apr 2019 15:09:50 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

>From: Maxime Chevallier <maxime.chevallier@bootlin.com>
>Date: Fri, 19 Apr 2019 15:30:27 +0200
>
>> +/* Internal represention of a Flow Steering rule */
>> +struct mvpp2_rfs_rule {
>> +	/* Rule location inside the flow*/
>> +	int loc;
>> +
>> +	/* Flow type, such as TCP_V4_FLOW, IP6_FLOW, etc. */
>> +	int flow_type;
>> +
>> +	/* The lookup type used by this flow. This allows the classification
>> +	 * engines to differentiate between entries that match the same
>> +	 * parameters
>> +	 */
>> +	int lu_type;
>> +
>> +	/* Index of the entry handling this rule in the flow table */
>> +	int flt_index;
>> +
>> +	/* Index of the C2 TCAM entry handling this rule */
>> +	int c2_index;  
>
>On 64-bit there will be a 32-bit hole here.  Why not put hek_fields
>and engine here?

You're right, I'll re-arrange that.

Thanks,

Maxime

