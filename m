Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66159C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3364E217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfDSWJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:09:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36114 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfDSWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:09:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 785BB14D9DAB9;
        Fri, 19 Apr 2019 15:09:51 -0700 (PDT)
Date:   Fri, 19 Apr 2019 15:09:50 -0700 (PDT)
Message-Id: <20190419.150950.1875022930637674395.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: mvpp2: cls: Add Classification offload
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190419133027.8012-1-maxime.chevallier@bootlin.com>
References: <20190419133027.8012-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Apr 2019 15:09:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 19 Apr 2019 15:30:27 +0200

> +/* Internal represention of a Flow Steering rule */
> +struct mvpp2_rfs_rule {
> +	/* Rule location inside the flow*/
> +	int loc;
> +
> +	/* Flow type, such as TCP_V4_FLOW, IP6_FLOW, etc. */
> +	int flow_type;
> +
> +	/* The lookup type used by this flow. This allows the classification
> +	 * engines to differentiate between entries that match the same
> +	 * parameters
> +	 */
> +	int lu_type;
> +
> +	/* Index of the entry handling this rule in the flow table */
> +	int flt_index;
> +
> +	/* Index of the C2 TCAM entry handling this rule */
> +	int c2_index;

On 64-bit there will be a 32-bit hole here.  Why not put hek_fields
and engine here?
