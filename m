Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A522BC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83595207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfJBUa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:30:57 -0400
Received: from avon.wwwdotorg.org ([104.237.132.123]:44176 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBUa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:30:56 -0400
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 1D3BD1C00ED;
        Wed,  2 Oct 2019 14:30:55 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at avon.wwwdotorg.org
Subject: Re: [PATCH] arm64: tegra: only map accessible sysram
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org
References: <20190929200851.14228-1-ykaukab@suse.de>
 <5d2e47ec-8304-d648-9c4a-80c7c02050a9@wwwdotorg.org>
 <20190930100212.GA21324@suse.de>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <c7d64f56-cb44-cb3a-aa7a-ee7b5c01d6db@wwwdotorg.org>
Date:   Wed, 2 Oct 2019 14:30:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930100212.GA21324@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 4:02 AM, Mian Yousaf Kaukab wrote:
> On Sun, Sep 29, 2019 at 11:28:43PM -0600, Stephen Warren wrote:
>> On 9/29/19 2:08 PM, Mian Yousaf Kaukab wrote:
>>> Most of the SysRAM is secure and only accessible by TF-A.
>>> Don't map this inaccessible memory in kernel. Only map pages
>>> used by bpmp driver.
>>
>> I don't believe this change is correct. The actual patch doesn't
>> implement mapping a subset of the RAM (a software issue), but rather it
>> changes the DT representation of the SYSRAM hardware. The SYSRAM
>> hardware always does start at 0x30000000, even if a subset of the
>> address range is dedicated to a specific purpose. If the kernel must map
>> only part of the RAM, then some additional property should indicate
>> this.[...]
> I agree the hardware description becomes inaccurate with this change.
> 
> In the current setup complete 0x3000_0000 to 0x3005_0000 range is being mapped
> as normal memory (MT_NORMAL_NC). Though only 0x3004_E000 to 0x3005_0000 are
> accessible by the kernel.

Nit: I expect that a much larger region than that is *accessible*, 
although it's quite plausible that only that region is actually 
*accessed*/used right now.

> I am seeing an issue where a read access (which I
> believe is speculative) to inaccessible range causes an SError. Another
> solution for this problem could be to add "no-memory-wc" to SysRAM node so that
> it is mapped as device memory (MT_DEVICE_nGnRE). Would that be acceptable?

Why does the driver blindly map the entire memory at all? Surely it 
should only map the portions of RAM that other drivers request/use? And 
surely the BPMP driver or DT node is already providing that information?

But yes, changing the mapping type to avoid speculation might be an 
acceptable solution for now, although I think we'd want to work things 
out better later. I don't know if there would be any impact to the BPMP 
driver related to the slower SRAM access due to this change. Best 
consult a BPMP expert or Tegra maintainer about that.

>> [...] Also, I believe it's incorrect to hard-code into the kernel's DT
>> the range of addresses used by the secure monitor/OS, since this can
>> vary depending on what the user actually chooses to install as the
>> secure monitor/OS. Any indication of such regions should be filled in at
>> runtime by some boot firmware or the secure monitor/OS itself, or
>> retrieved using some runtime API rather than DT.
> Secure-OS addresses are not of interest here. SysRAM is partitioned
> between secure-OS and BPMP and kernel is only interested in the BPMP
> part. The firmware can update these addresses in the device-tree if it
> wants to. Would you prefer something similar implemented in u-boot so
> that it updates SysRAM node to only expose kernel accessible part of it
> to the kernel?
> 
> Can u-boot dynamically figure out the Secure-OS vs BPMP partition?
> 
> BR,
> Yousaf
> 

