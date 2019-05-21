Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F805C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137B9217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmmRM6me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfEUUDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:03:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45088 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfEUUDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:03:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so19944102wrq.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Ex9Xmtyry1B30bkYQ4vO9WZfzc7CXwAhzSIGMRlg0E=;
        b=tmmRM6mesK3WnsAtWxTmwCYQuCdVR6TiMu+Hl7vHCjVHgliuq6zHTwCWN/HLiSah+P
         1h2Hyjn5tOua/KMjdFPZjwY8MZU9hsoQkbYBdzvhdyKPUuBgLJYcE+Ffg6IrCTvtSjax
         wjyDZPJQzlJq5MzhunBkxgnL2/DwWj3FsPBZtFgMlEZHcIJxMLcbT18qcpqunGy9yOsX
         V1dHYEOkkzhvO9pQ/Gy4zlrf7bUNvty/Azc6ZaOqqJgrYXE5cHdZ2cUkwyTCONNlNcQd
         bVkKkfdHTqAIaSV/Y+iKpzlRiv5ULV0D6fFZ49Lg9b1KwAWcX8fO3GiwCDmFddKQTmhb
         V/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Ex9Xmtyry1B30bkYQ4vO9WZfzc7CXwAhzSIGMRlg0E=;
        b=BScCfsjyl/R6nux7nQ9nPWlmBnJvBA0ZQJr4sj9b6lKn1L312V4pXBB5ga/Bmskn1R
         fJB50MncvbK0fELmpcYH8r14nIG2JbJ+tqZPSTNlXtPpTExbTETPQi3HSQa0wf4w/mQ+
         INqoeBZ8QzbwM5nqjTTYDZOFeG53lNfZPL4RReASqbPKGeORXZZdAgOgb7/06I9bldrl
         7NXa62+xI9qT0jisQhrx4ZGr0mYYM857D8fVbvANI5rxtd1BL0myzlvc4BB+mp1bhAQ5
         ClYBKQfAOI1w3WJ8qXHbsXOyubWU/V8cVNncRV84Og4zHtSokpjHke5azaPFdAx2tsgv
         ayUg==
X-Gm-Message-State: APjAAAX2u0FOCgtM35lP/0RGqs+8AbZFQ2I6hnhgunPrCi28kLvYdcOx
        VbUJSuZhdSAN5ufv5RLxjChEMIx0AzEGIRb0pVPB
X-Google-Smtp-Source: APXvYqxaXQ8mKdIQzLmvQZerTUP9gU54q8ICGaY+qmIZSG18YioYhaJp6EVmw3iXRVnunE2clrRu+ebCdY3w1qR2USg=
X-Received: by 2002:adf:d4c8:: with SMTP id w8mr18285717wrk.2.1558468990356;
 Tue, 21 May 2019 13:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <B5B745A3-96B4-46ED-8F3F-D3636A96057F@marvell.com>
In-Reply-To: <B5B745A3-96B4-46ED-8F3F-D3636A96057F@marvell.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 21 May 2019 15:02:57 -0500
Message-ID: <CAErSpo5qy6WuUe9cz1vTBBnc5P_uZaPzc-Yqbag2eBBxzi+ENg@mail.gmail.com>
Subject: Re: VPD access Blocked by commit 0d5370d1d85251e5893ab7c90a429464de2e140b
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     "ethan.zhao@oracle.com" <ethan.zhao@oracle.com>,
        Andrew Vasquez <andrewv@marvell.com>,
        Girish Basrur <gbasrur@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        Myron Stowe <mstowe@redhat.com>, linux-pci@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quinn Tran <quinn.tran@qlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Myron, Quinn, linux-pci, linux-kernel]

From: Himanshu Madhani <hmadhani@marvell.com>
Date: Fri, May 17, 2019 at 5:21 PM
To: ethan.zhao@oracle.com, bhelgaas@google.com
Cc: Andrew Vasquez, Girish Basrur, Giridhar Malavali

> Hi Ethan,
>
> Our OEM partners reported to us that VPD access with latest distros were =
returning I/O error for them. They indicated this to be issue only with new=
er kernels.
>
> One of the distro vendor pointed out patch posted by you to be reason for=
 IO error trying to VPD. The patch looks like blocks access to VPD by black=
listing ISP.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0d5370d1d85251e5893ab7c90a429464de2e140b=EF=BB=BF
>
> I setup PCIe analyzer to reproduce this in our lab to root cause it and d=
iscovered that after reverting the patch.  I am able to get VPD data okay w=
ith upstream 5.1.0 and I used RHEL8.
>
> I also used  "lspci" and "cat" to dump out VPD data and do not see any is=
sue.
>
> # lspci -vvv -s 03:00.0
> 03:00.0 Fibre Channel: QLogic Corp. ISP2722-based 16/32Gb Fibre Channel t=
o PCIe Adapter (rev 01)
>                 Subsystem: QLogic Corp. QLE2742 Dual Port 32Gb Fibre Chan=
nel to PCIe Adapter
>                 Physical Slot: 15
>                 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoo=
p- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>                 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >=
TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>                 Latency: 0, Cache Line Size: 64 bytes
>                 Interrupt: pin A routed to IRQ 67
>                 NUMA node: 0
>                 Region 0: Memory at fbe05000 (64-bit, prefetchable) [size=
=3D4K]
>                 Region 2: Memory at fbe02000 (64-bit, prefetchable) [size=
=3D8K]
>                 Region 4: Memory at fbd00000 (64-bit, prefetchable) [size=
=3D1M]
>                 Expansion ROM at fb540000 [disabled] [size=3D256K]
>                 Capabilities: [44] Power Management version 3
>                                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D=
0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D=
0 DScale=3D0 PME-
>                 Capabilities: [4c] Express (v2) Endpoint, MSI 00
>                                 DevCap:                MaxPayload 2048 by=
tes, PhantFunc 0, Latency L0s <4us, L1 <1us
>                                                 ExtTag- AttnBtn- AttnInd-=
 PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
>                                 DevCtl:  Report errors: Correctable+ Non-=
Fatal+ Fatal+ Unsupported+
>                                                 RlxdOrd- ExtTag- PhantFun=
c- AuxPwr- NoSnoop+ FLReset-
>                                                 MaxPayload 256 bytes, Max=
ReadReq 4096 bytes
>                                 DevSta: CorrErr+ UncorrErr- FatalErr- Uns=
uppReq+ AuxPwr- TransPend-
>                                 LnkCap: Port #0, Speed 8GT/s, Width x8, A=
SPM L0s L1, Exit Latency L0s <512ns, L1 <2us
>                                                 ClockPM- Surprise- LLActR=
ep- BwNot- ASPMOptComp+
>                                 LnkCtl:  ASPM Disabled; RCB 64 bytes Disa=
bled- CommClk+
>                                                 ExtSynch- ClockPM- AutWid=
Dis- BWInt- AutBWInt-
>                                 LnkSta:  Speed 8GT/s, Width x8, TrErr- Tr=
ain- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                                 DevCap2: Completion Timeout: Range B, Tim=
eoutDis+, LTR-, OBFF Not Supported
>                                                 AtomicOpsCap: 32bit- 64bi=
t- 128bitCAS-
>                                 DevCtl2: Completion Timeout: 50us to 50ms=
, TimeoutDis-, LTR-, OBFF Disabled
>                                                 AtomicOpsCtl: ReqEn-
>                                 LnkCtl2: Target Link Speed: 8GT/s, EnterC=
ompliance- SpeedDis-
>                                                 Transmit Margin: Normal O=
perating Range, EnterModifiedCompliance- ComplianceSOS-
>                                                 Compliance De-emphasis: -=
6dB
>                                 LnkSta2: Current De-emphasis Level: -6dB,=
 EqualizationComplete+, EqualizationPhase1+
>                                                 EqualizationPhase2+, Equa=
lizationPhase3+, LinkEqualizationRequest-
>                 Capabilities: [88] Vital Product Data
>                                 Product Name: QLogic 32Gb 2-port FC to PC=
Ie Gen3 x8 Adapter
>                                 Read-only fields:
>                                                 [PN] Part number: QLE2742
>                                                 [SN] Serial number: RFD17=
06R22611
>                                                 [EC] Engineering changes:=
 BK3210408-05 04
>                                                 [V9] Vendor specific: 010=
189
>                                                 [RV] Reserved: checksum g=
ood, 0 byte(s) reserved
>                                 End
>                 Capabilities: [90] MSI-X: Enable+ Count=3D16 Masked-
>                                 Vector table: BAR=3D2 offset=3D00000000
>                                 PBA: BAR=3D2 offset=3D00001000
>                 Capabilities: [9c] Vendor Specific Information: Len=3D0c =
<?>
>                 Capabilities: [100 v1] Advanced Error Reporting
>                                 UESta:   DLP- SDES- TLP- FCP- CmpltTO- Cm=
pltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                                 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- Cmpl=
tAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- Cmp=
ltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                                 CESta:   RxErr- BadTLP- BadDLLP- Rollover=
- Timeout- NonFatalErr-
>                                 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- =
Timeout- NonFatalErr+
>                                 AERCap:               First Error Pointer=
: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                                                 MultHdrRecCap- MultHdrRec=
En- TLPPfxPres- HdrLogCap-
>                                 HeaderLog: 00000000 00000000 00000000 000=
00000
>                 Capabilities: [154 v1] Alternative Routing-ID Interpretat=
ion (ARI)
>                                 ARICap: MFVC- ACS-, Next Function: 1
>                                 ARICtl:   MFVC- ACS-, Function Group: 0
>                 Capabilities: [1c0 v1] #19
>                 Capabilities: [1f4 v1] Vendor Specific Information: ID=3D=
0001 Rev=3D1 Len=3D014 <?>
>                 Kernel driver in use: qla2xxx
>                 Kernel modules: qla2xxx
>
> # cat /sys/bus/pci/devices/0000\:03\:00.0/vpd
> RFD1706R22611ECBK3210408-05 04V9010189RV=EF=BF=BDx
>
> Can you share some more insight into where you encountered issue? I am in=
 process of reverting this patch from upstream kernel but wanted to reach o=
ut and find out if you still have setup to provide more context.

0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722") prevented
a panic while reading VPD, so we can't simply revert it.

Since you don't see a panic while reading VPD from that device, it's
possible that a QLogic firmware change fixed the VPD format so Linux
no longer reads the area that caused the problem.  Or possibly your
system doesn't handle the config read error the same way Ethan's HP
DL380 does.  Unfortunately we don't have an actual PCIe analyzer trace
from Ethan's system, so we don't know exactly what happened on PCIe.

I suggest that you capture the entire VPD area and hexdump it, e.g.,
with "xxd", and look at its structure.  pci_vpd_size() parses it and
computes the valid size based on a PCI_VPD_STIN_END tag, and
pci_vpd_read() should not read past that size.

And you *do* have an analyzer trace.  If new QLogic firmware fixed the
VPD format, the trace should show that Linux read only the valid part
of VPD, and there should be no errors in the trace.  Then it might
just be a question of tweaking the quirk so it allows VPD reads if the
firmware is new enough.

But if the trace does show config reads with errors, then it might be
that your system just tolerates the errors while the DL380 did not.
Then we'd have to figure out exactly what the error was and how to
deal with it so things work on both your system and Ethan's.

Bjorn
