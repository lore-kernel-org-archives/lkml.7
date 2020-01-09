Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C30C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEF32067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tSbosFiC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="0QnCgywH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgAIIe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:34:27 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:45164 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728435AbgAIIe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:34:27 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0098T35T005712;
        Thu, 9 Jan 2020 00:34:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=l+NMzc8nQIRL4j9Hy0Is6barePS3fyj82V77ZT689pc=;
 b=tSbosFiCODtJUtmfnNucFO5uRfB5YJk8T8LGXLu3RMUv8hPY+VjJGP5bylP15nEmlBx6
 hmvkeXx2K5+g2JI8i02ksgzZPsUE93nJP7R/CjqaLZTjQAXcO8fFwNGzGgcS2F+DqFu1
 1UhSrbmwxp6SMFB3RWilw7Bnug8K8mqNBc7lElFxQOcrmO6fTcAJxE4OK8oO6M5g/Q03
 ME2ZCZJhEOYKUQWExrFNywo89oBk2bxGkw4F7v8aP4UpRaGV5LU3zr1HGhVOwOBY2Gn8
 pJB5nYOF6U7vPg+PCPhcjzurZojLvezdKkch5AM16lX5uC26USswiMBjOuJLI0fzfaGD HA== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xaq6213w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 00:34:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1IK59HhaQDmbu8Md5KbFGw8vcSHUvPW5mDPM7Zhl/ZnSD234YhIu+RzHPKh8ZvHGX+AdZq9G9FSIndduwG2dbVzf5CyTPrQ44s8IcAb3U4SmziuaNOOMxMeeNANyOyNqzvaVWMUXET+FyZZxsjQSYCFHVqgkp/+dSNuXxw93gzsF1vCBu8trIp9S2E6SYVuT8NA92a8rrd9CQHUHxYebxMbHodglmaYN32apBOG7bolj7KHx2OHLK6tklIHeTq1FO899JoXOdtNbZ8cCD/V/wN5tTsHSmPpw8kO4/NSvQF3dJurLCa7ujWQY9CRCfin/CLxT9aD3ZnFGoYzyaew3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+NMzc8nQIRL4j9Hy0Is6barePS3fyj82V77ZT689pc=;
 b=Joign5i/tOqdmuy7lA2himAZPserIIqHpk9FD8rtd7emvWinpH9JtQIxTWvjJyYeqOkwSrcZ9IRjXCAjonCSinRQC+QtCuvRsse23GnJ7xpY7Xai2KDg16nKIrqsqps3JZuAotq5eGhiM6I5+IVkqm60YwJy+kBxSGlL0qTBAB/bnioUagWZY2Zom4un0zk2nuZmdFIHU/aKh1FSoqFooc6IOThQ8P0v7IhYz0+cLZk9ef7u3PdmrdLpNLBO/UOGkXszq+K55bs0XcpAV2Omxra9b2j5PztOe0T45SGTNXaoXLQvFSq8Qqo6yf0YKM+mb2thtK32zCdQ3xG6yCHSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+NMzc8nQIRL4j9Hy0Is6barePS3fyj82V77ZT689pc=;
 b=0QnCgywHKAXopqtO1Mqf2n0WWATcMd8Ai9MfI1vrp3T97lOuGpsMJqR4EVaauFBrqQzBzOEl3+GVGqMPAtHlIzikXAoapCUlP2Ty18hlxXysIIQjDphKS1GSDnKdBTB0KhHPOldEoPnJtFtxwWH9hqasvKspwGVC+aDyPBIuasc=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5511.namprd07.prod.outlook.com (20.177.229.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 08:34:12 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d01d:9089:7310:db3a%6]) with mapi id 15.20.2623.011; Thu, 9 Jan 2020
 08:34:12 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Peter Chan <peter.chan@nxp.com>
Subject: RE: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Topic: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect
 operation.
Thread-Index: AQHVxhgd/L7cK1vWyke0JuU/54YkXqfg05qAgADt7MCAACEmgIAAGtLA
Date:   Thu, 9 Jan 2020 08:34:12 +0000
Message-ID: <BYAPR07MB4709AA109700B4BCAD1C1ED8DD390@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20200108113719.21551-1-pawell@cadence.com>
 <20200108142829.GB2383861@kroah.com>
 <BYAPR07MB4709983A2DF70AA0058C737FDD390@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20200109063841.GA2579094@kroah.com>
In-Reply-To: <20200109063841.GA2579094@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2Q4NzQzNTgtMzJiYS0xMWVhLTg3NTItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGNkODc0MzU5LTMyYmEtMTFlYS04NzUyLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjE4NiIgdD0iMTMyMjMwMzI0NDkyMTYwMDcyIiBoPSJqb05CakI3UTZaampUNWFOb1FqVkpwRmJ6TEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 607e2702-9c3d-4717-048b-08d794deb433
x-ms-traffictypediagnostic: BYAPR07MB5511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB55114B07AB7FA0AB635B8AFDDD390@BYAPR07MB5511.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(36092001)(189003)(199004)(55016002)(66556008)(66476007)(86362001)(8936002)(5660300002)(66446008)(9686003)(6506007)(186003)(7696005)(54906003)(33656002)(66946007)(52536014)(76116006)(26005)(64756008)(81156014)(4326008)(71200400001)(8676002)(2906002)(478600001)(81166006)(6916009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5511;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OMWWsIeVrzh581Lt+VeLMJmAcCklPebnHFzY8eyJQOmyPittgVOVGMgXaE1MV5ULA00SmGBsegzIzw+iQcnugXwOo+B41G9BUlDL1/SQYzI/MsItvo9wFt4jCqQzwHsN4aPTMScP4pXClHqGOHmohbcieg35tEdoP+VXzdIc1Yml731QUdJCyOWTtYP7yV/NfrDh2Pi9pi0ur9D3YuTwSEXeiPTu3cf1naomfrxk2uIGO9gz6T6+nwE6l6y8ZOKwEASpxpxVCBj+p62G347f7xcgKuQ/Ft55s0pGiLPFbUrOPPy50/gkkuKb+y7IrOdZBdlaDbNSqMplTaqaZBZnUc5/fdZlDxDTtK8gGIMte7Vz3GJQCKDyvcHzCe6HE/tTBmPwa5fG8FcVZtxeYdH35pVPmu2SGXFmwxXjTXsEpNLF9kJ7ctZTkxrTpAxkn8QPKHC4pP4oIixL8iS79sDVKxMOXNZXfvA+4GqzfHMwdRfCOsta3JqoLKchlWn+ZZKw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607e2702-9c3d-4717-048b-08d794deb433
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 08:34:12.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRfiu76iBiffGolvXx0JEoO2u3jHPwt6XwAFwsEp2czWFZ8VyD6SkEgMT5mnR9E+igU+ekCN4RH97AAY++WbeyjuGIQpo5RaP7RWduwp9MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5511
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-08,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=980
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, Jan 09, 2020 at 06:27:02AM +0000, Pawel Laszczak wrote:
>> >> +	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>> >> +
>> >> +	ret =3D readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
>> >> +					!(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
>> >> +					1, 1000);
>> >> +
>> >> +	if (unlikely(ret))
>> >
>> >Unless you can measure the difference of using/not using a
>> >unlikely/likely mark, NEVER use it.  The compiler and cpu can almost
>> >always do better than you can, we have the tests to prove it.
>> >
>>
>> The both of the above timeout should never occur. If they occurred it wo=
uld be a
>> critical controller bug. In this case driver can only inform  about this=
 event.
>
>"Should never occur" is a fun thing to say :)
>
>If it can never occur, then don't even check for it.

Yes, on existing platforms it can never occur.=20

>
>If it can, then check for it and handle it properly.
>
>What about this controller in systems with removable busses (like PCI?)
>What happens then (hint, I bet this could occur...)

It's good question.  Nobody from our customer currently use such system.=20
The only platform with PCI is used by me for testing purpose. =20
I will talk with  HW team about such cases. Maybe in the feature such impro=
vement=20
will be necessary.   =20
It's important fix for our customer so I will delete this checking for now.=
=20

>
>> For timeouts used in driver I've never see an errors. Because debugging =
these
>> kind of errors is very hard I decided to leave dev_err in such case to i=
nform that
>> probably something is wrong in HW project.
>>
>> I will remove unlikely.
>>
>> >> +		dev_err(priv_dev->dev, "Timeout: %s resetting failed.\n",
>> >> +			priv_ep->name);
>> >> +
>> >> +	priv_ep->flags |=3D EP_HW_RESETED;
>> >
>> >So an error happens, but you still claim the device is reset?  What can
>> >a user do about this error?
>>
>> The error should never occur.
>
>Then no need to warn anyone, just wait and move on.
>
>Or properly handle it.
>
>thanks,
>
>greg k-h

Thanks,

Pawell
