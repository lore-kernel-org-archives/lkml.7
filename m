Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B934C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D2F22CF7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T0AQp8Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbfIEKiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:38:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46576 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfIEKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:38:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id x7so1357065oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tv5zv7d3FEtwudjYamqn7+k4/1WeuNjqzNifKb9iPcY=;
        b=T0AQp8Z6RlhSgmRazaWOtGrXwEZFngAVq5L0iDAp/nE+T+zk/K2ldKZthPSxto3kNq
         pKIFAkUcbIo3USBodDrY/A7J3mHTqXghyzi4cB2P7TiEgVCNCPVEWxTCGGovSOppxDkB
         ib8mQjcIe+on2cK1tbVouERXOoQfERCy5SrDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tv5zv7d3FEtwudjYamqn7+k4/1WeuNjqzNifKb9iPcY=;
        b=tustCnhpYBIuzRgX4SasqVjK1x5TuhReMPW361fC5wjn52qPK3cX7Q6V1PxQIYOzb0
         ezGdFbiuldlgkARBcGJp64mxdOKRtp5JPR/iSWCTzm1JXDNuxBJUFKaxCC6rNBZYcokI
         hlkejZO47rVU0ZebVFo+oXtT3vRf46+wDBx4nFvfEII8d0n09KR7+iovnzfNDdqGoIlp
         TL9RA0/fpISTVckLQqoPtH51sSbg4mmiNWlYyAKAZY9gH5wtIOXrQXpFVQ9CzbLcKmSl
         C2flnZoClXADkidcnt0XAWO8qQxzdQC7EAn2OuOJyR3dOG8BPIvXF9lWFW9bLWvTB1AB
         bdag==
X-Gm-Message-State: APjAAAXk21hWsbHVBGZIBzhkBeqO4fQHggVPJvRrqu/PNXYwttwxVzzH
        7/LZZZ3A4Q8rh98Ydkp4PVseoCIXHtTDKaFMrFicSg==
X-Google-Smtp-Source: APXvYqypOysP5N8fdDTTUQZWV9ARI/nvkJSqknhAHdDvXyc190CkNaJJMrDjJli8RDQMWmr0wUQ5JzeCFIcVsGrk3qw=
X-Received: by 2002:aca:5697:: with SMTP id k145mr1808438oib.101.1567679879301;
 Thu, 05 Sep 2019 03:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de> <90e78ce8-d46a-5154-c324-a05aa1743c98@intel.com>
 <2e1b4d65-d477-f571-845d-fa0a670859af@suse.de> <20190904062716.GC5541@shbuild999.sh.intel.com>
 <72c33bf1-9184-e24a-c084-26d9c8b6f9b7@suse.de> <CAKMK7uGdOtyDHZMSzY8J45bX57EFKo=DWNUi+WL+GVOzoBpUhw@mail.gmail.com>
 <20190904083558.GD5541@shbuild999.sh.intel.com> <CAKMK7uGVKEN=pi4Erc_gtbL3ZFN-b6pm-nXSznjd_rH4H2yn4w@mail.gmail.com>
 <CAPM=9tzDMfRf_VKaiHmnb_KKVwqW3=y=09JO0SJrG6ySe=DbfQ@mail.gmail.com>
 <CAKMK7uGtNu0M74+Ag5-7HJhuHDVv1HoMPz=2XjU6tCkfMScQnA@mail.gmail.com> <20190905065917.GE5541@shbuild999.sh.intel.com>
In-Reply-To: <20190905065917.GE5541@shbuild999.sh.intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 5 Sep 2019 12:37:47 +0200
Message-ID: <CAKMK7uESbH_0_SFUc+v=BhjW0bv4FbL8Dq2UG1fWcSqyue3wig@mail.gmail.com>
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rong Chen <rong.a.chen@intel.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 8:58 AM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi Vetter,
>
> On Wed, Sep 04, 2019 at 01:20:29PM +0200, Daniel Vetter wrote:
> > On Wed, Sep 4, 2019 at 1:15 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Wed, 4 Sep 2019 at 19:17, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Wed, Sep 4, 2019 at 10:35 AM Feng Tang <feng.tang@intel.com> wrote:
> > > > >
> > > > > Hi Daniel,
> > > > >
> > > > > On Wed, Sep 04, 2019 at 10:11:11AM +0200, Daniel Vetter wrote:
> > > > > > On Wed, Sep 4, 2019 at 8:53 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > > > >
> > > > > > > Hi
> > > > > > >
> > > > > > > Am 04.09.19 um 08:27 schrieb Feng Tang:
> > > > > > > >> Thank you for testing. But don't get too excited, because the patch
> > > > > > > >> simulates a bug that was present in the original mgag200 code. A
> > > > > > > >> significant number of frames are simply skipped. That is apparently the
> > > > > > > >> reason why it's faster.
> > > > > > > >
> > > > > > > > Thanks for the detailed info, so the original code skips time-consuming
> > > > > > > > work inside atomic context on purpose. Is there any space to optmise it?
> > > > > > > > If 2 scheduled update worker are handled at almost same time, can one be
> > > > > > > > skipped?
> > > > > > >
> > > > > > > To my knowledge, there's only one instance of the worker. Re-scheduling
> > > > > > > the worker before a previous instance started, will not create a second
> > > > > > > instance. The worker's instance will complete all pending updates. So in
> > > > > > > some way, skipping workers already happens.
> > > > > >
> > > > > > So I think that the most often fbcon update from atomic context is the
> > > > > > blinking cursor. If you disable that one you should be back to the old
> > > > > > performance level I think, since just writing to dmesg is from process
> > > > > > context, so shouldn't change.
> > > > >
> > > > > Hmm, then for the old driver, it should also do the most update in
> > > > > non-atomic context?
> > > > >
> > > > > One other thing is, I profiled that updating a 3MB shadow buffer needs
> > > > > 20 ms, which transfer to 150 MB/s bandwidth. Could it be related with
> > > > > the cache setting of DRM shadow buffer? say the orginal code use a
> > > > > cachable buffer?
> > > >
> > > > Hm, that would indicate the write-combining got broken somewhere. This
> > > > should definitely be faster. Also we shouldn't transfer the hole
> > > > thing, except when scrolling ...
> > >
> > > First rule of fbcon usage, you are always effectively scrolling.
> > >
> > > Also these devices might be on a PCIE 1x piece of wet string, not sure
> > > if the numbers reflect that.
> >
> > pcie 1x 1.0 is 250MB/s, so yeah with a bit of inefficiency and
> > overhead not entirely out of the question that 150MB/s is actually the
> > hw limit. If it's really pcie 1x 1.0, no idea where to check that.
> > Also might be worth to double-check that the gpu pci bar is listed as
> > wc in debugfs/x86/pat_memtype_list.
>
> Here is some dump of the device info and the pat_memtype_list, while it is
> running other 0day task:

Looks all good, I guess Dave is right with this probably only being a
real slow, real old pcie link, plus maybe some inefficiencies in the
mapping. Your 150MB/s, was that just the copy, or did you include all
the setup/map/unmap/teardown too in your measurement in the trace?
-Daniel

>
> controller info
> =================
> 03:00.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200e [Pilot] ServerEngines (SEP1) (rev 05) (prog-if 00 [VGA controller])
>         Subsystem: Intel Corporation MGA G200e [Pilot] ServerEngines (SEP1)
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 16
>         NUMA node: 0
>         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=16M]
>         Region 1: Memory at d1800000 (32-bit, non-prefetchable) [size=16K]
>         Region 2: Memory at d1000000 (32-bit, non-prefetchable) [size=8M]
>         Expansion ROM at 000c0000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [e4] Express (v1) Legacy Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [54] MSI: Enable- Count=1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Kernel driver in use: mgag200
>         Kernel modules: mgag200
>
>
> Related pat setting
> ===================
> uncached-minus @ 0xc0000000-0xc0001000
> uncached-minus @ 0xc0000000-0xd0000000
> uncached-minus @ 0xc0008000-0xc0009000
> uncached-minus @ 0xc0009000-0xc000a000
> uncached-minus @ 0xc0010000-0xc0011000
> uncached-minus @ 0xc0011000-0xc0012000
> uncached-minus @ 0xc0012000-0xc0013000
> uncached-minus @ 0xc0013000-0xc0014000
> uncached-minus @ 0xc0018000-0xc0019000
> uncached-minus @ 0xc0019000-0xc001a000
> uncached-minus @ 0xc001a000-0xc001b000
> write-combining @ 0xd0000000-0xd0300000
> write-combining @ 0xd0000000-0xd1000000
> uncached-minus @ 0xd1800000-0xd1804000
> uncached-minus @ 0xd1900000-0xd1980000
> uncached-minus @ 0xd1980000-0xd1981000
> uncached-minus @ 0xd1a00000-0xd1a80000
> uncached-minus @ 0xd1a80000-0xd1a81000
> uncached-minus @ 0xd1f10000-0xd1f11000
> uncached-minus @ 0xd1f11000-0xd1f12000
> uncached-minus @ 0xd1f12000-0xd1f13000
>
> Host bridge info
> ================
> 00:00.0 Host bridge: Intel Corporation Device 7853
>         Subsystem: Intel Corporation Device 0000
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 0
>         NUMA node: 0
>         Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0
>                         ExtTag- RBE+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L0s <512ns, L1 <4us
>                         ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>                 RootCtl: ErrCorrectable+ ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range BCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [e0] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>         Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
>         Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
>         Capabilities: [250 v1] #19
>         Capabilities: [280 v1] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
>         Capabilities: [298 v1] Vendor Specific Information: ID=0007 Rev=0 Len=024 <?>
>
>
> Thanks,
> Feng
>
>
> >
> > -Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
