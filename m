Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E348FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B545521537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1laPt4Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfENO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37292 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfENO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eNvhEe3BMTRaZ1fLMuDOKnrgYFbmEX60UqHNIxHZPnQ=; b=1laPt4YcsSByydA6OAeBTkdoPG
        GEisQedgcPbnTOnE5ITOdPgGqPKli8Fm3YkUxv1tV8/brlnLK2OkiCxHxD9S6n74I227kkS5b4KOS
        29QCup7DP9WooAOpTON1XnmqTFEazMGg/3uaC5Bi00d2r4I2G9XX9yNqSCL85MdCWGggxMFleqlge
        mU/pJXFircxoc2K4v3FLEXZyCWpxNLlx/fHs/NrNOYBvG+naStYkxQes3ysF+2hE1KPcQ7jLzJKQh
        8nJiJvZS4WAV3JAYWzDN1dVSR10p7E51BUWAMoR725GoJ4m95xyaUoay2f9G7322GHH+96j1vLU8W
        tNUbutLQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQYOS-0008LC-RO; Tue, 14 May 2019 14:27:01 +0000
Subject: Re: [RFC PATCH v3 11/21] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1557842534-4266-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <62576937-50fc-fded-784b-d691e455dfc1@infradead.org>
Date:   Tue, 14 May 2019 07:26:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557842534-4266-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/19 7:02 AM, Ricardo Neri wrote:
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index 15d0fbe27872..376a5db81aec 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -169,6 +169,17 @@ config IOMMU_LEAK
>  config HAVE_MMIOTRACE_SUPPORT
>  	def_bool y
>  
> +config X86_HARDLOCKUP_DETECTOR_HPET
> +	bool "Use HPET Timer for Hard Lockup Detection"
> +	select SOFTLOCKUP_DETECTOR
> +	select HARDLOCKUP_DETECTOR
> +	select HARDLOCKUP_DETECTOR_CORE
> +	depends on HPET_TIMER && HPET && X86_64
> +	help
> +	  Say y to enable a hardlockup detector that is driven by an High-

	                                                       by a

> +	  Precision Event Timer. This option is helpful to not use counters
> +	  from the Performance Monitoring Unit to drive the detector.
> +
>  config X86_DECODER_SELFTEST
>  	bool "x86 instruction decoder selftest"
>  	depends on DEBUG_KERNEL && KPROBES


-- 
~Randy
