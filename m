Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA486218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfCUUl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:41:27 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:54688 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbfCUUl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:41:27 -0400
From:   Meelis Roos <mroos@linux.ee>
Subject: Radeon HD 7450 brightness oversaturated
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Message-ID: <6f3801ea-476f-6715-db9b-0eb188c5711d@linux.ee>
Date:   Thu, 21 Mar 2019 22:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I decided to put a discrete graphics card into a PC and found a fitting Radeon HD 7450.
It works, but there is strange whiteness like the brightness is oversaturated and
light places turn into other colors:
* on fbcon, right after radeondrmfb initializes
* in X after powersave

The colors return to normal after a VT switch or two.

Screenshot of one such washed view is at http://kodu.ut.ee/~mroos/radeon_washed.jpg

Kernels are 5.0 and 5.1-rc1.

lspci -vvvxxx and dmesg are below.

00:00.0 Host bridge: Intel Corporation Core Processor DMI (rev 11)
	Subsystem: Hewlett-Packard Company Core Processor DMI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] #00 [0000]
00: 86 80 31 d1 00 01 10 00 11 00 00 06 10 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 80 d1 fe 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 90 02 01 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 10 e0 41 00 20 80 00 00 00 00 00 00 41 3c 39 00
a0: 00 00 41 30 00 00 00 00 c0 07 00 00 00 00 00 00
b0: 00 00 00 00 3e 00 00 00 10 00 00 00 00 00 00 00
c0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 01 00 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 PCI bridge: Intel Corporation Core Processor PCI Express Root Port 1 (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: f0000000-f00fffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: Hewlett-Packard Company Core Processor PCI Express Root Port 1
	Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
		Address: fee01004  Data: 40ef
		Masking: 00000000  Pending: 00000000
	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x4, ASPM L0s, Exit Latency L0s <512ns, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd Off, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [150 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
	Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Kernel driver in use: pcieport
00: 86 80 38 d1 07 01 10 00 11 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 10 10 00 20
20: 00 f0 00 f0 01 e0 f1 ef 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 0a 00
40: 0d 60 00 00 3c 10 4a 30 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 90 02 01 04 10 e0 fe ef 40 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 10 e0 42 01 21 80 00 00 00 01 00 00 42 34 39 00
a0: 40 00 02 f1 00 00 00 00 c0 03 00 00 10 00 01 00
b0: 00 00 00 00 3e 00 00 00 00 00 00 00 00 00 00 00
c0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 01 00 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 System peripheral: Intel Corporation Core Processor System Management Registers (rev 11)
	Subsystem: Device 003c:004a
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
	Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0 Len=000 <?>
00: 86 80 55 d1 00 00 10 00 11 00 80 08 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 00 4a 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 00 92 00 00 80 00 00 00 00 00 00 00 f4 3b 00
50: 00 00 00 10 00 00 00 00 c0 07 00 00 00 00 01 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 f4 3b 00
70: 00 00 00 10 00 00 00 00 c0 07 00 00 01 00 00 00
80: 00 00 00 00 ff ff 0f 00 00 00 ff ff 0f 00 00 00
90: 00 00 00 00 00 00 00 00 20 90 04 00 1f 00 00 00
a0: 00 00 00 00 00 00 00 00 09 00 80 df 00 00 00 00
b0: 00 00 ff ff 0f 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 ff ff 0f 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 dc 00 00 00 1c 01 00 00 00 00 00 00 fc
e0: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 70 20 3f 12 00 00 00 00 40 00 00 00 00 00 00 00

00:08.1 System peripheral: Intel Corporation Core Processor Semaphore and Scratchpad Registers (rev 11)
	Subsystem: Device 003c:004a
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
	Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0 Len=000 <?>
00: 86 80 56 d1 00 00 10 00 11 00 80 08 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 00 4a 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 00 92 00 00 80 00 00 00 00 00 00 00 f4 3b 00
50: 00 00 00 10 00 00 00 00 c0 07 00 00 00 00 01 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 f4 3b 00
70: 00 00 00 10 00 00 00 00 c0 07 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bf
a0: 00 00 00 00 00 00 30 01 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bf

00:08.2 System peripheral: Intel Corporation Core Processor System Control and Status Registers (rev 11)
	Subsystem: Device 003c:004a
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
	Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0 Len=000 <?>
00: 86 80 57 d1 00 00 10 00 11 00 80 08 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 00 4a 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 10 00 92 00 00 80 00 00 00 00 00 00 00 f4 3b 00
50: 00 00 00 10 00 00 00 00 c0 07 00 00 00 00 01 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 f4 3b 00
70: 00 00 00 10 00 00 00 00 c0 07 00 00 00 00 00 00
80: a4 82 a0 02 50 01 aa aa a8 00 00 00 65 15 00 00
90: aa 01 00 00 24 00 00 00 08 04 00 00 22 05 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00
d0: 08 00 00 00 e5 22 02 05 11 09 00 00 00 00 00 00
e0: 00 00 00 00 ff 07 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.3 System peripheral: Intel Corporation Core Processor Miscellaneous Registers (rev 11)
	Subsystem: Device 003c:004a
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
00: 86 80 58 d1 00 00 00 00 11 00 80 08 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 00 4a 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 90 e7 02 00 00 00 00 00 00 79 60 52 01
50: 00 00 00 00 00 00 00 00 43 07 00 00 f0 aa 18 00
60: 2c 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 0b 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 0b 00 00 00 00 00 00 00 01 00 00 00
a0: 02 00 00 00 08 00 00 00 00 00 00 00 00 32 02 40
b0: 01 00 00 00 01 f0 ff ff c0 20 40 00 00 f0 ff ff
c0: c0 40 44 00 00 f0 ff ff 82 49 48 00 02 f0 ff ff
d0: 01 00 00 00 01 00 00 00 03 40 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00 00

00:10.0 System peripheral: Intel Corporation Core Processor QPI Link (rev 11)
	Subsystem: Device 003c:004a
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
00: 86 80 50 d1 00 00 00 00 11 00 80 08 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 00 4a 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 39 00 00 00
60: 88 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 18 00 00 00 00 00 00 00 00 00 00 00
90: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 90 08 38 00 10 00 00 3c 06 06 00 00 5f 00
d0: 45 0e 00 00 00 00 d1 00 00 00 00 00 81 04 01 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 38 00 10 00 00 00 00 00 66 10 11 01 66 10 11 01

00:10.1 System peripheral: Intel Corporation Core Processor QPI Routing and Protocol Registers (rev 11)
	Subsystem: Device 003c:004a
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
00: 86 80 51 d1 00 00 00 00 11 00 80 08 10 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 00 4a 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 02 02 40 00
50: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 41 10 04 41 10 04 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00
d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:16.0 Communication controller: Intel Corporation 5 Series/3400 Series Chipset HECI Controller (rev 06)
	Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset HECI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 30
	Region 0: Memory at f012a000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee40004  Data: 4021
	Kernel driver in use: mei_me
00: 86 80 64 3b 06 04 10 00 06 00 80 07 00 00 80 00
10: 04 a0 12 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 00
40: 45 02 00 00 20 00 01 80 00 00 00 63 00 00 00 00
50: 01 8c 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 05 00 81 00
90: 04 00 e4 fe 00 00 00 00 21 40 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 c0
c0: 45 04 55 bb 65 3e 37 f8 77 d8 12 a4 42 91 b0 ba
d0: 27 69 05 67 02 a9 25 69 1d 24 77 80 cd 16 4b ea
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:16.3 Serial controller: Intel Corporation 5 Series/3400 Series Chipset KT Controller (rev 06) (prog-if 02 [16550])
	Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset KT Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at 2180 [size=8]
	Region 1: Memory at f0124000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: serial
00: 86 80 67 3b 07 00 b0 00 06 02 00 07 00 00 00 00
10: 81 21 00 00 00 40 12 f0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 c8 00 00 00 00 00 00 00 0a 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 23 00 08 00 00 00
d0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.0 Ethernet controller: Intel Corporation 82578DM Gigabit Network Connection (rev 05)
	Subsystem: Hewlett-Packard Company 82578DM Gigabit Network Connection
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 32
	Region 0: Memory at f0100000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at f0125000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 2100 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee80004  Data: 4022
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e
	Kernel modules: e1000e
00: 86 80 ef 10 07 05 10 00 05 00 00 02 00 00 00 00
10: 00 00 10 f0 00 50 12 f0 01 21 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 c8 00 00 00 00 00 00 00 05 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 22 c8 00 20 00 08
d0: 05 e0 81 00 04 00 e8 fe 00 00 00 00 22 40 00 00
e0: 13 00 06 03 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset USB2 Enhanced Host Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at f0127000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci
00: 86 80 3c 3b 06 01 90 02 05 20 03 0c 00 00 00 00
10: 00 70 12 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 c2 c9 00 00 00 00 0a 98 a0 20 00 00 00 00
60: 20 20 ff 07 00 00 00 00 01 00 00 00 00 00 08 c0
70: 00 00 df 3f 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 80 00 11 89 0c 13 a0 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 13 00 06 03 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 aa ff 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 04 f0 ff ff
f0: 00 00 00 00 88 85 80 00 87 0f 07 08 28 17 5b 30

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio (rev 05)
	Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset High Definition Audio
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 33
	Region 0: Memory at f0120000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee01004  Data: 4022
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=2 ArbSelect=Fixed TC/VC=04
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
00: 86 80 56 3b 06 05 10 00 05 00 03 04 10 00 00 00
10: 04 00 12 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
40: 01 00 00 07 00 00 00 00 00 00 00 00 00 80 00 00
50: 01 60 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 70 81 00 04 10 e0 fe 00 00 00 00 22 40 00 00
70: 10 00 91 00 00 00 00 10 00 00 10 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 04 00 01 00 00 00 00 05 00 09 02 10 70 30 16
d0: 0b 00 91 06 10 00 31 16 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 07 08 00 00 00 00

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 1 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Bus: primary=00, secondary=18, subordinate=18, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f8000000-f81fffff
	Prefetchable memory behind bridge: 00000000f8200000-00000000f83fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: fee40004  Data: 4021
	Capabilities: [90] Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset PCI Express Root Port 1
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
00: 86 80 42 3b 07 01 10 00 05 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 18 18 00 30 30 00 20
20: 00 f8 10 f8 21 f8 31 f8 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 02 00
40: 10 80 42 01 00 80 00 00 00 00 10 00 41 4c 11 01
50: 00 00 01 10 60 00 04 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 04 00 e4 fe 21 40 00 00 00 00 00 00
90: 0d a0 00 00 3c 10 4a 30 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 10 00 00 00 00 00 00 00 00 11 80 00 00 00 00
e0: 00 0f 00 00 06 07 08 00 31 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 07 08 00 00 00 00

00:1c.4 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 5 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Bus: primary=00, secondary=24, subordinate=24, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f8400000-f85fffff
	Prefetchable memory behind bridge: 00000000f8600000-00000000f87fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: fee40004  Data: 4021
	Capabilities: [90] Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset PCI Express Root Port 5
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
00: 86 80 4a 3b 07 01 10 00 05 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 24 24 00 40 40 00 20
20: 40 f8 50 f8 61 f8 71 f8 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 02 00
40: 10 80 42 01 00 80 00 00 00 00 10 00 11 4c 11 05
50: 00 00 01 10 60 00 04 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 04 00 e4 fe 21 40 00 00 00 00 00 00
90: 0d a0 00 00 3c 10 4a 30 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 10 00 00 00 00 00 00 00 00 11 80 00 00 00 00
e0: 00 0f 00 00 06 07 08 00 31 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 07 08 00 00 00 00

00:1c.6 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 7 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 22
	Bus: primary=00, secondary=30, subordinate=30, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: f8800000-f89fffff
	Prefetchable memory behind bridge: 00000000f8a00000-00000000f8bfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #7, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: fee40004  Data: 4021
	Capabilities: [90] Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset PCI Express Root Port 7
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport
00: 86 80 4e 3b 07 01 10 00 05 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 30 30 00 50 50 00 20
20: 80 f8 90 f8 a1 f8 b1 f8 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 03 02 00
40: 10 80 42 01 00 80 00 00 00 00 10 00 11 4c 11 07
50: 00 00 01 10 60 00 04 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 00 00 04 00 e4 fe 21 40 00 00 00 00 00 00
90: 0d a0 00 00 3c 10 4a 30 00 00 00 00 00 00 00 00
a0: 01 00 02 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 10 00 00 00 00 00 00 00 00 11 80 00 00 00 00
e0: 00 0f 00 00 06 07 08 00 31 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 07 08 00 00 00 00

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset USB2 Enhanced Host Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at f0128000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci
00: 86 80 34 3b 06 01 90 02 05 20 03 0c 00 00 00 00
10: 00 80 12 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 c2 c9 00 00 00 00 0a 98 a0 20 00 00 00 00
60: 20 20 ff 07 00 00 00 00 01 00 00 00 00 00 00 c0
70: 00 00 df 3f 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 80 00 11 89 0c 13 a0 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 13 00 06 03 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 aa ff 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 04 f0 ff ff
f0: 00 00 00 00 88 85 80 00 87 0f 07 08 28 17 5b 30

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a5) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=0d, subordinate=0d, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Hewlett-Packard Company 82801 PCI Bridge
00: 86 80 4e 24 07 01 10 00 a5 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 0d 0d 20 f0 00 80 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 02 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 12 00 10
50: 0d 00 00 00 3c 10 4a 30 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 07 08 00 00 00 00

00:1f.0 ISA bridge: Intel Corporation Q57 Chipset LPC Interface Controller (rev 05)
	Subsystem: Hewlett-Packard Company Q57 Chipset LPC Interface Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=10 <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich
00: 86 80 0a 3b 07 01 10 02 05 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 f8 00 00 80 00 00 00 01 fa 00 00 11 00 00 00
50: f8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 85 8a 8a 85 d0 00 00 00 8a 8b 85 80 f8 00 00 00
70: f8 00 f8 00 f8 00 f8 00 f8 00 f8 00 f8 00 f8 00
80: 10 00 05 34 01 04 7c 00 81 04 0c 00 b1 0c 0c 00
90: 00 00 00 00 00 0f 00 00 00 00 00 00 00 00 00 00
a0: 18 06 00 00 38 a9 00 00 00 45 00 00 00 03 00 80
b0: 00 00 00 00 00 00 00 00 00 00 00 10 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 33 22 11 00 67 45 00 00 c0 ff 00 00 02 00 00 00
e0: 09 00 10 11 91 00 e4 04 00 33 02 58 06 14 b8 02
f0: 01 c0 d1 fe 00 00 00 00 87 0f 07 08 00 00 00 00

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset 6 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
	Subsystem: Hewlett-Packard Company 5 Series/3400 Series Chipset 6 port SATA AHCI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 31
	Region 0: I/O ports at 2188 [size=8]
	Region 1: I/O ports at 21a0 [size=4]
	Region 2: I/O ports at 2190 [size=8]
	Region 3: I/O ports at 21a4 [size=4]
	Region 4: I/O ports at 2120 [size=32]
	Region 5: Memory at f0126000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee80004  Data: 4021
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci
00: 86 80 22 3b 07 04 b0 02 05 01 06 01 00 00 00 00
10: 89 21 00 00 a1 21 00 00 91 21 00 00 a5 21 00 00
20: 21 21 00 00 00 60 12 f0 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 02 00 00
40: 00 80 00 80 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 a8 03 40 08 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 01 00 04 00 e8 fe 21 40 00 00 00 00 00 00
90: 60 00 17 83 83 01 00 00 20 02 50 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 12 b0 10 00 48 00 00 00
b0: 13 00 06 03 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 87 0f 07 08 00 00 00 00

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos PRO [Radeon HD 7450] (prog-if 00 [VGA controller])
	Subsystem: Hewlett-Packard Company Caicos PRO [Radeon HD 7450]
	Physical Slot: 1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 35
	Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at f0000000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 1100 [size=256]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal+ Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee04004  Data: 4023
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [150 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: radeon
	Kernel modules: radeon
00: 02 10 7b 67 07 04 10 00 00 00 00 03 10 00 80 00
10: 0c 00 00 e0 00 00 00 00 04 00 00 f0 00 00 00 00
20: 01 11 00 00 00 00 00 00 00 00 00 00 3c 10 b7 90
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 b7 90
50: 01 58 03 06 00 00 00 00 10 a0 12 00 a1 8f 00 00
60: 14 29 09 00 02 0d 00 00 40 00 02 11 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 00 81 00 04 40 e0 fe 00 00 00 00 23 40 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Caicos HDMI Audio [Radeon HD 6450 / 7450/8450/8490 OEM / R5 230/235/235X OEM]
	Subsystem: Hewlett-Packard Company Caicos HDMI Audio [Radeon HD 6450 / 7450/8450/8490 OEM / R5 230/235/235X OEM]
	Physical Slot: 1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 34
	Region 0: Memory at f0020000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal+ Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee02004  Data: 4023
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [150 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
00: 02 10 98 aa 07 04 10 00 00 00 03 04 10 00 80 00
10: 04 00 02 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 98 aa
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 98 aa
50: 01 58 03 06 00 00 00 00 10 a0 12 00 a1 8f 00 00
60: 14 29 09 00 02 0d 00 00 40 00 02 11 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 00 81 00 04 20 e0 fe 00 00 00 00 23 40 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:00.0 Host bridge: Intel Corporation Core Processor QuickPath Architecture Generic Non-Core Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor QuickPath Architecture Generic Non-Core Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 51 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 20 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 01 04 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 12 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 80 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:00.1 Host bridge: Intel Corporation Core Processor QuickPath Architecture System Address Decoder (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor QuickPath Architecture System Address Decoder
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 81 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 10 11 11 11 11 31 33 00 00 00 00 00 00 1a 00 00
50: 0d 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 dc 00 00 00 00 00 0c 00 fe 0f 00 00 00
80: c3 0d 00 00 c0 0f 00 00 c3 11 00 00 c0 11 00 00
90: c0 11 00 00 c0 11 00 00 c0 11 00 00 c0 11 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 11 11 11 11 00 00 00 00 11 11 11 11 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor QPI Link 0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 90 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 01 8f 08 00 00 00 00 30 00 30 00 00 00 00 00
50: 00 00 00 86 00 00 00 00 55 45 06 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 7f 00 05 06 00 00 00 00 00 b3 00 00 00 00
d0: 01 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0 (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor QPI Physical 0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 91 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 12 01 0c 12 12 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:03.0 Host bridge: Intel Corporation Core Processor Integrated Memory Controller (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 98 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 03 00 00 0c 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 89 44 02 00 d0 00 00 00 00 00 00 00 00 00 00 00
70: 0e 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:03.1 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Target Address Decoder (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Target Address Decoder
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 99 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: c3 0d 00 00 c0 0f 00 00 c3 11 00 00 c0 11 00 00
90: c0 11 00 00 c0 11 00 00 c0 11 00 00 c0 11 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 01 01 01 00 00 00 00 01 01 01 01 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:03.4 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Test Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Test Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 9c 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 09 00 ff f0 01 00 80 0b 03 10 10 04 e7 00 01 03
50: 0a 00 00 0a 0a 00 00 00 15 00 00 00 01 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 07 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 0f 00 11 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 09 0a 00 00 00 00 00 00

3f:04.0 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 0 Control Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Channel 0 Control Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 a0 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 04 00 00 32 40 3f 06 00 00 00 00
60: 58 0b 80 00 00 00 00 00 01 00 00 00 00 00 00 00
70: 58 0b 06 08 50 00 00 00 50 06 00 00 01 00 00 00
80: 58 44 34 12 14 b5 00 00 89 f3 2a 00 6b fa 5c 03
90: a4 03 10 00 90 1a 40 60 f0 3d 01 00 50 62 e4 03
a0: 00 00 00 00 00 04 01 01 04 04 01 01 01 06 05 09
b0: 05 06 05 09 18 ff af 0d e0 29 00 00 50 14 00 00
c0: 12 05 11 00 04 01 02 00 12 0a 09 00 00 0a 00 00
d0: 09 11 00 00 34 00 00 00 03 20 00 00 00 00 00 00
e0: 12 05 00 00 05 01 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:04.1 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 0 Address Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Channel 0 Address Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 a1 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 8c 02 00 00 00 10 00 00
50: 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 01 00 00 00 00 00 e0 ff 01 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:04.2 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 0 Rank Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Channel 0 Rank Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 a2 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 00 00 00 07 00 00 00 07 00 00 00 07 00 00 00
50: 07 00 00 00 07 00 00 00 07 00 00 00 07 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:04.3 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 0 Thermal Control Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Channel 0 Thermal Control Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 a3 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 80 d9 0a 11 ff 01 ff 04 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 6d 6d 6d 6d 00 ff 03 00 ff ff ff ff 00 00 00 00
90: 00 00 00 00 00 00 00 00 19 28 28 28 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:05.0 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 1 Control Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Channel 1 Control Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 a8 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 04 00 00 32 40 3f 06 00 00 00 00
60: 58 0b 80 00 00 00 00 00 01 00 00 00 00 00 00 00
70: 58 0b 06 08 50 00 00 00 50 06 00 00 01 00 00 00
80: 58 44 34 12 14 b5 00 00 89 f3 2a 00 6b fa 5c 03
90: a4 03 10 00 90 1a 40 60 f0 3d 01 00 50 62 e4 03
a0: 00 00 00 00 00 04 01 01 04 04 01 01 01 06 05 09
b0: 05 06 05 09 18 ff af 0d e0 29 00 00 50 14 00 00
c0: 12 05 11 00 04 01 02 00 12 0a 09 00 00 0a 00 00
d0: 09 11 00 00 34 00 00 00 03 20 00 00 00 00 00 00
e0: 12 05 00 00 05 01 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:05.1 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 1 Address Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Channel 1 Address Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 a9 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 8c 02 00 00 00 10 00 00
50: 00 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 01 00 00 00 00 00 e0 ff 01 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:05.2 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 1 Rank Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Channel 1 Rank Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 aa 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 00 00 00 07 00 00 00 07 00 00 00 07 00 00 00
50: 07 00 00 00 07 00 00 00 07 00 00 00 07 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3f:05.3 Host bridge: Intel Corporation Core Processor Integrated Memory Controller Channel 1 Thermal Control Registers (rev 04)
	Subsystem: Hewlett-Packard Company Core Processor Integrated Memory Controller Channel 1 Thermal Control Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 86 80 ab 2c 06 00 00 00 04 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 4a 30
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 80 d9 0a 11 ff 01 ff 04 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 6d 6d 6d 6d 00 ff 03 00 ff ff ff ff 00 00 00 00
90: 00 00 00 00 00 00 00 00 19 28 28 28 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



[    0.000000] microcode: microcode updated early to revision 0xa, date = 2018-05-08
[    0.000000] Linux version 5.1.0-rc1 (mroos@prometheus) (gcc version 8.3.0 (Debian 8.3.0-2)) #239 SMP Mon Mar 18 22:12:33 EET 2019
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.1.0-rc1 root=/dev/sda1 ro
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e8000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000dbfac43f] usable
[    0.000000] BIOS-e820: [mem 0x00000000dbfae440-0x00000000dbfae49f] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dbfae4a0-0x00000000dc7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f4000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fed3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed45000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000011fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Hewlett-Packard HP Compaq 8100 Elite SFF PC/304Ah, BIOS 786H1 v01.13 07/14/2011
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2926.319 MHz processor
[    0.001822] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001823] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001827] last_pfn = 0x120000 max_arch_pfn = 0x400000000
[    0.001829] MTRR default type: uncachable
[    0.001830] MTRR fixed ranges enabled:
[    0.001831]   00000-9FFFF write-back
[    0.001831]   A0000-BFFFF uncachable
[    0.001832]   C0000-E3FFF write-protect
[    0.001832]   E4000-EFFFF write-back
[    0.001833]   F0000-FFFFF write-protect
[    0.001833] MTRR variable ranges enabled:
[    0.001834]   0 base 000000000 mask E00000000 write-back
[    0.001835]   1 base 0DC000000 mask FFC000000 uncachable
[    0.001835]   2 base 0E0000000 mask FE0000000 uncachable
[    0.001836]   3 disabled
[    0.001836]   4 disabled
[    0.001836]   5 disabled
[    0.001836]   6 disabled
[    0.001837]   7 disabled
[    0.002464] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.002705] e820: update [mem 0xdc000000-0xffffffff] usable ==> reserved
[    0.002709] last_pfn = 0xdbfac max_arch_pfn = 0x400000000
[    0.008252] found SMP MP-table at [mem 0x000f9bf0-0x000f9bff] mapped at [(____ptrval____)]
[    0.008264] Base memory trampoline at [(____ptrval____)] 99000 size 24576
[    0.008267] BRK [0xbc401000, 0xbc401fff] PGTABLE
[    0.008269] BRK [0xbc402000, 0xbc402fff] PGTABLE
[    0.008270] BRK [0xbc403000, 0xbc403fff] PGTABLE
[    0.008300] BRK [0xbc404000, 0xbc404fff] PGTABLE
[    0.008302] BRK [0xbc405000, 0xbc405fff] PGTABLE
[    0.008479] ACPI: Early table checksum verification disabled
[    0.008481] ACPI: RSDP 0x00000000000E5210 000014 (v00 COMPAQ)
[    0.008484] ACPI: RSDT 0x00000000DBFD0540 000044 (v01 HPQOEM SLIC-BPC 20110714      00000000)
[    0.008488] ACPI: FACP 0x00000000DBFD05E8 000074 (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.008492] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Address but zero Length: 0x0000000000000050/0x0 (20190215/tbfadt-624)
[    0.008494] ACPI BIOS Warning (bug): Invalid length for FADT/Pm2ControlBlock: 0, using default 8 (20190215/tbfadt-674)
[    0.008497] ACPI: DSDT 0x00000000DBFD0A4F 009F8A (v01 COMPAQ DSDT_PRJ 00000001 MSFT 0100000E)
[    0.008500] ACPI: FACS 0x00000000DBFD0500 000040
[    0.008502] ACPI: APIC 0x00000000DBFD065C 0000BC (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.008504] ACPI: ASF! 0x00000000DBFD0718 000063 (v32 COMPAQ IBEXPEAK 00000001      00000000)
[    0.008507] ACPI: MCFG 0x00000000DBFD077B 00003C (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.008509] ACPI: TCPA 0x00000000DBFD07B7 000032 (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.008512] ACPI: SLIC 0x00000000DBFD07E9 000176 (v01 HPQOEM SLIC-BPC 00000001      00000000)
[    0.008514] ACPI: HPET 0x00000000DBFD095F 000038 (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.008517] ACPI: DMAR 0x00000000DBFD0997 000068 (v01 COMPAQ IBEXPEAK 00000001      00000000)
[    0.008523] ACPI: Local APIC address 0xfee00000
[    0.008536] Zone ranges:
[    0.008537]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.008538]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.008539]   Normal   [mem 0x0000000100000000-0x000000011fffffff]
[    0.008540] Movable zone start for each node
[    0.008541] Early memory node ranges
[    0.008542]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.008543]   node   0: [mem 0x0000000000100000-0x00000000dbfabfff]
[    0.008543]   node   0: [mem 0x0000000100000000-0x000000011fffffff]
[    0.008816] Zeroed struct page in unavailable ranges: 16566 pages
[    0.008817] Initmem setup node 0 [mem 0x0000000000001000-0x000000011fffffff]
[    0.008819] On node 0 totalpages: 1032010
[    0.008820]   DMA zone: 64 pages used for memmap
[    0.008820]   DMA zone: 21 pages reserved
[    0.008821]   DMA zone: 3998 pages, LIFO batch:0
[    0.008901]   DMA32 zone: 14015 pages used for memmap
[    0.008902]   DMA32 zone: 896940 pages, LIFO batch:63
[    0.027261]   Normal zone: 2048 pages used for memmap
[    0.027263]   Normal zone: 131072 pages, LIFO batch:31
[    0.029924] ACPI: PM-Timer IO Port: 0xf808
[    0.029928] ACPI: Local APIC address 0xfee00000
[    0.029933] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.029934] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.029935] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.029936] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.029936] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.029937] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.029938] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.029939] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.029948] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.029950] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.029952] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.029953] ACPI: IRQ0 used by override.
[    0.029954] ACPI: IRQ9 used by override.
[    0.029956] Using ACPI (MADT) for SMP configuration information
[    0.029957] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.029961] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.029971] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.029972] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.029973] PM: Registered nosave memory: [mem 0x000a0000-0x000e7fff]
[    0.029974] PM: Registered nosave memory: [mem 0x000e8000-0x000fffff]
[    0.029975] PM: Registered nosave memory: [mem 0xdbfac000-0xdbfaefff]
[    0.029976] PM: Registered nosave memory: [mem 0xdbfae000-0xdbfaefff]
[    0.029977] PM: Registered nosave memory: [mem 0xdbfaf000-0xdc7fffff]
[    0.029978] PM: Registered nosave memory: [mem 0xdc800000-0xf3ffffff]
[    0.029978] PM: Registered nosave memory: [mem 0xf4000000-0xf7ffffff]
[    0.029979] PM: Registered nosave memory: [mem 0xf8000000-0xfdffffff]
[    0.029980] PM: Registered nosave memory: [mem 0xfe000000-0xfed3ffff]
[    0.029980] PM: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
[    0.029981] PM: Registered nosave memory: [mem 0xfed45000-0xffffffff]
[    0.029983] [mem 0xdc800000-0xf3ffffff] available for PCI devices
[    0.029986] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.156292] random: get_random_bytes called from start_kernel+0x8b/0x410 with crng_init=0
[    0.156297] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.156557] percpu: Embedded 42 pages/cpu @(____ptrval____) s134936 r8192 d28904 u262144
[    0.156562] pcpu-alloc: s134936 r8192 d28904 u262144 alloc=1*2097152
[    0.156563] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.156580] Built 1 zonelists, mobility grouping on.  Total pages: 1015862
[    0.156581] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.1.0-rc1 root=/dev/sda1 ro
[    0.156606] printk: log_buf_len individual max cpu contribution: 16384 bytes
[    0.156607] printk: log_buf_len total cpu_extra contributions: 114688 bytes
[    0.156607] printk: log_buf_len min size: 131072 bytes
[    0.156655] printk: log_buf_len: 262144 bytes
[    0.156655] printk: early log buf free: 122280(93%)
[    0.157010] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.157189] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.175482] Memory: 3968088K/4128040K available (10243K kernel code, 545K rwdata, 1944K rodata, 924K init, 1924K bss, 159952K reserved, 0K cma-reserved)
[    0.175546] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.175551] Kernel/User page tables isolation: enabled
[    0.175612] rcu: Hierarchical RCU implementation.
[    0.175614] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.175624] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.175894] rcu: 	Offload RCU callbacks from CPUs: (none).
[    0.178832] Console: colour VGA+ 80x25
[    0.189432] printk: console [tty0] enabled
[    0.189530] ACPI: Core revision 20190215
[    0.189761] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.189938] hpet clockevent registered
[    0.189942] APIC: Switch to symmetric I/O mode setup
[    0.190037] DMAR: Host address width 36
[    0.190128] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.190227] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c90780106f0462 ecap f020e3
[    0.190393] DMAR: RMRR base: 0x000000dbfde000 end: 0x000000dbfe7fff
[    0.190961] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.209942] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2a2e61c1386, max_idle_ns: 440795303300 ns
[    0.210123] Calibrating delay loop (skipped), value calculated using timer frequency.. 5852.63 BogoMIPS (lpj=11705276)
[    0.210293] pid_max: default: 32768 minimum: 301
[    0.210404] LSM: Security Framework initializing
[    0.210513] AppArmor: AppArmor initialized
[    0.210623] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.210729] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.210940] *** VALIDATE proc ***
[    0.211074] *** VALIDATE cgroup1 ***
[    0.211167] *** VALIDATE cgroup2 ***
[    0.211279] mce: CPU supports 9 MCE banks
[    0.211376] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.211475] process: using mwait in idle threads
[    0.211569] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.211664] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.211760] Spectre V2 : Mitigation: Full generic retpoline
[    0.211853] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.212020] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.212119] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.212287] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.212384] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.212685] Freeing SMP alternatives memory: 32K
[    0.218113] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         870  @ 2.93GHz (family: 0x6, model: 0x1e, stepping: 0x5)
[    0.218113] Performance Events: PEBS fmt1+, Nehalem events, 16-deep LBR, Intel PMU driver.
[    0.218113] core: CPU erratum AAJ80 worked around
[    0.218113] core: CPUID marked event: 'bus cycles' unavailable
[    0.218113] ... version:                3
[    0.218113] ... bit width:              48
[    0.218113] ... generic registers:      4
[    0.218113] ... value mask:             0000ffffffffffff
[    0.218113] ... max period:             000000007fffffff
[    0.218113] ... fixed-purpose events:   3
[    0.218113] ... event mask:             000000070000000f
[    0.218113] rcu: Hierarchical SRCU implementation.
[    0.218113] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.218113] smp: Bringing up secondary CPUs ...
[    0.218113] x86: Booting SMP configuration:
[    0.218113] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.234156] smp: Brought up 1 node, 8 CPUs
[    0.234305] smpboot: Max logical packages: 1
[    0.234397] smpboot: Total of 8 processors activated (46821.10 BogoMIPS)
[    0.238278] devtmpfs: initialized
[    0.238316] PM: Registering ACPI NVS region [mem 0xdbfae440-0xdbfae49f] (96 bytes)
[    0.238316] reboot: HP Compaq Laptop series board detected. Selecting BIOS-method for reboots.
[    0.238511] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.242120] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.242320] NET: Registered protocol family 16
[    0.242475] audit: initializing netlink subsys (disabled)
[    0.242575] audit: type=2000 audit(1552940971.052:1): state=initialized audit_enabled=0 res=1
[    0.242575] cpuidle: using governor ladder
[    0.242575] cpuidle: using governor menu
[    0.242575] ACPI: bus type PCI registered
[    0.242575] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf4000000-0xf7ffffff] (base 0xf4000000)
[    0.242575] PCI: MMCONFIG at [mem 0xf4000000-0xf7ffffff] reserved in E820
[    0.242621] pmd_set_huge: Cannot satisfy [mem 0xf4000000-0xf4200000] with a huge-page mapping due to MTRR override.
[    0.242841] PCI: Using configuration type 1 for base access
[    0.243856] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.246137] ACPI: Added _OSI(Module Device)
[    0.246230] ACPI: Added _OSI(Processor Device)
[    0.246322] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.246414] ACPI: Added _OSI(Processor Aggregator Device)
[    0.246508] ACPI: Added _OSI(Linux-Dell-Video)
[    0.246600] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.246696] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.248611] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.249400] ACPI: Dynamic OEM Table Load:
[    0.249496] ACPI: SSDT 0xFFFF890D5A981C00 0003BA (v01 COMPAQ CPU_TM2  00000001 MSFT 0100000E)
[    0.249890] ACPI: Dynamic OEM Table Load:
[    0.249985] ACPI: SSDT 0xFFFF890D5A982000 0003D8 (v01 COMPAQ CST      00000001 MSFT 0100000E)
[    0.250819] ACPI: Interpreter enabled
[    0.250925] ACPI: (supports S0 S3 S4 S5)
[    0.251019] ACPI: Using IOAPIC for interrupt routing
[    0.251129] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.251408] ACPI: Enabled 4 GPEs in block 00 to 3F
[    0.255165] acpi LNXCPU:00: Invalid PBLK length [7]
[    0.255266] acpi LNXCPU:01: Invalid PBLK length [7]
[    0.255364] acpi LNXCPU:02: Invalid PBLK length [7]
[    0.255462] acpi LNXCPU:03: Invalid PBLK length [7]
[    0.255560] acpi LNXCPU:04: Invalid PBLK length [7]
[    0.255658] acpi LNXCPU:05: Invalid PBLK length [7]
[    0.255757] acpi LNXCPU:06: Invalid PBLK length [7]
[    0.255855] acpi LNXCPU:07: Invalid PBLK length [7]
[    0.256073] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.256172] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.256344] ACPI BIOS Error (bug): \_SB.PCI0._OSC: Excess arguments - ASL declared 5, ACPI requires 4 (20190215/nsarguments-164)
[    0.256550] ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0._OSC.CAPD], AE_ALREADY_EXISTS (20190215/dsfield-183)
[    0.256727] ACPI Error: Aborting method \_SB.PCI0._OSC due to previous error (AE_ALREADY_EXISTS) (20190215/psparse-531)
[    0.256904] acpi PNP0A08:00: _OSC failed (AE_ALREADY_EXISTS); disabling ASPM
[    0.257002] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.257341] PCI host bridge to bus 0000:00
[    0.257436] pci_bus 0000:00: root bus resource [mem 0xf8000000-0xfdffffff window]
[    0.257605] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.257702] pci_bus 0000:00: root bus resource [io  0x1000-0x2fff window]
[    0.257799] pci_bus 0000:00: root bus resource [io  0x3000-0x6fff window]
[    0.257895] pci_bus 0000:00: root bus resource [io  0x7000-0xafff window]
[    0.257992] pci_bus 0000:00: root bus resource [io  0xb000-0xffff window]
[    0.258089] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.258120] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xf3ffffff window]
[    0.258289] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff window]
[    0.258457] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.258559] pci 0000:00:00.0: [8086:d131] type 00 class 0x060000
[    0.258656] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    0.258714] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.258783] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    0.258868] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    0.258951] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    0.259032] pci 0000:00:08.3: [8086:d158] type 00 class 0x088000
[    0.259101] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    0.259163] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    0.259240] pci 0000:00:16.0: [8086:3b64] type 00 class 0x078000
[    0.259270] pci 0000:00:16.0: reg 0x10: [mem 0xf012a000-0xf012a00f 64bit]
[    0.259355] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.259410] pci 0000:00:16.3: [8086:3b67] type 00 class 0x070002
[    0.259433] pci 0000:00:16.3: reg 0x10: [io  0x2180-0x2187]
[    0.259441] pci 0000:00:16.3: reg 0x14: [mem 0xf0124000-0xf0124fff]
[    0.259567] pci 0000:00:19.0: [8086:10ef] type 00 class 0x020000
[    0.259584] pci 0000:00:19.0: reg 0x10: [mem 0xf0100000-0xf011ffff]
[    0.259591] pci 0000:00:19.0: reg 0x14: [mem 0xf0125000-0xf0125fff]
[    0.259598] pci 0000:00:19.0: reg 0x18: [io  0x2100-0x211f]
[    0.259650] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.259708] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    0.259728] pci 0000:00:1a.0: reg 0x10: [mem 0xf0127000-0xf01273ff]
[    0.259806] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.259866] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.259885] pci 0000:00:1b.0: reg 0x10: [mem 0xf0120000-0xf0123fff 64bit]
[    0.259952] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.260008] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.260079] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.260095] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.260190] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.260343] pci 0000:00:1c.4: [8086:3b4a] type 01 class 0x060400
[    0.260416] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.260430] pci 0000:00:1c.4: Enabling MPC IRBNCE
[    0.260525] pci 0000:00:1c.4: Intel PCH root port ACS workaround enabled
[    0.260678] pci 0000:00:1c.6: [8086:3b4e] type 01 class 0x060400
[    0.260749] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.260763] pci 0000:00:1c.6: Enabling MPC IRBNCE
[    0.260857] pci 0000:00:1c.6: Intel PCH root port ACS workaround enabled
[    0.261007] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    0.261026] pci 0000:00:1d.0: reg 0x10: [mem 0xf0128000-0xf01283ff]
[    0.261101] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.261158] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.261257] pci 0000:00:1f.0: [8086:3b0a] type 00 class 0x060100
[    0.261402] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.261418] pci 0000:00:1f.2: reg 0x10: [io  0x2188-0x218f]
[    0.261424] pci 0000:00:1f.2: reg 0x14: [io  0x21a0-0x21a3]
[    0.261430] pci 0000:00:1f.2: reg 0x18: [io  0x2190-0x2197]
[    0.261437] pci 0000:00:1f.2: reg 0x1c: [io  0x21a4-0x21a7]
[    0.261443] pci 0000:00:1f.2: reg 0x20: [io  0x2120-0x213f]
[    0.261449] pci 0000:00:1f.2: reg 0x24: [mem 0xf0126000-0xf01267ff]
[    0.261485] pci 0000:00:1f.2: PME# supported from D3hot
[    0.261585] pci 0000:01:00.0: [1002:677b] type 00 class 0x030000
[    0.261606] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.261616] pci 0000:01:00.0: reg 0x18: [mem 0xf0000000-0xf001ffff 64bit]
[    0.261623] pci 0000:01:00.0: reg 0x20: [io  0x1100-0x11ff]
[    0.261636] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.261679] pci 0000:01:00.0: supports D1 D2
[    0.261740] pci 0000:01:00.1: [1002:aa98] type 00 class 0x040300
[    0.261760] pci 0000:01:00.1: reg 0x10: [mem 0xf0020000-0xf0023fff 64bit]
[    0.261794] pci 0000:01:00.1: enabling Extended Tags
[    0.261929] pci 0000:01:00.1: supports D1 D2
[    0.262134] pci 0000:00:03.0: ASPM: current common clock configuration is broken, reconfiguring
[    0.274127] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.274223] pci 0000:00:03.0:   bridge window [io  0x1000-0x1fff]
[    0.274225] pci 0000:00:03.0:   bridge window [mem 0xf0000000-0xf00fffff]
[    0.274228] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.274276] pci 0000:00:1c.0: PCI bridge to [bus 18]
[    0.274420] pci 0000:00:1c.4: PCI bridge to [bus 24]
[    0.274564] pci 0000:00:1c.6: PCI bridge to [bus 30]
[    0.274679] pci_bus 0000:0d: extended config space not accessible
[    0.274852] pci 0000:00:1e.0: PCI bridge to [bus 0d] (subtractive decode)
[    0.274956] pci 0000:00:1e.0:   bridge window [mem 0xf8000000-0xfdffffff window] (subtractive decode)
[    0.274957] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.274958] pci 0000:00:1e.0:   bridge window [io  0x1000-0x2fff window] (subtractive decode)
[    0.274959] pci 0000:00:1e.0:   bridge window [io  0x3000-0x6fff window] (subtractive decode)
[    0.274960] pci 0000:00:1e.0:   bridge window [io  0x7000-0xafff window] (subtractive decode)
[    0.274961] pci 0000:00:1e.0:   bridge window [io  0xb000-0xffff window] (subtractive decode)
[    0.274962] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.274963] pci 0000:00:1e.0:   bridge window [mem 0xe0000000-0xf3ffffff window] (subtractive decode)
[    0.274964] pci 0000:00:1e.0:   bridge window [mem 0xfed40000-0xfed44fff window] (subtractive decode)
[    0.274986] pci_bus 0000:00: on NUMA node 0
[    0.275279] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
[    0.275420] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
[    0.275559] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
[    0.275697] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 14 15)
[    0.275837] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 14 15)
[    0.275976] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 14 15)
[    0.276115] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 14 15)
[    0.276253] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
[    0.276565] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.276565] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.276565] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.276565] vgaarb: loaded
[    0.276565] SCSI subsystem initialized
[    0.276565] libata version 3.00 loaded.
[    0.276565] ACPI: bus type USB registered
[    0.276565] usbcore: registered new interface driver usbfs
[    0.276565] usbcore: registered new interface driver hub
[    0.276565] usbcore: registered new device driver usb
[    0.276565] PCI: Using ACPI for IRQ routing
[    0.278978] PCI: Discovered peer bus 3f
[    0.279069] PCI: root bus 3f: using default resources
[    0.279069] PCI: Probing PCI hardware (bus 3f)
[    0.279084] PCI host bridge to bus 0000:3f
[    0.279177] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.279272] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfffffffff]
[    0.279368] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    0.279537] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.279541] pci 0000:3f:00.0: [8086:2c51] type 00 class 0x060000
[    0.279575] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    0.279608] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    0.279638] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    0.279669] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    0.279698] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    0.279730] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    0.279762] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    0.279792] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    0.279821] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    0.279851] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    0.279882] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    0.279911] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    0.279941] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    0.279971] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    0.280010] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    0.280011] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.280015] PCI: pci_cache_line_size set to 64 bytes
[    0.280064] e820: reserve RAM buffer [mem 0x0009f800-0x0009ffff]
[    0.280065] e820: reserve RAM buffer [mem 0xdbfac440-0xdbffffff]
[    0.280140] HPET: 8 timers in total, 5 timers will be used for per-cpu timer
[    0.280140] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 24, 25, 26, 27, 28, 0
[    0.280140] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.282129] hpet: hpet2 irq 24 for MSI
[    0.282136] hpet: hpet3 irq 25 for MSI
[    0.282139] hpet: hpet4 irq 26 for MSI
[    0.282139] hpet: hpet5 irq 27 for MSI
[    0.282139] hpet: hpet6 irq 28 for MSI
[    0.282139] clocksource: Switched to clocksource tsc-early
[    0.282267] *** VALIDATE hugetlbfs ***
[    0.282421] AppArmor: AppArmor Filesystem Enabled
[    0.282527] pnp: PnP ACPI init
[    0.282652] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.282670] pnp 00:01: Plug and Play ACPI device, IDs PNP0f13 PNP0f0e (active)
[    0.282685] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.282868] pnp 00:03: [dma 3]
[    0.282879] pnp 00:03: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.283035] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 PNP0500 (active)
[    0.283071] pnp 00:05: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
[    0.283226] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.283266] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    0.283365] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.283404] system 00:08: [io  0x0400-0x041f] has been reserved
[    0.283500] system 00:08: [io  0x0420-0x043f] has been reserved
[    0.283594] system 00:08: [io  0x0440-0x045f] has been reserved
[    0.283689] system 00:08: [io  0x0460-0x047f] has been reserved
[    0.283785] system 00:08: [io  0x0480-0x048f] has been reserved
[    0.283879] system 00:08: [io  0xf800-0xf81f] has been reserved
[    0.283974] system 00:08: [io  0xf820-0xf83f] has been reserved
[    0.284070] system 00:08: [io  0xf840-0xf85f] has been reserved
[    0.284165] system 00:08: [io  0xf860-0xf87f] has been reserved
[    0.284260] system 00:08: [io  0xfa00-0xfa3f] has been reserved
[    0.284355] system 00:08: [io  0xfc00-0xfc7f] has been reserved
[    0.284453] system 00:08: [io  0xfc80-0xfcff] has been reserved
[    0.284548] system 00:08: [io  0xfe00-0xfe7f] has been reserved
[    0.284645] system 00:08: [io  0xfe80-0xfeff] has been reserved
[    0.284742] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.285005] system 00:09: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.285104] system 00:09: [mem 0x00100000-0xdfffffff] could not be reserved
[    0.285202] system 00:09: [mem 0x000e4000-0x000fffff] could not be reserved
[    0.285299] system 00:09: [mem 0xfec01000-0xfecfffff] has been reserved
[    0.285396] system 00:09: [mem 0xfed00400-0xfed3ffff] has been reserved
[    0.285492] system 00:09: [mem 0xfed45000-0xffffffff] could not be reserved
[    0.285589] system 00:09: [mem 0xf4000000-0xf7ffffff] has been reserved
[    0.285686] system 00:09: [mem 0x000c4000-0x000cffff] could not be reserved
[    0.285783] system 00:09: [mem 0x000d2000-0x000e3fff] has been reserved
[    0.285882] system 00:09: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.285889] pnp: PnP ACPI: found 10 devices
[    0.291412] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.291588] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 18] add_size 1000
[    0.291590] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 18] add_size 200000 add_align 100000
[    0.291591] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 18] add_size 200000 add_align 100000
[    0.291593] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 24] add_size 1000
[    0.291594] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 24] add_size 200000 add_align 100000
[    0.291595] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff] to [bus 24] add_size 200000 add_align 100000
[    0.291597] pci 0000:00:1c.6: bridge window [io  0x1000-0x0fff] to [bus 30] add_size 1000
[    0.291598] pci 0000:00:1c.6: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 30] add_size 200000 add_align 100000
[    0.291599] pci 0000:00:1c.6: bridge window [mem 0x00100000-0x000fffff] to [bus 30] add_size 200000 add_align 100000
[    0.291605] pci 0000:00:1c.0: BAR 14: assigned [mem 0xf8000000-0xf81fffff]
[    0.291706] pci 0000:00:1c.0: BAR 15: assigned [mem 0xf8200000-0xf83fffff 64bit pref]
[    0.291874] pci 0000:00:1c.4: BAR 14: assigned [mem 0xf8400000-0xf85fffff]
[    0.291974] pci 0000:00:1c.4: BAR 15: assigned [mem 0xf8600000-0xf87fffff 64bit pref]
[    0.292142] pci 0000:00:1c.6: BAR 14: assigned [mem 0xf8800000-0xf89fffff]
[    0.292242] pci 0000:00:1c.6: BAR 15: assigned [mem 0xf8a00000-0xf8bfffff 64bit pref]
[    0.292411] pci 0000:00:1c.0: BAR 13: assigned [io  0x3000-0x3fff]
[    0.292508] pci 0000:00:1c.4: BAR 13: assigned [io  0x4000-0x4fff]
[    0.292605] pci 0000:00:1c.6: BAR 13: assigned [io  0x5000-0x5fff]
[    0.292704] pci 0000:01:00.0: BAR 6: assigned [mem 0xf0040000-0xf005ffff pref]
[    0.292873] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.292968] pci 0000:00:03.0:   bridge window [io  0x1000-0x1fff]
[    0.293065] pci 0000:00:03.0:   bridge window [mem 0xf0000000-0xf00fffff]
[    0.293163] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.293334] pci 0000:00:1c.0: PCI bridge to [bus 18]
[    0.293429] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.293526] pci 0000:00:1c.0:   bridge window [mem 0xf8000000-0xf81fffff]
[    0.293623] pci 0000:00:1c.0:   bridge window [mem 0xf8200000-0xf83fffff 64bit pref]
[    0.293792] pci 0000:00:1c.4: PCI bridge to [bus 24]
[    0.293886] pci 0000:00:1c.4:   bridge window [io  0x4000-0x4fff]
[    0.293983] pci 0000:00:1c.4:   bridge window [mem 0xf8400000-0xf85fffff]
[    0.294081] pci 0000:00:1c.4:   bridge window [mem 0xf8600000-0xf87fffff 64bit pref]
[    0.294257] pci 0000:00:1c.6: PCI bridge to [bus 30]
[    0.294351] pci 0000:00:1c.6:   bridge window [io  0x5000-0x5fff]
[    0.294449] pci 0000:00:1c.6:   bridge window [mem 0xf8800000-0xf89fffff]
[    0.294547] pci 0000:00:1c.6:   bridge window [mem 0xf8a00000-0xf8bfffff 64bit pref]
[    0.297023] pci 0000:00:1e.0: PCI bridge to [bus 0d]
[    0.297124] pci_bus 0000:00: resource 4 [mem 0xf8000000-0xfdffffff window]
[    0.297125] pci_bus 0000:00: resource 5 [io  0x0000-0x0cf7 window]
[    0.297126] pci_bus 0000:00: resource 6 [io  0x1000-0x2fff window]
[    0.297127] pci_bus 0000:00: resource 7 [io  0x3000-0x6fff window]
[    0.297128] pci_bus 0000:00: resource 8 [io  0x7000-0xafff window]
[    0.297128] pci_bus 0000:00: resource 9 [io  0xb000-0xffff window]
[    0.297130] pci_bus 0000:00: resource 10 [mem 0x000a0000-0x000bffff window]
[    0.297131] pci_bus 0000:00: resource 11 [mem 0xe0000000-0xf3ffffff window]
[    0.297132] pci_bus 0000:00: resource 12 [mem 0xfed40000-0xfed44fff window]
[    0.297133] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    0.297134] pci_bus 0000:01: resource 1 [mem 0xf0000000-0xf00fffff]
[    0.297135] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xefffffff 64bit pref]
[    0.297136] pci_bus 0000:18: resource 0 [io  0x3000-0x3fff]
[    0.297136] pci_bus 0000:18: resource 1 [mem 0xf8000000-0xf81fffff]
[    0.297137] pci_bus 0000:18: resource 2 [mem 0xf8200000-0xf83fffff 64bit pref]
[    0.297138] pci_bus 0000:24: resource 0 [io  0x4000-0x4fff]
[    0.297139] pci_bus 0000:24: resource 1 [mem 0xf8400000-0xf85fffff]
[    0.297140] pci_bus 0000:24: resource 2 [mem 0xf8600000-0xf87fffff 64bit pref]
[    0.297141] pci_bus 0000:30: resource 0 [io  0x5000-0x5fff]
[    0.297142] pci_bus 0000:30: resource 1 [mem 0xf8800000-0xf89fffff]
[    0.297143] pci_bus 0000:30: resource 2 [mem 0xf8a00000-0xf8bfffff 64bit pref]
[    0.297144] pci_bus 0000:0d: resource 4 [mem 0xf8000000-0xfdffffff window]
[    0.297145] pci_bus 0000:0d: resource 5 [io  0x0000-0x0cf7 window]
[    0.297146] pci_bus 0000:0d: resource 6 [io  0x1000-0x2fff window]
[    0.297147] pci_bus 0000:0d: resource 7 [io  0x3000-0x6fff window]
[    0.297148] pci_bus 0000:0d: resource 8 [io  0x7000-0xafff window]
[    0.297149] pci_bus 0000:0d: resource 9 [io  0xb000-0xffff window]
[    0.297150] pci_bus 0000:0d: resource 10 [mem 0x000a0000-0x000bffff window]
[    0.297151] pci_bus 0000:0d: resource 11 [mem 0xe0000000-0xf3ffffff window]
[    0.297152] pci_bus 0000:0d: resource 12 [mem 0xfed40000-0xfed44fff window]
[    0.297184] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    0.297185] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    0.297210] NET: Registered protocol family 2
[    0.297414] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes)
[    0.297595] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    0.297832] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.298054] TCP: Hash tables configured (established 32768 bind 32768)
[    0.298185] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.298304] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.298454] NET: Registered protocol family 1
[    0.298550] NET: Registered protocol family 44
[    0.299034] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.299227] PCI: CLS 64 bytes, default 64
[    0.299284] DMAR: No ATSR found
[    0.299418] DMAR: dmar0: Using Queued invalidation
[    0.299560] pci 0000:00:00.0: DMAR: Hardware identity mapping
[    0.299656] pci 0000:00:03.0: DMAR: Hardware identity mapping
[    0.299752] pci 0000:00:08.0: DMAR: Hardware identity mapping
[    0.299847] pci 0000:00:08.1: DMAR: Hardware identity mapping
[    0.299941] pci 0000:00:08.2: DMAR: Hardware identity mapping
[    0.300037] pci 0000:00:08.3: DMAR: Hardware identity mapping
[    0.300132] pci 0000:00:10.0: DMAR: Hardware identity mapping
[    0.300227] pci 0000:00:10.1: DMAR: Hardware identity mapping
[    0.300322] pci 0000:00:16.0: DMAR: Hardware identity mapping
[    0.300419] pci 0000:00:16.3: DMAR: Hardware identity mapping
[    0.300513] pci 0000:00:19.0: DMAR: Hardware identity mapping
[    0.300608] pci 0000:00:1a.0: DMAR: Hardware identity mapping
[    0.300703] pci 0000:00:1b.0: DMAR: Hardware identity mapping
[    0.300798] pci 0000:00:1c.0: DMAR: Hardware identity mapping
[    0.300894] pci 0000:00:1c.4: DMAR: Hardware identity mapping
[    0.300988] pci 0000:00:1c.6: DMAR: Hardware identity mapping
[    0.301083] pci 0000:00:1d.0: DMAR: Hardware identity mapping
[    0.301178] pci 0000:00:1f.0: DMAR: Hardware identity mapping
[    0.301273] pci 0000:00:1f.2: DMAR: Hardware identity mapping
[    0.301369] pci 0000:01:00.0: DMAR: Hardware identity mapping
[    0.301464] pci 0000:01:00.1: DMAR: Hardware identity mapping
[    0.301558] pci 0000:3f:00.0: DMAR: Hardware identity mapping
[    0.301654] pci 0000:3f:00.1: DMAR: Hardware identity mapping
[    0.301749] pci 0000:3f:02.0: DMAR: Hardware identity mapping
[    0.301845] pci 0000:3f:02.1: DMAR: Hardware identity mapping
[    0.301939] pci 0000:3f:03.0: DMAR: Hardware identity mapping
[    0.302034] pci 0000:3f:03.1: DMAR: Hardware identity mapping
[    0.302134] pci 0000:3f:03.4: DMAR: Hardware identity mapping
[    0.302231] pci 0000:3f:04.0: DMAR: Hardware identity mapping
[    0.302327] pci 0000:3f:04.1: DMAR: Hardware identity mapping
[    0.302421] pci 0000:3f:04.2: DMAR: Hardware identity mapping
[    0.302515] pci 0000:3f:04.3: DMAR: Hardware identity mapping
[    0.302611] pci 0000:3f:05.0: DMAR: Hardware identity mapping
[    0.302705] pci 0000:3f:05.1: DMAR: Hardware identity mapping
[    0.302801] pci 0000:3f:05.2: DMAR: Hardware identity mapping
[    0.302895] pci 0000:3f:05.3: DMAR: Hardware identity mapping
[    0.302989] DMAR: Setting RMRR:
[    0.303080] pci 0000:00:1a.0: DMAR: Ignoring identity map for HW passthrough [0xdbfde000 - 0xdbfe7fff]
[    0.303249] pci 0000:00:1d.0: DMAR: Ignoring identity map for HW passthrough [0xdbfde000 - 0xdbfe7fff]
[    0.303421] DMAR: Prepare 0-16MiB unity mapping for LPC
[    0.303515] pci 0000:00:1f.0: DMAR: Ignoring identity map for HW passthrough [0x0 - 0xffffff]
[    0.303701] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.303819] pci 0000:00:00.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.303991] pci 0000:00:00.0: Adding to iommu group 0
[    0.304091] pci 0000:00:03.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.304264] pci 0000:00:03.0: Adding to iommu group 1
[    0.304385] pci 0000:00:08.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.304556] pci 0000:00:08.0: Adding to iommu group 2
[    0.304657] pci 0000:00:08.1: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.304830] pci 0000:00:08.1: Adding to iommu group 2
[    0.304930] pci 0000:00:08.2: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.305103] pci 0000:00:08.2: Adding to iommu group 2
[    0.305203] pci 0000:00:08.3: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.305376] pci 0000:00:08.3: Adding to iommu group 2
[    0.305486] pci 0000:00:10.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.305659] pci 0000:00:10.0: Adding to iommu group 3
[    0.305759] pci 0000:00:10.1: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.305932] pci 0000:00:10.1: Adding to iommu group 3
[    0.306043] pci 0000:00:16.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.306222] pci 0000:00:16.0: Adding to iommu group 4
[    0.306324] pci 0000:00:16.3: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.306496] pci 0000:00:16.3: Adding to iommu group 4
[    0.306597] pci 0000:00:19.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.306770] pci 0000:00:19.0: Adding to iommu group 5
[    0.306872] pci 0000:00:1a.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.307044] pci 0000:00:1a.0: Adding to iommu group 6
[    0.307146] pci 0000:00:1b.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.307318] pci 0000:00:1b.0: Adding to iommu group 7
[    0.307420] pci 0000:00:1c.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.307594] pci 0000:00:1c.0: Adding to iommu group 8
[    0.307695] pci 0000:00:1c.4: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.307869] pci 0000:00:1c.4: Adding to iommu group 9
[    0.307970] pci 0000:00:1c.6: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.308142] pci 0000:00:1c.6: Adding to iommu group 10
[    0.308244] pci 0000:00:1d.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.308417] pci 0000:00:1d.0: Adding to iommu group 11
[    0.308519] pci 0000:00:1e.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.308691] pci 0000:00:1e.0: Adding to iommu group 12
[    0.308801] pci 0000:00:1f.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.308973] pci 0000:00:1f.0: Adding to iommu group 13
[    0.309076] pci 0000:00:1f.2: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.309249] pci 0000:00:1f.2: Adding to iommu group 13
[    0.309364] pci 0000:01:00.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.309536] pci 0000:01:00.0: Adding to iommu group 14
[    0.309643] pci 0000:01:00.1: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.309817] pci 0000:01:00.1: Adding to iommu group 14
[    0.309927] pci 0000:3f:00.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.310099] pci 0000:3f:00.0: Adding to iommu group 15
[    0.310206] pci 0000:3f:00.1: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.310376] pci 0000:3f:00.1: Adding to iommu group 15
[    0.310485] pci 0000:3f:02.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.310656] pci 0000:3f:02.0: Adding to iommu group 16
[    0.310758] pci 0000:3f:02.1: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.310929] pci 0000:3f:02.1: Adding to iommu group 16
[    0.311043] pci 0000:3f:03.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.311214] pci 0000:3f:03.0: Adding to iommu group 17
[    0.311316] pci 0000:3f:03.1: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.311486] pci 0000:3f:03.1: Adding to iommu group 17
[    0.311587] pci 0000:3f:03.4: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.311759] pci 0000:3f:03.4: Adding to iommu group 17
[    0.311878] pci 0000:3f:04.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.312048] pci 0000:3f:04.0: Adding to iommu group 18
[    0.312151] pci 0000:3f:04.1: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.312323] pci 0000:3f:04.1: Adding to iommu group 18
[    0.312427] pci 0000:3f:04.2: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.312600] pci 0000:3f:04.2: Adding to iommu group 18
[    0.312702] pci 0000:3f:04.3: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.312873] pci 0000:3f:04.3: Adding to iommu group 18
[    0.312992] pci 0000:3f:05.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.313164] pci 0000:3f:05.0: Adding to iommu group 19
[    0.313267] pci 0000:3f:05.1: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.313440] pci 0000:3f:05.1: Adding to iommu group 19
[    0.313543] pci 0000:3f:05.2: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.313714] pci 0000:3f:05.2: Adding to iommu group 19
[    0.313817] pci 0000:3f:05.3: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.313988] pci 0000:3f:05.3: Adding to iommu group 19
[    0.316204] workingset: timestamp_bits=46 max_order=20 bucket_order=0
[    0.318763] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.318934] io scheduler mq-deadline registered
[    0.319265] genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
[    0.319440] pcie_bw_notification: probe of 0000:00:03.0:pcie010 failed with error -22
[    0.322462] intel_idle: MWAIT substates: 0x1120
[    0.322462] intel_idle: v0.4.1 model 0x1E
[    0.322788] intel_idle: lapic_timer_reliable_states 0x2
[    0.322832] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.323013] ACPI: Power Button [PBTN]
[    0.323130] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.323302] ACPI: Power Button [PWRF]
[    0.323687] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.344305] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.365297] 0000:00:16.3: ttyS1 at I/O 0x2180 (irq = 17, base_baud = 115200) is a 16550A
[    0.365690] Linux agpgart interface v0.103
[    0.366445] ahci 0000:00:1f.2: version 3.0
[    0.366793] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x17 impl SATA mode
[    0.366966] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part sxs apst
[    0.367885] scsi host0: ahci
[    0.368252] scsi host1: ahci
[    0.368589] scsi host2: ahci
[    0.368917] scsi host3: ahci
[    0.369259] scsi host4: ahci
[    0.369584] scsi host5: ahci
[    0.369732] ata1: SATA max UDMA/133 abar m2048@0xf0126000 port 0xf0126100 irq 31
[    0.369902] ata2: SATA max UDMA/133 abar m2048@0xf0126000 port 0xf0126180 irq 31
[    0.370070] ata3: SATA max UDMA/133 abar m2048@0xf0126000 port 0xf0126200 irq 31
[    0.370247] ata4: DUMMY
[    0.370337] ata5: SATA max UDMA/133 abar m2048@0xf0126000 port 0xf0126300 irq 31
[    0.370504] ata6: DUMMY
[    0.370626] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.370724] ehci-pci: EHCI PCI platform driver
[    0.370929] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    0.371028] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    0.371206] ehci-pci 0000:00:1a.0: debug port 2
[    0.371307] ehci-pci 0000:00:1a.0: DMAR: 32bit DMA uses non-identity mapping
[    0.371453] ehci-pci 0000:00:1a.0: DMAR: Setting identity map [0xdbfde000 - 0xdbfe7fff]
[    0.375531] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    0.375541] ehci-pci 0000:00:1a.0: irq 20, io mem 0xf0127000
[    0.390359] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    0.390489] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.01
[    0.390660] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.390883] usb usb1: Product: EHCI Host Controller
[    0.390977] usb usb1: Manufacturer: Linux 5.1.0-rc1 ehci_hcd
[    0.391072] usb usb1: SerialNumber: 0000:00:1a.0
[    0.391435] hub 1-0:1.0: USB hub found
[    0.391542] hub 1-0:1.0: 3 ports detected
[    0.391834] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.391933] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    0.392109] ehci-pci 0000:00:1d.0: debug port 2
[    0.392211] ehci-pci 0000:00:1d.0: DMAR: 32bit DMA uses non-identity mapping
[    0.392355] ehci-pci 0000:00:1d.0: DMAR: Setting identity map [0xdbfde000 - 0xdbfe7fff]
[    0.396436] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    0.396440] ehci-pci 0000:00:1d.0: irq 20, io mem 0xf0128000
[    0.410353] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.410479] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.01
[    0.410646] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.410868] usb usb2: Product: EHCI Host Controller
[    0.410961] usb usb2: Manufacturer: Linux 5.1.0-rc1 ehci_hcd
[    0.411056] usb usb2: SerialNumber: 0000:00:1d.0
[    0.411421] hub 2-0:1.0: USB hub found
[    0.411525] hub 2-0:1.0: 3 ports detected
[    0.411732] usbcore: registered new interface driver usb-storage
[    0.411848] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
[    0.415080] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.415178] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.415699] mousedev: PS/2 mouse device common for all mice
[    0.415848] rtc_cmos 00:00: RTC can wake from S4
[    0.416119] rtc_cmos 00:00: registered as rtc0
[    0.416239] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.416412] intel_pstate: CPU ID not supported
[    0.416511] hidraw: raw HID events driver (C) Jiri Kosina
[    0.416618] usbcore: registered new interface driver usbhid
[    0.416712] usbhid: USB HID core driver
[    0.416960] NET: Registered protocol family 10
[    0.419772] Segment Routing with IPv6
[    0.419897] mip6: Mobile IPv6
[    0.419988] NET: Registered protocol family 17
[    0.420203] Key type dns_resolver registered
[    0.421491] RAS: Correctable Errors collector initialized.
[    0.421646] microcode: sig=0x106e5, pf=0x2, revision=0xa
[    0.421989] microcode: Microcode Update Driver: v2.2.
[    0.421995] sched_clock: Marking stable (407786702, 14198716)->(530440319, -108454901)
[    0.422673] registered taskstats version 1
[    0.422776] AppArmor: AppArmor sha1 policy hashing enabled
[    0.422966] printk: console [netcon0] enabled
[    0.423059] netconsole: network logging started
[    0.423245] rtc_cmos 00:00: setting system clock to 2019-03-18T20:29:31 UTC (1552940971)
[    0.526337] random: fast init done
[    0.686357] ata5: SATA link down (SStatus 0 SControl 300)
[    0.686482] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.686779] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    0.686905] ata3: SATA link down (SStatus 0 SControl 300)
[    0.687584] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
[    0.687762] ata1.00: ACPI cmd ef/03:45:00:00:00:a0 (SET FEATURES) filtered out
[    0.688152] ata1.00: ACPI cmd c6/00:10:00:00:00:a0 (SET MULTIPLE MODE) succeeded
[    0.688366] ata1.00: ACPI cmd e3/00:00:00:00:00:a0 (IDLE) succeeded
[    0.688370] ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 (DEVICE CONFIGURATION OVERLAY) filtered out
[    0.688550] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    0.688719] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    0.689170] ata2.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
[    0.689348] ata2.00: ACPI cmd ef/03:45:00:00:00:a0 (SET FEATURES) filtered out
[    0.689517] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    0.689691] ata2.00: ATAPI: hp       CDDVDW TS-H653T, H6D1, max UDMA/100
[    0.690017] ata1.00: ATA-8: Hitachi HDS721025CLA682, JP1OA41A, max UDMA/133
[    0.690228] ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    0.691566] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
[    0.691745] ata1.00: ACPI cmd ef/03:45:00:00:00:a0 (SET FEATURES) filtered out
[    0.692196] ata2.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
[    0.692374] ata2.00: ACPI cmd ef/03:45:00:00:00:a0 (SET FEATURES) filtered out
[    0.692542] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    0.692713] ata2.00: configured for UDMA/100
[    0.692809] ata1.00: ACPI cmd c6/00:10:00:00:00:a0 (SET MULTIPLE MODE) succeeded
[    0.693026] ata1.00: ACPI cmd e3/00:00:00:00:00:a0 (IDLE) succeeded
[    0.693030] ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 (DEVICE CONFIGURATION OVERLAY) filtered out
[    0.693210] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    0.693377] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    0.694592] ata1.00: configured for UDMA/133
[    0.695177] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72102 A41A PQ: 0 ANSI: 5
[    0.695831] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.695843] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    0.696102] sd 0:0:0:0: [sda] Write Protect is off
[    0.696196] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.696207] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.696389] sd 0:0:0:0: [sda] Optimal transfer size 0 bytes < PAGE_SIZE (4096 bytes)
[    0.696735] scsi 1:0:0:0: CD-ROM            hp       CDDVDW TS-H653T  H6D1 PQ: 0 ANSI: 5
[    0.726357] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    0.737837]  sda: sda1 sda2 < sda5 >
[    0.738407] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.746353] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    0.753683] sr 1:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[    0.753864] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.754231] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.754409] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    0.826296] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    0.826475] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    0.872028] devtmpfs: mounted
[    0.872415] Freeing unused kernel image memory: 924K
[    0.883191] usb 1-1: New USB device found, idVendor=8087, idProduct=0020, bcdDevice= 0.00
[    0.883370] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    0.883817] hub 1-1:1.0: USB hub found
[    0.884122] hub 1-1:1.0: 6 ports detected
[    0.886251] Write protecting the kernel read-only data: 14336k
[    0.887102] Freeing unused kernel image memory: 2008K
[    0.887327] Freeing unused kernel image memory: 104K
[    0.894746] mei mei::55213584-9a29-4916-badf-0fb7ed682aeb:01: Could not read FW version
[    0.894915] mei mei::55213584-9a29-4916-badf-0fb7ed682aeb:01: FW version command failed -5
[    0.896074] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.898579] x86/mm: Checking user space page tables
[    0.902871] usb 2-1: New USB device found, idVendor=8087, idProduct=0020, bcdDevice= 0.00
[    0.903041] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    0.903383] hub 2-1:1.0: USB hub found
[    0.903606] hub 2-1:1.0: 8 ports detected
[    0.906818] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.906914] Run /sbin/init as init process
[    1.170327] usb 1-1.1: new low-speed USB device number 3 using ehci-pci
[    1.308720] usb 1-1.1: New USB device found, idVendor=046d, idProduct=c30e, bcdDevice= 1.80
[    1.308901] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.309070] usb 1-1.1: Product: HID compliant keyboard
[    1.309165] usb 1-1.1: Manufacturer: Logitech
[    1.321317] input: Logitech HID compliant keyboard as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/0003:046D:C30E.0001/input/input4
[    1.338245] tsc: Refined TSC clocksource calibration: 2926.338 MHz
[    1.338356] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2a2e7390952, max_idle_ns: 440795292405 ns
[    1.338677] clocksource: Switched to clocksource tsc
[    1.378503] hid-generic 0003:046D:C30E.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech HID compliant keyboard] on usb-0000:00:1a.0-1.1/input0
[    1.393934] input: Logitech HID compliant keyboard Consumer Control as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.1/0003:046D:C30E.0002/input/input5
[    1.454281] input: Logitech HID compliant keyboard System Control as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.1/0003:046D:C30E.0002/input/input6
[    1.454729] hid-generic 0003:046D:C30E.0002: input,hidraw1: USB HID v1.10 Device [Logitech HID compliant keyboard] on usb-0000:00:1a.0-1.1/input1
[    1.534248] usb 1-1.2: new high-speed USB device number 4 using ehci-pci
[    1.642980] usb 1-1.2: New USB device found, idVendor=0424, idProduct=2512, bcdDevice= b.b3
[    1.643161] usb 1-1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.643888] hub 1-1.2:1.0: USB hub found
[    1.644183] hub 1-1.2:1.0: 2 ports detected
[    3.126676] systemd[1]: Inserted module 'autofs4'
[    3.370420] random: crng init done
[    3.370652] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    3.390437] systemd[1]: Detected architecture x86-64.
[    3.432563] systemd[1]: Set hostname to <prometheus>.
[    8.307102] systemd[1]: Listening on LVM2 poll daemon socket.
[    8.307493] systemd[1]: Reached target Remote File Systems.
[    8.309448] systemd[1]: Created slice User and Session Slice.
[    8.309843] systemd[1]: Listening on Syslog Socket.
[    8.310258] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    8.310645] systemd[1]: Listening on udev Kernel Socket.
[    8.311040] systemd[1]: Listening on Journal Socket (/dev/log).
[    8.472135] systemd[1]: Starting Load Kernel Modules...
[    8.473089] systemd[1]: Starting File System Check on Root Device...
[    8.769523] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    8.770371] systemd[1]: Starting Nameserver information manager...
[    8.772700] systemd[1]: Starting Journal Service...
[    8.773686] systemd[1]: Mounting Huge Pages File System...
[    8.774163] systemd[1]: Listening on udev Control Socket.
[    8.775370] systemd[1]: Starting udev Coldplug all Devices...
[    8.776493] systemd[1]: Mounting POSIX Message Queue File System...
[    8.776836] systemd[1]: Reached target Slices.
[    9.123419] lp: driver loaded but no devices found
[    9.213284] parport_pc 00:03: reported by Plug and Play ACPI
[    9.213436] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[    9.214471] parport_pc 00:03: DMAR: Allocating domain failed
[    9.214566] parport0: cannot get buffer for DMA, resorting to PIO operation
[    9.314454] lp0: using parport0 (interrupt-driven).
[    9.482955] i2c /dev entries driver
[    9.545113] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    9.586289] loop: module loaded
[    9.649949] systemd-journald[211]: Received request to flush runtime journal from PID 1
[   11.643274] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   11.643374] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   11.643601] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   11.769908] iTCO_vendor_support: vendor-support=0
[   11.779707] tpm_tis 00:05: 1.2 TPM (device-id 0xB, rev-id 16)
[   11.780663] input: PC Speaker as /devices/platform/pcspkr/input/input7
[   11.799506] tpm tpm0: TPM is disabled/deactivated (0x7)
[   11.815014] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.815131] iTCO_wdt: Found a Q57 TCO device (Version=2, TCOBASE=0xf860)
[   11.815323] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   11.843500] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 78:e3:b5:a0:e5:e4
[   11.843668] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[   11.843814] e1000e 0000:00:19.0 eth0: MAC: 9, PHY: 9, PBA No: A002FF-0FF
[   12.226197] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[   12.346866] pktcdvd: pktcdvd0: writer mapped to sr0
[   12.509505] Error: Driver 'pcspkr' is already registered, aborting...
[   12.509574] [drm] radeon kernel modesetting enabled.
[   12.509754] radeon 0000:01:00.0: vgaarb: deactivate vga console
[   12.511387] Console: switching to colour dummy device 80x25
[   12.511636] [drm] initializing kernel modesetting (CAICOS 0x1002:0x677B 0x103C:0x90B7 0x00).
[   12.511680] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than pnp 00:09 [mem 0x000d2000-0x000e3fff]
[   12.511686] caller pci_map_rom+0x65/0x178 mapping multiple BARs
[   12.511710] ATOM BIOS: HP
[   12.512176] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[   12.512179] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[   12.512184] [drm] Detected VRAM RAM=1024M, BAR=256M
[   12.512186] [drm] RAM width 64bits DDR
[   12.512294] [TTM] Zone  kernel: Available graphics memory: 2018538 kiB
[   12.512298] [TTM] Initializing pool allocator
[   12.512304] [TTM] Initializing DMA pool allocator
[   12.512323] [drm] radeon: 1024M of VRAM memory ready
[   12.512327] [drm] radeon: 1024M of GTT memory ready.
[   12.512340] [drm] Loading CAICOS Microcode
[   12.725391] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card1/input9
[   12.788604] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC662 rev1: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[   12.788610] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   12.788613] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   12.788616] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   12.788618] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   12.788620] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
[   12.788622] snd_hda_codec_realtek hdaudioC0D0:      Line=0x18
[   12.799913] input: HDA Intel MID Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   12.799976] input: HDA Intel MID Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   12.800034] input: HDA Intel MID Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   12.800090] input: HDA Intel MID Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   12.834322] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input8
[   12.985368] [drm] Internal thermal controller with fan control
[   12.990762] [drm] radeon: dpm initialized
[   13.082764] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   13.083667] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[   13.091663] [drm] PCIE GART of 1024M enabled (table at 0x0000000000162000).
[   13.091793] radeon 0000:01:00.0: WB enabled
[   13.091796] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x000000005d85445b
[   13.091799] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000000cc21bb
[   13.092547] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118 and cpu addr 0x00000000b2f0d94d
[   13.092551] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.092552] [drm] Driver supports precise vblank timestamp query.
[   13.092554] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[   13.092589] radeon 0000:01:00.0: radeon: using MSI.
[   13.092620] [drm] radeon: irq initialized.
[   13.109236] [drm] ring test on 0 succeeded in 2 usecs
[   13.109248] [drm] ring test on 3 succeeded in 7 usecs
[   13.286099] [drm] ring test on 5 succeeded in 2 usecs
[   13.286117] [drm] UVD initialized successfully.
[   13.286368] [drm] ib test on ring 0 succeeded in 0 usecs
[   13.286456] [drm] ib test on ring 3 succeeded in 0 usecs
[   13.946360] [drm] ib test on ring 5 succeeded
[   13.948584] [drm] Radeon Display Connectors
[   13.948592] [drm] Connector 0:
[   13.948595] [drm]   DP-1
[   13.948599] [drm]   HPD2
[   13.948604] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[   13.948610] [drm]   Encoders:
[   13.948613] [drm]     DFP1: INTERNAL_UNIPHY1
[   13.948618] [drm] Connector 1:
[   13.948621] [drm]   DVI-I-1
[   13.948624] [drm]   HPD4
[   13.948629] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[   13.948634] [drm]   Encoders:
[   13.948638] [drm]     DFP2: INTERNAL_UNIPHY
[   13.948642] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   14.025344] [drm] fb mappable at 0xE0363000
[   14.025346] [drm] vram apper at 0xE0000000
[   14.025348] [drm] size 8294400
[   14.025349] [drm] fb depth is 24
[   14.025350] [drm]    pitch is 7680
[   14.025433] fbcon: radeondrmfb (fb0) is primary device
[   14.057119] Console: switching to colour frame buffer device 240x67
[   14.062714] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[   14.102252] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[   14.382452] Adding 7532540k swap on /dev/sda5.  Priority:-2 extents:1 across:7532540k
[   26.971482] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   26.972652] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   40.409202] radeon_dp_aux_transfer_native: 74 callbacks suppressed
