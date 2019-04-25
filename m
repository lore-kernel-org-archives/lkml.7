Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC52C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB6B214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfDYKNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:13:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfDYKNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:13:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABA34374;
        Thu, 25 Apr 2019 03:13:42 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6DDD3F5C1;
        Thu, 25 Apr 2019 03:13:40 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:13:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, robh+dt@kernel.org, sachin.ghadi@sifive.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] RISC-V: Add DT documentation for SiFive L2 Cache
 Controller
Message-ID: <20190425101318.GA8469@e107155-lin>
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556171696-7741-2-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:24:55AM +0530, Yash Shah wrote:
> Add device tree bindings for SiFive FU540 L2 cache controller driver
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> new file mode 100644
> index 0000000..15132e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> @@ -0,0 +1,53 @@
> +SiFive L2 Cache Controller
> +--------------------------
> +The SiFive Level 2 Cache Controller is used to provide access to fast copies
> +of memory for masters in a Core Complex. The Level 2 Cache Controller also
> +acts as directory-based coherency manager.
> +
> +Required Properties:
> +--------------------
> +- compatible: Should be "sifive,fu540-c000-ccache"
> +
> +- cache-block-size: Specifies the block size in bytes of the cache
> +
> +- cache-level: Should be set to 2 for a level 2 cache
> +
> +- cache-sets: Specifies the number of associativity sets of the cache
> +
> +- cache-size: Specifies the size in bytes of the cache
> +
> +- cache-unified: Specifies the cache is a unified cache
> +
> +- interrupt-parent: Must be core interrupt controller
> +
> +- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
> +
> +- reg: Physical base address and size of L2 cache controller registers map
> +
> +- reg-names: Should be "control"
> +

It would be good if you mark the properties that are present in DT
specification and those that are added for sifive,fu540-c000-ccache
explicitly. Also I assume you can retain the stardard "cache" compatible
in addition to above. I am interested to see if the cacheinfo infrastructure
can be used without any issues.

--
Regards,
Sudeep
