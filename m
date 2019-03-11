Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E275C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CA920850
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Lbewkexo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCKG2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:25 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:47824 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfCKG2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:18 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 6DF9510C19FF;
        Sun, 10 Mar 2019 23:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552285697; bh=yTT4lc6NRs7NoGJjylNIbTYR+ZelPgsvezsjL4YGkjg=;
        h=From:To:CC:Subject:Date:References:From;
        b=LbewkexohEpc9piiNrZjxcyiBtiEdDOFXqbvrZNDG9n2xmVf72sUAkz3/9wS4eJxw
         7dVOZSeqOw64qARJvIdg6f2EdC8izYNEi9a2IAEH7iTkTY0MCMfNfoNeGnnGGaT1Qs
         juwchN9bw2eihFTYnegiIPpO0ePtvmCTBP+YkP5Cx7eavE4CC0h/QWGn7PbepqC0TM
         out04X/zs7rXoSVZ3+HzYCick9lAJXL6i5T936O+adAxslC8bH/eAN+IjIKj082A+g
         goTAlLtl3TEG72/AMu2F6bNmIXhJFRWtfHRsD61+wTk64i4+4UT2dujhbStuqjw8bs
         Em2cmM83MbMEQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EF834A005A;
        Mon, 11 Mar 2019 06:28:16 +0000 (UTC)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 10 Mar 2019 23:28:16 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 11 Mar 2019 10:28:13 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Artur Petrosyan <arthur.petrosyan@synopsys.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Gall <tom.gall@linaro.org>
Subject: Re: REGRESSION: dwc2: gadget: Add scatter-gather mode
Thread-Topic: REGRESSION: dwc2: gadget: Add scatter-gather mode
Thread-Index: AQHU1fD/NTF8t692fUKIZOfpzpmgYw==
Date:   Mon, 11 Mar 2019 06:28:12 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7E8D90@am04wembxa.internal.synopsys.com>
References: <CALAqxLUZKinhCasO4rXBJuip3bOo+JCovWLrHYPBPTopf6d7Vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,=0A=
=0A=
USB CV MSC tests failed starting from Test Case 6 with BNA interrupt on =0A=
ep1in. It's first BULK IN transaction after GET MAXLUN.=0A=
=0A=
[319523.955339] dwc2 dwc2.1.auto: dwc2_hsotg_irq: 04088028 00080000 =0A=
(d88c3cc4) retry 8=0A=
[319523.955357] dwc2 dwc2.1.auto: dwc2_hsotg_irq: daint=3D00020000=0A=
[319523.955366] dwc2 dwc2.1.auto: dwc2_hsotg_epint: ep1(out) =0A=
DxEPINT=3D0x00000001=0A=
[319523.955372] dwc2 dwc2.1.auto: dwc2_hsotg_epint: XferCompl: =0A=
DxEPCTL=3D0x00098200, DXEPTSIZ=3D15c7d486=0A=
[319523.955377] dwc2 dwc2.1.auto: complete: ep 00000000b58e703a ep1out, =0A=
req 00000000bde78704, 0 =3D> 000000002620ceb8=0A=
[319523.955396] dwc2 dwc2.1.auto: ep1in: req 00000000acdadb34: =0A=
36@00000000450496f9, noi=3D0, zero=3D0, snok=3D0=0A=
[319523.955403] dwc2 dwc2.1.auto: dwc2_hsotg_start_req: =0A=
DxEPCTL=3D0x004a8200, ep 1, dir in=0A=
[319523.955406] dwc2 dwc2.1.auto: ureq->length:36 ureq->actual:0=0A=
[319523.955408] dwc2 dwc2.1.auto: dwc2_hsotg_start_req: 1@36/36, =0A=
0x20080024 =3D> 0x00000930=0A=
[319523.955410] dwc2 dwc2.1.auto: dwc2_hsotg_start_req: 36cbc000 pad =3D> =
=0A=
0x00000934=0A=
[319523.955412] dwc2 dwc2.1.auto: ep0 state:0=0A=
[319523.955413] dwc2 dwc2.1.auto: dwc2_hsotg_start_req: DxEPCTL=3D0x844a820=
0=0A=
[319523.955420] dwc2 dwc2.1.auto: dwc2_hsotg_start_req: DXEPCTL=3D0x8048820=
0=0A=
[319523.955425] dwc2 dwc2.1.auto: ep1in: req 00000000f74873bc: =0A=
13@000000007a860fd2, noi=3D0, zero=3D0, snok=3D0=0A=
[319523.955446] dwc2 dwc2.1.auto: dwc2_hsotg_irq: 04048028 00040000 =0A=
(d88c3cc4) retry 8=0A=
[319523.955451] dwc2 dwc2.1.auto: dwc2_hsotg_irq: daint=3D00000002=0A=
[319523.955460] dwc2 dwc2.1.auto: dwc2_hsotg_epint: ep1(in) =0A=
DxEPINT=3D0x00000200=0A=
[319523.955462] dwc2 dwc2.1.auto: dwc2_hsotg_epint: BNA interrupt=0A=
[319553.987219] dwc2 dwc2.1.auto: dwc2_hsotg_irq: 04008428 00000400 =0A=
(d88c3cc4) retry 8=0A=
=0A=
Meanwhile it's passing smoke test with mass storage function.=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
=0A=
On 3/9/2019 12:53 AM, John Stultz wrote:=0A=
> Hey Andrzej,=0A=
>    I just wanted to let you know, trying to boot linus/master on the=0A=
> hikey board today, I've been seeing lots of errors on boot (which=0A=
> sometimes crash the board, and sometimes doesn't). See the example=0A=
> below.=0A=
> =0A=
> I've bisected the issue down to 10209abe87f5 ("usb: dwc2: gadget: Add=0A=
> scatter-gather mode"), and if I revert that change the issue goes=0A=
> away.=0A=
> =0A=
> Looking at the patch, I can't see anything obviously sticking out, but=0A=
> let me know if you have anything suggestions you'd like me to test.=0A=
> =0A=
> thanks=0A=
> -john=0A=
> =0A=
> =0A=
> [   13.088934] functionfs read size 512 > requested size 24, splitting=0A=
> request into multiple reads.=0A=
> [   13.089029] ------------[ cut here ]------------=0A=
> [   13.102665] Trying to vfree() bad address (00000000ecf3404f)=0A=
> [   13.108436] WARNING: CPU: 0 PID: 2014 at mm/vmalloc.c:1516 __vunmap+0x=
e0/0xe8=0A=
> [   13.115587] CPU: 0 PID: 2014 Comm: adbd Not tainted=0A=
> 5.0.0-08291-ga032141-dirty #897=0A=
> [   13.123244] Hardware name: HiKey Development Board (DT)=0A=
> [   13.128469] pstate: 80400005 (Nzcv daif +PAN -UAO)=0A=
> [   13.133266] pc : __vunmap+0xe0/0xe8=0A=
> [   13.136757] lr : __vunmap+0xe0/0xe8=0A=
> [   13.140243] sp : ffffff80114d3b40=0A=
> [   13.143555] x29: ffffff80114d3b40 x28: ffffffc07333d280=0A=
> [   13.148868] x27: ffffffc071b67a38 x26: 00000000000001e8=0A=
> [   13.154180] x25: ffffff80114d3ca8 x24: ffffffc07190e400=0A=
> [   13.159492] x23: ffffffc0748bca00 x22: ffffff8010ffd000=0A=
> [   13.164803] x21: 0000000000000001 x20: ffffff80114d3c98=0A=
> [   13.170113] x19: ffffff8010414e74 x18: ffffff8010ffda48=0A=
> [   13.175423] x17: 0000000000000000 x16: 0000000000000000=0A=
> [   13.180734] x15: ffffff80914d3867 x14: 0000000000000006=0A=
> [   13.186044] x13: ffffff80114d3875 x12: ffffff801101c898=0A=
> [   13.191371] x11: ffffff801101c000 x10: 0000000005f5e0ff=0A=
> [   13.191416] type=3D1400 audit(16.743:79): avc: denied { read } for=0A=
> comm=3D"drmserver" name=3D"enabled" dev=3D"sysfs" ino=3D5492=0A=
> scontext=3Du:r:drmserver:s0 tcont0=0A=
> [   13.196698] x9 : ffffff80114d3800 x8 : 2966343034336663=0A=
> [   13.196707] x7 : 6530303030303030 x6 : 0000000000000424=0A=
> [   13.196713] x5 : 0000000000000000 x4 : 0000000000000000=0A=
> [   13.196718] x3 : 0000000000000001 x2 : 0000000000000001=0A=
> [   13.196724] x1 : b357113b3815f700 x0 : 0000000000000000=0A=
> [   13.214445] type=3D1400 audit(17.075:84): avc: denied { read } for=0A=
> comm=3D"audioserver" name=3D"enabled" dev=3D"sysfs" ino=3D5492=0A=
> scontext=3Du:r:audioserver:s0 t0=0A=
> [   13.219604] Call trace:=0A=
> [   13.219616]  __vunmap+0xe0/0xe8=0A=
> [   13.219623]  __vfree+0x24/0x70=0A=
> [   13.219635]  vfree+0x20/0x38=0A=
> [   13.270258]  ffs_epfile_io.isra.12+0x190/0x6b0=0A=
> [   13.274707]  ffs_epfile_read_iter+0xa0/0x168=0A=
> [   13.278982]  __vfs_read+0x10c/0x168=0A=
> [   13.282471]  vfs_read+0x8c/0x148=0A=
> [   13.285700]  ksys_read+0x5c/0xc8=0A=
> [   13.288930]  __arm64_sys_read+0x14/0x20=0A=
> [   13.292773]  el0_svc_common.constprop.0+0xb0/0x110=0A=
> [   13.297461] type=3D1400 audit(17.075:84): avc: denied { read } for=0A=
> comm=3D"audioserver" name=3D"enabled" dev=3D"sysfs" ino=3D5492=0A=
> scontext=3Du:r:audioserver:s0 t0=0A=
> [   13.297570]  el0_svc_handler+0x28/0x78=0A=
> [   13.315592] type=3D1400 audit(17.179:85): avc: denied { read } for=0A=
> comm=3D"bootanimation" name=3D"enabled" dev=3D"sysfs" ino=3D5492=0A=
> scontext=3Du:r:bootanim:s0 tc0=0A=
> [   13.319239]  el0_svc+0x8/0xc=0A=
> [   13.319245] ---[ end trace 729ab9edfbdb0764 ]---=0A=
> =0A=
=0A=
