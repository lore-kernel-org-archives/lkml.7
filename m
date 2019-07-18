Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6FDC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 04:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E522E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 04:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="d7x60vid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfGREJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 00:09:23 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:43884 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbfGREJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 00:09:23 -0400
X-Greylist: delayed 1237 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 00:09:22 EDT
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6I3jchG026798
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 22:48:45 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by mx0b-00010702.pphosted.com with ESMTP id 2ts0cd7xwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 22:48:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoJ22StuC7LryG8db3dEL3zzi/JJgOMfDfUprADQXY0IPMTO7uUWN6kj4hbIoVaMEgVH7V8OXaZVilTqCvUqQX/sCc9CWaQNx/ZYPGw3oirZM19T7CX/6X0NLTgp05j6K0C2rL2NnSTQPisDJ5ryDjTUhEBHZLNhnxmH0dt+U9OaD4f39qIKbFhLIcwCWWQOpJWfIIxZ4O14KZK8fVkAVwwX1gTpASpAze9OK6Ay3XblVnvcPaTQPUo6GJXc1i8JIdteH4TE3sDOoP3Swtqd57ysFsKY+1PHvXm78mJAR2KOSrihU30Z1b1ZFhJMy/psEr5TprxppyV/psOG7PJuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNr3kzVhwMK6+UhX6hIAZbop7fOeZlcFRw0fn43z3s4=;
 b=JUe/t4U5uj2X2RhMUyIX7lh/EZL8H/jR/uXd+oF0wmnDoKaT+0ImlIG7shWV3IoGBoCo25AU4Lz4weDXPA2Wm90HP4CRp9URt8PQogjTCC/x9jlFXZoVoCEyoozuCNA8y6bkkHZghs3fDWuwVAQz4rCDArt68A9o2W8EoJ9Yy4Htvx0ZbGlmbMu4oDHi8bAv5+INbSJcAtJ528nL/GzHqeGlPx36ItOqP1uUXPXOXSqiC7hy98Jmd6rir8G1On5hH4EmxtlNjeRfIFBnIKfeYKN/DZwgGW/cdgNlk+rhk+m2EeqZbnJarjsvSk5V0vt8cH9BnbqFQ+vwKs/JHLirmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ni.com;dmarc=pass action=none header.from=ni.com;dkim=pass
 header.d=ni.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNr3kzVhwMK6+UhX6hIAZbop7fOeZlcFRw0fn43z3s4=;
 b=d7x60vidRR4bbG+KGqeIuVzXVZGxKKvbQ8dJLHtyCz3/NpsJl/ZaBDbME5qabx+7XXMkqJ57OA2tNhQ7gEHstc3pupcsqCeL3+0Q85hVY7YROtOpcIQMqviRqbI9qi2VKMcNK1pXlVzUUjARjf5p7rA6xd03lOC91HuUlcFK7jc=
Received: from DM6PR04MB6249.namprd04.prod.outlook.com (20.178.228.16) by
 DM6PR04MB5868.namprd04.prod.outlook.com (20.179.49.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 18 Jul 2019 03:48:42 +0000
Received: from DM6PR04MB6249.namprd04.prod.outlook.com
 ([fe80::e4b8:8309:6793:f623]) by DM6PR04MB6249.namprd04.prod.outlook.com
 ([fe80::e4b8:8309:6793:f623%5]) with mapi id 15.20.2073.015; Thu, 18 Jul 2019
 03:48:42 +0000
From:   Kar Hin Ong <kar.hin.ong@ni.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Keng Soon Cheah <keng.soon.cheah@ni.com>
Subject: Firing an interrupt pin induces the occurrence of another interrupt
Thread-Topic: Firing an interrupt pin induces the occurrence of another
 interrupt
Thread-Index: AdU9G2vsQGAkqV8+TnmePN80wZpMhw==
Date:   Thu, 18 Jul 2019 03:48:42 +0000
Message-ID: <DM6PR04MB6249DDAA6BCD01D1B37D41E8C3C80@DM6PR04MB6249.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e936329-26d9-45e0-047b-08d70b32d3be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR04MB5868;
x-ms-traffictypediagnostic: DM6PR04MB5868:
x-microsoft-antispam-prvs: <DM6PR04MB58680A9268AD639B71C511B4C3C80@DM6PR04MB5868.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39860400002)(376002)(189003)(199004)(256004)(4744005)(8676002)(81166006)(478600001)(2501003)(5660300002)(66066001)(7736002)(8936002)(2906002)(71190400001)(14454004)(74316002)(7696005)(2351001)(66556008)(71200400001)(3846002)(6916009)(305945005)(26005)(6116002)(81156014)(316002)(99286004)(486006)(476003)(102836004)(33656002)(6506007)(52536014)(5640700003)(86362001)(55016002)(4326008)(9686003)(53936002)(66946007)(66476007)(6436002)(64756008)(68736007)(76116006)(66446008)(25786009)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5868;H:DM6PR04MB6249.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Db6/rKiNxjd01TPAiQfuDcPJ5Sm97g6Ng4Wpvvg1w/iADaf7GjC8nFhe8+RtNv2wtG4EgzNzAL84beNwvo6I/20eTGpm4F5jKSHVcYtpOlru4D9Uu8UAlEPgDcYJ0ixIi5me8A8zHmcxtVYxxb+A9zF/Oe5TpYsP15IrER1dkvV3vtSyHwyG5Yi7gJjsFzT9IRjBCK4IewxXxM34o9yRUC4rkH8HnSa0UJeua/1+5hiE1LTvkNCct0K7fJbHjSfBwlCeuN3HP8HKKgMVAAPkmOKPx48tFGdsuZiNNDMnzn7B3be+KnXmd97K5D6saM8rb6jR8JbPb5tI49dtZDeOyhTi4o2rXdbfkWtTCk2wz8NjrcDqtgap2YrcqaqDyZO6h4VVZF9VhCau07d+73bTEZBFNxliVrVHctFULgH1lh8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e936329-26d9-45e0-047b-08d70b32d3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 03:48:42.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kar.hin.ong@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5868
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-18_01:2019-07-17,2019-07-18 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 clxscore=1011 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=658 priorityscore=1501
 adultscore=0 suspectscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1904300001 definitions=main-1907180041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

I have a x86 system with Xeon CPU running Linux with preempt_rt patch (kern=
el version 4.14).=20

When a PCI device firing interrupt to GSI 44 (ioapic2, pin20), I noticed th=
at GSI 19 (ioapic1, pin19) will get fired as well, and then it went unhandl=
ed.
I can reproduce this issue by using another PCI card or swapping the PCI ca=
rd to other slot, as long as the device is driving GSI 44.

By putting traces on do_IRQ, I can see it's being called once for GSI 44, t=
hen being called another once for GSI 19.

I tried to reproduce it on RHEL 8, it is not reproducible initially. Howeve=
r, after I added "threadirqs" kernel parameter, this behaviour appears on R=
HEL 8 as well.

I would like to get your advice on whether this could be a kernel issue or =
hardware issue.
Inputs on how to further narrow down the issue are most welcomed.

Thanks very much in advance,
Kar Hin Ong
