Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DE2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E291920718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="HjEKJD6g";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lywOLawZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfKVL5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:57:40 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:20200 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbfKVL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:57:40 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMBs21o001615;
        Fri, 22 Nov 2019 03:55:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=d0XRtZihvB9OKzDjrD98uQNQJSkNbCNWAxyTWTmKNrQ=;
 b=HjEKJD6gQpYz4soMW11x53HZS7izNuVFEgndCc4mxvrMuNR4xaN/mwZwYBVTfSYagoJ+
 NQsCirxhBfDR/Xrv2S9XHQGZtewLxpGoiiy4uSCe2UF3bSI/5bqeou9K8nIyvZWROvfx
 eO4ds5WLPpgwPUfCXydP1mpFDyp9qrX55Iobm4xCeCtpkWIYIdHyA01C7b8kJVgEbMac
 5Epm/cjRiSz3Rt4yS1X6dF42aoHmizn6xr3o5oVGjeYxA0U22x7my8dV6rcCk3ws7qc+
 4q8oWWjfEhRVS/vMSzbCw8D3ZRDIMiJCXlqgmSYopgQv9V8+ksUrUaTr2AHThiq87HS2 AQ== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wadjyrd7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 03:55:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnSEFnoRh/OWvfV0zGS4tSiKHCy9JI8OFKmGAniXPJo0qDwWbjHvhLSIlDSFpsgF9orzhGbJ15SbhArUaXMe9eW9Ad0TmdfoadRiLHhpaUcbjNIHXzOTCqb/R9znp2a7bqbXYj+kL47AtJbzdUMq+pOClr+0IAgeLU7PEzHjyqr8ckwpj8+PngMvCpTAX7OUE0iW20YJ5sJWJCKrHBGvHCHVsqQoRZY5lyMvjMBmNI+KlZIFtiaDvgcXEWuYClmUTelUGLXbE8qSHBywxNYzXvXHgUShPfSt1MnUCEHNlHxaN9nBYwonz+0wPiu/C4KJfcRlgWi7O15ZkOrNQ7W10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0XRtZihvB9OKzDjrD98uQNQJSkNbCNWAxyTWTmKNrQ=;
 b=PvZ9/lVJMh0y36ykqS9CzVDwD6tAcDIE6XbXDGdGk87v37E4TceJ+STf53beLccLQxIUC+YfbgDWPk//bCpzlgy76vVhfTwHtCgBrnjBJrOnnAFeC5CrkhLkJUWP51udf1cU2hki5EAxBuIM0OmdErYXwqjAFyfvtA98fDpJ0UO3lPmvN9MpIOZExYkw2WnaEDzPHbMXOtp/sLnetcYpI7l+QvpW8Oz4r8xLuPXjrlRxLyb+EsmzEhI9jXu4SipfIuYB1ttcsAN+Mm24UKMtVzKudzkdN+obd3tuc4hfFF6k55b3FwaBPuaosqooyJ43zVlDBpfTcmjWwIalV+GMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0XRtZihvB9OKzDjrD98uQNQJSkNbCNWAxyTWTmKNrQ=;
 b=lywOLawZRIZgoTstYMmSJX8NaGBPs2ktEqH7Aww58YWK8QXsIB48GVAzH4/jkCfpCTpv+c9fYtv5/42nC9y3fINbNYNDpFE9zOnWe0XKmVuraFM2hKpB3qw+pQc5Z90SVBoqFP9sbzI5GCQl8Y0C8UcUOdBiDpmmTIECmpW6d4U=
Received: from MN2PR07MB6288.namprd07.prod.outlook.com (20.179.86.160) by
 MN2PR07MB6959.namprd07.prod.outlook.com (52.132.170.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 22 Nov 2019 11:55:18 +0000
Received: from MN2PR07MB6288.namprd07.prod.outlook.com
 ([fe80::f0d8:94b6:89b0:f07f]) by MN2PR07MB6288.namprd07.prod.outlook.com
 ([fe80::f0d8:94b6:89b0:f07f%3]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 11:55:18 +0000
From:   Jayshri Dajiram Pawar <jpawar@cadence.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: RE: [RFC PATCH] usb: gadget: f_tcm: Added DMA32 flag while allocation
 of command buffer
Thread-Topic: [RFC PATCH] usb: gadget: f_tcm: Added DMA32 flag while
 allocation of command buffer
Thread-Index: AQHVmgyuNyYLAfnkAkOoAoMPYASOq6eJ+IIAgAB0mYCAAZa/YIAAEvaAgABytoCACpPRUA==
Date:   Fri, 22 Nov 2019 11:55:17 +0000
Message-ID: <MN2PR07MB6288E654268FBEB6DFC36F6FC1490@MN2PR07MB6288.namprd07.prod.outlook.com>
References: <1573640672-10344-1-git-send-email-jpawar@cadence.com>
 <20191114025301.GD30608@b29397-desktop>
 <5b567d57-6206-24cf-5886-20e8b5a92a45@ti.com>
 <MN2PR07MB6288D92B4AB6CF1B622A797CC1700@MN2PR07MB6288.namprd07.prod.outlook.com>
 <cefc03a1-b70a-bb40-289e-fbf4f9c79faf@ti.com>
 <20191115180215.GC23860@char.us.oracle.com>
In-Reply-To: <20191115180215.GC23860@char.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcanBhd2FyXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjE2OGQ0NDItMGQxZS0xMWVhLTg0ZmMtMDRkM2IwMjc3MWJiXGFtZS10ZXN0XGYxNjhkNDQzLTBkMWUtMTFlYS04NGZjLTA0ZDNiMDI3NzFiYmJvZHkudHh0IiBzej0iMTQwODYiIHQ9IjEzMjE4ODk3MzE0OTEwOTEyNyIgaD0iazBxcDVQeDF6T1FWOGllNTlpQ3kzY3RlUElZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de9b445c-2fec-455f-53a9-08d76f42d877
x-ms-traffictypediagnostic: MN2PR07MB6959:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR07MB6959E1A4F04CA6DA74FB2979C1490@MN2PR07MB6959.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(36092001)(189003)(199004)(51234002)(43544003)(316002)(305945005)(7736002)(66066001)(74316002)(478600001)(25786009)(99286004)(2906002)(66476007)(66556008)(64756008)(66446008)(6116002)(76116006)(66946007)(45080400002)(33656002)(3846002)(71190400001)(71200400001)(9686003)(6306002)(966005)(86362001)(55016002)(6916009)(54906003)(14444005)(5660300002)(6246003)(14454004)(256004)(4326008)(19627235002)(52536014)(30864003)(446003)(8676002)(81156014)(81166006)(229853002)(11346002)(6506007)(76176011)(7416002)(8936002)(53546011)(102836004)(55236004)(186003)(6436002)(7696005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB6959;H:MN2PR07MB6288.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pwlqo9w8XO8fM8IibwAYBCpswjkyl2cogF5vhy9KAy/W8Nvg0zxBGZrceVty7ytjeqYRUzD8jWfiw4ZMQbGlhAEzjIpzmtXHBeEAjaFLtUywiRFbW2ie9xiB72t3Cy5QqHpkWwaEetFrN0sDeBJC7t0zicqwf03CfM9JcNg3NE6VGp5qxjTI+V4jrk//J713J6dgLbSnx52g37C1YOQpWgCT3AY+FbELbciGwoIj9h32nDE2W1lG6/4OB2G+fTAMwnezzuFiurRqmFPVxRyr/zRUf5EfcQBRQCKGLoVTWAANRX3D/H2iqjrG3SO7Pjd50MGmx1rYEm2AWkT0UFmDQCJJOo3PGtWMgkVuMB0aJAjpr+JapuIXJpXhbi7eJGfQeEpsgjTi4waghmgjEFwSDfaXKDIRX/gjx6SdvkeZqjxfPR7rAal9IHnVX/+VbOG1O3c/6KnvOnBYIXm76mCHVAGpujNZoMjHb4xFTLXvxIiOFPfumh1RDF6fbc5iZblR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9b445c-2fec-455f-53a9-08d76f42d877
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 11:55:18.2360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/9EXMqGDS7GvMojKElK8HDjiVXlvgQukZbykMHRy1zunXSJiA7ioMmhDtN+hxtaV9nVusSBjpW0j8TfOUPkQZH8q5VhKoW9WXf59jjJTeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6959
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911220108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +Konrad
>=20
> You can run Linux with CONFIG_DEBU_DMA and use
> debug_dma_dump_mappings() to dump and figure things out. See
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__xenbits.xen.org_gitweb_-3Fp-3Dxentesttools_bootstrap.git-3Ba-3Dblob-
> 3Bf-3Droot-5Fimage_drivers_dump_dump-5Fdma.c-3Bh-
> 3D2ba251a2f8c36c24c68762b3e4c9f76ea178238f-3Bhb-
> 3DHEAD&d=3DDwIFAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-
> _haXqY&r=3DyUzzs89gsBIbqjpopjycywmchLJKpKHDc_YLMD1daI0&m=3DuPhjYpgZJ
> ovroCszC7ZGapdrx4F72MK7pqXmzpRyGmA&s=3DdSO49c-
> githIzhiwgvwOt0m00M2trGWB3AnKL3OKpkw&e=3D
>=20
> >
> > Jayshri,
> >
> > On 15/11/2019 12:14, Jayshri Dajiram Pawar wrote:
> > > > > > There is a problem when function driver allocate memory for
> > > > > > buffer used by DMA from outside dma_mask space.
> > > > > > It appears during testing f_tcm driver with cdns3 controller.
> > > > > > In the result cdns3 driver was not able to map virtual buffer t=
o DMA.
> > > > > > This fix should be improved depending on dma_mask associated
> > > > > > with
> > > > device.
> > > > > > Adding GFP_DMA32 flag while allocationg command data buffer
> > > > > > only for
> > > > > > 32 bit controllers.
> > > > >
> > > > > Hi Jayshri,
> > > > >
> > > > > This issue should be fixed by setting DMA_MASK correctly for
> > > > > controller, you can't limit user's memory region. At
> > > > > usb_ep_queue, the UDC driver will call DMA MAP API, for Cadence,
> > > > > it is
> > > > usb_gadget_map_request_by_dev.
> > > > > For the system without SMMU (IO-MMU), it will use swiotlb to
> > > > > make sure the data buffer used for DMA transfer is within DMA
> > > > > mask for controller, There is a reserved low memory region for
> > > > > debounce buffer in swiotlb use case.
> > > > >
> > > >
> > > > /**
> > > >    * struct usb_request - describes one i/o request
> > > >    * @buf: Buffer used for data.  Always provide this; some control=
lers
> > > >    *	only use PIO, or don't use DMA for some endpoints.
> > > >    * @dma: DMA address corresponding to 'buf'.  If you don't set th=
is
> > > >    *	field, and the usb controller needs one, it is responsible
> > > >    *	for mapping and unmapping the buffer.
> > > > <snip>
> > > >    */
> > > >
> > > > So if dma is not set in the usb_request then controller driver is
> > > > responsible to do a dma_map of the buffer pointed by 'buf' before i=
t
> attemps to do DMA.
> > > > This should take care of DMA mask and swiotlb.
> > > >
> > > > This patch is not correct.
> > > >
> > > Hi Roger,
> > >
> > > We have scatter-gather disabled.
> > > We are getting below error while allocation of cmd data buffer with
> length 524288 or greater, while writing large size files to device.
> > > This error occurred on x86 platform.
> > > Because of this reason we have added DMA flag while allocation of
> buffer.
> > >
> > > [ 1602.977532] swiotlb_tbl_map_single: 26 callbacks suppressed [
> > > 1602.977536] cdns-usb3 cdns-usb3.1: swiotlb buffer is full (sz:
> > > 524288 bytes), total 32768 (slots), used 0 (slots)
> >
Hi Roger,

> > Why is swiotlb buffer getting full? How much is it on your system?

On our system swiotlb max mapping size is 256KB.
UASP receive data state tries to queue and map buffer of length 524288 (512=
KB), which is greater than 256KB that's why swiotlb buffer is getting full.

> > Are you sure that dma_unmap is happening on requests that complete?
> else we'll just keep hogging the swiotlb buffer.

Yes, dma_unmap is happening on requests that complete.

I could map buffer of length 512KB with  IO_TLB_SEGSIZE changed to 256.
With this max mapping size is increased to  256*2048 =3D 512KB.=20

+++ b/include/linux/swiotlb.h
@@ -21,7 +21,7 @@ enum swiotlb_force {
  * must be a power of 2.  What is the appropriate value ?
  * The complexity of {map,unmap}_single is linearly dependent on this valu=
e.
  */
-#define IO_TLB_SEGSIZE 128
+#define IO_TLB_SEGSIZE 256

Regards,
Jayshri

> >
> > cheers,
> > -roger



> >
> > > [ 1602.977542] cdns-usb3 cdns-usb3.1: overflow
> > > 0x00000007eee00000+524288 of DMA mask ffffffff bus mask 0 [
> > > 1602.977555] WARNING: CPU: 6 PID: 285 at kernel/dma/direct.c:43
> > > report_addr+0x37/0x60 [ 1602.977556] Modules linked in:
> target_core_user uio target_core_pscsi target_core_file target_core_ibloc=
k
> usb_f_tcm(OE) target_core_mod cdns3(OE) cdns3_pci_wrap(OE) roles(E)
> libcomposite(OE) udc_core(OE) xt_multiport iptable_filter bpfilter
> snd_hda_codec_hdmi nls_iso8859_1 i915 intel_rapl x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm snd_hda_codec_realtek
> snd_hda_codec_generic ledtrig_audio snd_hda_intel irqbypass
> snd_hda_codec snd_hda_core snd_hwdep snd_pcm drm_kms_helper
> snd_seq_midi snd_seq_midi_event crct10dif_pclmul snd_rawmidi
> crc32_pclmul drm snd_seq ghash_clmulni_intel snd_seq_device aesni_intel
> snd_timer mei_me i2c_algo_bit aes_x86_64 crypto_simd cryptd fb_sys_fops
> glue_helper snd mei input_leds syscopyarea intel_cstate sysfillrect
> intel_rapl_perf sysimgblt hp_wmi soundcore sparse_keymap serio_raw
> wmi_bmof tpm_infineon mac_hid sch_fq_codel parport_pc ppdev lp parport
> ip_tables x_tables autofs4 hid_generic usbhid hid e1000e psmouse ahci
> lpc_ich libahci i2c_i801 wmi [ 1602.977605]  video
> > > [ 1602.977613] CPU: 6 PID: 285 Comm: kworker/6:2 Tainted: G          =
 OE
> 5.2.0-rc3cdns3-jayshri-stream-common+ #7
> > > [ 1602.977615] Hardware name: Hewlett-Packard HP EliteDesk 800 G1
> > > TWR/18E4, BIOS L01 v02.21 12/17/2013 [ 1602.977623] Workqueue:
> > > tcm_usb_gadget usbg_cmd_work [usb_f_tcm] [ 1602.977628] RIP:
> > > 0010:report_addr+0x37/0x60 [ 1602.977631] Code: 48 8b 87 28 02 00 00
> > > 48 89 75 f8 48 85 c0 74 2a 4c 8b 00 b8 fe ff ff ff 49 39 c0 76 11 80
> > > 3d af 61 72 01 00 0f 84 df 06 00 00 <0f> 0b c9 c3 48 83 bf 38 02 00
> > > 00 00 74 f2 eb e3 80 3d 93 61 72 01 [ 1602.977634] RSP:
> > > 0018:ffffa0a6834dfc00 EFLAGS: 00010046 [ 1602.977636] RAX:
> > > 0000000000000000 RBX: ffff8ec574aeb010 RCX: 0000000000000000 [
> > > 1602.977638] RDX: 0000000000000007 RSI: 0000000000000086 RDI:
> > > 0000000000000000 [ 1602.977640] RBP: ffffa0a6834dfc08 R08:
> > > 0000000000000569 R09: ffffffffa2189fb8 [ 1602.977642] R10:
> > > 0000000000000069 R11: ffffa0a6834df940 R12: 0000000000080000 [
> > > 1602.977644] R13: ffff8ec5ad536218 R14: ffff8ec5ad693800 R15:
> ffff8ec5ad693800 [ 1602.977647] FS:  0000000000000000(0000)
> GS:ffff8ec5be980000(0000) knlGS:0000000000000000 [ 1602.977649] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 1602.977651] CR2:
> 00007f05a56b7000 CR3: 000000036fc0a006 CR4: 00000000001606e0 [
> 1602.977653] Call Trace:
> > > [ 1602.977660]  dma_direct_map_page+0xdf/0xf0 [ 1602.977669]
> > > usb_gadget_map_request_by_dev+0x17a/0x190 [udc_core] [
> 1602.977679]
> > > __cdns3_gadget_ep_queue.isra.30+0x149/0x2e0 [cdns3] [ 1602.977686]
> > > ? kmalloc_order+0x18/0x40 [ 1602.977693]
> > > cdns3_gadget_ep_queue+0x53/0x100 [cdns3] [ 1602.977698]
> > > usb_ep_queue+0x36/0xa0 [udc_core] [ 1602.977704]
> > > usbg_send_write_request+0x1ae/0x250 [usb_f_tcm] [ 1602.977731]
> > > transport_generic_new_cmd+0x1bc/0x320 [target_core_mod] [
> > > 1602.977749]  transport_handle_cdb_direct+0x42/0x60
> > > [target_core_mod] [ 1602.977766]
> > > target_submit_cmd_map_sgls+0x176/0x230 [target_core_mod] [
> > > 1602.977771]  ? __switch_to_asm+0x40/0x70 [ 1602.977788]
> > > target_submit_cmd+0x26/0x30 [target_core_mod] [ 1602.977794]
> > > usbg_cmd_work+0x60/0xd0 [usb_f_tcm] [ 1602.977799]
> > > process_one_work+0x20f/0x410 [ 1602.977802]
> > > worker_thread+0x34/0x400 [ 1602.977807]  kthread+0x120/0x140 [
> > > 1602.977811]  ? process_one_work+0x410/0x410 [ 1602.977815]  ?
> > > __kthread_parkme+0x70/0x70 [ 1602.977818]  ret_from_fork+0x35/0x40
> [
> > > 1602.977822] ---[ end trace 70f27f846049ae32 ]--- [ 1602.977826]
> > > cdns-usb3 cdns-usb3.1: failed to map buffer [ 1602.977853]
> > > uasp_send_write_request(695)
> > >
> > > Regards,
> > > Jayshri
> > >
> > > > cheers,
> > > > -roger
> > > >
> > > > > Peter
> > > > >
> > > > > >
> > > > > > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > > > > > Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> > > > > > ---
> > > > > >    drivers/usb/gadget/function/f_tcm.c | 20 ++++++++++++++-----=
-
> > > > > >    include/linux/usb/gadget.h          |  2 ++
> > > > > >    2 files changed, 16 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/usb/gadget/function/f_tcm.c
> > > > > > b/drivers/usb/gadget/function/f_tcm.c
> > > > > > index 36504931b2d1..a78d5fad3d84 100644
> > > > > > --- a/drivers/usb/gadget/function/f_tcm.c
> > > > > > +++ b/drivers/usb/gadget/function/f_tcm.c
> > > > > > @@ -213,7 +213,8 @@ static int bot_send_read_response(struct
> > > > usbg_cmd *cmd)
> > > > > >    	}
> > > > > >
> > > > > >    	if (!gadget->sg_supported) {
> > > > > > -		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > > GFP_ATOMIC);
> > > > > > +		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > > GFP_ATOMIC |
> > > > > > +					gadget->dma_flag);
> > > > > >    		if (!cmd->data_buf)
> > > > > >    			return -ENOMEM;
> > > > > >
> > > > > > @@ -257,7 +258,8 @@ static int bot_send_write_request(struct
> > > > usbg_cmd *cmd)
> > > > > >    	}
> > > > > >
> > > > > >    	if (!gadget->sg_supported) {
> > > > > > -		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > > GFP_KERNEL);
> > > > > > +		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> GFP_KERNEL
> > > > |
> > > > > > +					gadget->dma_flag);
> > > > > >    		if (!cmd->data_buf)
> > > > > >    			return -ENOMEM;
> > > > > >
> > > > > > @@ -305,6 +307,7 @@ static void bot_cmd_complete(struct usb_ep
> > > > > > *ep,
> > > > struct usb_request *req)
> > > > > >    static int bot_prepare_reqs(struct f_uas *fu)
> > > > > >    {
> > > > > >    	int ret;
> > > > > > +	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
> > > > > >
> > > > > >    	fu->bot_req_in =3D usb_ep_alloc_request(fu->ep_in,
> GFP_KERNEL);
> > > > > >    	if (!fu->bot_req_in)
> > > > > > @@ -327,7 +330,8 @@ static int bot_prepare_reqs(struct f_uas *f=
u)
> > > > > >    	fu->bot_status.req->complete =3D bot_status_complete;
> > > > > >    	fu->bot_status.csw.Signature =3D
> > > > > > cpu_to_le32(US_BULK_CS_SIGN);
> > > > > >
> > > > > > -	fu->cmd.buf =3D kmalloc(fu->ep_out->maxpacket,
> GFP_KERNEL);
> > > > > > +	fu->cmd.buf =3D kmalloc(fu->ep_out->maxpacket, GFP_KERNEL
> |
> > > > > > +				gadget->dma_flag);
> > > > > >    	if (!fu->cmd.buf)
> > > > > >    		goto err_buf;
> > > > > >
> > > > > > @@ -515,7 +519,8 @@ static int uasp_prepare_r_request(struct
> > > > usbg_cmd *cmd)
> > > > > >    	struct uas_stream *stream =3D cmd->stream;
> > > > > >
> > > > > >    	if (!gadget->sg_supported) {
> > > > > > -		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > > GFP_ATOMIC);
> > > > > > +		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > > GFP_ATOMIC |
> > > > > > +					gadget->dma_flag);
> > > > > >    		if (!cmd->data_buf)
> > > > > >    			return -ENOMEM;
> > > > > >
> > > > > > @@ -763,11 +768,13 @@ static int uasp_alloc_stream_res(struct
> > > > > > f_uas *fu, struct uas_stream *stream)
> > > > > >
> > > > > >    static int uasp_alloc_cmd(struct f_uas *fu)
> > > > > >    {
> > > > > > +	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
> > > > > >    	fu->cmd.req =3D usb_ep_alloc_request(fu->ep_cmd,
> GFP_KERNEL);
> > > > > >    	if (!fu->cmd.req)
> > > > > >    		goto err;
> > > > > >
> > > > > > -	fu->cmd.buf =3D kmalloc(fu->ep_cmd->maxpacket,
> GFP_KERNEL);
> > > > > > +	fu->cmd.buf =3D kmalloc(fu->ep_cmd->maxpacket,
> GFP_KERNEL |
> > > > > > +				gadget->dma_flag);
> > > > > >    	if (!fu->cmd.buf)
> > > > > >    		goto err_buf;
> > > > > >
> > > > > > @@ -980,7 +987,8 @@ static int usbg_prepare_w_request(struct
> > > > usbg_cmd *cmd, struct usb_request *req)
> > > > > >    	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
> > > > > >
> > > > > >    	if (!gadget->sg_supported) {
> > > > > > -		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > > GFP_ATOMIC);
> > > > > > +		cmd->data_buf =3D kmalloc(se_cmd->data_length,
> > > > GFP_ATOMIC |
> > > > > > +					gadget->dma_flag);
> > > > > >    		if (!cmd->data_buf)
> > > > > >    			return -ENOMEM;
> > > > > >
> > > > > > diff --git a/include/linux/usb/gadget.h
> > > > > > b/include/linux/usb/gadget.h index 124462d65eac..d6c9cd222600
> > > > > > 100644
> > > > > > --- a/include/linux/usb/gadget.h
> > > > > > +++ b/include/linux/usb/gadget.h
> > > > > > @@ -373,6 +373,7 @@ struct usb_gadget_ops {
> > > > > >     * @connected: True if gadget is connected.
> > > > > >     * @lpm_capable: If the gadget max_speed is FULL or HIGH, th=
is
> flag
> > > > > >     *	indicates that it supports LPM as per the LPM ECN & errat=
a.
> > > > > > + * @dma_flag: dma zone to be used for buffer allocation.
> > > > > >     *
> > > > > >     * Gadgets have a mostly-portable "gadget driver" implementi=
ng
> device
> > > > > >     * functions, handling all usb configurations and interfaces=
.
> > > > > > Gadget @@ -427,6 +428,7 @@ struct usb_gadget {
> > > > > >    	unsigned			deactivated:1;
> > > > > >    	unsigned			connected:1;
> > > > > >    	unsigned			lpm_capable:1;
> > > > > > +	unsigned int			dma_flag;
> > > > > >    };
> > > > > >    #define work_to_gadget(w)	(container_of((w), struct usb_gadg=
et,
> > > > work))
> > > > > >
> > > > > > --
> > > > > > 2.20.1
> > > > > >
> > > > >
> > > >
> > > > --
> > > > Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> > > > Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> >
> > --
> > Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> > Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
