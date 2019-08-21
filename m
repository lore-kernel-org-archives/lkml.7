Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B5AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B17622CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfHUSwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:52:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56883 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfHUSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:52:06 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0Vi8-0003VO-TM; Wed, 21 Aug 2019 20:51:57 +0200
Date:   Wed, 21 Aug 2019 20:51:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Hubbard <jhubbard@nvidia.com>
cc:     Neil MacLeod <neil@nmacleod.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org
Subject: Re: Boot failure due to: x86/boot: Save fields explicitly, zero out
 everything else
In-Reply-To: <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com>
Message-ID: <alpine.DEB.2.21.1908212047140.1983@nanos.tec.linutronix.de>
References: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com> <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com>
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

On Wed, 21 Aug 2019, John Hubbard wrote:
> On 8/21/19 10:05 AM, Neil MacLeod wrote:
> static void sanitize_boot_params(struct boot_params *boot_params)
> {
> ...
> 		const struct boot_params_to_save to_save[] = {
> 			BOOT_PARAM_PRESERVE(screen_info),
> 			BOOT_PARAM_PRESERVE(apm_bios_info),
> 			BOOT_PARAM_PRESERVE(tboot_addr),
> 			BOOT_PARAM_PRESERVE(ist_info),
> 			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
> 			BOOT_PARAM_PRESERVE(hd0_info),
> 			BOOT_PARAM_PRESERVE(hd1_info),
> 			BOOT_PARAM_PRESERVE(sys_desc_table),
> 			BOOT_PARAM_PRESERVE(olpc_ofw_header),
> 			BOOT_PARAM_PRESERVE(efi_info),
> 			BOOT_PARAM_PRESERVE(alt_mem_k),
> 			BOOT_PARAM_PRESERVE(scratch),
> 			BOOT_PARAM_PRESERVE(e820_entries),
> 			BOOT_PARAM_PRESERVE(eddbuf_entries),
> 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
> 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
> 			BOOT_PARAM_PRESERVE(e820_table),
> 			BOOT_PARAM_PRESERVE(eddbuf),
> 		};

I think I spotted it:

-               boot_params->acpi_rsdp_addr = 0;

+ 			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),

And it does not preserve 'hdr'

Grr. I surely was too tired when staring at this last time.

Thanks,

	tglx
