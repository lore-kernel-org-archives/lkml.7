Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FACCC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7177420867
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfJDKw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:52:28 -0400
Received: from mout1.fh-giessen.de ([212.201.18.42]:50006 "EHLO
        mout1.fh-giessen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJDKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:52:27 -0400
X-Greylist: delayed 1068 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 06:52:26 EDT
Received: from mx3.fh-giessen.de ([212.201.18.28])
        by mout1.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
        id 1iGKuw-0000Qg-10; Fri, 04 Oct 2019 12:34:34 +0200
Received: from mailgate-2.its.fh-giessen.de ([212.201.18.14])
        by mx3.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
        id 1iGKuv-00F8NC-UG; Fri, 04 Oct 2019 12:34:33 +0200
Received: from p549d322d.dip0.t-ipconnect.de ([84.157.50.45] helo=zwei.fritz.box)
        by mailgate-2.its.fh-giessen.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
        id 1iGKuv-0000cY-Om; Fri, 04 Oct 2019 12:34:33 +0200
To:     kai.heng.feng@canonical.com, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
From:   Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Subject: e1000e regression - 5.4rc1
Cc:     tobias.klausmann@freenet.de
Message-ID: <171f0c61-73a2-81c2-5c8a-7c140f548803@mni.thm.de>
Date:   Fri, 4 Oct 2019 12:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:71.0) Gecko/20100101
 Thunderbird/71.0a1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

While testing the 5.4rc1 release, i noticed my Ethernet never coming 
fully up, seemingly having a timeout problem. While bisecting this i 
landed at the commit dee23594d587386e9fda76732aa5f5a487709510 ("e1000e: 
Make speed detection on hotplugging cable more reliable") as the first 
bad commit. And indeed just reverting the commit on top of 5.4rc1 
resolves the problem. Let me know if you have further questions, or 
patches to test!

Greetings,

Tobias


lspci:

00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network 
Connection (rev 06)
         DeviceName:  Onboard LAN
         Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 56
         Region 0: Memory at fbf00000 (32-bit, non-prefetchable) [size=128K]
         Region 1: Memory at fbf28000 (32-bit, non-prefetchable) [size=4K]
         Region 2: I/O ports at f040 [size=32]
         Capabilities: [c8] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 00000000fee00698  Data: 0000
         Capabilities: [e0] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: e1000e
         Kernel modules: e1000e

