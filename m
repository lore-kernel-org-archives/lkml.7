Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D56C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19242086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560775982;
	bh=Lw4H+apTPqBmAWFUYxz+C05aM8XYDHNRGlPEvefR3u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=XneUgSKO/BCU9pFnf65gCI2+4eZ98bwbTaSr4oBeD0TuXCTzRWNHeHwD0EWc/A2X2
	 60BjONRrxt3xMYL3e8cOlOFJVL+XQrLAzQkhNViYD4NtF2pT68rfFSmI9+hyt2DeMI
	 ilXjXmQJhEmAth31YYmspGNMdEQmSMx3qvZYhcOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfFQMxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:53:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:13071 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfFQMw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:52:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 05:52:58 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2019 05:52:56 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list\:DESIGNWARE USB3 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
In-Reply-To: <AM5PR0402MB2865D0F0E2B4F65C86D051F8F1140@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com> <87ineb9b5v.fsf@linux.intel.com> <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com> <87shdfet90.fsf@linux.intel.com> <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com> <87k1eaanjw.fsf@linux.intel.com> <AM5PR0402MB2865F3735D808E1BC9F67968F1180@AM5PR0402MB2865.eurprd04.prod.outlook.com> <AM5PR0402MB2865D0F0E2B4F65C86D051F8F1140@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Date:   Mon, 17 Jun 2019 15:52:52 +0300
Message-ID: <87o92wgyqj.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Ran Wang <ran.wang_1@nxp.com> writes:
> Hi Felipe,
>
> On Thursday, May 30, 2019 17:09, Ran Wang wrote:
>>=20
>> <snip>
>> > >> >> >  /* Global Debug Queue/FIFO Space Available Register */
>> > >> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
>> > >> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
>> > >> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
>> > >> >> >   * 	3	- Reserved
>> > >> >> >   * @imod_interval: set the interrupt moderation interval in 2=
50ns
>> > >> >> >   *                 increments or 0 to disable.
>> > >> >> > + * @dma_coherent: set if enable dma-coherent.
>> > >> >>
>> > >> >> you're not enabling dma coherency, you're enabling cache snoopin=
g.
>> > >> >> And this property should describe that. Also, keep in mind that
>> > >> >> different devices may want different cache types for each of
>> > >> >> those fields, so your property would have to be a lot more
>> > >> >> complex. Something
>> > like:
>> > >> >>
>> > >> >> 	snps,cache-type =3D <foobar "cacheable">, <baz "cacheable">, ...
>> > >> >>
>> > >> >> Then driver would have to parse this properly to setup GSBUSCFG0.
>> > >
>> > > According to the DesignWare Cores SuperSpeed USB 3.0 Controller
>> > > Databook (v2.60a), it has described Type Bit Assignments for all
>> > > supported
>> > master bus type:
>> > > AHB, AXI3, AXI4 and Native. I found the bit definition are different
>> > > among
>> > them.
>> > > So, for the example you gave above, feel a little bit confused.
>> > > Did you mean:
>> > >     snps,cache-type =3D <DATA_RD  "write allocate">, <DESC_RD
>> > > "cacheable">, <DATA_WR  "bufferable">, <DESC_WR  "read allocate">
>> >
>> > yeah, something like that.
>>=20
>> I think DATA_RD  should be a macro, right? So, where I can put its defin=
e?
>> Create a dwc3.h in include/dt-bindings/usb/ ?
>
> Could you please give me some advice here? I'd like to prepare next versi=
on patch after
> getting this settled.
>
>> Another question about this remain open is: DWC3 data book's Table 6-5 C=
ache
>> Type Bit Assignments show that bits definition will differ per MBUS_TYPE=
s as
>> below:
>> ----------------------------------------------------------------
>>  MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
>>  ----------------------------------------------------------------
>>  AHB      |Cacheable     |Bufferable   |Privilegge |Data
>>  AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
>>  AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
>>  AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
>>  Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
>>  ----------------------------------------------------------------
>>  Note: The AHB, AXI3, AXI4, and PCIe busses use different names for cert=
ain
>>  signals, which have the same meaning:
>>    Bufferable =3D Posted
>>    Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
>>=20
>> For Layerscape SoCs, MBUS_TYPE is AXI3. So I am not sure how to use
>> snps,cache-type =3D <DATA_RD  "write allocate">, to cover all MBUS_TYPE?
>> (you can notice that AHB and AXI3's cacheable are on different bit) Or I=
 just need
>> to handle AXI3 case?
>
> Also on this open. Thank you in advance.

You could pass two strings and let the driver process them. Something
like:

	snps,cache_type =3D <"data_wr" "write allocate">, <"desc_rd" "cacheable">.=
..

And so on. The only thing missing is for the mbus_type to be known by
the driver. Is that something we can figure out on any of the HWPARAMS
registers or does it have to be told explicitly?

Another option would be to pass a string followed by one hex digit for
the bits:

	snps,cache_type =3D <"data_wr" 0x8>, <"desc_rd" 0x2>...;

Then we don't need to describe mbus_type since the bits are what matters.

Rob, any comments?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0HjSQACgkQzL64meEa
mQbg7g/+Lx8yM+keMyEm6/45HFbt8dj+svzOYxh0bbIrId4/UkgiphoH7tOEvT/m
daGDtnccJ8ec6pGl1gHMweog+R7WEkFjf43hBoJjjGWqExeeNDaP6cKD60v2fU2v
fpDbfEs4Y5HKxxaBu65MmRwBbtAg+O0ZXEC2RY5jan9GE/HbuqD5xorbRCtIdo1r
a5f5CgMUgIglqJiQ+r9dH2M3BjlCBl+2h9YHs0IuLN9+wtRmE9V82s+b1egjot/N
fsp9eB/YCCpuvsw38pis00SyN2KiYB1TSBYKFplZon9j1dPrUomP7dg6CUlp+UGf
T3jlokigmXQKNK7vrBjm76fdtTAKLEuXLnVGMxFM+sn/vh95bVamyS6MNYTY/XdA
q/0KA4Z3tpPXIF0jDV4H92sKt2qXfDjj0vt8oSpWMB4yLOpkKQtvOcpRqd3AYsbD
+xvIOipBs6dtdp6wpvmK7BbobggCUxAObAYiJI4FoaqZbWWWnzd2piXWH5bAGkIp
u14xAKyE7Nz20RuARpD+TchfbeAZUnrTF+PJ6LcRNshiGoPWBrRT2oCYjqN9XcE7
K8sd6hxcXXwA4vPmo3faq4s1oiq/ACZWJPeGwCyF4yB+Y7b/I2aEicVSbOV49aiC
j6yHlveZA9Z/GX8hVlxmkKLdhR5Uki6HP8wG5Bn2dlBK6tA2Kvk=
=7tqt
-----END PGP SIGNATURE-----
--=-=-=--
