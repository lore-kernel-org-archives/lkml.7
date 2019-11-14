Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DDAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A86206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfKNJHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:07:38 -0500
Received: from ozlabs.org ([203.11.71.1]:34503 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfKNJHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxM5mVHz9sNT; Thu, 14 Nov 2019 20:07:35 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4e706af3cd8e1d0503c25332b30cad33c97ed442
In-Reply-To: <20190502210907.42375-1-gwalbon@linux.ibm.com>
To:     Gustavo Walbon <gwalbon@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     mikey@neuling.org, maurosr@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        diana.craciun@nxp.com, paulus@samba.org, leitao@debian.org,
        msuchanek@suse.de, gwalbon@linux.vnet.ibm.com
Subject: Re: [PATCH] Fix wrong message when RFI Flush is disable
Message-Id: <47DFxM5mVHz9sNT@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:35 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-02 at 21:09:07 UTC, Gustavo Walbon wrote:
> From: "Gustavo L. F. Walbon" <gwalbon@linux.ibm.com>
> 
> The issue was showing "Mitigation" message via sysfs whatever the state of
> "RFI Flush", but it should show "Vulnerable" when it is disabled.
> 
> If you have "L1D private" feature enabled and not "RFI Flush" you are
> vulnerable to meltdown attacks.
> 
> "RFI Flush" is the key feature to mitigate the meltdown whatever the
> "L1D private" state.
> 
> SEC_FTR_L1D_THREAD_PRIV is a feature for Power9 only.
> 
> So the message should be as the truth table shows.
> CPU | L1D private | RFI Flush |                   sysfs               |
> ----| ----------- | --------- | ------------------------------------- |
>  P9 |    False    |   False   | Vulnerable
>  P9 |    False    |   True    | Mitigation: RFI Flush
>  P9 |    True     |   False   | Vulnerable: L1D private per thread
>  P9 |    True     |   True    | Mitigation: RFI Flush, L1D private per
>     |             |           | thread
>  P8 |    False    |   False   | Vulnerable
>  P8 |    False    |   True    | Mitigation: RFI Flush
> 
> Output before this fix:
>  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
>  Mitigation: RFI Flush, L1D private per thread
>  # echo 0 > /sys/kernel/debug/powerpc/rfi_flush
>  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
>  Mitigation: L1D private per thread
> 
> Output after fix:
>  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
>  Mitigation: RFI Flush, L1D private per thread
>  # echo 0 > /sys/kernel/debug/powerpc/rfi_flush
>  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
>  Vulnerable: L1D private per thread
> 
> Link: https://github.com/linuxppc/issues/issues/243
> 
> Signed-off-by: Gustavo L. F. Walbon <gwalbon@linux.ibm.com>
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4e706af3cd8e1d0503c25332b30cad33c97ed442

cheers
