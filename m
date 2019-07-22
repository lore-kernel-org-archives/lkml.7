Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6398C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADF1219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YiMGzvE7";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BFOqndkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfGVJ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:59:54 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:52710 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726846AbfGVJ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:59:54 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6M9sD5r028561;
        Mon, 22 Jul 2019 02:58:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=K0hkKvO7YZPlHlbXWV4QF/ol6xFH7ed6OgLtRkuHfDM=;
 b=YiMGzvE7hXf4KqwJ7lMOhfr4CYM2spvaAUf4OqqO4gRk6zp13AKHJ6GNRLQeal2zJ4xH
 klgctrxJcZaVNLCnOgo/LFZkq0l/WRTb/mNS4gdRoE/rolE8HDIdooQzggpjTAT/Q/rW
 j6pkoYWeLRA9tr0JCrTrFpDM/z8HQZPkVJS8OZezNTPKL2+0Hyy0/5oZ9uxqsqBbv0Pa
 LBkla6+hAvt+wAZsiY7RzvkwztNXzJJC7clfjdl6itU7/6gQVLLE5zRYuvcOdrEIZLir
 uw0eAJ2cXEZCKkEX4tPoc7Az2rf63euT0AkfcZbirsNzgxexiRJYrl8I3yyApw8TYmkc oA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tuxhwebya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 02:58:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YstHRofUFRfs+g1R6qW6zrE4Nigi92w+BqU0Fywus/XXINbZsu+jEExRCcUJMnLe45fAlkYMpj9DEmK1BqmiL6cHupHPMs9St9YvmRPb2jvRRKD9iTr2OTsJG0Ac2ZDR0KV3gvp1cfHNCSi6HDiQ1g4tjI4QdeerzqD9YwOx+MESn9swiG7tW8c9DTzalbVr5/e/nivwZErGbv3oXqQJrz8Ddez/gt9SxHM+QlsCarWiUMQSGukAypR3RgY53NWrS65I8Lw3UhhRc2t8Py/776xyI2gLXZYq/QjJQktACk+j20yCAWOa4Ihewlytv//8XGGSWXn6da1ga+NeJAUfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0hkKvO7YZPlHlbXWV4QF/ol6xFH7ed6OgLtRkuHfDM=;
 b=WF+M7qundlVmCOQqOMPxh9UFRaXUqfjcJ35OXxH3pW/Wp4pIptfc9urpOx5u1t8C1kWPj4qt7HFyBNSp8quT6nii6QlrpSoRhGFReJa1BdgWXEAJCjL2Hs0OMDe9V6U1/C+Ce4TFkGdSYEK5V9bHN2/9AU5UCnFjP9h2WmyNFHbnr5P9x/RIySZV28/zjdJVmt6FHHNGd5HbxTYSK+ubTl0C5+le2T5UUOMhFtnB31eeNeyNCLyuPKyDUhg2xE+mAETPEduWXwjprUbFg9ORDkPuAFQVjctR04tHyqgglAYhoKz/SiLuQlpPErY1XHI44wZRxffa2LRbAGgDBl1iTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0hkKvO7YZPlHlbXWV4QF/ol6xFH7ed6OgLtRkuHfDM=;
 b=BFOqndkBL75XUurnmYz/2OBvB1SZFaWAnUN8BHrKFtnISSpbu0zxnVqJbZD7B+lLj1nNG14XVT5waO5qtd7NoSfhju2/ogVZUGrOITFmQVov/EopxoNffAXlrY8BtUEkEnaVhoWi/MwHr8fH24lsE4oVFK3rP6ws+EC3ltbz8jk=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6231.namprd07.prod.outlook.com (20.179.63.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 09:58:43 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 09:58:43 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: RE: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Thread-Topic: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Thread-Index: AQHVP/K3++/PZvX91EKpHiAZrLktoabVbhiAgAD3BZA=
Date:   Mon, 22 Jul 2019 09:58:42 +0000
Message-ID: <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
In-Reply-To: <20190721190335.GA19831@xo-6d-61-c0.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDZkZjM2ZjMtYWM2Ny0xMWU5LTg3NDMtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDQ2ZGYzNmY1LWFjNjctMTFlOS04NzQzLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iODU5IiB0PSIxMzIwODI2MzExOTIyOTc5MzYiIGg9ImFWQXo5UVpka05PU1F5V1dKK2M4UmpCSE40Yz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a65282f9-0d5d-4595-0190-08d70e8b2dfb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB6231;
x-ms-traffictypediagnostic: BYAPR07MB6231:
x-microsoft-antispam-prvs: <BYAPR07MB6231E51472F862FABD4E317BDDC40@BYAPR07MB6231.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(36092001)(52536014)(64756008)(66556008)(66476007)(66946007)(102836004)(107886003)(6246003)(2906002)(7736002)(14454004)(305945005)(6506007)(86362001)(3846002)(486006)(68736007)(99286004)(5660300002)(76116006)(66066001)(66446008)(6116002)(256004)(14444005)(55016002)(316002)(7696005)(33656002)(6916009)(478600001)(6436002)(53936002)(76176011)(11346002)(54906003)(4744005)(71200400001)(71190400001)(8936002)(74316002)(229853002)(4326008)(476003)(25786009)(9686003)(81166006)(81156014)(186003)(26005)(8676002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6231;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GQ9n1fMd3MRiCUuJn1xuR/CCAz/kA8vEZY9cq/9BxJii89mPB662MsY6AjoxuohNkx8N64ymN3QOWjQtTNiJDpHO4ti7OCwd8lWz88iYWmqUaFrLudkbjx/XQ4WYqeOx2hD8kn+JHHsY7Ps6dXoBONuT1mFbpvhqbrJvbVm1dhQiqrxqwxuEO6T4aKRM48BoyuK5xOYW5KadFjqLdguytBl6GhWhl012GF5LW3sNAyymgMgXanuCX8ngJLyKb9z4QIICHKr5QVucEgA7VBoe/fbeyvOyUl5c9IdkmUZQfovP6EJH1+BXs4eg/0AyVJsIRWq4QSc02vWNvsqfFPEiMJkCRnDke7I4eCOSmUJf8hEckPaDv6Ts/I+eiA/FwtZH0o1Xj/m3F8qLa5b2jo1eu8dO4gew4uqtSFKTN6ZJdYw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65282f9-0d5d-4595-0190-08d70e8b2dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 09:58:42.9133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6231
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=325 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

>
>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>
>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> Host Only (XHCI)configurations.
>
>I see you are using debugfs to select between DRD, peripheral-onlyh and XH=
CI...
>
>Is that good idea?

Yes driver allows selecting dr_mode by debugfs. Controller also support suc=
h functionality=20
so I don't understand why would it not be a good idea.=20

I personally use this for testing but it can be used to limit controller fu=
nctionality without=20
recompiling kernel.=20

>This is at least 3rd driver needing that capability, and debugfs does not
>sound like a good match.
>

Pawell
