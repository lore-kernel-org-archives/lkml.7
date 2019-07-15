Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B676C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122872080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="D/PMIkAH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="TOacTt1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfGOLAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:00:33 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:63794 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729747AbfGOLAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:00:32 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FAuN20018633;
        Mon, 15 Jul 2019 04:00:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=2R1NXKIm37q/Uah5k+uRNSfJOKDxJeDX9XptluCY0/I=;
 b=D/PMIkAHe8JiKoa6MhO3FTvABh0f2HsbYIkYT6r244ZvoVBDZ9ZjQyxgv2ZCAI7TW78N
 vFgXWYizKWzyvzvS9rIVOUDlrSXQf32SLFjATv0ovqW1ccuKo4hBavg6qccypuuPITxI
 hvJhzVbT0/TKTdBxMKwyv4u6CA8JUVdTG1NzKplzSVZqbUqHizS2BNH3INxzjyv7kSeJ
 v1LmDby7FUSIzs6QgIjmTYc5YDzBwjqmOgr9FA+axTzk4r21hGoRX7H4KPleZWWoz+lP
 AL3KoHbqZjPdmeikc22kbvoFyeBoSFouTlIymuzZyuYvYKuP15NrEOS347Q7K6NP1FcL WA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tqbuvx78t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Jul 2019 04:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U94d/k3Vo8VMS4OnH+Qe40G7qPqF+kX0saz0d1mLfnd7i4aK2s8KBmDzRiYOfnnhoDG2EGQEiiX8Mn5jlq0483ZB8tfzRnI71QOrjoTEh/pwe3cBxdw72ITeKwBLp/uHdwh2c3nqbWPofcDyRRWptL3T30/j68nZ8//mKsCizZLOEeG2VvjKFz+kL+MuVUOP1FN44aPmBhz84ZoRahyJ6oAu+vJr1GT6xaFINSpEFHC/lTcln9iO89hZpIQJ+ZLiPsXS7A0rW1vbz0VOnzDu4+luJ1QtY+k5e5dlqXhGQyjTrP9wnBiLoQHK8NZjHCtQZLLlsDQbzv6oxnSuXAvwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R1NXKIm37q/Uah5k+uRNSfJOKDxJeDX9XptluCY0/I=;
 b=F9tawv6a/frCW2INGKYAOkp4mgLVGxhJOKCLPZnwcoI6UdNiG1tzeYlHajkvEgXrOudbWACehwjWRzHPNIUJMrUlHni34G681lmcimR5OqzlJ+0RhGE7/Kys6iXnl77vHaIWBNvjCqWxDknLT1prtLatlqzgjaARXvSG0kuutsUI0kV7cMDnMXR0nN3KRruNlJjL/cUnhkFW7R3vheDEknoFvhBOKCUbspoL/0L2HHIHxpoFIR9SRNtzoMjzchW8lu4thOsyq/SRJhHcHBWWhHccmbwNWlE2dXuqouET48Un3c1pgL/BU6aapuMkBMJpE5A2Gqabou2s6TRBoXcznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R1NXKIm37q/Uah5k+uRNSfJOKDxJeDX9XptluCY0/I=;
 b=TOacTt1tAhPYeENPoLwT43DNA98CystfSQQpQSSW70X96VQQ1+w/qrkYlwNVqu2/1srjjPXzAzVkHfiWImCdAVJajonYIjWelMzTw+cHE39UKYqJBRz98QWUauefvwd9y18lygQJvq3eaucf02j+5w3XxzWkyVS5Zf0bWBn/Oa0=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5511.namprd07.prod.outlook.com (20.177.231.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Mon, 15 Jul 2019 11:00:11 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::81:1b79:7f6e:4ba9]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::81:1b79:7f6e:4ba9%6]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 11:00:11 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6bAUmQAgAroVsA=
Date:   Mon, 15 Jul 2019 11:00:11 +0000
Message-ID: <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <877e8tm25r.fsf@linux.intel.com>
In-Reply-To: <877e8tm25r.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjQyNGM4ODMtYTZlZi0xMWU5LTg3NDMtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGI0MjRjODg0LWE2ZWYtMTFlOS04NzQzLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTU3NTUiIHQ9IjEzMjA3NjYyMDA3MTcyMjkzNCIgaD0iK25sRGVzbkM3K0JBTk5uMU1IWmV2bzRDajhzPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59b000bb-8399-4f58-43de-08d709139bbc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5511;
x-ms-traffictypediagnostic: BYAPR07MB5511:
x-microsoft-antispam-prvs: <BYAPR07MB55115DE7AF44831C413A48A9DDCF0@BYAPR07MB5511.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(36092001)(51444003)(189003)(199004)(446003)(76176011)(76116006)(7696005)(66476007)(64756008)(66446008)(66556008)(52536014)(99286004)(229853002)(66946007)(26005)(6116002)(71190400001)(68736007)(71200400001)(3846002)(86362001)(486006)(476003)(30864003)(66066001)(33656002)(11346002)(2906002)(102836004)(305945005)(7736002)(74316002)(14454004)(55016002)(9686003)(6436002)(4326008)(2501003)(53946003)(6246003)(107886003)(53936002)(54906003)(6506007)(186003)(110136005)(8676002)(498600001)(81166006)(5660300002)(7416002)(81156014)(8936002)(256004)(14444005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5511;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XROQJMOwVOpQ2DkcW3iVyBby/Zq3Siac6H4b2+IIDOFypoLez4QnAhQqiA0Zur+0udW0pY6L98mv/IScP8Mn6ZfiOFV8QI+unR8U5XGt3AqNcZAbupW7nL/R2Zx0y28riOSpTajlQruQjrK33axJl1A0S03lSXldLvabKOqq3u8W7d05AksLLJiNbWpqz7DMgeaF0QFcISoFpZRO2XqqMsrP1KNK4ippzln/UHvepl92L3uilFGJwM3lpe8zgRidvYFvgxtuJbag7z4we32iglEZn0NxpPi/JcBUK0cR5Te/jRwzVFX1QRRSFpCbXLs8ORZqwb3a43PpR2LEJo7Dq6m+Yfnz9RXNz5iU7JlJPyJ8SkXKM95+of/up19MgzGDHLs0uCYkKQKrsR6Lb0dBQ+/fZMXiID0qNeku+RYtUiE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b000bb-8399-4f58-43de-08d709139bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 11:00:11.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5511
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe

>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>> +static void cdns3_gadget_config(struct cdns3_device *priv_dev)
>> +{
>> +	struct cdns3_usb_regs __iomem *regs =3D priv_dev->regs;
>> +	u32 reg;
>> +
>> +	cdns3_ep0_config(priv_dev);
>> +
>> +	/* enable interrupts for endpoint 0 (in and out) */
>> +	writel(EP_IEN_EP_OUT0 | EP_IEN_EP_IN0, &regs->ep_ien);
>> +
>> +	/*
>> +	 *Driver need modify LFPS minimal U1 Exit time for 0x00024505 revision
>
>comment style
>
>> +	 * of controller
>> +	 */
>> +	if (priv_dev->dev_ver =3D=3D DEV_VER_TI_V1) {
>
>this version is really only for TI? And there's another only for NXP?

Yes, from driver point of view the only difference for this version is  LFP=
S=20
parameter. It's depend on the kind of used PHY and should be set on=20
integration level. Default value is incorrect for DEV_VER_TI_V1 version and
it cause some issue for  one of the Link Layer test.

>
>+#define DEV_VER_NXP_V1		0x00024502
>+#define DEV_VER_TI_V1		0x00024509
>+#define DEV_VER_V2		0x0002450C
>+#define DEV_VER_V3		0x0002450d
>
>How do you actually decode this?

It's read from register: USB_CAP6
priv_dev->dev_ver =3D readl(&priv_dev->regs->usb_cap6);
But's only 3  less significant  bytes are used as version.=20

>
>> +static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>> +{
>> +	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>> +	struct cdns3_endpoint *priv_ep;
>> +	u32 bEndpointAddress;
>> +	struct usb_ep *ep;
>> +	int ret =3D 0;
>> +
>> +	priv_dev->gadget_driver =3D NULL;
>> +
>> +	priv_dev->onchip_used_size =3D 0;
>> +	priv_dev->out_mem_is_allocated =3D 0;
>> +	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
>> +
>> +	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
>> +		priv_ep =3D ep_to_cdns3_ep(ep);
>> +		bEndpointAddress =3D priv_ep->num | priv_ep->dir;
>> +		cdns3_select_ep(priv_dev, bEndpointAddress);
>> +		writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>> +		ret =3D cdns3_handshake(&priv_dev->regs->ep_cmd,
>> +				      EP_CMD_EPRST, 0, 100);
>> +		cdns3_free_trb_pool(priv_ep);
>
>are you sure you want to free your trb pool when a gadget driver is
>unloaded? One can easily fragment memory by constantly loading and
>unloading a gadget driver, no?

I think that such constantly loading/unloading will occurs only during=20
testing.
=20
>
>How about you allocate the trb poll during cdns3 load and free it when
>cdns3 is unloaded?

This allocation is made only in cdns3_gadget_ep_enable, so memory=20
is allocated only for  endpoint in use. We save a lot of memory, especially
for streams and ISOC endpoint.=20

Streams support is not implemented now but it will be added as separate
patch in the feature. It will require allocation multiple Transfer Rings.=20

The second issue are ISOC endpoints. For each ITP we need separate TRB.=20
So, for bInterval > 1 driver must allocate the quite big size of Transfer R=
ing. =20

During loading cdns3 we don't know which endpoint and how it will be used.

If someone from customers will complain about current implementation,=20
Then I will try to implement some improvement.=20
=20
>
>> +static int cdns3_gadget_start(struct cdns3 *cdns)
>> +{
>> +	struct cdns3_device *priv_dev;
>> +	u32 max_speed;
>> +	int ret;
>> +
>> +	priv_dev =3D kzalloc(sizeof(*priv_dev), GFP_KERNEL);
>> +	if (!priv_dev)
>> +		return -ENOMEM;
>> +
>> +	cdns->gadget_dev =3D priv_dev;
>> +	priv_dev->sysdev =3D cdns->dev;
>> +	priv_dev->dev =3D cdns->dev;
>> +	priv_dev->regs =3D cdns->dev_regs;
>> +
>> +	device_property_read_u16(priv_dev->dev, "cdns,on-chip-buff-size",
>> +				 &priv_dev->onchip_buffers);
>> +
>> +	if (priv_dev->onchip_buffers <=3D  0) {
>> +		u32 reg =3D readl(&priv_dev->regs->usb_cap2);
>> +
>> +		priv_dev->onchip_buffers =3D USB_CAP2_ACTUAL_MEM_SIZE(reg);
>> +	}
>> +
>> +	if (!priv_dev->onchip_buffers)
>> +		priv_dev->onchip_buffers =3D 256;
>> +
>> +	max_speed =3D usb_get_maximum_speed(cdns->dev);
>> +
>> +	/* Check the maximum_speed parameter */
>> +	switch (max_speed) {
>> +	case USB_SPEED_FULL:
>> +	case USB_SPEED_HIGH:
>> +	case USB_SPEED_SUPER:
>> +		break;
>> +	default:
>> +		dev_err(cdns->dev, "invalid maximum_speed parameter %d\n",
>> +			max_speed);
>> +		/* fall through */
>> +	case USB_SPEED_UNKNOWN:
>> +		/* default to superspeed */
>> +		max_speed =3D USB_SPEED_SUPER;
>> +		break;
>> +	}
>> +
>> +	/* fill gadget fields */
>> +	priv_dev->gadget.max_speed =3D max_speed;
>> +	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
>> +	priv_dev->gadget.ops =3D &cdns3_gadget_ops;
>> +	priv_dev->gadget.name =3D "usb-ss-gadget";
>> +	priv_dev->gadget.sg_supported =3D 1;
>> +
>> +	spin_lock_init(&priv_dev->lock);
>> +	INIT_WORK(&priv_dev->pending_status_wq,
>> +		  cdns3_pending_setup_status_handler);
>> +
>> +	/* initialize endpoint container */
>> +	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
>> +	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
>> +
>> +	ret =3D cdns3_init_eps(priv_dev);
>> +	if (ret) {
>> +		dev_err(priv_dev->dev, "Failed to create endpoints\n");
>> +		goto err1;
>> +	}
>> +
>> +	/* allocate memory for setup packet buffer */
>> +	priv_dev->setup_buf =3D dma_alloc_coherent(priv_dev->sysdev, 8,
>> +						 &priv_dev->setup_dma, GFP_DMA);
>> +	if (!priv_dev->setup_buf) {
>> +		ret =3D -ENOMEM;
>> +		goto err2;
>> +	}
>> +
>> +	priv_dev->dev_ver =3D readl(&priv_dev->regs->usb_cap6);
>> +
>> +	dev_dbg(priv_dev->dev, "Device Controller version: %08x\n",
>> +		readl(&priv_dev->regs->usb_cap6));
>> +	dev_dbg(priv_dev->dev, "USB Capabilities:: %08x\n",
>> +		readl(&priv_dev->regs->usb_cap1));
>> +	dev_dbg(priv_dev->dev, "On-Chip memory cnfiguration: %08x\n",
>> +		readl(&priv_dev->regs->usb_cap2));
>> +
>> +	priv_dev->dev_ver =3D GET_DEV_BASE_VERSION(priv_dev->dev_ver);
>> +
>> +	priv_dev->zlp_buf =3D kzalloc(CDNS3_EP_ZLP_BUF_SIZE, GFP_KERNEL);
>> +	if (!priv_dev->zlp_buf) {
>> +		ret =3D -ENOMEM;
>> +		goto err3;
>> +	}
>> +
>> +	/* add USB gadget device */
>> +	ret =3D usb_add_gadget_udc(priv_dev->dev, &priv_dev->gadget);
>> +	if (ret < 0) {
>> +		dev_err(priv_dev->dev,
>> +			"Failed to register USB device controller\n");
>> +		goto err4;
>> +	}
>> +
>> +	return 0;
>> +err4:
>> +	kfree(priv_dev->zlp_buf);
>> +err3:
>> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
>> +			  priv_dev->setup_dma);
>> +err2:
>> +	cdns3_free_all_eps(priv_dev);
>> +err1:
>> +	cdns->gadget_dev =3D NULL;
>> +	return ret;
>> +}
>> +
>> +static int __cdns3_gadget_init(struct cdns3 *cdns)
>> +{
>> +	struct cdns3_device *priv_dev;
>> +	int ret =3D 0;
>> +
>> +	cdns3_drd_switch_gadget(cdns, 1);
>> +	pm_runtime_get_sync(cdns->dev);
>> +
>> +	ret =3D cdns3_gadget_start(cdns);
>> +	if (ret)
>> +		return ret;
>> +
>> +	priv_dev =3D cdns->gadget_dev;
>> +	ret =3D devm_request_threaded_irq(cdns->dev, cdns->dev_irq,
>> +					cdns3_device_irq_handler,
>> +					cdns3_device_thread_irq_handler,
>> +					IRQF_SHARED, dev_name(cdns->dev), cdns);
>
>copied handlers here for commenting. Note that you don't have
>IRQF_ONESHOT:

I know, I can't use  IRQF_ ONESHOT flag in this case. I have implemented=20
some code for masking/unmasking interrupts in cdns3_device_irq_handler.

Some priority interrupts should be handled ASAP so I can't blocked interrup=
t=20
Line.=20

>
>> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
>> +{
>> +	struct cdns3_device *priv_dev;
>> +	struct cdns3 *cdns =3D data;
>> +	irqreturn_t ret =3D IRQ_NONE;
>> +	unsigned long flags;
>> +	u32 reg;
>> +
>> +	priv_dev =3D cdns->gadget_dev;
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>
>the top half handler runs in hardirq context. You don't need any locks
>here. Also IRQs are *already* disabled, you don't need to disable them aga=
in.

I will remove spin_lock_irqsave but I need to disable only some of the inte=
rrupts.=20
I disable interrupts associated with USB endpoints. Handling of them can be=
=20
deferred to thread handled.=20

>> +
>> +	/* check USB device interrupt */
>> +	reg =3D readl(&priv_dev->regs->usb_ists);
>> +
>> +	if (reg) {
>> +		writel(reg, &priv_dev->regs->usb_ists);
>> +		cdns3_check_usb_interrupt_proceed(priv_dev, reg);
>> +		ret =3D IRQ_HANDLED;
>
>now, because you _don't_ mask this interrupt, you're gonna have
>issues. Say we actually get both device and endpoint interrupts while
>the thread is already running with previous endpoint interrupts. Now
>we're gonna reenter the top half, because device interrupts are *not*
>masked, which will read usb_ists and handle it here.

Endpoint interrupts are masked in cdns3_device_irq_handler and stay masked
until they are not handled in threaded handler.=20
Of course, not all endpoint interrupts are masked, but only reported in ep_=
ists.
USB interrupt will be handled immediately.=20

Also, I can get next endpoint interrupt from not masked endpoint and driver=
 also again wake=20
the thread. I saw such situation, but threaded interrupt handler has been w=
orking correct
in such situations.

In thread handler driver checks again which endpoint should be handled in e=
p_ists.=20

I think that such situation should also occurs during our LPM enter/exit te=
st.=20
So, driver has  been tested for such case. During this test driver during=20
transferring data generate a huge number of LPM interrupts which=20
are usb interrupts.

I can't block usb interrupts interrupts because:
/*
 * WORKAROUND: CDNS3 controller has issue with hardware resuming
 * from L1. To fix it, if any DMA transfer is pending driver
 * must starts driving resume signal immediately.
 */


>
>Then it will ahead and read ep_ists and wake the thread that's already
>running.
>
>This hasn't really been tested, has it?

It has been tested. And I've haven't seen any issue with this.

>
>> +static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
>> +{
>> +	struct cdns3_device *priv_dev;
>> +	struct cdns3 *cdns =3D data;
>> +	irqreturn_t ret =3D IRQ_NONE;
>> +	unsigned long flags;
>> +	u32 ep_ien;
>> +	int bit;
>> +	u32 reg;
>> +
>> +	priv_dev =3D cdns->gadget_dev;
>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>
>Ideally, the _irqsave() here wouldn't be necessary (since this device's
>interrupts are already masked), but removing _irqsave() causes problem
>with networking gadgets. Just thought I'd leave a note here, nothing to
>change in this handler.
>
>> +	reg =3D readl(&priv_dev->regs->ep_ists);
>> +
>> +	/* handle default endpoint OUT */
>> +	if (reg & EP_ISTS_EP_OUT0) {
>> +		cdns3_check_ep0_interrupt_proceed(priv_dev, USB_DIR_OUT);
>> +		ret =3D IRQ_HANDLED;
>> +	}
>> +
>> +	/* handle default endpoint IN */
>> +	if (reg & EP_ISTS_EP_IN0) {
>> +		cdns3_check_ep0_interrupt_proceed(priv_dev, USB_DIR_IN);
>> +		ret =3D IRQ_HANDLED;
>> +	}
>> +
>> +	/* check if interrupt from non default endpoint, if no exit */
>> +	reg &=3D ~(EP_ISTS_EP_OUT0 | EP_ISTS_EP_IN0);
>> +	if (!reg)
>> +		goto irqend;
>> +
>> +	for_each_set_bit(bit, (unsigned long *)&reg,
>> +			 sizeof(u32) * BITS_PER_BYTE) {
>> +		priv_dev->shadow_ep_en |=3D BIT(bit);
>> +		cdns3_check_ep_interrupt_proceed(priv_dev->eps[bit]);
>> +		ret =3D IRQ_HANDLED;
>> +	}
>> +
>> +	if (priv_dev->run_garbage_colector) {
>
>wait, what?

DMA require data buffer aligned to 8 bytes. So, if buffer data is not align=
ed=20
driver allocate aligned buffer for data and copy it from unaligned to=20
Aligned. =20

>
>ps: correct spelling is "collector" ;-)

Ok, thanks.=20
>
>> +		struct cdns3_aligned_buf *buf, *tmp;
>> +
>> +		list_for_each_entry_safe(buf, tmp, &priv_dev->aligned_buf_list,
>> +					 list) {
>> +			if (!buf->in_use) {
>> +				list_del(&buf->list);
>> +
>> +				spin_unlock_irqrestore(&priv_dev->lock, flags);
>
>creates the possibility of a race condition
Why? In this place the buf can't be used.=20
>
>> +				dma_free_coherent(priv_dev->sysdev, buf->size,
>> +						  buf->buf,
>> +						  buf->dma);
>> +				spin_lock_irqsave(&priv_dev->lock, flags);
>> +
>> +				kfree(buf);
>
>why do you even need this "garbage collector"?

I need to free not used memory. The once allocated buffer will be associate=
d with
request, but if request.length will be increased in usb_request then driver=
 will =20
must allocate the  bigger buffer. As I remember I couldn't call dma_free_co=
herent
in interrupt context so I had to move it to thread handled. This flag was u=
sed to avoid
going through whole  aligned_buf_list  every time.=20
In most cases this part will never called int this place=20
>
>> +static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
>> +{
>> +	cdns3_gadget_exit(cdns);
>
>so on suspend you completely teardown the entire controller? This means
>that a mounted mass storage gadget will, actually, disconnect from the
>host, no?

Yes It's true. I know that it's not good idea.=20
I will try to improve it.=20

>
>> diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/trace.h
>> new file mode 100644
>> index 000000000000..1cc2abca320c
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/trace.h
>> @@ -0,0 +1,447 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * USBSS device controller driver.
>> + * Trace support header file.
>> + *
>> + * Copyright (C) 2018 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com>
>> + */
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM cdns3
>> +
>> +#if !defined(__LINUX_CDNS3_TRACE) || defined(TRACE_HEADER_MULTI_READ)
>> +#define __LINUX_CDNS3_TRACE
>> +
>> +#include <linux/types.h>
>> +#include <linux/tracepoint.h>
>> +#include <asm/byteorder.h>
>> +#include <linux/usb/ch9.h>
>> +#include "core.h"
>> +#include "gadget.h"
>> +#include "debug.h"
>> +
>> +#define CDNS3_MSG_MAX	500
>> +
>> +TRACE_EVENT(cdns3_log,
>> +	TP_PROTO(struct cdns3_device *priv_dev, struct va_format *vaf),
>> +	TP_ARGS(priv_dev, vaf),
>> +	TP_STRUCT__entry(
>> +		__string(name, dev_name(priv_dev->dev))
>> +		__dynamic_array(char, msg, CDNS3_MSG_MAX)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(name, dev_name(priv_dev->dev));
>> +		vsnprintf(__get_str(msg), CDNS3_MSG_MAX, vaf->fmt, *vaf->va);
>> +	),
>> +	TP_printk("%s: %s", __get_str(name), __get_str(msg))
>> +);
>> +
>> +DECLARE_EVENT_CLASS(cdns3_log_doorbell,
>> +	TP_PROTO(const char *ep_name, u32 ep_trbaddr),
>> +	TP_ARGS(ep_name, ep_trbaddr),
>> +	TP_STRUCT__entry(
>> +		__string(name, ep_name)
>> +		__field(u32, ep_trbaddr)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(name, ep_name);
>> +		__entry->ep_trbaddr =3D ep_trbaddr;
>> +	),
>> +	TP_printk("%s, ep_trbaddr %08x", __get_str(name),
>
>nit-picking but... the event name will be printed on trace log. You
>don't need this "Ding Dong" string here :-p

I will remove it:

>
>> +	TP_printk("%s: req: %p, req buff %p, length: %u/%u %s%s%s, status: %d,=
"
>> +		cd   " trb: [start:%d, end:%d: virt addr %pa], flags:%x ",
>> +		__get_str(name), __entry->req, __entry->buf, __entry->actual,
>> +		__entry->length,
>> +		__entry->zero ? "zero | " : "",
>> +		__entry->short_not_ok ? "short | " : "",
>> +		__entry->no_interrupt ? "no int" : "",
>
>I guess you didn't really think the formatting through. Think about what
>happens if you get a request with only zero flag or only short flag. How
>will this log look like?

Like this:
cdns3_gadget_giveback: ep0: req: 0000000071a6a5f5, req buff 000000008d40c4d=
b, length: 60/60 zero | , status: 0, trb: [start:0, end:0: virt addr (null)=
], flags:0

Is it something wrong with this?. Maybe one extra sign |.

Pawell
