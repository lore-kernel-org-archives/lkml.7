Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08319C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9321734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfC0TUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:20:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388208AbfC0TUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:20:03 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9E5e-0007cz-0l; Wed, 27 Mar 2019 20:19:58 +0100
Date:   Wed, 27 Mar 2019 20:19:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v4 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
In-Reply-To: <20190325163410.171021-2-Yazen.Ghannam@amd.com>
Message-ID: <alpine.DEB.2.21.1903272019190.1789@nanos.tec.linutronix.de>
References: <20190325163410.171021-1-Yazen.Ghannam@amd.com> <20190325163410.171021-2-Yazen.Ghannam@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Mar 2019, Ghannam, Yazen wrote:

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> AMD Family 17h Models 10h-2Fh may report a high number of L1 BTB MCA
> errors under certain conditions. The errors are benign and can safely be
> ignored. However, the high error rate may cause the MCA threshold
> counter to overflow causing a high rate of thresholding interrupts. In
> addition, users may see the errors reported through the AMD MCE decoder
> module, even with the interrupt disabled, due to MCA polling.
> 
> This error is reported through the Instruction Fetch bank.
> 
> Clear the "Counter Present" bit in the Instruction Fetch bank's
> MCA_MISC0 register. This will prevent enabling MCA thresholding on this
> bank which will prevent the high interrupt rate due to this error.
> 
> Define an AMD-specific function to filter these errors from the MCE
> event pool.
> 
> Rename filter function in EDAC/mce_amd to avoid a naming conflict.
> 
> Cc: <stable@vger.kernel.org> # 5.0.x: c95b323dcd35: x86/MCE/AMD: Turn off MC4_MISC thresholding on all family 0x15 models

What is this supposed to tell us?

> Cc: <stable@vger.kernel.org> # 5.0.x: 30aa3d26edb0: x86/MCE/AMD: Carve out the MC4_MISC thresholding quirk
> Cc: <stable@vger.kernel.org> # 5.0.x: 9308fd407455: x86/MCE: Group AMD function prototypes in <asm/mce.h>
> Cc: <stable@vger.kernel.org> # 5.0.x

Confused.

Thanks,

	tglx
