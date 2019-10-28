Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0377CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9941820679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfJ1HHM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:07:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53077 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbfJ1HHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:07:12 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iOz7N-0006al-7r
        for linux-kernel@vger.kernel.org; Mon, 28 Oct 2019 07:07:09 +0000
Received: by mail-pf1-f199.google.com with SMTP id l20so7878833pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jfQkmuDOTeTMav8WguTDuTWarriQw/T8WFB78g2eSdo=;
        b=uRWUsszDxl/8Y19gwIZhXdjQCHCC2MDE6wDtKORpJ13tLztXg2Ma7K39DE3eBOKNlX
         ELLCnbQSVddnkgCWK5D0AFV2IYegYUOqzUiGTTzkRPYYxKSXyFbHjmpSzUnK8oKRlQ4P
         ziOEhNeSrKsulyX+owBOWM6akIpbfZ+ePm5og6Y6puX7gykHSwc8GAwS6PPLw16gEmEO
         o/Ahav0ELJquK4vNRBUWcUIl94y7MmLv9w4MqNLIONWdHxnqc1u7NJwj90Mvd6M8lKlU
         2o6Fun/15QpBYHCdB+qZWX5dsCi6Sp/4/9+DJ/8bpTwUvwCzhKXmCTGLxfq/kwka1K4D
         8cTw==
X-Gm-Message-State: APjAAAXzWPGmyov1Z3u0va2KO+VkBGEU/fbY+2Ih/pILrL1pe3AnVYqf
        3Wz9GUSEN7QaDtISeWdbEg9p6dCLhPXn4twSMo9biHfwM9OStuZudtDsj0Wa54F6NFjKyyxEgdp
        xAN1T8zTetxDcz8qI0AbPTczYCREpxnlZhDID577CdQ==
X-Received: by 2002:a63:2f47:: with SMTP id v68mr19033523pgv.318.1572246427647;
        Mon, 28 Oct 2019 00:07:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxvGjAlrLKj/JoHnaALxY+Y3Db7Nsjp996m81JYS6jCJ9XPQyGYp8qXg4sxTYJKEh2DEwmc5A==
X-Received: by 2002:a63:2f47:: with SMTP id v68mr19033484pgv.318.1572246427128;
        Mon, 28 Oct 2019 00:07:07 -0700 (PDT)
Received: from 2001-b011-380f-3c42-74a9-e8b4-eac5-9609.dynamic-ip6.hinet.net (2001-b011-380f-3c42-74a9-e8b4-eac5-9609.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:74a9:e8b4:eac5:9609])
        by smtp.gmail.com with ESMTPSA id c12sm5351039pfp.178.2019.10.28.00.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 00:07:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601\))
Subject: Re: e1000e regression - 5.4rc1
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <940da657-a8af-ccde-34ca-7a93fad94567@mni.thm.de>
Date:   Mon, 28 Oct 2019 15:07:04 +0800
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org, tobias.klausmann@freenet.de
Content-Transfer-Encoding: 8BIT
Message-Id: <ADFA5FA0-ED36-4313-9CDD-602946FEBA67@canonical.com>
References: <171f0c61-73a2-81c2-5c8a-7c140f548803@mni.thm.de>
 <56242322-D549-4E23-97AB-153CC392B107@canonical.com>
 <76fc2204-0786-03b3-773d-110912d48168@mni.thm.de>
 <2994F2A2-D844-40B0-9971-C002E5EC49CD@canonical.com>
 <940da657-a8af-ccde-34ca-7a93fad94567@mni.thm.de>
To:     Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
X-Mailer: Apple Mail (2.3601)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

> On Oct 9, 2019, at 02:28, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
> 
> Hi,
> 
> On 08.10.19 09:46, Kai-Heng Feng wrote:
>> Hi Tobias,
>> 
>>> On Oct 5, 2019, at 03:52, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
>>> 
>>> Hello,
>>> 
>>> On 04.10.19 19:36, Kai-Heng Feng wrote:
>>>> Hi Tobias
>>>> 
>>>>> On Oct 4, 2019, at 18:34, Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de> wrote:
>>>>> 
>>>>> Hello all,
>>>>> 
>>>>> While testing the 5.4rc1 release, i noticed my Ethernet never coming fully up, seemingly having a timeout problem. While bisecting this i landed at the commit dee23594d587386e9fda76732aa5f5a487709510 ("e1000e: Make speed detection on hotplugging cable more reliable") as the first bad commit. And indeed just reverting the commit on top of 5.4rc1 resolves the problem. Let me know if you have further questions, or patches to test!
>>>> Is runtime PM enabled (i.e. "power/control" = auto)?
>>> 
>>> Yes it is set to auto.
>> Is something like TLP or `powertop --auto-tune` is in use?
>> 
>> Do you still see the issue when "power/control" keeps at "on"?
> 
> 
> With "power/control" set to "on" it does still cycle between up and down. But yes i have upower and powerdevil running. After killing them the connection comes up with "power/control" set to "on", yet not with "auto".

Can you please give this branch a try:
https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/log/?h=dev-queue

Kai-Heng

> 
> 
> Greetings,
> 
> Tobias
> 
> 
>> 
>> Kai-Heng
>> 
>>> 
>>>> Also please attach full dmesg, thanks!
>>> Attached,
>>> 
>>> Tobias
>>> 
>>>> Kai-Heng
>>>> 
>>>>> Greetings,
>>>>> 
>>>>> Tobias
>>>>> 
>>>>> 
>>>>> lspci:
>>>>> 
>>>>> 00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network Connection (rev 06)
>>>>>         DeviceName:  Onboard LAN
>>>>>         Subsystem: ASUSTeK Computer Inc. P8P67 Deluxe Motherboard
>>>>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>>>>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>>>         Latency: 0
>>>>>         Interrupt: pin A routed to IRQ 56
>>>>>         Region 0: Memory at fbf00000 (32-bit, non-prefetchable) [size=128K]
>>>>>         Region 1: Memory at fbf28000 (32-bit, non-prefetchable) [size=4K]
>>>>>         Region 2: I/O ports at f040 [size=32]
>>>>>         Capabilities: [c8] Power Management version 2
>>>>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>>>>>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>>>                 Address: 00000000fee00698  Data: 0000
>>>>>         Capabilities: [e0] PCI Advanced Features
>>>>>                 AFCap: TP+ FLR+
>>>>>                 AFCtrl: FLR-
>>>>>                 AFStatus: TP-
>>>>>         Kernel driver in use: e1000e
>>>>>         Kernel modules: e1000e
>>>>> 
>>> <dmesg.txt>

