Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154F1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA502171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDLPbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:31:07 -0400
Received: from foss.arm.com ([217.140.101.70]:34862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbfDLPbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:31:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DEF915AB;
        Fri, 12 Apr 2019 08:31:06 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB9503F557;
        Fri, 12 Apr 2019 08:31:05 -0700 (PDT)
Subject: Re: [v7 00/10] arm64: add system vulnerability sysfs entries
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2se.com,
        Andre.Przywara@arm.com, linux-kernel@vger.kernel.org
References: <20190410231237.52506-1-jeremy.linton@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <fbbbd716-044c-f916-c744-625c5cf3a3c9@arm.com>
Date:   Tue, 9 Apr 2019 19:48:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190410231237.52506-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has a bug, and I think i'm going to tweak patch 9 to drop the 
tristate (and default to a bool that is not vulnerable) since I ended up 
adding all those extra return checks to deal with the unresponsive 
firmware case.



On 4/10/19 6:12 PM, Jeremy Linton wrote:
> Arm64 machines should be displaying a human readable
> vulnerability status to speculative execution attacks in
> /sys/devices/system/cpu/vulnerabilities
> 
> This series enables that behavior by providing the expected
> functions. Those functions expose the cpu errata and feature
> states, as well as whether firmware is responding appropriately
> to display the overall machine status. This means that in a
> heterogeneous machine we will only claim the machine is mitigated
> or safe if we are confident all booted cores are safe or
> mitigated.
> 
> v6->v7: Invert ssb white/black list logic so that we only mark
> 	       cores in the whitelist not affected when the firmware
> 	       fails to respond. Removed reviewed/tested tags for
> 	       just patch 9 because of this.
> 
> v5->v6:
> 	Invert meltdown logic to display that a core is safe rather
> 	       than mitigated if the mitigation has been enabled on
> 	       machines that are safe. This can happen when the
> 	       mitigation was forced on via command line or KASLR.
> 	       This means that in order to detect if kpti is enabled
> 	       other methods must be used (look at dmesg) when the
> 	       machine isn't itself susceptible to meltdown.
> 	Trivial whitespace tweaks.
> 
> v4->v5:
> 	Revert the changes to remove the CONFIG_EXPERT hidden
> 	       options, but leave the detection paths building
> 	       without #ifdef wrappers. Also remove the
> 	       CONFIG_GENERIC_CPU_VULNERABILITIES #ifdefs
> 	       as we are 'select'ing the option in the Kconfig.
> 	       This allows us to keep all three variations of
> 	       the CONFIG/enable/disable paths without a lot of
> 	       (CONFIG_X || CONFIG_Y) checks.
> 	Various bits/pieces moved between the patches in an attempt
> 		to keep similar features/changes together.
> 
> v3->v4:
>          Drop the patch which selectivly exports sysfs entries
>          Remove the CONFIG_EXPERT hidden options which allowed
>                 the kernel to be built without the vulnerability
>                 detection code.
>          Pick Marc Z's patches which invert the white/black
>                 lists for spectrev2 and clean up the firmware
>                 detection logic.
>          Document the existing kpti controls
>          Add a nospectre_v2 option to boot time disable the
>               mitigation
> 
> v2->v3:
>          Remove "Unknown" states, replace with further blacklists
>                 and default vulnerable/not affected states.
>          Add the ability for an arch port to selectively export
>                 sysfs vulnerabilities.
> 
> v1->v2:
>          Add "Unknown" state to ABI/testing docs.
>          Minor tweaks.
> 
> Jeremy Linton (6):
>    arm64: Provide a command line to disable spectre_v2 mitigation
>    arm64: add sysfs vulnerability show for meltdown
>    arm64: Always enable spectrev2 vulnerability detection
>    arm64: add sysfs vulnerability show for spectre v2
>    arm64: Always enable ssb vulnerability detection
>    arm64: add sysfs vulnerability show for speculative store bypass
> 
> Marc Zyngier (2):
>    arm64: Advertise mitigation of Spectre-v2, or lack thereof
>    arm64: Use firmware to detect CPUs that are not affected by Spectre-v2
> 
> Mian Yousaf Kaukab (2):
>    arm64: add sysfs vulnerability show for spectre v1
>    arm64: enable generic CPU vulnerabilites support
> 
>   .../admin-guide/kernel-parameters.txt         |   8 +-
>   arch/arm64/Kconfig                            |   1 +
>   arch/arm64/include/asm/cpufeature.h           |   4 -
>   arch/arm64/kernel/cpu_errata.c                | 257 +++++++++++++-----
>   arch/arm64/kernel/cpufeature.c                |  58 +++-
>   5 files changed, 241 insertions(+), 87 deletions(-)
> 

