Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D948C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0538E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="O+mUbPtO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZFfRk/No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfGJIZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:25:26 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:27320 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727341AbfGJIZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:25:26 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6A87XN3022873;
        Wed, 10 Jul 2019 01:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=4bqHHbmbC2R4T/5g4w9ojG9RSzRFaLktUk83MoAtoJM=;
 b=O+mUbPtO+EaFdUlJYu95Pwj/RQIgNfAw5giE5XbJOb/umLAJD2V8t9VBb8aLR0nILxRX
 DZ4bm86mFpyiBs9oMKC6aIWCpafIHh/WGHBgeiA4LPXWQt7Q1SeD2AKUJcXX9ZK54QXR
 96cLAfu6CCtvOzRm1F8SU0sNiWMOl263LWjX9sJYjFCv3sSMFHR171qQMrmXzIHCCphR
 VRVQQtyhbLRw2IC0DT9G6d2NTWaGnp2qJ1SEQkMTwPzZco/rvqy7n6x4LT+rR8UkPSo0
 hQF0cI3dqMt+s90HQVWOo6yVCOu+K9SG/gVc1vky0d7GbOLCOljdKmoOBqVBktyW1qhV Lg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2050.outbound.protection.outlook.com [104.47.40.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tjr6vq116-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Jul 2019 01:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bqHHbmbC2R4T/5g4w9ojG9RSzRFaLktUk83MoAtoJM=;
 b=ZFfRk/NoPkylwrUWiPxA03jdBuD+czwVICoJ87LHpwN7MZcq32DreZ6064TcSRjlk12AW6dwDezffPqFOaSIqfu0GxsXWzbuXKkOFNA0ScEk4JcckIFz7yaKOZsq71e+FYa1CYeq4zUC0tWRBrjL+U8bRB/xcHflSgwn93BUP8c=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5877.namprd07.prod.outlook.com (20.179.91.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 08:25:08 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::fd8c:399c:929b:33e2%6]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 08:25:08 +0000
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
Thread-Index: AQHVMyCBLRb+XoB9zUqxphM8AIPBC6a76sKAgAN7ISCABBicwA==
Date:   Wed, 10 Jul 2019 08:25:08 +0000
Message-ID: <BYAPR07MB47090E2221C96D0B8178235CDDF00@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-6-git-send-email-pawell@cadence.com>
 <87r274lmqk.fsf@linux.intel.com>
 <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-tag-bcast: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzdjN2M5OWUtYTJlYy0xMWU5LTg3NDItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDM3YzdjOTlmLWEyZWMtMTFlOS04NzQyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzA4MCIgdD0iMTMyMDcyMjA3MDUzODM4MTI1IiBoPSJCTjNPQXNuT2lDUnovay8vUWpGdDZEMnJxanM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-paste: 
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5c6b387-8e38-458d-7c83-08d705101e9b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5877;
x-ms-traffictypediagnostic: BYAPR07MB5877:
x-microsoft-antispam-prvs: <BYAPR07MB58770E5238654E71E0224E1FDDF00@BYAPR07MB5877.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(36092001)(189003)(199004)(102836004)(14454004)(26005)(52536014)(6506007)(8676002)(7696005)(7416002)(33656002)(76176011)(53936002)(71200400001)(71190400001)(66066001)(81156014)(99286004)(107886003)(81166006)(86362001)(6246003)(5660300002)(476003)(68736007)(2501003)(8936002)(55016002)(3846002)(6116002)(478600001)(186003)(9686003)(256004)(14444005)(305945005)(446003)(6436002)(2906002)(486006)(66476007)(66556008)(66946007)(54906003)(64756008)(66446008)(110136005)(74316002)(7736002)(316002)(11346002)(4326008)(229853002)(76116006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5877;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W/ilHZcFTRvblVqiesVUzPVY4M7TXn1vh6/Ys8k85i+jvB53ajbR7yXFABI9k688Vi+O2JvnGW7BEhpS/zs6o5aeQw6zW/E2wCN///VQ8hNNnyiXMEazscx0FVN1H7ttXKljlQoCcsr3TJq8ZOgT2wQ+sPnIT5N55fxXkMkabLnw95IM0hHRT9jcSJKHovVtoK7Rk0pq2jIe0h70XfWryyuA9zke0fSDxvoQJ5GnLLw6z8HnpxAxLoAFkkAQuDuhXNz1MFpqy93GsILrRWUte9Tner+fKPZOQlT2IZ61gMNxz8lrpVzZWTufEMTYAYtkkDTsJ+RtJo8QnyaCHYKLsmtpquPKqNa6Hu/bu6DxiMDNW/14cAsUD151RZ5PXqMNG45vGYdtiEd3OY7aX8+Auqem/BgByMUIReeK5i1VxRc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c6b387-8e38-458d-7c83-08d705101e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 08:25:08.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5877
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=797 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe

>>> +
>>> +static int cdns3_idle_init(struct cdns3 *cdns)
>>> +{
>>> +	struct cdns3_role_driver *rdrv;
>>> +
>>> +	rdrv =3D devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
>>> +	if (!rdrv)
>>> +		return -ENOMEM;
>>> +
>>> +	rdrv->start =3D cdns3_idle_role_start;
>>> +	rdrv->stop =3D cdns3_idle_role_stop;
>>> +	rdrv->state =3D CDNS3_ROLE_STATE_INACTIVE;
>>> +	rdrv->suspend =3D NULL;
>>> +	rdrv->resume =3D NULL;
>>> +	rdrv->name =3D "idle";
>>
>>why don't you use the mux framework for this? This looks a bit fishy
>>too. Why do you have your own driver registration structure for your
>>driver only?
>>
>
>I assume you mean interface defined in include/linux/usb/role.h.
>It's quite new framework and probably was added after I've start implement=
ing cdns3 driver.
>At first glance it's look that I could use it.

I've started integrating driver with role switch framework. =20

Even if I use role switch interface , I still need this internal driver reg=
istration.=20
It's convenient to use fallowing structure.=20

struct cdns3_role_driver {
	int (*start)(struct cdns3 *cdns);
	void (*stop)(struct cdns3 *cdns);
	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
	int (*resume)(struct cdns3 *cdns, bool hibernated);
	const char *name;
#define CDNS3_ROLE_STATE_INACTIVE	0
#define CDNS3_ROLE_STATE_ACTIVE		1
	int state;
};

Driver can supports: only Host, only Device or DRD - depending on configura=
tion.

If current configuration support only Host then driver assigns:
	rdrv_host->start	=3D __cdns3_host_init;
	rdrv_host->stop	=3D cdns3_host_exit;

	cdns->roles[CDNS3_ROLE_HOST]  =3D 	rdrv_host
	cdns->roles[CDNS3_ROLE_GADGET	=3D NULL;
if support only Device then:
	rdrv_dev->start	=3D __cdns3_ gadget _init;
	rdrv_dev->stop	=3D cdns3_ gadget _exit;
	cdns->roles[CDNS3_ROLE_HOST]	=3D NULL;
for DRD:
	cdns->roles[CDNS3_ROLE_HOST =3D rdrv_host;
	cdns->roles[CDNS3_ROLE_GADGET] =3D rdrv_dev;

So for DRD we will have both filled, but for only Device or Host we=20
will have filled single element of array.=20

With such array we can easily start/stop role by=20
	if (!cdns->roles[role])
		not supported by configuration.
	else
		cdns->roles[role]->start / cdns->roles[role]->stop

I don't need any extra: switch instruction or #ifdef statement.=20

The name cdns3_role_driver can be misleading.=20
Driver doesn't register the driver but rather the interface to Device/Host.=
=20

Maybe I should change this name to  cdns3_role_interface or cdns3_role_acti=
on ?

Now I have my private enum:
enum cdns3_roles {
	CDNS3_ROLE_IDLE =3D 0,
	CDNS3_ROLE_HOST,
	CDNS3_ROLE_GADGET,
	CDNS3_ROLE_END,
};

I think I could replace it with usb_role. I need one extra state for IDLE b=
ut
Instead of CDNS3_ROLE_IDLE I can use USB_ROLE_NONE.

It should little simplify the driver and improve readability.=20

Do you have any comments or suggestion ?

Cheers,=20
Pawel

>
>>> +
>>> +	cdns->roles[CDNS3_ROLE_IDLE] =3D rdrv;
>>> +
>>> +	return 0;
>>> +}
>>> +

