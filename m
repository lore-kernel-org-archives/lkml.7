Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C969C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B9C2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="P22BMGfb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="oH4bbIBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfGVMLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:11:52 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:10984 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728413AbfGVMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:11:52 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MC77df011535;
        Mon, 22 Jul 2019 05:11:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=LsW8GUUQuC9LIS5ZwpXbRs8DB8jte9c48VVXpKPmcvM=;
 b=P22BMGfbDDojbZGx0hc+tFRBt4pH2DizL/05mX9+WS8Rs6RXjZsqNbcpTNAuJYkJGxvK
 CPm4L7s3FZ1hU+yIYwT9KS0HQXUgE++G58m72FQgn2XYUOqYt3pgI8T1174NbpvNKte9
 +gn0ba8Tn9ex+lC8De01RBbAUmv7m3HLSo8W9wYcCskkQ5USULFjX36M2CKdmVLdCjui
 omE6TU9fUjBwpqF5sADiLqSShxcpRk02Cr4mnpALK9V4pbjjGYvKEcOOGoV0HKYpXYkK
 sE37Eb5qA3ShSMHt3o+v0y6j3Tto9aXV8jSal1umGp3ssI9dq6Wf5a9gnKBu6okx+AjH Xg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2056.outbound.protection.outlook.com [104.47.42.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tuygwpc23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 05:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnwtkRArf+F34NnZDE+qpAavwcTzG/Q7qsFM8ubaQCJhBE3S4sAH1qojS6hcT/EVuj6XD9onUJy55D0qYTokj5c96AWeSBK88BbUkXotEkT36kEowZRKycJ9K7HFMFNmSB5enDqzLeE/514IwMg+ExR0w4DQLuDPQxwuFSlHpsEaSsCPsy3E7yyIHqT3+/qPRrW5qvgf5xmgpcmWkxi5MPvJYRsnpiWkx5MotX6iRa5tsfkXuiMbAfKg9kXCnUwYIjC0SsFcKpkNOSkpVgR6gy5QQmQXKgovoq8/7gxpWTlp+ezObPwaY9KWJ9JjHVRmbpKECvP9SN1bKwY6YtuQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsW8GUUQuC9LIS5ZwpXbRs8DB8jte9c48VVXpKPmcvM=;
 b=JsTxNLuYRIhjqYMIBnCkZF1NTgsengNiObRK/fWalH+OKUv9SsyMtQcYxb8cEeN0B2FTHINtANAhCfYO6+kTjoiUISD0MZjtDHkwfaWzHNB+ktBbwG5pfh/tBaZVobqN7GnFj/fLaH2idntFhrkll1ZDO1qVhx78v/PPSiReIyqdEB/djlXPYHikpgHv4wj6vc5oPQiVdkqN5sr3EIbQ/bwltfaSpNur9lYSF5kyGEKGVw8pU1neolXQxFD5+odE2joxoMY362DRL+YbbR3Z3s99/eMRkUYHRf5NNtkUEznWcIPGmD0AsSdA+8fiXzL1MaiSaF0uplWyJEKVRvog5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=cadence.com;dmarc=pass action=none
 header.from=cadence.com;dkim=pass header.d=cadence.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsW8GUUQuC9LIS5ZwpXbRs8DB8jte9c48VVXpKPmcvM=;
 b=oH4bbIBdO9o5VF8dsZKh5Ol1sEsnEVD3Xu8QXkrSashAXkciXam6Tc/d7NxtW+53PqSKc9xhGxmPYKxSbkzVAMJRA4dCsGd1F1G8StDTDYMQo29iAuAOrMhHZJhCCfRg3BfSUOAgyeEnv24dK45ndTmO82wFkfKWYAm+CUnXtFs=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5671.namprd07.prod.outlook.com (20.178.0.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 22 Jul 2019 12:11:40 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::41f8:6c26:5cc9:743d%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 12:11:40 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Pavel Machek <pavel@denx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
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
Thread-Index: AQHVP/K3++/PZvX91EKpHiAZrLktoabVbhiAgAD3BZCAACHLgIAAAkOAgAAB8kA=
Date:   Mon, 22 Jul 2019 12:11:40 +0000
Message-ID: <BYAPR07MB470924FB97951364BD3AB5B3DDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190722114839.GA10515@kroah.com> <20190722115644.GA12069@amd>
In-Reply-To: <20190722115644.GA12069@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGFjYmE1OWItYWM3OS0xMWU5LTg3NDMtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGRhY2JhNTlkLWFjNzktMTFlOS04NzQzLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTc2NSIgdD0iMTMyMDgyNzEwOTgzNTE5ODA4IiBoPSJvaWc0eHN3cFI5dEkvNlB6QjBXVVZQTXRPQnc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 243f0d79-5ea9-462c-4f7b-08d70e9dc0d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR07MB5671;
x-ms-traffictypediagnostic: BYAPR07MB5671:
x-microsoft-antispam-prvs: <BYAPR07MB5671984B5A03464D3CDB27F8DDC40@BYAPR07MB5671.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(189003)(199004)(36092001)(52536014)(4326008)(7736002)(6506007)(8676002)(478600001)(305945005)(107886003)(476003)(25786009)(68736007)(446003)(7696005)(64756008)(66556008)(26005)(186003)(66446008)(66476007)(76116006)(5660300002)(71190400001)(102836004)(6436002)(229853002)(11346002)(86362001)(54906003)(66946007)(76176011)(486006)(9686003)(14444005)(6246003)(6116002)(99286004)(3846002)(256004)(53936002)(74316002)(8936002)(2501003)(110136005)(66066001)(33656002)(14454004)(55016002)(81166006)(316002)(71200400001)(81156014)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5671;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iUkshYMr4l7BGs1jsIrTmRfnRrsvGXdbD1BdsvBN/+ENO8eMejdAIbkTVDDXSpJgHadmVakvXV94MrWjv5ZW15XM1UgsOGuEL9sstG5pbPzfeOuFxwc7DuSQu/zGKFRz7ApA+cktd60AyepTAIjzy9f2UWJW7KyY8oU8jeYAMu/uNinFl/4ujIrKzAw4RnwWh4DAfdTNUDsYsn3ZFcbhwQKEvvd+B8UTX9bTbdC6osgsUrrKOT1pPY0CHvoKxffMHV0eD+E2BvUsqqZJ6knD5KyNEPFVVG8HzZVaH3RXu0jiM/aqrbdhr589wr6PfgnMp9mMm9nh/Ys4CjQAguEgTdKSK9LFl/tHeQ0WRbSJyaWVa4L4mQCRj7JQYZDi4OQzz6SnV52lNI7waxUaAtd2jEFkTHBMX1zr5A5TyT/Th74=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243f0d79-5ea9-462c-4f7b-08d70e9dc0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 12:11:40.2615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5671
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=452 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi!
>
>> > >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>> > >>
>> > >> The Cadence USBSS DRD Controller is a highly configurable IP Core w=
hich
>> > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> > >> Host Only (XHCI)configurations.
>> > >
>> > >I see you are using debugfs to select between DRD, peripheral-onlyh a=
nd XHCI...
>> > >
>> > >Is that good idea?
>> >
>> > Yes driver allows selecting dr_mode by debugfs. Controller also suppor=
t such functionality
>> > so I don't understand why would it not be a good idea.
>> >
>> > I personally use this for testing but it can be used to limit controll=
er functionality without
>> > recompiling kernel.
>>
>> debugfs is ONLY for debugging, never rely on it being enabled, or
>> mounted, on a system in order to have any normal operation happen.
>>
>> So for testing, yes, this is fine.  If this is going to be the normal
>> api/interface for how to control this driver, no, that is not acceptable
>> at all.
>
>It makes a lot of sense for end-user to toggle this... for example
>when he is lacking right cable for proper otg detection. As it is
>third driver offering this functionality, I believe we should stop
>treating it as debugging.
>

Exactly I use this for this purpose. Depending on my testing platform I hav=
e=20
the adapter with Typ-c plugs or normal Type A plugs. In the second case,=20
by means of this property I can force Device or Host mode from driver=20
without changing adapter.=20

Bu as I wrote I use it only for debugging purpose.  I believe  that device =
on=20
the market should not work in this way.=20

Cheers,
Pawel.=20

