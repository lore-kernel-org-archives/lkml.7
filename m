Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7EC606D8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC9320665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pON6Otu5";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fgvDJSwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGIHJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:09:22 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58046 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfGIHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:09:21 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6972i7N019636;
        Tue, 9 Jul 2019 00:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=NEPuBJ+gFwGLH06FQcjhEbO0a19NvhJYfjOIoJZB4LQ=;
 b=pON6Otu56/1YlpDtIP3vrHHxdT293Qr+CvzjUOHR2m/HKVWk2+iKi8RdO/B720dUyjPD
 3IJxslVxIRD5JRuSET377T1hyaJg+hf9+uMKJHzSJUiixIRkFs7EdI9KQyG4BPr8q21O
 hMtOIn1H+2dv/ne+8Ks5OzrDYJAEXk7vov1fFDqP4I4iDErFr7OizaRpVb5NLWSMVOEQ
 6q5zUg6DXshcLs14G2IiLXfQl4hKuXajAcYsyil1dKkqkRnP7GP1+FatQJZpQ8XvTDoO
 AcHR8M/TeJyuZaWsSeYAT8Ensb07h20eSgdTb+HLjdvhW4/rtcNIaqI27ddjkG4W9e0Z tQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tjr6vjhhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 00:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEPuBJ+gFwGLH06FQcjhEbO0a19NvhJYfjOIoJZB4LQ=;
 b=fgvDJSwvMOkeRK15HlmVAPstHW9cTklGgQ+WqNaNM4DI4qFLYOvVohPYvGY5i6v6l0LvNutA5IwVQDLfiTEF1mhPwyKbQXLuGNAtVqMOJIRYctayRc8UX1mkhrnAMZVAVBV5sCLo1w0+3dBpddJuJGSlW6wSSWZtvtigEMVf6Cs=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4231.namprd07.prod.outlook.com (52.135.223.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 07:07:30 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 07:07:30 +0000
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
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6a76sKAgAN7ISCAAOC4gIAAeMvwgAEbwYCAAATIEA==
Date:   Tue, 9 Jul 2019 07:07:30 +0000
Message-ID: <BYAPR07MB47092C1E19FD36FB336A55C2DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <87r274lmqk.fsf@linux.intel.com>
 <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7dpm442.fsf@linux.intel.com>
 <BYAPR07MB47094B372CEC6DFD25FC78E1DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87pnmj67ee.fsf@linux.intel.com>
In-Reply-To: <87pnmj67ee.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzU4ZmM4OGMtYTIxOC0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDM1OGZjODhkLWEyMTgtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzU5OCIgdD0iMTMyMDcxMjk2NDgzNTMwNjg1IiBoPSJIMjdkK21qWVpqcW1POXNaQ2NZNjkwM1Q1cEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc5bcb15-5ec6-4828-0bc3-08d7043c1be0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4231;
x-ms-traffictypediagnostic: BYAPR07MB4231:
x-microsoft-antispam-prvs: <BYAPR07MB4231E4ED4EA16EF3DA28FB59DDF10@BYAPR07MB4231.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(36092001)(199004)(189003)(446003)(11346002)(8936002)(4326008)(66066001)(6116002)(81166006)(256004)(14454004)(74316002)(476003)(33656002)(71190400001)(229853002)(2906002)(14444005)(71200400001)(8676002)(107886003)(55016002)(9686003)(64756008)(53936002)(6436002)(99286004)(66476007)(7416002)(66556008)(305945005)(26005)(66946007)(81156014)(76116006)(73956011)(2501003)(86362001)(7736002)(316002)(5660300002)(54906003)(186003)(52536014)(25786009)(102836004)(486006)(66446008)(110136005)(68736007)(6506007)(76176011)(6246003)(478600001)(7696005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4231;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DfYpXpAK8ASbieV7TPRvSFXdhLPp0ul5pm+iAKkr7dJCcCCOByi2OElv2NgRpL+geCInjP9Vo7XyD49vDlRb3xzThnKL8b82t7/ayHbDBJI0Bw+QyyfJVRzQ2x9pXv3lwvszBiOX+xEquia7ep20RajCVpCnERVkoZrxAGKkgJn/MEDtya86HoyTqR7jVyTvzrdL+Njw8BrklaJBIdq4AZ/M2FjV0LDtdN5Nz00iwFz2/MnKE3Mj4UgsOoIUT1yr4L0BpA46P83BR2YFNYA/cHRTnX1l4zVpUI6hjJLvLxVvG30C9o5G93TyGfjaCZLMgJO2fpS5eMXbjwqdAWh7pjnzsXXwF2pso3pYgXkMwK8uwXAGkDINtQXJwd5Gy9LuxPpJ8YUFnSGSDrvGZlHaIKOevAClhnCEK3To6LGllaY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5bcb15-5ec6-4828-0bc3-08d7043c1be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 07:07:30.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4231
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=795 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>>>> IRQF_ONESHOT can be used  only in threaded handled.
>>>> "
>>>>  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler=
 finished.
>>>>  *                Used by threaded interrupts which need to keep the
>>>>  *                irq line disabled until the threaded handler has bee=
n run.
>>>> "
>>>
>>>so?
>>
>> I don't understand why If I don't have threaded handler why I need IRQF_=
ONESHOT.
>> Why interrupt cannot be reenabled after hardirq handler finished ?
>> I do not use threaded handler so this flag seem unnecessary.
>
>Unless this has changed over the years, it was a requirement from IRQ susb=
ystem.
>
>	/*
>	 * Drivers are often written to work w/o knowledge about the
>	 * underlying irq chip implementation, so a request for a
>	 * threaded irq without a primary hard irq context handler
>	 * requires the ONESHOT flag to be set. Some irq chips like
>	 * MSI based interrupts are per se one shot safe. Check the
>	 * chip flags, so we can avoid the unmask dance at the end of
>	 * the threaded handler for those.
>	 */
>	if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
>		new->flags &=3D ~IRQF_ONESHOT;

From description I understand that it should be set when driver uses only=20
threaded handler without hard irq handler.
eg.=20

	ret =3D devm_request_threaded_irq(dev, data->usb_id_irq,
					NULL, int3496_thread_isr,
					IRQF_SHARED | IRQF_ONESHOT |
					IRQF_TRIGGER_RISING |
					IRQF_TRIGGER_FALLING,
					dev_name(dev), data);

It make sense, we don't have hard irq handler so we can't clear source of i=
nterrupt.=20
If we clear it immediately in interrupt controller then the same interrupt =
could=20
be raised again, because it was not cleared e.g in controller register.=20


>>>>>> +	} else {
>>>>>> +		struct usb_request *request;
>>>>>> +
>>>>>> +		if (priv_dev->eps[index]->flags & EP_WEDGE) {
>>>>>> +			cdns3_select_ep(priv_dev, 0x00);
>>>>>> +			return 0;
>>>>>> +		}
>>>>>> +
>>>>>> +		cdns3_dbg(priv_ep->cdns3_dev, "Clear Stalled endpoint %s\n",
>>>>>> +			  priv_ep->name);
>>>>>
>>>>>why do you need your own wrapper around dev_dbg()? This looks quite un=
necessary.
>>>>
>>>> It's generic function used for adding message to trace.log.  It's not =
wrapper to dev_dbg
>>>>
>>>> void cdns3_dbg(struct cdns3_device *priv_dev, const char *fmt, ...)
>>>> {
>>>> 	struct va_format vaf;
>>>> 	va_list args;
>>>>
>>>> 	va_start(args, fmt);
>>>> 	vaf.fmt =3D fmt;
>>>> 	vaf.va =3D &args;
>>>> 	trace_cdns3_log(priv_dev, &vaf);
>>>> 	va_end(args);
>>>> }
>>>
>>>oh. Don't do it like that. Add a proper trace event that actually
>>>decodes the information you want. These random messages will give you
>>>trouble in the future. I had this sort of construct in dwc3 for a while
>>>and it became clear that it's a bad idea. It's best to have trace events
>>>that decode information coming from the HW. That way your trace logs
>>>have a "predictable" shape/format and you can easily find problem areas.
>>
>> Ok , I will change this.
>> I used such solution because I didn't want to create to many trace event=
s.
>> I used it only for rely used messages.
>
>If you have these messages that are *really* needed, then you should add
>a trace event for it. Look at the events we have on dwc3 if you need
>some inspiration. Could also look at the history of our trace events to
>figure out how things changed over time.
>
>cheers
>
>--
>balbi
