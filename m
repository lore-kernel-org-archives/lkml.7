Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4112C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9294B20867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfJHHqT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:46:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47227 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfJHHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:46:19 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iHkCH-0003Xt-7r
        for linux-kernel@vger.kernel.org; Tue, 08 Oct 2019 07:46:17 +0000
Received: by mail-pg1-f200.google.com with SMTP id h36so12022470pgb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PjByk3+qcqmoyRROOKSgncBpIurhIbIveg7FM/NtDSE=;
        b=E8uFk5B7fQkoPRinbautV0P1X60KC+2YjNkSMEpHCwiUfv2WkbKdH+9jUqmSYe8+av
         Q0BHUPIBuuFlvjCL6p8qJl9TQsiQAnQdUrmqMgijrTbQNk0/KuNVkCloFxzV3Zlsn/KA
         imYVbbivji14hMnsFYm5FUxWTVO7JxFspSE7O1IlslAGO0BLg39S4GVoDovozL3jpuNJ
         Us3reC/N1zRMdrjAUmYaW5EYSnorWx+fmW48oeVFXxFqbU5AG36EJ1GCQ5V9UPswkqE1
         qUno/8W7MFoPgmaEeR0ZjcDpXrv4Lc3Hbtbo/ay1MGYeDxzD+N32L6rr8iA5NO7BPaFm
         EmLQ==
X-Gm-Message-State: APjAAAWlUKzPnfBB/vdxi1GiHVU/s3QyUs4X+k31t/KTC/yI81SGZIHp
        WrZv+eO82dXxYI8UxQaGfSZp/e/JhuMNNcoXr6hZmls0hs7fSRv8uxLvBXD1NjKoFga0mVvBpFO
        DjW3gZ8Brq55EvDXPIXx7nkcfAgGxe52jUK0XdMDrcg==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr34613202plt.282.1570520775639;
        Tue, 08 Oct 2019 00:46:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxq2z9TPA04cnVKcnWKfwfTy6uh7Pdgkh/eovRcCG7IjF5fS2tihcKdlwsRnNokM3dRcqpmqQ==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr34613177plt.282.1570520775239;
        Tue, 08 Oct 2019 00:46:15 -0700 (PDT)
Received: from 2001-b011-380f-3c42-1138-6cd0-3dc6-cfa2.dynamic-ip6.hinet.net (2001-b011-380f-3c42-1138-6cd0-3dc6-cfa2.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:1138:6cd0:3dc6:cfa2])
        by smtp.gmail.com with ESMTPSA id f3sm15041747pgj.62.2019.10.08.00.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 00:46:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: e1000e regression - 5.4rc1
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <76fc2204-0786-03b3-773d-110912d48168@mni.thm.de>
Date:   Tue, 8 Oct 2019 15:46:10 +0800
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org, tobias.klausmann@freenet.de
Content-Transfer-Encoding: 8BIT
Message-Id: <2994F2A2-D844-40B0-9971-C002E5EC49CD@canonical.com>
References: <171f0c61-73a2-81c2-5c8a-7c140f548803@mni.thm.de>
 <56242322-D549-4E23-97AB-153CC392B107@canonical.com>
 <76fc2204-0786-03b3-773d-110912d48168@mni.thm.de>
To:     Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

> On Oct 5, 2019, at 03:52, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
> 
> Hello,
> 
> On 04.10.19 19:36, Kai-Heng Feng wrote:
>> Hi Tobias
>> 
>>> On Oct 4, 2019, at 18:34, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
>>> 
>>> Hello all,
>>> 
>>> While testing the 5.4rc1 release, i noticed my Ethernet never coming fully up, seemingly having a timeout problem. While bisecting this i landed at the commit dee23594d587386e9fda76732aa5f5a487709510 ("e1000e: Make speed detection on hotplugging cable more reliable") as the first bad commit. And indeed just reverting the commit on top of 5.4rc1 resolves the problem. Let me know if you have further questions, or patches to test!
>> Is runtime PM enabled (i.e. "power/control" = auto)?
> 
> 
> Yes it is set to auto.

Is something like TLP or `powertop --auto-tune` is in use?

Do you still see the issue when "power/control" keeps at "on"?

Kai-Heng

> 
> 
>> Also please attach full dmesg, thanks!
> 
> Attached,
> 
> Tobias
> 
>> 
>> Kai-Heng
>> 
>>> Greetings,
>>> 
>>> Tobias
>>> 
>>> 
>>> lspci:
>>> 
>>> 00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network Connection (rev 06)
>>>         DeviceName:  Onboard LAN
>>>         Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
>>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>         Latency: 0
>>>         Interrupt: pin A routed to IRQ 56
>>>         Region 0: Memory at fbf00000 (32-bit, non-prefetchable) [size=128K]
>>>         Region 1: Memory at fbf28000 (32-bit, non-prefetchable) [size=4K]
>>>         Region 2: I/O ports at f040 [size=32]
>>>         Capabilities: [c8] Power Management version 2
>>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>>>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>                 Address: 00000000fee00698  Data: 0000
>>>         Capabilities: [e0] PCI Advanced Features
>>>                 AFCap: TP+ FLR+
>>>                 AFCtrl: FLR-
>>>                 AFStatus: TP-
>>>         Kernel driver in use: e1000e
>>>         Kernel modules: e1000e
>>> 
> <dmesg.txt>

