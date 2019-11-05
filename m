Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D42C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3D421929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XEUxt89i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfKEMDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:03:54 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9260 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbfKEMDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:03:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc1652d0000>; Tue, 05 Nov 2019 04:03:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Nov 2019 04:03:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Nov 2019 04:03:53 -0800
Received: from [10.26.11.93] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Nov
 2019 12:03:51 +0000
Subject: Re: [REGRESSION v5.3] SUNRPC: Replace the queue timer with a delayed
 work function (7e0a0e38fcfe)
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <271ff39f-1f44-b201-6274-85f1085bfc16@nvidia.com>
Message-ID: <329228f8-e194-a021-9226-69a9b6a403ce@nvidia.com>
Date:   Tue, 5 Nov 2019 12:03:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <271ff39f-1f44-b201-6274-85f1085bfc16@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572955438; bh=AZfLvetcKty1RUMhPBJVPXae796yrRpZVsA3ANb7qc8=;
        h=X-PGP-Universal:Subject:From:To:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XEUxt89iA1MfpqxryeY4mRpRa3HkNbFowEirE7A5fqMaiaYH/nhEk6TJwxjaUsZLO
         z0HHLfyzA9vsznwdyZQTPcAchJ6L3sv2axAvUD3DGV3h5GG+qyumIJM/ReQHQ88LM5
         rkLntd2V+Fz99XbD8iNXkdzpQyFYK2ikhgq1Yn9M/6LWZEkkiOZKZM7to/uuTGSJoo
         3zrTQS6H+tw5HTxpT18rkMl/f2RgmB4/nEdh78nVwoFKVXBWaFMMcieq8dMCEL0mHq
         rd4k/KzpCwsXmpvjA1MUsbbh/h11EKDeF5p3BY5sUTeiadahsUzDSMOv+17vOIYycC
         BAHZwcoY4FaJQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

Any feedback on this?

Jon

On 25/10/2019 08:28, Jon Hunter wrote:
> Hi Trond,
> 
> Similar to the change 431235818bc3 ("SUNRPC: Declare RPC timers as
> TIMER_DEFERRABLE") I have been tracking down another suspend/NFS related
> issue where again I am seeing random delays exiting suspend. The delays
> can be up to a couple minutes in the worst case and this is causing a
> suspend test we have to fail. For example, with this change I see ...
> 
> [  130.599520] PM: suspend entry (deep)
> 
> [  130.607267] Filesystems sync: 0.000 seconds
> 
> [  130.615800] Freezing user space processes ... (elapsed 0.001 seconds) done.
> 
> [  130.628247] OOM killer disabled.
> 
> [  130.635382] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> 
> [  130.648052] printk: Suspending console(s) (use no_console_suspend to debug)
> 
> [  130.686015] Disabling non-boot CPUs ...
> 
> [  130.689568] IRQ 17: no longer affine to CPU2
> 
> [  130.693435] Entering suspend state LP1
> 
> [  130.693489] Enabling non-boot CPUs ...
> 
> [  130.697108] CPU1 is up
> 
> [  130.700602] CPU2 is up
> 
> [  130.704338] CPU3 is up
> 
> [  130.781259] mmc1: queuing unknown CIS tuple 0x80 (50 bytes)
> 
> [  130.789742] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
> 
> [  130.792793] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
> 
> [  130.820913] mmc1: queuing unknown CIS tuple 0x02 (1 bytes)
> 
> [  131.345569] OOM killer enabled.
> 
> [  131.352643] Restarting tasks ... done.
> 
> [  131.365480] PM: suspend exit
> 
> [  134.524261] asix 1-1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1
> 
> [  243.745788] nfs: server 192.168.99.1 not responding, still trying
> 
> [  243.745811] nfs: server 192.168.99.1 not responding, still trying
> 
> [  243.767939] nfs: server 192.168.99.1 not responding, still trying
> 
> [  243.778233] nfs: server 192.168.99.1 OK
> 
> [  243.787058] nfs: server 192.168.99.1 OK
> 
> [  243.787542] nfs: server 192.168.99.1 OK
> 
> 
> Running a git bisect I was able to track it down to the commit referenced
> in the $subject. Reverting this on top of the current mainline fixes the
> problem and I no longer see these long delays.
> 
> Cheers
> Jon
> 

-- 
nvpublic
