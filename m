Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9910C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C23217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B/Dzp+Hh";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="TdsPJ02r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFNRnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:43:02 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:49386 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbfFNRnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:43:02 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EHf4es007981;
        Fri, 14 Jun 2019 10:42:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=VqEDN5eTSpN1gvCS3Iem5BPA/AbwrrdonOaPDePuaZQ=;
 b=B/Dzp+Hh3xAvBlqJg1em352zca7Ewn9lMnL9X+JV0Bt+q2SfSLs9Idp2MEPzOyeoH/px
 Vd0A3amqtcovnh9tc9shfMvDs/fXmY5DYynplsUO/ITfrE9hVcKdy83joSDyLWJMbC+u
 fpLS2QJ8Ogp7Ugj+xErsA6A18prv3AACLNc4amfYHQgP4G6s3h9xHT2HCAjJqPMQh9Rs
 kSFoJ9Dd1oj/owDMefUStxKyObLSgs4I2tJj3NBiaOkDR0IRFKmdLx/OAUsWIMQPYxo4
 6vdaae6thbLZxcPSAcJHbxQ93Y+xfnxx/0zIYHdr3RNaVADLhZZCHYHW3ZY8lnYQzI1V vw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t41j63g2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 10:42:51 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 10:42:50 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.51) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 14 Jun 2019 10:42:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqEDN5eTSpN1gvCS3Iem5BPA/AbwrrdonOaPDePuaZQ=;
 b=TdsPJ02ro8zVlkYIHJ2cXsLTwAZ1mhWwi4uCPUKipx6VoH9qu4OzhDaJ9BRzZ4ttdPmC4HAafifI426vOyU4PsqXzr5wyVNUPB/Dib5D7dPFid2hvaquSic8gzexmu6idGTlMIGE/zAUuHM5B4gGnMCRQyedgUzHxWGFfz6ZxUc=
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com (10.164.205.31) by
 MWHPR1801MB1936.namprd18.prod.outlook.com (10.164.204.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 17:42:45 +0000
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::7c5a:e2f5:64e0:5b70]) by MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::7c5a:e2f5:64e0:5b70%7]) with mapi id 15.20.1987.013; Fri, 14 Jun 2019
 17:42:45 +0000
From:   Ganapatrao Kulkarni <gkulkarni@marvell.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>,
        "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
        "Jan.Glauber@cavium.com" <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH 0/2] Add CCPI2 PMU support
Thread-Topic: [PATCH 0/2] Add CCPI2 PMU support
Thread-Index: AQHVItiSZuHNgKndYkGQyfWKOHcA/w==
Date:   Fri, 14 Jun 2019 17:42:45 +0000
Message-ID: <1560534144-13896-1-git-send-email-gkulkarni@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:a03:60::35) To MWHPR1801MB2030.namprd18.prod.outlook.com
 (2603:10b6:301:69::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d61100f-19cc-4c3b-ddbf-08d6f0efb533
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR1801MB1936;
x-ms-traffictypediagnostic: MWHPR1801MB1936:
x-microsoft-antispam-prvs: <MWHPR1801MB1936BE12BE6C434F12172B91B2EE0@MWHPR1801MB1936.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39850400004)(396003)(376002)(366004)(199004)(189003)(66946007)(6116002)(71200400001)(2501003)(102836004)(3846002)(7416002)(4720700003)(52116002)(66066001)(99286004)(6512007)(14454004)(6506007)(71190400001)(4326008)(386003)(478600001)(6436002)(2906002)(54906003)(110136005)(68736007)(5660300002)(256004)(8936002)(2616005)(305945005)(2201001)(476003)(36756003)(7736002)(4744005)(53936002)(81166006)(66556008)(66476007)(26005)(50226002)(25786009)(186003)(64756008)(66446008)(73956011)(486006)(81156014)(316002)(86362001)(8676002)(6486002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1801MB1936;H:MWHPR1801MB2030.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IGtNPM3zBupv+PQyDvnjITg/V1M8bfDpi1ivtfe8tiqhwIPPTqSa6tlfAt4w0eG7K9rPCLbNJ2qd2VtXebHYwzQDJZhGwWbsrUYQg1hwgX78oAZOBKNNZib6kNIYD5pKZpoFouZwo5reHVwKgs3jXfk9jV2LAr2oOOF53QyHLh04uhfGU7gbhLGSKgrhWJnlWpFrmXU3Fi7gGzMGuc8udp6WG5+sYhv9hGryfJbVXHRgmAYdh1/kI2kLOzgufub7UA1ld5//PFAOySEpIIIPZZYa3RTo1fNa25eR7LbOMSE6Evbeymyh9BQq7dS9keqjgw6ViUzCJWd66ooHJrw7bNliE55axEPH5cj1xRGwV53peqeuaMGrYBam9zwM6BO8PjLmblLJ8bFffBrNZRPV2+y6oaB4kDtniz6kWCQY/rk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d61100f-19cc-4c3b-ddbf-08d6f0efb533
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 17:42:45.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkulkarni@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1936
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIENhdml1bSBDb2hlcmVudCBQcm9jZXNzb3IgSW50ZXJjb25uZWN0IChDQ1BJMikgUE1VDQpz
dXBwb3J0IGluIFRodW5kZXJYMiBVbmNvcmUgZHJpdmVyLg0KDQpHYW5hcGF0cmFvIEt1bGthcm5p
ICgyKToNCiAgRG9jdW1lbnRhdGlvbjogcGVyZjogVXBkYXRlIGRvY3VtZW50YXRpb24gZm9yIFRo
dW5kZXJYMiBQTVUgdW5jb3JlDQogICAgZHJpdmVyDQogIGRyaXZlcnMvcGVyZjogQWRkIENDUEky
IFBNVSBzdXBwb3J0IGluIFRodW5kZXJYMiBVTkNPUkUgZHJpdmVyLg0KDQogRG9jdW1lbnRhdGlv
bi9wZXJmL3RodW5kZXJ4Mi1wbXUudHh0IHwgIDIwICstLQ0KIGRyaXZlcnMvcGVyZi90aHVuZGVy
eDJfcG11LmMgICAgICAgICB8IDE3OSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiAyIGZp
bGVzIGNoYW5nZWQsIDE2OCBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCg0KLS0gDQoy
LjE3LjENCg0K
