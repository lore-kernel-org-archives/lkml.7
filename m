Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB13C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D4A215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfI3KCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbfI3KCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:02:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89203B157;
        Mon, 30 Sep 2019 10:02:19 +0000 (UTC)
Date:   Mon, 30 Sep 2019 12:02:12 +0200
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: only map accessible sysram
Message-ID: <20190930100212.GA21324@suse.de>
References: <20190929200851.14228-1-ykaukab@suse.de>
 <5d2e47ec-8304-d648-9c4a-80c7c02050a9@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d2e47ec-8304-d648-9c4a-80c7c02050a9@wwwdotorg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 11:28:43PM -0600, Stephen Warren wrote:
> On 9/29/19 2:08 PM, Mian Yousaf Kaukab wrote:
> > Most of the SysRAM is secure and only accessible by TF-A.
> > Don't map this inaccessible memory in kernel. Only map pages
> > used by bpmp driver.
> 
> I don't believe this change is correct. The actual patch doesn't
> implement mapping a subset of the RAM (a software issue), but rather it
> changes the DT representation of the SYSRAM hardware. The SYSRAM
> hardware always does start at 0x30000000, even if a subset of the
> address range is dedicated to a specific purpose. If the kernel must map
> only part of the RAM, then some additional property should indicate
> this.[...]
I agree the hardware description becomes inaccurate with this change.

In the current setup complete 0x3000_0000 to 0x3005_0000 range is being mapped
as normal memory (MT_NORMAL_NC). Though only 0x3004_E000 to 0x3005_0000 are
accessible by the kernel. I am seeing an issue where a read access (which I
believe is speculative) to inaccessible range causes an SError. Another 
solution for this problem could be to add "no-memory-wc" to SysRAM node so that
it is mapped as device memory (MT_DEVICE_nGnRE). Would that be acceptable?

> [...] Also, I believe it's incorrect to hard-code into the kernel's DT
> the range of addresses used by the secure monitor/OS, since this can
> vary depending on what the user actually chooses to install as the
> secure monitor/OS. Any indication of such regions should be filled in at
> runtime by some boot firmware or the secure monitor/OS itself, or
> retrieved using some runtime API rather than DT.
Secure-OS addresses are not of interest here. SysRAM is partitioned
between secure-OS and BPMP and kernel is only interested in the BPMP
part. The firmware can update these addresses in the device-tree if it
wants to. Would you prefer something similar implemented in u-boot so
that it updates SysRAM node to only expose kernel accessible part of it
to the kernel?

Can u-boot dynamically figure out the Secure-OS vs BPMP partition?

BR,
Yousaf
