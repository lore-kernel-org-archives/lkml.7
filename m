Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05A5C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB56D214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfDYKSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:18:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbfDYKSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:18:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C30B374;
        Thu, 25 Apr 2019 03:18:02 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 678453F5C1;
        Thu, 25 Apr 2019 03:18:00 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:17:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, robh+dt@kernel.org, sachin.ghadi@sifive.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] RISC-V: sifive_l2_cache: Add L2 cache controller
 driver for SiFive SoCs
Message-ID: <20190425101757.GB8469@e107155-lin>
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556171696-7741-3-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:24:56AM +0530, Yash Shah wrote:
> The driver currently supports only SiFive FU540-C000 platform.
> 
> The initial version of L2 cache controller driver includes:
> - Initial configuration reporting at boot up.
> - Support for ECC related functionality.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

[....]

> +static const struct file_operations l2_fops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.write = l2_write
> +};
> +
> +static void setup_sifive_debug(void)
> +{
> +	sifive_test = debugfs_create_dir("sifive_l2_cache", NULL);
> +	if (!sifive_test)

Drop the conditional check above, Greg K H removed lots of them recently.
In his words: When calling debugfs functions, there is no need to ever
check the return value.  The function can work or not, but the code
logic should never do something different based on this.

He may not like to see this :)

> +		return;
> +
> +	if (!debugfs_create_file("sifive_debug_inject_error", 0200,
> +				 sifive_test, NULL, &l2_fops))

Ditto.

> +		debugfs_remove_recursive(sifive_test);
> +}

--
Regards,
Sudeep
