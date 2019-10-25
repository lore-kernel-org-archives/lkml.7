Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E358206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ehnPVjuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394254AbfJYH3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:29:01 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12073 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJYH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:29:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db2a4450000>; Fri, 25 Oct 2019 00:29:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Oct 2019 00:29:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Oct 2019 00:29:00 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Oct
 2019 07:29:00 +0000
Received: from [10.21.133.51] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 25 Oct
 2019 07:28:59 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: [REGRESSION v5.3] SUNRPC: Replace the queue timer with a delayed work
 function (7e0a0e38fcfe)
Message-ID: <271ff39f-1f44-b201-6274-85f1085bfc16@nvidia.com>
Date:   Fri, 25 Oct 2019 08:28:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571988549; bh=oA1xY6WGO+YbrmP0Bs3pvIsu3O7VlCxPiPqvKf8AA3A=;
        h=X-PGP-Universal:To:From:Subject:Message-ID:Date:User-Agent:
         MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Language:Content-Transfer-Encoding;
        b=ehnPVjuYCX8OWxsuuALJqjRf9gfryALS5XTI0uWyavaixJ4klOrGajRRy692X4YrO
         EtOOAzq7fNhanOpw8+0dNLRVeXjQS7QsfYXl9q1x+QDTzrTLkjz75BbaKC54aCDva2
         ey04zQ8VtJJrLFLDMGCbo03Vp0xlbTUKCiPSUj8IRY79+rlzq6WGx4JWHPbjBTeiee
         FTdZZVOSBNvwwb6vvc9QD1bBRsd5yuFl9XQGlOvWSMeCcM7GEMO9ArFvnB5IrV/Seh
         kligc3+ZGZH5S/6nNTjBJz9IYuKdU+xaU4acOwif2/datDMR81ckNX6XijDNnLO8+q
         /Cp4srDWGWJYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

Similar to the change 431235818bc3 ("SUNRPC: Declare RPC timers as
TIMER_DEFERRABLE") I have been tracking down another suspend/NFS related
issue where again I am seeing random delays exiting suspend. The delays
can be up to a couple minutes in the worst case and this is causing a
suspend test we have to fail. For example, with this change I see ...

[  130.599520] PM: suspend entry (deep)

[  130.607267] Filesystems sync: 0.000 seconds

[  130.615800] Freezing user space processes ... (elapsed 0.001 seconds) done.

[  130.628247] OOM killer disabled.

[  130.635382] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.

[  130.648052] printk: Suspending console(s) (use no_console_suspend to debug)

[  130.686015] Disabling non-boot CPUs ...

[  130.689568] IRQ 17: no longer affine to CPU2

[  130.693435] Entering suspend state LP1

[  130.693489] Enabling non-boot CPUs ...

[  130.697108] CPU1 is up

[  130.700602] CPU2 is up

[  130.704338] CPU3 is up

[  130.781259] mmc1: queuing unknown CIS tuple 0x80 (50 bytes)

[  130.789742] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)

[  130.792793] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)

[  130.820913] mmc1: queuing unknown CIS tuple 0x02 (1 bytes)

[  131.345569] OOM killer enabled.

[  131.352643] Restarting tasks ... done.

[  131.365480] PM: suspend exit

[  134.524261] asix 1-1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1

[  243.745788] nfs: server 192.168.99.1 not responding, still trying

[  243.745811] nfs: server 192.168.99.1 not responding, still trying

[  243.767939] nfs: server 192.168.99.1 not responding, still trying

[  243.778233] nfs: server 192.168.99.1 OK

[  243.787058] nfs: server 192.168.99.1 OK

[  243.787542] nfs: server 192.168.99.1 OK


Running a git bisect I was able to track it down to the commit referenced
in the $subject. Reverting this on top of the current mainline fixes the
problem and I no longer see these long delays.

Cheers
Jon

-- 
nvpublic
