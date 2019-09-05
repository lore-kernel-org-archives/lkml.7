Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0021C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A122145D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbfIEG6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:58:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:49525 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731065AbfIEG6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:58:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 23:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,469,1559545200"; 
   d="scan'208";a="185358483"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2019 23:58:51 -0700
Date:   Thu, 5 Sep 2019 14:59:17 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dave Airlie <airlied@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rong Chen <rong.a.chen@intel.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, LKP <lkp@01.org>
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8%
 regression
Message-ID: <20190905065917.GE5541@shbuild999.sh.intel.com>
References: <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de>
 <90e78ce8-d46a-5154-c324-a05aa1743c98@intel.com>
 <2e1b4d65-d477-f571-845d-fa0a670859af@suse.de>
 <20190904062716.GC5541@shbuild999.sh.intel.com>
 <72c33bf1-9184-e24a-c084-26d9c8b6f9b7@suse.de>
 <CAKMK7uGdOtyDHZMSzY8J45bX57EFKo=DWNUi+WL+GVOzoBpUhw@mail.gmail.com>
 <20190904083558.GD5541@shbuild999.sh.intel.com>
 <CAKMK7uGVKEN=pi4Erc_gtbL3ZFN-b6pm-nXSznjd_rH4H2yn4w@mail.gmail.com>
 <CAPM=9tzDMfRf_VKaiHmnb_KKVwqW3=y=09JO0SJrG6ySe=DbfQ@mail.gmail.com>
 <CAKMK7uGtNu0M74+Ag5-7HJhuHDVv1HoMPz=2XjU6tCkfMScQnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGtNu0M74+Ag5-7HJhuHDVv1HoMPz=2XjU6tCkfMScQnA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vetter,

On Wed, Sep 04, 2019 at 01:20:29PM +0200, Daniel Vetter wrote:
> On Wed, Sep 4, 2019 at 1:15 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Wed, 4 Sep 2019 at 19:17, Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Wed, Sep 4, 2019 at 10:35 AM Feng Tang <feng.tang@intel.com> wrote:
> > > >
> > > > Hi Daniel,
> > > >
> > > > On Wed, Sep 04, 2019 at 10:11:11AM +0200, Daniel Vetter wrote:
> > > > > On Wed, Sep 4, 2019 at 8:53 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > > >
> > > > > > Hi
> > > > > >
> > > > > > Am 04.09.19 um 08:27 schrieb Feng Tang:
> > > > > > >> Thank you for testing. But don't get too excited, because the patch
> > > > > > >> simulates a bug that was present in the original mgag200 code. A
> > > > > > >> significant number of frames are simply skipped. That is apparently the
> > > > > > >> reason why it's faster.
> > > > > > >
> > > > > > > Thanks for the detailed info, so the original code skips time-consuming
> > > > > > > work inside atomic context on purpose. Is there any space to optmise it?
> > > > > > > If 2 scheduled update worker are handled at almost same time, can one be
> > > > > > > skipped?
> > > > > >
> > > > > > To my knowledge, there's only one instance of the worker. Re-scheduling
> > > > > > the worker before a previous instance started, will not create a second
> > > > > > instance. The worker's instance will complete all pending updates. So in
> > > > > > some way, skipping workers already happens.
> > > > >
> > > > > So I think that the most often fbcon update from atomic context is the
> > > > > blinking cursor. If you disable that one you should be back to the old
> > > > > performance level I think, since just writing to dmesg is from process
> > > > > context, so shouldn't change.
> > > >
> > > > Hmm, then for the old driver, it should also do the most update in
> > > > non-atomic context?
> > > >
> > > > One other thing is, I profiled that updating a 3MB shadow buffer needs
> > > > 20 ms, which transfer to 150 MB/s bandwidth. Could it be related with
> > > > the cache setting of DRM shadow buffer? say the orginal code use a
> > > > cachable buffer?
> > >
> > > Hm, that would indicate the write-combining got broken somewhere. This
> > > should definitely be faster. Also we shouldn't transfer the hole
> > > thing, except when scrolling ...
> >
> > First rule of fbcon usage, you are always effectively scrolling.
> >
> > Also these devices might be on a PCIE 1x piece of wet string, not sure
> > if the numbers reflect that.
> 
> pcie 1x 1.0 is 250MB/s, so yeah with a bit of inefficiency and
> overhead not entirely out of the question that 150MB/s is actually the
> hw limit. If it's really pcie 1x 1.0, no idea where to check that.
> Also might be worth to double-check that the gpu pci bar is listed as
> wc in debugfs/x86/pat_memtype_list.

Here is some dump of the device info and the pat_memtype_list, while it is
running other 0day task:

controller info
=================
03:00.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200e [Pilot] ServerEngines (SEP1) (rev 05) (prog-if 00 [VGA controller])
	Subsystem: Intel Corporation MGA G200e [Pilot] ServerEngines (SEP1)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	NUMA node: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at d1800000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at d1000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e4] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [54] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: mgag200
	Kernel modules: mgag200


Related pat setting
===================
uncached-minus @ 0xc0000000-0xc0001000
uncached-minus @ 0xc0000000-0xd0000000
uncached-minus @ 0xc0008000-0xc0009000
uncached-minus @ 0xc0009000-0xc000a000
uncached-minus @ 0xc0010000-0xc0011000
uncached-minus @ 0xc0011000-0xc0012000
uncached-minus @ 0xc0012000-0xc0013000
uncached-minus @ 0xc0013000-0xc0014000
uncached-minus @ 0xc0018000-0xc0019000
uncached-minus @ 0xc0019000-0xc001a000
uncached-minus @ 0xc001a000-0xc001b000
write-combining @ 0xd0000000-0xd0300000
write-combining @ 0xd0000000-0xd1000000
uncached-minus @ 0xd1800000-0xd1804000
uncached-minus @ 0xd1900000-0xd1980000
uncached-minus @ 0xd1980000-0xd1981000
uncached-minus @ 0xd1a00000-0xd1a80000
uncached-minus @ 0xd1a80000-0xd1a81000
uncached-minus @ 0xd1f10000-0xd1f11000
uncached-minus @ 0xd1f11000-0xd1f12000
uncached-minus @ 0xd1f12000-0xd1f13000

Host bridge info
================
00:00.0 Host bridge: Intel Corporation Device 7853
	Subsystem: Intel Corporation Device 0000
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 0
	NUMA node: 0
	Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		RootCtl: ErrCorrectable+ ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [e0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
	Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
	Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
	Capabilities: [250 v1] #19
	Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
	Capabilities: [298 v1] Vendor Specific Information: ID=0007 Rev=0 Len=024 <?>


Thanks,
Feng


>
> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
