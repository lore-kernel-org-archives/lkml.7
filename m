Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE20C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD1C2053B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfJDRgT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:36:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54892 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387509AbfJDRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:36:18 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iGRV2-0004GH-59
        for linux-kernel@vger.kernel.org; Fri, 04 Oct 2019 17:36:16 +0000
Received: by mail-pg1-f198.google.com with SMTP id m17so4765587pgh.21
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L3tfumWRZEtUR1PqVEP/89/GbIPwI6NtDxX+kDFfkU8=;
        b=nVmP5L+zOSscd4EyFktArO6n7/cMdJzxFqF42ZBOTP8Nt4WNsNhG1EJIEl6yyseXgT
         StlPyQSiQ+QthHMK8OsY/d6Yy9nx2Su22j4ogjPKnB9G5PX5qwN4OAQ75Nb/28jdtSiX
         iwLmjznrJPnQNQpjhWCRMolvaKjXs7Fmavk4OJ9sQ2MCRPESVlaRNcaHB9MvHGJTVCd5
         30Fq+bCZOD6F9kZ+lCOS0HZPq70HaHMEIjA3pBDv27ShN8Y0vkKmNTxJZLd2AzY4EXwn
         hxRLc3E7QaqG94qiDa+/mBHF7vdXvSog6X4rRFR3SBdotVQEScuFgV2oKZ1Qh1GMrRTu
         N+aA==
X-Gm-Message-State: APjAAAV3HS3/D/YjBhXNAhZg6aeAlnrHGFvUc26CpA/NDxVzYUxvkuzw
        EjkJn9iF1V2oHIaxvdNt5cX5xlWC8O3/8XSLw0FzyCFX+7gpM1hJgSdUFvGIqAY4c+JJE02I9j5
        c1suCgkEAsA4UKOn+x4zhDkosbd9Vp3/lbPm+qDC4Og==
X-Received: by 2002:a63:ca06:: with SMTP id n6mr16259159pgi.17.1570210574801;
        Fri, 04 Oct 2019 10:36:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzmvTxnFf7austvnOxYDw8RbmtlxccNk38ggjAtesz64RktW0dvAfQaQKXsIYJPA4nZdhpfA==
X-Received: by 2002:a63:ca06:: with SMTP id n6mr16259081pgi.17.1570210573861;
        Fri, 04 Oct 2019 10:36:13 -0700 (PDT)
Received: from 2001-b011-380f-3c42-9827-fbc1-5efc-0e00.dynamic-ip6.hinet.net (2001-b011-380f-3c42-9827-fbc1-5efc-0e00.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:9827:fbc1:5efc:e00])
        by smtp.gmail.com with ESMTPSA id 20sm5679277pgo.27.2019.10.04.10.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 10:36:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.18\))
Subject: Re: e1000e regression - 5.4rc1
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <171f0c61-73a2-81c2-5c8a-7c140f548803@mni.thm.de>
Date:   Sat, 5 Oct 2019 01:36:09 +0800
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org, tobias.klausmann@freenet.de
Content-Transfer-Encoding: 8BIT
Message-Id: <56242322-D549-4E23-97AB-153CC392B107@canonical.com>
References: <171f0c61-73a2-81c2-5c8a-7c140f548803@mni.thm.de>
To:     Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
X-Mailer: Apple Mail (2.3594.4.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias

> On Oct 4, 2019, at 18:34, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
> 
> Hello all,
> 
> While testing the 5.4rc1 release, i noticed my Ethernet never coming fully up, seemingly having a timeout problem. While bisecting this i landed at the commit dee23594d587386e9fda76732aa5f5a487709510 ("e1000e: Make speed detection on hotplugging cable more reliable") as the first bad commit. And indeed just reverting the commit on top of 5.4rc1 resolves the problem. Let me know if you have further questions, or patches to test!

Is runtime PM enabled (i.e. "power/control" = auto)?
Also please attach full dmesg, thanks!

Kai-Heng 

> 
> Greetings,
> 
> Tobias
> 
> 
> lspci:
> 
> 00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network Connection (rev 06)
>         DeviceName:  Onboard LAN
>         Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 56
>         Region 0: Memory at fbf00000 (32-bit, non-prefetchable) [size=128K]
>         Region 1: Memory at fbf28000 (32-bit, non-prefetchable) [size=4K]
>         Region 2: I/O ports at f040 [size=32]
>         Capabilities: [c8] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee00698  Data: 0000
>         Capabilities: [e0] PCI Advanced Features
>                 AFCap: TP+ FLR+
>                 AFCtrl: FLR-
>                 AFStatus: TP-
>         Kernel driver in use: e1000e
>         Kernel modules: e1000e
> 

