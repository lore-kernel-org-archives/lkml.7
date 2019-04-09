Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A47D20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Na1yTW1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfDIDIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:08:42 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:48195
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfDIDIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2y9gpkeDN5KZJ1C+h8a3pZ48jKWvsMfdBETldy9EdU=;
 b=Na1yTW1q9qkJhu5auQYLiVGkozXFTo2bCyTKYYcPR7yrLDA1e1TwxPcf0narQ4ubzdNvGrA1d77cdJ1vI1O/tfe0thhUzHSd/iUr6FEEc2TyAEPZWX2UK/aBKbMIwa159R1Zsm+ssfG4TZnCblJUVQPbbO817pX6UYk0zXaTcgI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5186.eurprd04.prod.outlook.com (20.176.215.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 03:08:37 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 03:08:37 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V5 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHU3TgXVF69xScZaEuBoN4oQ+OPnaYyOqtQgAD6lICAAAKDMA==
Date:   Tue, 9 Apr 2019 03:08:37 +0000
Message-ID: <AM0PR04MB4211C3DA99287071FD102EDB802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
 <1552878291-22866-4-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211209072B94795A6A04E9A802C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB39164EEA38E9A3C239CCA221F52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39164EEA38E9A3C239CCA221F52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f0854b4-f5e9-4ee1-16fb-08d6bc98a8f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5186;
x-ms-traffictypediagnostic: AM0PR04MB5186:
x-microsoft-antispam-prvs: <AM0PR04MB51869DD687F93B36F538D5AB802D0@AM0PR04MB5186.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(51914003)(74316002)(68736007)(66066001)(478600001)(3846002)(6116002)(99286004)(2201001)(26005)(93886005)(25786009)(305945005)(14454004)(102836004)(2906002)(52536014)(86362001)(8936002)(81166006)(7736002)(8676002)(7416002)(186003)(446003)(316002)(44832011)(11346002)(81156014)(106356001)(33656002)(476003)(105586002)(229853002)(76176011)(6436002)(4326008)(5660300002)(97736004)(486006)(55016002)(6246003)(53936002)(71200400001)(71190400001)(2501003)(9686003)(7696005)(6506007)(14444005)(256004)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5186;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wb83tbBlduaJQ55zTOlKNcIwQPjshZvDZdn/FcZz2RdrJb8HzkgiRx8GgDhIpOGXukSGMrih8x7zdRRCW2n2niuW0cDfus/h6u2tP7OFnQj5pgSvoMlkND20Y/ejiE6eDtNeVq3EIRf3yuNK1m6PHhcUs4UuQkQQwL97PeKDzrg0iTW+qqffczaS0ke0v6nqW4kjeOjKfFsMjTaTMZdB2XffPwfITgvRKSbKnJW98piuK/SryFEAaFdws5QjQDcAxziwRUdRwzsPOGGSOygaGkNeTpstXnNJ3ttOT5Sjh6B/4GyjiSCTTL7RPDGie/BYfJHCfJcYkP7B8e1xVVdlpVA1e7gRxCVhQQ0j85GjC6vMKHiKvIsZqqLW9MicT4cudOo9kOVUmnb4FVOscrdoEoacMPwzZJ++sRUPxJnUex4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0854b4-f5e9-4ee1-16fb-08d6bc98a8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 03:08:37.4158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> so I will add another API in imx-scu-irq
> driver to provide function of enabling/disabling irq, each driver can jus=
t call the
> API to enable/disable its own IRQ, ONLY need to pass the corresponding
> arguments:
>=20

That's exactly what I mean.

> >
> > > +	msg.group =3D SC_IRQ_GROUP_RTC;
> > > +	msg.mask =3D SC_IRQ_RTC;
> > > +	msg.enable =3D enable;
> > > +
> > > +	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> > > +	if (ret) {
> > > +		dev_err(dev, "enable rtc irq failed, ret %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int imx_sc_rtc_read_alarm(struct device *dev, struct
> > > +rtc_wkalrm
> > > +*alrm) {
> > > +	return 0;
> > > +}
> >
> > Can't avoid define NULL function?
>=20
> We have to implement it as NULL function, as SCFW does NOT provide such
> feature, But rtc alarm ONLY available when .read_alarm ops is implemented=
:
>=20

If the framework mandantorily requires it, then we'd probably better to add
doc before this function and explain why it's safe to be NULL.

> 147 static ssize_t
> 148 wakealarm_store(struct device *dev, struct device_attribute *attr,
> 149                 const char *buf, size_t n)
> 150 {
>=20
> ...
>=20
> 187                 retval =3D rtc_read_alarm(rtc, &alm);
> 188                 if (retval < 0)
> 189                         return retval;
>=20
>=20
> >
> > > +
> > > +static int imx_sc_rtc_set_alarm(struct device *dev, struct
> > > +rtc_wkalrm
> > > +*alrm) {
> > > +	struct imx_sc_msg_timer_rtc_set_alarm msg;
> > > +	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> > > +	int ret;
> > > +	struct rtc_time *alrm_tm =3D &alrm->time;
> > > +
> > > +	hdr->ver =3D IMX_SC_RPC_VERSION;
> > > +	hdr->svc =3D IMX_SC_RPC_SVC_TIMER;
> > > +	hdr->func =3D IMX_SC_TIMER_FUNC_SET_RTC_ALARM;
> > > +	hdr->size =3D 3;
> > > +
> > > +	msg.year =3D alrm_tm->tm_year + 1900;
> > > +	msg.mon =3D alrm_tm->tm_mon + 1;
> > > +	msg.day =3D alrm_tm->tm_mday;
> > > +	msg.hour =3D alrm_tm->tm_hour;
> > > +	msg.min =3D alrm_tm->tm_min;
> > > +	msg.sec =3D alrm_tm->tm_sec;
> > > +
> > > +	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> > > +	if (ret) {
> > > +		dev_err(dev, "set rtc alarm failed, ret %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D imx_sc_rtc_alarm_irq_enable(dev, alrm->enabled);
> >
> > Just curious we already have .alarm_irq_enable().
> > Why do we need call it again here?
>=20
> That is because the  set_alarm function  pass alarm time and alarm->enabl=
ed
> argument, it could be to enable alarm or to disable alarm, so we have to
> control the alarm function here, all other rtc drivers also do it this wa=
y.
> The .alarm_irq_enable() callback is for just enable or disable alarm.
>=20

Got it, thanks for the explanation.

Regards
Dong Aisheng

> Thanks,
> Anson
>=20
>=20
> >
> > Regards
> > Dong Aisheng
> >
> > > +	if (ret) {
> > > +		dev_err(dev, "enable rtc alarm failed, ret %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct rtc_class_ops imx_sc_rtc_ops =3D {
> > >  	.read_time =3D imx_sc_rtc_read_time,
> > >  	.set_time =3D imx_sc_rtc_set_time,
> > > +	.read_alarm =3D imx_sc_rtc_read_alarm,
> > > +	.set_alarm =3D imx_sc_rtc_set_alarm,
> > > +	.alarm_irq_enable =3D imx_sc_rtc_alarm_irq_enable, };
> > > +
> > > +static int imx_sc_rtc_alarm_sc_notify(struct notifier_block *nb,
> > > +					unsigned long event, void *group) {
> > > +	/* ignore non-rtc irq */
> > > +	if (!((event & SC_IRQ_RTC) && (*(u8 *)group =3D=3D
> > SC_IRQ_GROUP_RTC)))
> > > +		return 0;
> > > +
> > > +	rtc_update_irq(imx_sc_rtc, 1, RTC_IRQF | RTC_AF);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct notifier_block imx_sc_rtc_alarm_sc_notifier =3D {
> > > +	.notifier_call =3D imx_sc_rtc_alarm_sc_notify,
> > >  };
> > >
> > >  static int imx_sc_rtc_probe(struct platform_device *pdev) @@ -73,6
> > > +181,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > +	device_init_wakeup(&pdev->dev, true);
> > > +
> > >  	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
> > >  	if (IS_ERR(imx_sc_rtc))
> > >  		return PTR_ERR(imx_sc_rtc);
> > > @@ -87,6 +197,8 @@ static int imx_sc_rtc_probe(struct
> > > platform_device
> > > *pdev)
> > >  		return ret;
> > >  	}
> > >
> > > +	imx_scu_irq_register_notifier(&imx_sc_rtc_alarm_sc_notifier);
> > > +
> > >  	return 0;
> > >  }
> > >
> > > --
> > > 2.7.4

