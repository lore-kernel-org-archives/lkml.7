Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88530C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D06820679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564514540;
	bh=8Mp1ZpFhLYa4PCKDKvKs2UH6Ndtv2RBDlqpJAwfjEkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O0Lwuq8m93AG4EMvkNPs80NPh6enrQ1PnNUK5bQeKQ/9FgkqUYPQ74KscU8QCfUx8
	 fqt0dWpBHDgJ0V0NMR1igb8MZG4wywHO739hDtHV3s1HBmBoepNTjYvyHTozhoMh1G
	 fj4j/CNbXXXN7J/4i3UsUPXAJgaAR4oU0FrIm4D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbfG3TWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:22:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:43559 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387863AbfG3TWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:22:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 12:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="173805048"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2019 12:22:17 -0700
Date:   Tue, 30 Jul 2019 13:19:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mario.Limonciello@dell.com, rjw@rjwysocki.net,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatja@google.com
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Message-ID: <20190730191934.GD13948@localhost.localdomain>
References: <2332799.izEFUvJP67@kreacher>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher>
 <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:50:01AM +0800, Kai-Heng Feng wrote:
> 
> Just did a quick test, this patch regress SK Hynix BC501, the SoC stays at
> PC3 once the patch is applied.

Okay, I'm afraid device/platform quirks may be required unless there are
any other ideas out there.

I'm not a big fan of adding more params to this driver. Those are
global to the module, so that couldn't really handle a platform with
two different devices that want different behavior.
