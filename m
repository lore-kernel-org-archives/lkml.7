Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C071C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171E8222B2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfDPNtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:49:55 -0400
Received: from [195.159.176.226] ([195.159.176.226]:45046 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:49:55 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1hGOTB-000sqi-7H
        for linux-kernel@vger.kernel.org; Tue, 16 Apr 2019 15:49:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 4.9 64/76] parisc: Detect QEMU earlier in boot process
Date:   Tue, 16 Apr 2019 15:49:47 +0200
Message-ID: <26f36020-9c8f-0559-7692-56fe88f5f6c1@gmx.de>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183726.478117691@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Cc:     stable@vger.kernel.org
In-Reply-To: <20190415183726.478117691@linuxfoundation.org>
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

please do NOT apply this patch to the 4.9 tree.
See below, it was tagged for v4.14+ only.
It breaks the build on 4.9, I got a 0-day build bug about it.

Thanks,
Helge


On 15.04.19 20:44, Greg Kroah-Hartman wrote:
> From: Helge Deller <deller@gmx.de>
> 
> commit d006e95b5561f708d0385e9677ffe2c46f2ae345 upstream.
> 
> While adding LASI support to QEMU, I noticed that the QEMU detection in
> the kernel happens much too late. For example, when a LASI chip is found
> by the kernel, it registers the LASI LED driver as well.  But when we
> run on QEMU it makes sense to avoid spending unnecessary CPU cycles, so
> we need to access the running_on_QEMU flag earlier than before.
> 
> This patch now makes the QEMU detection the fist task of the Linux
> kernel by moving it to where the kernel enters the C-coding.
> 
> Fixes: 310d82784fb4 ("parisc: qemu idle sleep support")
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v4.14+
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  arch/parisc/kernel/process.c |    6 ------
>  arch/parisc/kernel/setup.c   |    3 +++
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -206,12 +206,6 @@ void __cpuidle arch_cpu_idle(void)
>  
>  static int __init parisc_idle_init(void)
>  {
> -	const char *marker;
> -
> -	/* check QEMU/SeaBIOS marker in PAGE0 */
> -	marker = (char *) &PAGE0->pad0;
> -	running_on_qemu = (memcmp(marker, "SeaBIOS", 8) == 0);
> -
>  	if (!running_on_qemu)
>  		cpu_idle_poll_ctrl(1);
>  
> --- a/arch/parisc/kernel/setup.c
> +++ b/arch/parisc/kernel/setup.c
> @@ -403,6 +403,9 @@ void start_parisc(void)
>  	int ret, cpunum;
>  	struct pdc_coproc_cfg coproc_cfg;
>  
> +	/* check QEMU/SeaBIOS marker in PAGE0 */
> +	running_on_qemu = (memcmp(&PAGE0->pad0, "SeaBIOS", 8) == 0);
> +
>  	cpunum = smp_processor_id();
>  
>  	set_firmware_width_unlocked();
> 
> 
> 


