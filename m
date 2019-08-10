Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2186C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8673C208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YP/GDfPu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Pe7uZBIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfHJUj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 16:39:56 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:56240 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfHJUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:39:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7AKaPfm021320;
        Sat, 10 Aug 2019 13:39:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=3NgbsqCzfnddYROx9cEbqqPW6IeEwNFVQrGN+AjIscg=;
 b=YP/GDfPuUjjLTgDcejDXP2Pi4GzWDdTjNNCg9DY/uvvZuoP27plHBlTM+P/snDnzQQL0
 bkn/zhfsZ3/2dUxEk7BstVu6dxR0W5UYC8ljq9g/fmx67pLP+aATtjXVOGR4jQIenv4j
 p6SU+f+TeBwqEqx8as5FNDxjDBpI+SSilchWaWvenTHWChtjYudX+724KeqLKlRVrM1k
 987dIe0l0UqNBwO5rv4tUlr+nlAtkaTMTIEWeYfdvY2MVDCpaOdwKPrkxh5W8QTXGp4P
 YOBADD5TfQzEeT3ejJQJ11pzYTavtTCUA+qkVpcsH+4vJHgYCt+mrCrPRh9TRDP9FZDz mw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u9tfs18yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Aug 2019 13:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjR1/Mw2o1QaDRFuk3sywhWSH0rfYyehE0Om+op8jAxiE8X7hpBRjZQVbjyCJLl1tlu5+58/kuHfaDe4ekfgtwWQQtjX65+JsOyAY0agjZGH06+EImd4NKwnA0Mt1jJATj/fTa9HEdVI0bZb/2P63IfR2r0MJSWIq6PbV0mHmmXPo+JTfsEYHa6C45CGxwFLoswnaurs4KRg6iDGiR5rxtp+KK8ZxbF2NUn+XvpgyUgZrdgwj266dhvPkC7AMX0u80ZK/MfNo7qM6BZWxSl9WjiOzArAemy8RcT/udTuMhUoVDpVE3zWikWqZgtrD5N+FWHkuh7o4XkctcEhTOiA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NgbsqCzfnddYROx9cEbqqPW6IeEwNFVQrGN+AjIscg=;
 b=FxN+iKU/oYeiQv+29wZteZ1hIdMD6MtX3Rw/L/99nE4OivXGaCXhG/CE5pfy9A9yqhcFyck3lPYY6bjUW5Wp1mSDQereVVmbDMcmq75pHBHkw7JjEZJ0YPxGLSn1xaKT9tbhQ44XhB40RvvkioM2UWnOFDTNbYC/jlYjmYOsxhzvjPp3yBLpaHlffG//Zu0LgJcf7koHUn3qmt9zvtSytQDqTC1qsuAJ5leqx/aFj5hEgwrqk3zL2dk/hANtb9EvhRUxfBqThzPyMCOOHHk2h8t8iAGTfuHuga7qzWAwnGFEZpiGU6lfxUMsytWZHc1JxGzsxtnVcYOziKekiCxV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NgbsqCzfnddYROx9cEbqqPW6IeEwNFVQrGN+AjIscg=;
 b=Pe7uZBIHG8f54Khbw2dc4EISzm/u6FLTGYW1l/qqxylronecfTBZ7fSp0+dMriTbkHiaKTaB+Q3xY7NR1CRC7Vo3BvH0kAKMRY39yTjcqiYcks1Xptej6KchJ6W/A8CI0+6R2OQRtBnjWfi6eAM2df+JVmfBYuCz/uKcRdmD2PY=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5575.namprd07.prod.outlook.com (20.177.231.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Sat, 10 Aug 2019 20:39:19 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.022; Sat, 10 Aug 2019
 20:39:19 +0000
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
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6bAUmQAgAroVsCAJHZ6gIAFRjxw
Date:   Sat, 10 Aug 2019 20:39:19 +0000
Message-ID: <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <877e8tm25r.fsf@linux.intel.com>
 <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <8736idnu0q.fsf@gmail.com>
In-Reply-To: <8736idnu0q.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYzUxZjk4ZjMtYmJhZS0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGM1MWY5OGY0LWJiYWUtMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTE2MzMiIHQ9IjEzMjA5OTQzMDkyODAwMDMxMSIgaD0iNEtOWElDVnZGazhzZDBqSUdrMWFldzJBMWdnPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6960f370-fd09-4bc1-31a3-08d71dd2d1b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5575;
x-ms-traffictypediagnostic: BYAPR07MB5575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB5575D31D61F58AEDAF97B390DDD10@BYAPR07MB5575.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(36092001)(51444003)(199004)(189003)(6116002)(3846002)(99286004)(4326008)(2501003)(71200400001)(86362001)(66066001)(478600001)(8936002)(256004)(55016002)(7416002)(14444005)(9686003)(14454004)(316002)(25786009)(6436002)(66556008)(26005)(33656002)(7736002)(76176011)(7696005)(305945005)(8676002)(2906002)(6246003)(71190400001)(102836004)(74316002)(229853002)(54906003)(107886003)(53936002)(110136005)(64756008)(66476007)(30864003)(66446008)(6506007)(5660300002)(81156014)(486006)(66946007)(446003)(11346002)(76116006)(186003)(52536014)(476003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5575;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vzqWRcCuNlz19BrkYOb4rvbl+q9JdIwcnsYopUYqbUD+A48RBictxBoMbP3bGxIyTsFf/xuSro1RnWik3CRE2407l1uIpIZEVyX0CAKstD/pSKKEvMd/G82Z/Qp+ajbvU+iP9s1dt7o+JDYiSRWXuCCVQqRRRqiz1A1w4YkT5lQAI8bPRBSRC14B7oAVuNR00FrE2u+DBpA8K3WXYQ8YW4/ziaKbpEZ92pqFA+9yAnHj23qykzFNxRymDAMjVYh6+Nq24ACUvbw3XX3x/f+k5/3WHXxKJWIQGPoqX7PAmTwfM5eQCvJqKIozvHjae5ujQZai2y5rA+4p8PbGReIuAFMoIsK2MgcNa+JQjabh4O+ycBzEU7NlXpsu3lEq7s8EkzqikscbmJad3SDv78docFzw+YqKHwqWBE0AAagNyXc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6960f370-fd09-4bc1-31a3-08d71dd2d1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 20:39:19.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5575
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908100231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>Pawel Laszczak <pawell@cadence.com> writes:
>>>> +static int cdns3_gadget_start(struct cdns3 *cdns)
>>>> +{
>>>> +	struct cdns3_device *priv_dev;
>>>> +	u32 max_speed;
>>>> +	int ret;
>>>> +
>>>> +	priv_dev =3D kzalloc(sizeof(*priv_dev), GFP_KERNEL);
>>>> +	if (!priv_dev)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	cdns->gadget_dev =3D priv_dev;
>>>> +	priv_dev->sysdev =3D cdns->dev;
>>>> +	priv_dev->dev =3D cdns->dev;
>>>> +	priv_dev->regs =3D cdns->dev_regs;
>>>> +
>>>> +	device_property_read_u16(priv_dev->dev, "cdns,on-chip-buff-size",
>>>> +				 &priv_dev->onchip_buffers);
>>>> +
>>>> +	if (priv_dev->onchip_buffers <=3D  0) {
>>>> +		u32 reg =3D readl(&priv_dev->regs->usb_cap2);
>>>> +
>>>> +		priv_dev->onchip_buffers =3D USB_CAP2_ACTUAL_MEM_SIZE(reg);
>>>> +	}
>>>> +
>>>> +	if (!priv_dev->onchip_buffers)
>>>> +		priv_dev->onchip_buffers =3D 256;
>>>> +
>>>> +	max_speed =3D usb_get_maximum_speed(cdns->dev);
>>>> +
>>>> +	/* Check the maximum_speed parameter */
>>>> +	switch (max_speed) {
>>>> +	case USB_SPEED_FULL:
>>>> +	case USB_SPEED_HIGH:
>>>> +	case USB_SPEED_SUPER:
>>>> +		break;
>>>> +	default:
>>>> +		dev_err(cdns->dev, "invalid maximum_speed parameter %d\n",
>>>> +			max_speed);
>>>> +		/* fall through */
>>>> +	case USB_SPEED_UNKNOWN:
>>>> +		/* default to superspeed */
>>>> +		max_speed =3D USB_SPEED_SUPER;
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	/* fill gadget fields */
>>>> +	priv_dev->gadget.max_speed =3D max_speed;
>>>> +	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
>>>> +	priv_dev->gadget.ops =3D &cdns3_gadget_ops;
>>>> +	priv_dev->gadget.name =3D "usb-ss-gadget";
>>>> +	priv_dev->gadget.sg_supported =3D 1;
>>>> +
>>>> +	spin_lock_init(&priv_dev->lock);
>>>> +	INIT_WORK(&priv_dev->pending_status_wq,
>>>> +		  cdns3_pending_setup_status_handler);
>>>> +
>>>> +	/* initialize endpoint container */
>>>> +	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
>>>> +	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
>>>> +
>>>> +	ret =3D cdns3_init_eps(priv_dev);
>>>> +	if (ret) {
>>>> +		dev_err(priv_dev->dev, "Failed to create endpoints\n");
>>>> +		goto err1;
>>>> +	}
>>>> +
>>>> +	/* allocate memory for setup packet buffer */
>>>> +	priv_dev->setup_buf =3D dma_alloc_coherent(priv_dev->sysdev, 8,
>>>> +						 &priv_dev->setup_dma, GFP_DMA);
>>>> +	if (!priv_dev->setup_buf) {
>>>> +		ret =3D -ENOMEM;
>>>> +		goto err2;
>>>> +	}
>>>> +
>>>> +	priv_dev->dev_ver =3D readl(&priv_dev->regs->usb_cap6);
>>>> +
>>>> +	dev_dbg(priv_dev->dev, "Device Controller version: %08x\n",
>>>> +		readl(&priv_dev->regs->usb_cap6));
>>>> +	dev_dbg(priv_dev->dev, "USB Capabilities:: %08x\n",
>>>> +		readl(&priv_dev->regs->usb_cap1));
>>>> +	dev_dbg(priv_dev->dev, "On-Chip memory cnfiguration: %08x\n",
>>>> +		readl(&priv_dev->regs->usb_cap2));
>>>> +
>>>> +	priv_dev->dev_ver =3D GET_DEV_BASE_VERSION(priv_dev->dev_ver);
>>>> +
>>>> +	priv_dev->zlp_buf =3D kzalloc(CDNS3_EP_ZLP_BUF_SIZE, GFP_KERNEL);
>>>> +	if (!priv_dev->zlp_buf) {
>>>> +		ret =3D -ENOMEM;
>>>> +		goto err3;
>>>> +	}
>>>> +
>>>> +	/* add USB gadget device */
>>>> +	ret =3D usb_add_gadget_udc(priv_dev->dev, &priv_dev->gadget);
>>>> +	if (ret < 0) {
>>>> +		dev_err(priv_dev->dev,
>>>> +			"Failed to register USB device controller\n");
>>>> +		goto err4;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +err4:
>>>> +	kfree(priv_dev->zlp_buf);
>>>> +err3:
>>>> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
>>>> +			  priv_dev->setup_dma);
>>>> +err2:
>>>> +	cdns3_free_all_eps(priv_dev);
>>>> +err1:
>>>> +	cdns->gadget_dev =3D NULL;
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int __cdns3_gadget_init(struct cdns3 *cdns)
>>>> +{
>>>> +	struct cdns3_device *priv_dev;
>>>> +	int ret =3D 0;
>>>> +
>>>> +	cdns3_drd_switch_gadget(cdns, 1);
>>>> +	pm_runtime_get_sync(cdns->dev);
>>>> +
>>>> +	ret =3D cdns3_gadget_start(cdns);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	priv_dev =3D cdns->gadget_dev;
>>>> +	ret =3D devm_request_threaded_irq(cdns->dev, cdns->dev_irq,
>>>> +					cdns3_device_irq_handler,
>>>> +					cdns3_device_thread_irq_handler,
>>>> +					IRQF_SHARED, dev_name(cdns->dev), cdns);
>>>
>>>copied handlers here for commenting. Note that you don't have
>>>IRQF_ONESHOT:
>>
>> I know, I can't use  IRQF_ ONESHOT flag in this case. I have implemented
>> some code for masking/unmasking interrupts in cdns3_device_irq_handler.
>>
>> Some priority interrupts should be handled ASAP so I can't blocked inter=
rupt
>> Line.
>
>You're completely missing my comment. Your top half should be as short
>as possile. It should only check if current device generated
>interrupts. If it did, then you should wake the thread handler.
>
>This is to improve realtime behavior but not keeping preemption disabled
>for longer than necessary.

Ok, I understand. I will move it to thread handler.

I can't use IRQF_ONESHOT flag because it doesn't work when interrupt line i=
s shared.=20
I have such situation in which one interrupt line is shared with ehci and c=
dns3 driver.=20
In such case this function returns error code.=20

So probably I will need to mask only the reported interrupts.=20
I can't mask all interrupt using controller register because I can miss som=
e of them.=20
After masking all interrupt  the next new event will not be reported in  us=
b_ists, ep_ists=20
registers.

>
>>>> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
>>>> +{
>>>> +	struct cdns3_device *priv_dev;
>>>> +	struct cdns3 *cdns =3D data;
>>>> +	irqreturn_t ret =3D IRQ_NONE;
>>>> +	unsigned long flags;
>>>> +	u32 reg;
>>>> +
>>>> +	priv_dev =3D cdns->gadget_dev;
>>>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>>
>>>the top half handler runs in hardirq context. You don't need any locks
>>>here. Also IRQs are *already* disabled, you don't need to disable them a=
gain.
>>
>> I will remove spin_lock_irqsave but I need to disable only some of the i=
nterrupts.
>> I disable interrupts associated with USB endpoints. Handling of them can=
 be
>> deferred to thread handled.
>
>you should defer all of them to thread. Endpoints or otherwise.

I will do this.=20

Also I remove spin_lock_irqsave(&priv_dev->lock, flags);=20
As I remember it's not needed here.=20

>
>>>> +
>>>> +	/* check USB device interrupt */
>>>> +	reg =3D readl(&priv_dev->regs->usb_ists);
>>>> +
>>>> +	if (reg) {
>>>> +		writel(reg, &priv_dev->regs->usb_ists);
>>>> +		cdns3_check_usb_interrupt_proceed(priv_dev, reg);
>>>> +		ret =3D IRQ_HANDLED;
>>>
>>>now, because you _don't_ mask this interrupt, you're gonna have
>>>issues. Say we actually get both device and endpoint interrupts while
>>>the thread is already running with previous endpoint interrupts. Now
>>>we're gonna reenter the top half, because device interrupts are *not*
>>>masked, which will read usb_ists and handle it here.
>>
>> Endpoint interrupts are masked in cdns3_device_irq_handler and stay mask=
ed
>> until they are not handled in threaded handler.
>
>Quick question, then: these ISTS registers, are they masked interrupt
>status or raw interrupt status?

Yes it's masked, but after masking them the new interrupts will not be repo=
rted=20
In ISTS registers. Form this reason I can mask only reported interrupt.=20

>
>> Of course, not all endpoint interrupts are masked, but only reported in =
ep_ists.
>> USB interrupt will be handled immediately.
>>
>> Also, I can get next endpoint interrupt from not masked endpoint and dri=
ver also again wake
>> the thread. I saw such situation, but threaded interrupt handler has bee=
n working correct
>> in such situations.
>>
>> In thread handler driver checks again which endpoint should be handled i=
n ep_ists.
>>
>> I think that such situation should also occurs during our LPM enter/exit=
 test.
>> So, driver has  been tested for such case. During this test driver durin=
g
>> transferring data generate a huge number of LPM interrupts which
>> are usb interrupts.
>>
>> I can't block usb interrupts interrupts because:
>> /*
>>  * WORKAROUND: CDNS3 controller has issue with hardware resuming
>>  * from L1. To fix it, if any DMA transfer is pending driver
>>  * must starts driving resume signal immediately.
>>  */
>
>I can't see why this would prevent you from defering handling to thread
>handler.
>

I also will  try to move it, but this change can has impact on performance.=
=20

>
>>>> +	if (priv_dev->run_garbage_colector) {
>>>
>>>wait, what?
>>
>> DMA require data buffer aligned to 8 bytes. So, if buffer data is not al=
igned
>> driver allocate aligned buffer for data and copy it from unaligned to
>> Aligned.
>>
>>>
>>>ps: correct spelling is "collector" ;-)
>>
>> Ok, thanks.
>>>
>>>> +		struct cdns3_aligned_buf *buf, *tmp;
>>>> +
>>>> +		list_for_each_entry_safe(buf, tmp, &priv_dev->aligned_buf_list,
>>>> +					 list) {
>>>> +			if (!buf->in_use) {
>>>> +				list_del(&buf->list);
>>>> +
>>>> +				spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>
>>>creates the possibility of a race condition
>> Why? In this place the buf can't be used.
>
>but you're reenabling interrupts, right?

Yes, driver frees not used buffers here.=20
I think that it's the safest place for this purpose.=20

>
>>>> +				dma_free_coherent(priv_dev->sysdev, buf->size,
>>>> +						  buf->buf,
>>>> +						  buf->dma);
>>>> +				spin_lock_irqsave(&priv_dev->lock, flags);
>>>> +
>>>> +				kfree(buf);
>>>
>>>why do you even need this "garbage collector"?
>>
>> I need to free not used memory. The once allocated buffer will be associ=
ated with
>> request, but if request.length will be increased in usb_request then dri=
ver will
>> must allocate the  bigger buffer. As I remember I couldn't call dma_free=
_coherent
>> in interrupt context so I had to move it to thread handled. This flag wa=
s used to avoid
>> going through whole  aligned_buf_list  every time.
>> In most cases this part will never called int this place
>
>Did you try, btw, setting the quirk flag which tells gadget drivers to
>always allocate buffers aligned to MaxPacketSize? Wouldn't that be enough?

If found only  quirk_ep_out_aligned_size flag, but it align only buffer siz=
e.=20

DMA used by this controller must have buffer address aligned to 8.
I think that on most architecture kmalloc should guarantee such aligned.
The problem was detected on NXP testing board. =20
On my board all buffer address are alignment at least to 8. =20

>
>>>> +	TP_printk("%s: req: %p, req buff %p, length: %u/%u %s%s%s, status: %=
d,"
>>>> +		cd   " trb: [start:%d, end:%d: virt addr %pa], flags:%x ",
>>>> +		__get_str(name), __entry->req, __entry->buf, __entry->actual,
>>>> +		__entry->length,
>>>> +		__entry->zero ? "zero | " : "",
>>>> +		__entry->short_not_ok ? "short | " : "",
>>>> +		__entry->no_interrupt ? "no int" : "",
>>>
>>>I guess you didn't really think the formatting through. Think about what
>>>happens if you get a request with only zero flag or only short flag. How
>>>will this log look like?
>>
>> Like this:
>> cdns3_gadget_giveback: ep0: req: 0000000071a6a5f5, req buff 000000008d40=
c4db, length: 60/60 zero | , status: 0, trb: [start:0, end:0:
>virt addr (null)], flags:0
>>
>> Is it something wrong with this?. Maybe one extra sign |.
>
>yes, the extra | :-)
>
>This is one reason why I switched to character flags where a lower case
>character means flag is cleared while uppercase means it's set.

I've made it in this way in v10

--

Thanks
Pawell
