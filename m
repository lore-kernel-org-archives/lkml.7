Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8E720663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="fsNS7Nzi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="d+ncnL5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfHLHOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:14:20 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37632 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbfHLHOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:14:18 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C7CI9f013244;
        Mon, 12 Aug 2019 00:13:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=EQo1H9MaTEAa+tVDAJH16X/m7j+eDrYZzosMOq/W97w=;
 b=fsNS7NzifGEsUb0B3nvKO3HWD14pV1udXSYDP0aTgkRkZiU7k6CeXGmBM3mvwHNJfB8c
 oeukolMZHBjkb0kAEiETTsn73UMxvw9eHeGskVtEEFQ8gnJj03EiatqlET7MEHcerINJ
 mhiLFeiP95GCkNJ/x8iAPZ9GEQGGp2NXABNHkrAtq1hFygVkQY//Xb0NriVg5ICoHQVr
 ytDqNP6vkXbTJIQ4jMfVQ0tiUuAa3vU40UgUE2vhSQvlr1sauR6fdBSAcdriaixpu329
 gKZUiZyyDwWxmlFlHX444o8jqrqTeFVe2+Ntiot/n8XXb9+QUJl0cuPxcR8dIgexyvcb sA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u9tfs4tmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 00:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a16cujxcUmRNU8IIDmk0rbpPE3JjAzFGcfd38ewzX3GEETyZcEzfQF6hp9vnqXtrGnrqVA1MzjILaduhj+62HHwLslI/VNV6ZKDhruhkLWAvTiSIsn9u04bTu4Wz8Qp4njzvII4G0+R2YRlhlnMnWwaffu4Re2dKF3/grpVYEWp5pj1KYbC+PmL8SvKk+rqB7UrnZHRf6Qme5RahL2lVD7j7SgLQDsJJPyEH9SFk4EQlWpn18IlpkaPilqbnZ5R/jzTXNs+ukC5VZUX6+zDsdXNskFnMuqrmv7TATvTiSR2QXc+Ct68W2IpbtHkwLSO6AiHIaq6dgsPd6mYehr7ARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQo1H9MaTEAa+tVDAJH16X/m7j+eDrYZzosMOq/W97w=;
 b=XNTm5FGg+t9kwHjA2Rdh67Ofgw8rvVcdF2oU5E5TpJm7HQrAcv6rMMmFHc0/F0eh8Gxlghqi6Shbzrc8CLvfa8C6q6ehhlm7axhAQEjLUjjWbNDVSBErBAijSENzl3duSmTatdFSi0VQKlKFvGPQoqI82EmYKMvDFtONKjMnLvAn3jfsMvyFeddYRa9Hw75uYWxqQLjkJHDO8MxX3yDGfCi45uDH9wzye3JECbCBmB7164SAwVszvPYFH0wLeYmbLinBNS1molgjHVTq8QFOxgYAGeEriDcVD12Mr53Drl1WtEUancFTe9/d4OkfYis562PKgDnoxzZbC+vlkk44PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQo1H9MaTEAa+tVDAJH16X/m7j+eDrYZzosMOq/W97w=;
 b=d+ncnL5QMdcu+bWARa26GQ3IilNbNnGNiMS/nb1R9/bfSXb5Z6OzT2oyrlYNN1IbhJGBFN6jLI4se7+nu+PMW9mpS0x3YPj3M+uIUsoWSvSajZEm/hN5Rs6ZujgsBmXLFxUSqBlK225tR9oZU6GIuXmd3SIueu64UM/E833Y99I=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6262.namprd07.prod.outlook.com (20.179.63.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 07:13:50 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.022; Mon, 12 Aug 2019
 07:13:50 +0000
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
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6bAUmQAgAroVsCAJHZ6gIAFRjxwgAI+roCAAAREAA==
Date:   Mon, 12 Aug 2019 07:13:50 +0000
Message-ID: <BYAPR07MB470926DA6241B54FC5AF3C2ADDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <877e8tm25r.fsf@linux.intel.com>
 <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <8736idnu0q.fsf@gmail.com>
 <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87k1bjvtvi.fsf@gmail.com>
In-Reply-To: <87k1bjvtvi.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOTQ0ZmZiNWMtYmNkMC0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDk0NGZmYjVkLWJjZDAtMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTQwNjIiIHQ9IjEzMjEwMDY3NTY0OTQ2ODgxMCIgaD0iYkIyZWpyZk1kb2JwRjBMMjBNaXMwSUxvVjRBPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [158.140.1.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 487df455-a736-4225-4f8f-08d71ef4a020
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB6262;
x-ms-traffictypediagnostic: BYAPR07MB6262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB6262007AD76CF803A47E52E5DDD30@BYAPR07MB6262.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(51444003)(36092001)(6506007)(66446008)(2501003)(9686003)(7736002)(11346002)(7696005)(102836004)(86362001)(4326008)(186003)(53936002)(26005)(55016002)(52536014)(74316002)(6246003)(3846002)(110136005)(476003)(33656002)(99286004)(107886003)(76176011)(316002)(229853002)(25786009)(305945005)(54906003)(446003)(6116002)(8676002)(486006)(5660300002)(66066001)(256004)(66476007)(478600001)(71200400001)(76116006)(66946007)(14444005)(14454004)(6436002)(71190400001)(8936002)(81166006)(7416002)(81156014)(64756008)(2906002)(30864003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6262;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z8/MaZR6WB6butlRrJefzb6i0uYckwwepnRqpGUlXBlpEvmv2HXUDPSSYkNfwyDJMb4OVsZBDe0AU1HQja4IaBLF+kRI+Avi0ay71p1WqOVOxbOpRzo1z2ASpwfVYNZwFmbZiPK+jXhLXlHvvcyxQzeZJ8rSPld3tcFVIh5eJk3guJ2FjK41IxvgaMiGSLVTLMoRATMAj7NGOLq5dLjMZy4yqzc5J9rcYJM8pMZCJhOfGq9rA3SVLimzaEGAIOGgSjVPFj+kcI9kRHQ3HOSyXbEg2BAw7UiDexBqWm595COPHQzAZ0eA3YX40tJUEEF76VBAo0npswm2F9u/C8g2FSIlsxmu+4E5yRTypRJn9u1R3NUCqWeFMTKM6pfdjJlkCxXNPgYDXKOEldnukWxUumnfZy0avIv3y6B1ROYbkww=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487df455-a736-4225-4f8f-08d71ef4a020
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 07:13:50.0871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6262
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>
>> Hi,
>>
>>>
>>>Pawel Laszczak <pawell@cadence.com> writes:
>>>>>> +static int cdns3_gadget_start(struct cdns3 *cdns)
>>>>>> +{
>>>>>> +	struct cdns3_device *priv_dev;
>>>>>> +	u32 max_speed;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	priv_dev =3D kzalloc(sizeof(*priv_dev), GFP_KERNEL);
>>>>>> +	if (!priv_dev)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	cdns->gadget_dev =3D priv_dev;
>>>>>> +	priv_dev->sysdev =3D cdns->dev;
>>>>>> +	priv_dev->dev =3D cdns->dev;
>>>>>> +	priv_dev->regs =3D cdns->dev_regs;
>>>>>> +
>>>>>> +	device_property_read_u16(priv_dev->dev, "cdns,on-chip-buff-size",
>>>>>> +				 &priv_dev->onchip_buffers);
>>>>>> +
>>>>>> +	if (priv_dev->onchip_buffers <=3D  0) {
>>>>>> +		u32 reg =3D readl(&priv_dev->regs->usb_cap2);
>>>>>> +
>>>>>> +		priv_dev->onchip_buffers =3D USB_CAP2_ACTUAL_MEM_SIZE(reg);
>>>>>> +	}
>>>>>> +
>>>>>> +	if (!priv_dev->onchip_buffers)
>>>>>> +		priv_dev->onchip_buffers =3D 256;
>>>>>> +
>>>>>> +	max_speed =3D usb_get_maximum_speed(cdns->dev);
>>>>>> +
>>>>>> +	/* Check the maximum_speed parameter */
>>>>>> +	switch (max_speed) {
>>>>>> +	case USB_SPEED_FULL:
>>>>>> +	case USB_SPEED_HIGH:
>>>>>> +	case USB_SPEED_SUPER:
>>>>>> +		break;
>>>>>> +	default:
>>>>>> +		dev_err(cdns->dev, "invalid maximum_speed parameter %d\n",
>>>>>> +			max_speed);
>>>>>> +		/* fall through */
>>>>>> +	case USB_SPEED_UNKNOWN:
>>>>>> +		/* default to superspeed */
>>>>>> +		max_speed =3D USB_SPEED_SUPER;
>>>>>> +		break;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* fill gadget fields */
>>>>>> +	priv_dev->gadget.max_speed =3D max_speed;
>>>>>> +	priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
>>>>>> +	priv_dev->gadget.ops =3D &cdns3_gadget_ops;
>>>>>> +	priv_dev->gadget.name =3D "usb-ss-gadget";
>>>>>> +	priv_dev->gadget.sg_supported =3D 1;
>>>>>> +
>>>>>> +	spin_lock_init(&priv_dev->lock);
>>>>>> +	INIT_WORK(&priv_dev->pending_status_wq,
>>>>>> +		  cdns3_pending_setup_status_handler);
>>>>>> +
>>>>>> +	/* initialize endpoint container */
>>>>>> +	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
>>>>>> +	INIT_LIST_HEAD(&priv_dev->aligned_buf_list);
>>>>>> +
>>>>>> +	ret =3D cdns3_init_eps(priv_dev);
>>>>>> +	if (ret) {
>>>>>> +		dev_err(priv_dev->dev, "Failed to create endpoints\n");
>>>>>> +		goto err1;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* allocate memory for setup packet buffer */
>>>>>> +	priv_dev->setup_buf =3D dma_alloc_coherent(priv_dev->sysdev, 8,
>>>>>> +						 &priv_dev->setup_dma, GFP_DMA);
>>>>>> +	if (!priv_dev->setup_buf) {
>>>>>> +		ret =3D -ENOMEM;
>>>>>> +		goto err2;
>>>>>> +	}
>>>>>> +
>>>>>> +	priv_dev->dev_ver =3D readl(&priv_dev->regs->usb_cap6);
>>>>>> +
>>>>>> +	dev_dbg(priv_dev->dev, "Device Controller version: %08x\n",
>>>>>> +		readl(&priv_dev->regs->usb_cap6));
>>>>>> +	dev_dbg(priv_dev->dev, "USB Capabilities:: %08x\n",
>>>>>> +		readl(&priv_dev->regs->usb_cap1));
>>>>>> +	dev_dbg(priv_dev->dev, "On-Chip memory cnfiguration: %08x\n",
>>>>>> +		readl(&priv_dev->regs->usb_cap2));
>>>>>> +
>>>>>> +	priv_dev->dev_ver =3D GET_DEV_BASE_VERSION(priv_dev->dev_ver);
>>>>>> +
>>>>>> +	priv_dev->zlp_buf =3D kzalloc(CDNS3_EP_ZLP_BUF_SIZE, GFP_KERNEL);
>>>>>> +	if (!priv_dev->zlp_buf) {
>>>>>> +		ret =3D -ENOMEM;
>>>>>> +		goto err3;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* add USB gadget device */
>>>>>> +	ret =3D usb_add_gadget_udc(priv_dev->dev, &priv_dev->gadget);
>>>>>> +	if (ret < 0) {
>>>>>> +		dev_err(priv_dev->dev,
>>>>>> +			"Failed to register USB device controller\n");
>>>>>> +		goto err4;
>>>>>> +	}
>>>>>> +
>>>>>> +	return 0;
>>>>>> +err4:
>>>>>> +	kfree(priv_dev->zlp_buf);
>>>>>> +err3:
>>>>>> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
>>>>>> +			  priv_dev->setup_dma);
>>>>>> +err2:
>>>>>> +	cdns3_free_all_eps(priv_dev);
>>>>>> +err1:
>>>>>> +	cdns->gadget_dev =3D NULL;
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int __cdns3_gadget_init(struct cdns3 *cdns)
>>>>>> +{
>>>>>> +	struct cdns3_device *priv_dev;
>>>>>> +	int ret =3D 0;
>>>>>> +
>>>>>> +	cdns3_drd_switch_gadget(cdns, 1);
>>>>>> +	pm_runtime_get_sync(cdns->dev);
>>>>>> +
>>>>>> +	ret =3D cdns3_gadget_start(cdns);
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	priv_dev =3D cdns->gadget_dev;
>>>>>> +	ret =3D devm_request_threaded_irq(cdns->dev, cdns->dev_irq,
>>>>>> +					cdns3_device_irq_handler,
>>>>>> +					cdns3_device_thread_irq_handler,
>>>>>> +					IRQF_SHARED, dev_name(cdns->dev), cdns);
>>>>>
>>>>>copied handlers here for commenting. Note that you don't have
>>>>>IRQF_ONESHOT:
>>>>
>>>> I know, I can't use  IRQF_ ONESHOT flag in this case. I have implement=
ed
>>>> some code for masking/unmasking interrupts in cdns3_device_irq_handler=
.
>>>>
>>>> Some priority interrupts should be handled ASAP so I can't blocked int=
errupt
>>>> Line.
>>>
>>>You're completely missing my comment. Your top half should be as short
>>>as possile. It should only check if current device generated
>>>interrupts. If it did, then you should wake the thread handler.
>>>
>>>This is to improve realtime behavior but not keeping preemption disabled
>>>for longer than necessary.
>>
>> Ok, I understand. I will move it to thread handler.
>>
>> I can't use IRQF_ONESHOT flag because it doesn't work when interrupt lin=
e is shared.
>
>yeah, you should try to avoid ONESHOT :-)
>
>> I have such situation in which one interrupt line is shared with ehci an=
d cdns3 driver.
>> In such case this function returns error code.
>
>which function returns error code?

devm_request_threaded_irq, of course if I set IRQF_SHARED | IRQF_ONESHOT.
As I remember it was EBUSY error.

>
>> So probably I will need to mask only the reported interrupts.
>
>you should mask all interrupts from your device, otherwise you top-halt
>may still end up reentrant.
>
>> I can't mask all interrupt using controller register because I can miss =
some of them.
>
>why would you miss them? They would be left in the register until you
>unmask them and the line is raised again.

I consult this with author of controller.=20
We have:
USB_IEN  and USB_ISTS for  generic interrupts
EP_IEN and EP_ISTS for endpoint interrupts=20

Both these group works different.
For endpoint I can disable all interrupt and I don't miss any of them.=20
So it's normal behavior.

But USB_ISTS work little different. If we mask all interrupt in USB_IEN
then when new event occurs the EP_ISTS will not be updated.=20
It's not standard and not expected behavior but it works in this way.=20

I thought that EP_IEN/EP_ISTS works in the same way.=20

I update driver according with this rules. I hope that it will work=20

>
>> After masking all interrupt  the next new event will not be reported in =
 usb_ists, ep_ists
>> registers.
>
>why not? Masking means that new events won't cause the IRQ line to be
>asserted (or MSI DWORD write won't be initiated), but the event itself
>should still be in the register.


>
>>>>>> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
>>>>>> +{
>>>>>> +	struct cdns3_device *priv_dev;
>>>>>> +	struct cdns3 *cdns =3D data;
>>>>>> +	irqreturn_t ret =3D IRQ_NONE;
>>>>>> +	unsigned long flags;
>>>>>> +	u32 reg;
>>>>>> +
>>>>>> +	priv_dev =3D cdns->gadget_dev;
>>>>>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>>>>
>>>>>the top half handler runs in hardirq context. You don't need any locks
>>>>>here. Also IRQs are *already* disabled, you don't need to disable them=
 again.
>>>>
>>>> I will remove spin_lock_irqsave but I need to disable only some of the=
 interrupts.
>>>> I disable interrupts associated with USB endpoints. Handling of them c=
an be
>>>> deferred to thread handled.
>>>
>>>you should defer all of them to thread. Endpoints or otherwise.
>>
>> I will do this.
>>
>> Also I remove spin_lock_irqsave(&priv_dev->lock, flags);
>> As I remember it's not needed here.
>
>right
>
>>>>>> +	/* check USB device interrupt */
>>>>>> +	reg =3D readl(&priv_dev->regs->usb_ists);
>>>>>> +
>>>>>> +	if (reg) {
>>>>>> +		writel(reg, &priv_dev->regs->usb_ists);
>>>>>> +		cdns3_check_usb_interrupt_proceed(priv_dev, reg);
>>>>>> +		ret =3D IRQ_HANDLED;
>>>>>
>>>>>now, because you _don't_ mask this interrupt, you're gonna have
>>>>>issues. Say we actually get both device and endpoint interrupts while
>>>>>the thread is already running with previous endpoint interrupts. Now
>>>>>we're gonna reenter the top half, because device interrupts are *not*
>>>>>masked, which will read usb_ists and handle it here.
>>>>
>>>> Endpoint interrupts are masked in cdns3_device_irq_handler and stay ma=
sked
>>>> until they are not handled in threaded handler.
>>>
>>>Quick question, then: these ISTS registers, are they masked interrupt
>>>status or raw interrupt status?
>>
>> Yes it's masked, but after masking them the new interrupts will not be r=
eported
>> In ISTS registers. Form this reason I can mask only reported interrupt.
>
>and what happens when you unmask the registers? Do they get reported?

No they are not reported in case of USB_ISTS register.
They should be reported in case EP_ISTS, but I need to test it.=20
=20
>
>>>> Of course, not all endpoint interrupts are masked, but only reported i=
n ep_ists.
>>>> USB interrupt will be handled immediately.
>>>>
>>>> Also, I can get next endpoint interrupt from not masked endpoint and d=
river also again wake
>>>> the thread. I saw such situation, but threaded interrupt handler has b=
een working correct
>>>> in such situations.
>>>>
>>>> In thread handler driver checks again which endpoint should be handled=
 in ep_ists.
>>>>
>>>> I think that such situation should also occurs during our LPM enter/ex=
it test.
>>>> So, driver has  been tested for such case. During this test driver dur=
ing
>>>> transferring data generate a huge number of LPM interrupts which
>>>> are usb interrupts.
>>>>
>>>> I can't block usb interrupts interrupts because:
>>>> /*
>>>>  * WORKAROUND: CDNS3 controller has issue with hardware resuming
>>>>  * from L1. To fix it, if any DMA transfer is pending driver
>>>>  * must starts driving resume signal immediately.
>>>>  */
>>>
>>>I can't see why this would prevent you from defering handling to thread
>>>handler.
>>>
>>
>> I also will  try to move it, but this change can has impact on performan=
ce.
>
>how much is the impact? What's the impact? Why does this impact performanc=
e?

It's only my guess.=20

I can't  come up with the right scenario now.=20

Sorry, I think that it was my mistake.=20

>
>>>>>> +		struct cdns3_aligned_buf *buf, *tmp;
>>>>>> +
>>>>>> +		list_for_each_entry_safe(buf, tmp, &priv_dev->aligned_buf_list,
>>>>>> +					 list) {
>>>>>> +			if (!buf->in_use) {
>>>>>> +				list_del(&buf->list);
>>>>>> +
>>>>>> +				spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>>>
>>>>>creates the possibility of a race condition
>>>> Why? In this place the buf can't be used.
>>>
>>>but you're reenabling interrupts, right?
>>
>> Yes, driver frees not used buffers here.
>> I think that it's the safest place for this purpose.
>
>I guess you missed the point a little. Since you reenable interrupts
>just to free the buffer, you end up creating the possibility for a race
>condition. Specially since you don't mask all interrupt events. The
>moment you reenable interrupts, one of your not-unmasked interrupt
>sources could trigger, then top-half gets scheduled which tries to wake
>up the IRQ thread again and things go boom.

Ok, I think I understand.  So I have 3 options:
1. Mask the USB_IEN and EP_IEN interrupts, but then I can lost some USB_IST=
S
events. It's dangerous options.=20
2. Remove implementation of handling unaligned buffers and assume that=20
    upper layer will worry about this. What with vendor specific drivers th=
at=20
    can be used by companies and not upstreamed  ?=20
    It could be good to have such safety mechanism even if it is not curren=
tly used.
3. Delegate this part of code for instance to separate thread that will be =
called=20
   In free time.=20

In my opinion the third option is safest.  =20

>
>>>>>> +				dma_free_coherent(priv_dev->sysdev, buf->size,
>>>>>> +						  buf->buf,
>>>>>> +						  buf->dma);
>>>>>> +				spin_lock_irqsave(&priv_dev->lock, flags);
>>>>>> +
>>>>>> +				kfree(buf);
>>>>>
>>>>>why do you even need this "garbage collector"?
>>>>
>>>> I need to free not used memory. The once allocated buffer will be asso=
ciated with
>>>> request, but if request.length will be increased in usb_request then d=
river will
>>>> must allocate the  bigger buffer. As I remember I couldn't call dma_fr=
ee_coherent
>>>> in interrupt context so I had to move it to thread handled. This flag =
was used to avoid
>>>> going through whole  aligned_buf_list  every time.
>>>> In most cases this part will never called int this place
>>>
>>>Did you try, btw, setting the quirk flag which tells gadget drivers to
>>>always allocate buffers aligned to MaxPacketSize? Wouldn't that be enoug=
h?
>>
>> If found only  quirk_ep_out_aligned_size flag, but it align only buffer =
size.
>>
>> DMA used by this controller must have buffer address aligned to 8.
>> I think that on most architecture kmalloc should guarantee such aligned.
>
>right, it should be aligned on PAGE_SIZE
>
>> The problem was detected on NXP testing board.
>
>and what was the alignment on that? IIRC, ARM had the same alignment
>requirements as x86. Where you sing SLUB allocator on that NXP board,
>perhaps?
>

Peter Chan explanation:=20
"
This un-aligned request buffer address for 8 occurs for Ethernet Gadget (eg=
, NCM),
it allocates socket buffer with NET_IP_ALIGN, so the last byte of buffer ad=
dress
is always 2. Although this can be workaround by setting quirk_avoids_skb_re=
serve,
but we are not sure if all gadget request buffers can be 8 or Max Packet Si=
ze aligned.
"

--
Pawell
