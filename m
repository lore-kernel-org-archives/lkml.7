Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F4DC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5380216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VYAgBsTJ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZN5v3L+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfGIHaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:30:06 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58352 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbfGIHaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:30:06 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x697T7Lx004367;
        Tue, 9 Jul 2019 00:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=A2M/PEn04W1AAB1Vv2F8+r+oocPj321pQT1z/5DschQ=;
 b=VYAgBsTJRiJteifEcq6tUC3JlqUWxUnmOFUIswMn2N4AvEMTwGgNc2cN2WFuScKXigkB
 bMlc9ijKXy2rVDvjYzza+s7ra3uCpfpmfLjYcqIYV1fOvfvunWpJXmcWvim8zRlXvFky
 7Bcltnu1qHVsPbXtQg5ug0e/vTZWq8mkEbSMIn8/ptaRROzDqIy763UqT2jhaoAxWyQ1
 0wZOrbfe1Hr+qdFS4n3C2z+uSpQlkGRQpbxCUUMUbIxGx3TdZoC/k/Udm72OgD2YTozu
 p8B3Yi4OfHyUQDgVJXkY3+w6/hq9AWj1TYPJ+cMhzcmmAp+2gNez4lB+R7wmvj2SCSWr ZQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2051.outbound.protection.outlook.com [104.47.48.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tjq7wjw18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 00:29:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2M/PEn04W1AAB1Vv2F8+r+oocPj321pQT1z/5DschQ=;
 b=ZN5v3L+EoCjmM1zGY8zygfhAtY7IFVL23MlVlpfTCgyYqAGNDCDzI4+CijivdKDKet3eS3EFCd2KjUhVbWjb6ALsSzlJXFWCilsTapZ/HOFWSZ7lK93d3ZGmfuoJ6KBeS9x3M/EY6DjNnZx38s2Bv5i2c0me2WJ8aD0379iQabU=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4984.namprd07.prod.outlook.com (52.135.238.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 07:29:10 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 07:29:10 +0000
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
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6a76sKAgAN7ISCAAOC4gIAAeMvwgAEbwYCAAATIEIAAB/4AgAAAbdA=
Date:   Tue, 9 Jul 2019 07:29:10 +0000
Message-ID: <BYAPR07MB4709648F659AB5A11B0EB621DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <87r274lmqk.fsf@linux.intel.com>
 <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87a7dpm442.fsf@linux.intel.com>
 <BYAPR07MB47094B372CEC6DFD25FC78E1DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87pnmj67ee.fsf@linux.intel.com>
 <BYAPR07MB47092C1E19FD36FB336A55C2DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
 <87muhn65a7.fsf@linux.intel.com>
In-Reply-To: <87muhn65a7.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctM2M4NTNkNTEtYTIxYi0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDNjODUzZDUyLWEyMWItMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjEzMyIgdD0iMTMyMDcxMzA5NDg1MTUwNjA1IiBoPSJVRHpPTDJUeld5SWFUZk1LK3JtU3l0WGljWHc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea82f729-a917-40ce-5087-08d7043f22ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB4984;
x-ms-traffictypediagnostic: BYAPR07MB4984:
x-microsoft-antispam-prvs: <BYAPR07MB49840E47960D565501890BB7DDF10@BYAPR07MB4984.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(36092001)(189003)(199004)(25786009)(76176011)(8676002)(7696005)(81166006)(81156014)(7416002)(8936002)(6506007)(9686003)(53936002)(4326008)(66446008)(64756008)(66556008)(66476007)(73956011)(71200400001)(86362001)(66066001)(99286004)(2906002)(71190400001)(5660300002)(2501003)(52536014)(76116006)(66946007)(6246003)(11346002)(486006)(476003)(478600001)(256004)(14444005)(7736002)(33656002)(74316002)(68736007)(305945005)(26005)(110136005)(55016002)(6436002)(54906003)(3846002)(446003)(102836004)(107886003)(229853002)(186003)(316002)(6116002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4984;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qTD4sH3+TPfT5E/RZbdTHhHDrLYXlsCD/NUPu0mPd7rfA0HGO/f6ZaudJy6h6Sa3eIcFffNFyXAseaWpoYTKj9LaBCBHqdAWMOSNEO5oh/o4X+dCz4j0BzR0N/tCDS+wGRr/orG4lR4p6goGkJQtqNdH42TkV2m1W/XFgEDBgE9bdqPR8ARdk4MP9QpsPNEln3hnvac2lU5ZlHkNoWh6uoW9KFGi7nFEfemusHZuOu02cklPz/y6MfmIJXld10Ss5dzN2SKUIfaIP7Yhd949NswH2zZyIQyUxuxEpcyOxq5g5asb0UxrJ6Q/ZBA2zx7VxfiZhfUqWpYLOtDfgBFu9TEz3Ix1OnDw6/dfn1D1DZtITazGfosUrHpYjIbca7Z7eOWkLvaQHrkH/Nm35T2aKHHf2h5w+XPQ2iYdjjnpH8c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea82f729-a917-40ce-5087-08d7043f22ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 07:29:10.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4984
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
 mlxlogscore=536 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>>>>>> IRQF_ONESHOT can be used  only in threaded handled.
>>>>>> "
>>>>>>  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handl=
er finished.
>>>>>>  *                Used by threaded interrupts which need to keep the
>>>>>>  *                irq line disabled until the threaded handler has b=
een run.
>>>>>> "
>>>>>
>>>>>so?
>>>>
>>>> I don't understand why If I don't have threaded handler why I need IRQ=
F_ONESHOT.
>>>> Why interrupt cannot be reenabled after hardirq handler finished ?
>>>> I do not use threaded handler so this flag seem unnecessary.
>>>
>>>Unless this has changed over the years, it was a requirement from IRQ su=
sbystem.
>>>
>>>	/*
>>>	 * Drivers are often written to work w/o knowledge about the
>>>	 * underlying irq chip implementation, so a request for a
>>>	 * threaded irq without a primary hard irq context handler
>>>	 * requires the ONESHOT flag to be set. Some irq chips like
>>>	 * MSI based interrupts are per se one shot safe. Check the
>>>	 * chip flags, so we can avoid the unmask dance at the end of
>>>	 * the threaded handler for those.
>>>	 */
>>>	if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
>>>		new->flags &=3D ~IRQF_ONESHOT;
>>
>> From description I understand that it should be set when driver uses onl=
y
>> threaded handler without hard irq handler.
>> eg.
>>
>> 	ret =3D devm_request_threaded_irq(dev, data->usb_id_irq,
>> 					NULL, int3496_thread_isr,
>> 					IRQF_SHARED | IRQF_ONESHOT |
>> 					IRQF_TRIGGER_RISING |
>> 					IRQF_TRIGGER_FALLING,
>> 					dev_name(dev), data);
>>
>> It make sense, we don't have hard irq handler so we can't clear source o=
f interrupt.
>> If we clear it immediately in interrupt controller then the same interru=
pt could
>> be raised again, because it was not cleared e.g in controller register.
>
>You are correct. Big mistake on my side. Apologies.

All right, you're welcome. I learn a lot of during such discussions :).

>--
>balbi
