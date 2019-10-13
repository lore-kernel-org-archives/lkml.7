Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09540ECE587
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 09:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6654206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 09:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JPB+piAg";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bSEqioGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfJMJfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 05:35:33 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3956 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbfJMJfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 05:35:32 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9D9WYCs010460;
        Sun, 13 Oct 2019 02:35:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=nDyM1Pq/Kd9GFGFgwHief5mhLsIhYPCy0Hvx4kACz9Y=;
 b=JPB+piAgCwDehxiaj0EIQrbh3wE7sFxBFUw2IowclaKY4+bpRdv9DS4iPfT+wCPW2WYQ
 Qyf//on/VtEifSR6VRqUqG11Um0Svs8hW3OL9l2BPOgdHrvy+bQiDge9i8F7kr6/b01m
 d8p2qjXnJPsLJmiZcbv9vAkvqTtXF078ZiwYq1B1IeZ8qJM/9DI/UsUQFw4PFcSIM9Ko
 PUR7Py15jZO0YcqxO5VmIAmZ+miZXgB2YaD9Ixj+xPFrX7Yl+n9mRfOTOfj0VQ+RUDQK
 LAiI8OK9fB/bYyWk6uLH9ftSzaSqqt7uyhB4B4EC/vvXvYWylkq2IoQejpnqDRWmt+Fz GA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2vkbd1jwc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Oct 2019 02:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVwKjlb6TVjkna3nlgaLuaXeqWPmpq40DnEaAqyyiDvoNqaYZvYLm41gIzwR1s0ypGgV0FC5JvjbAqvR0p/UGjyTtbhIlUjSupqoyzr+6BfKaDIaFyf5WLmt535Z/NGmdr532zmTxHBtfYpeuZD8mMPYXmieh2KiJ7TjQphdg2NsqgtuPnzCmFfUv7yrKKsZyC4jOrbLmIqxv+1cMfV3oldIfumAqeYLTY2ISJlgyxlCfNU/M4YVPpLq45rD5SGiucYXSbRPErGlvhHkASXEf/1lYXoDjPvZkUck7JHDUsIgjbeDVKtNFjt4uMlr4GsJ9Da5VJr2pz8q7tZD1zaA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDyM1Pq/Kd9GFGFgwHief5mhLsIhYPCy0Hvx4kACz9Y=;
 b=odlkYs4bw8vobO1mUQqlnV+pBbCXi9R1+74CM7k7q/fyWQP2QNUzo+4nKUm1lD5KjC+cVne56rX1rmsKvK1mXnodhHv8rTpPPVJPfvY174BgrYIDXeokdguPYZTULlAUgXKr2kivp53UfZNrMjjzMOrMLz8G+s+iqAJG/vXukZgwFZ09sQZh+k1HPunzfyAN3j3Lx35KezQHfCM72z1MiQr4dk4jMYQajK9doZZk6pjv2cIOOrMtbt8Z2lIT/kRXK9IjEmjLNhMtCvhYK7zV5fwZoXOVcNVj8aB7xvCGcp/2hNyBrXkJIkYF1Mm7d0cWhrICzSJ/6hE6Z91LXg6tLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDyM1Pq/Kd9GFGFgwHief5mhLsIhYPCy0Hvx4kACz9Y=;
 b=bSEqioGSUYfJWLroWjh7HNI5kR5j+43y+5A/uVyv65MQPAHbxvcVCoRYFaMAB08g8P6N+9KpORjoSTy3lZRz34dJOCh/rvwK4fMdphNsR9DwcoZP04bOp7cOLpllAFfouuz8DHR4yGNv2+BwG5TBK4eO8k3xJ4rZI9u+AHIDMo0=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5078.namprd07.prod.outlook.com (20.176.254.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Sun, 13 Oct 2019 09:35:21 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2347.021; Sun, 13 Oct 2019
 09:35:21 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v2] usb: cdns3: Fix dequeue implementation.
Thread-Topic: [PATCH v2] usb: cdns3: Fix dequeue implementation.
Thread-Index: AQHVgaYUzTdpjmpg6Uq4eFlHbcFodadYTE+AgAACM1A=
Date:   Sun, 13 Oct 2019 09:35:20 +0000
Message-ID: <BYAPR07MB4709B6549BA3081FEEE1DA58DD910@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <e611a60b-08e1-4077-8789-976c19e1ac93@maileu3.global.cadence.com>
 <20191013092259.GA2412199@kroah.com>
In-Reply-To: <20191013092259.GA2412199@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYzQ0NzFjYTgtZWQ5Yy0xMWU5LTg3NDktMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGM0NDcxY2FhLWVkOWMtMTFlOS04NzQ5LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDU3IiB0PSIxMzIxNTQzMjkxODUzNDYxNzMiIGg9IldST0N4MHFMOEFFKzRQeUV5d2czMTBSODRjND0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f98c00a-a6e5-4862-9c46-08d74fc0aa9b
x-ms-traffictypediagnostic: BYAPR07MB5078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB507880E6228CEB880112BE01DD910@BYAPR07MB5078.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 01894AD3B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36092001)(14454004)(4744005)(55016002)(66556008)(52536014)(6436002)(8676002)(66066001)(9686003)(5660300002)(81166006)(81156014)(66946007)(71190400001)(71200400001)(66446008)(66476007)(64756008)(8936002)(229853002)(76116006)(6246003)(4326008)(26005)(256004)(107886003)(76176011)(486006)(33656002)(476003)(2906002)(99286004)(54906003)(25786009)(6916009)(86362001)(478600001)(186003)(316002)(305945005)(3846002)(7736002)(6116002)(7696005)(11346002)(446003)(6506007)(102836004)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5078;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djo67pEdnNgyC/0pBmYBagQ8BeSNy/kdtSfynjFSaHS3+eLQUXBzfV/QJAGsB4cxgVcXT9J174gsFUsPXlLXxhI6KGtNVfTanpf2sIxAyEHpnjQCaKvMeciVhznE8zNYV0UM4wP6GGLtDkHpksUk+86lxgR2C/GF01KCacyyJAcrVbYmwF4FgvxGK+qe+eHDOjqYVDCcCJKXv2+b8lB0zsOYi3myP50xJyyWI91Bg1otK0fzHRyhifqD+FRRfWzTywqEjZFMP4S1stNzLdarfDsNOY1DRq/cMHpmBDZ359SXmJJx6oSDEa/oKv7y4bwPgvazKd11wkHFEIHOtQY4R6PYJFkqA/tW2aqw8J5orSYPCru14nDSL1zNtj4qN5odHAdaYd5s9nh5+0cjPqT/y6zDbJ9YgWAnI0rHhuwrhCY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f98c00a-a6e5-4862-9c46-08d74fc0aa9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2019 09:35:20.5677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmZag8EZnuLsIb5sW2kG+bLMrwZqwB1FSSO+qQEiLxa6sgZGiiN6veFAFfXBE32sVXYDUP31KdGMXGLm7AQExlIV47ym/yAsSuDQFEP5BIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5078
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-13_04:2019-10-10,2019-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 mlxlogscore=762 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910130095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

I've noticed it also. I sent the patch again with the same version.=20
I have change nothing.

Regards,
Pawel

>
>
>On Sun, Oct 13, 2019 at 10:09:20AM +0100,  wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>
><snip>
>
>Please look at your email client, your email had a _very_ odd "From:"
>line.  Please fix that up.
>
>thanks,
>
>greg k-h
