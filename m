Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD62C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D6520645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfFXT5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:57:02 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:58495 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727282AbfFXT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:57:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1FD7F100E86C5;
        Mon, 24 Jun 2019 19:57:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fold16_1fd688a2af52b
X-Filterd-Recvd-Size: 2354
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 19:56:58 +0000 (UTC)
Message-ID: <c40261d18ff593767a026d0392d44f322b4a3b33.camel@perches.com>
Subject: Re: [PATCH v6 1/1] EDAC, mellanox: Add ECC support for BlueField
 DDR4
From:   Joe Perches <joe@perches.com>
To:     Shravan Kumar Ramani <sramani@mellanox.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 12:56:57 -0700
In-Reply-To: <176e13c80688f9a37161091e31ade487db6d4c2e.1561400421.git.sramani@mellanox.com>
References: <cover.1561400421.git.sramani@mellanox.com>
         <176e13c80688f9a37161091e31ade487db6d4c2e.1561400421.git.sramani@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 14:42 -0400, Shravan Kumar Ramani wrote:
> Add ECC support for Mellanox BlueField SoC DDR controller.
> This requires SMC to the running Arm Trusted Firmware to report
> what is the current memory configuration.
[]
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
[]
> @@ -0,0 +1,381 @@
[]
> +#define MLXBF_ECC_CNT__SERR_CNT_SHIFT 0
> +#define MLXBF_ECC_CNT__SERR_CNT_MASK 0xffff
> +#define MLXBF_ECC_CNT__DERR_CNT_SHIFT 16
> +#define MLXBF_ECC_CNT__DERR_CNT_MASK 0xffff

[multiple variants of #defines like the above]

[]

> +	serr = (dram_syndrom >> MLXBF_SYNDROM__SERR_SHIFT) &
> +		MLXBF_SYNDROM__SERR_MASK;
> +	derr = (dram_syndrom >> MLXBF_SYNDROM__DERR_SHIFT) &
> +		MLXBF_SYNDROM__DERR_MASK;
> +	syndrom = (dram_syndrom >> MLXBF_SYNDROM__SYN_SHIFT) &
> +		MLXBF_SYNDROM__SYN_MASK;

To improve readability and reduce possible copy/paste errors,
these would all benefit from a macro like

#define MLXBF_SM(val, type) 	\
	(((val) >> (MLXBF_ ## type ## _SHIFT)) & (MLXBF_ ## type ## _MASK)))

So these uses could become:

	serr = MLXBF_SM(dram_syndrom, SYNDROM__SERR);
	derr = MLXBF_SM(dram_syndrom, SYNDROM__DERR);
	syndrom =
MLXBF_SM(dram_syndrom, SYN);

etc...


