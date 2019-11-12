Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9486020818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="Yhc9XCkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKLOkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:40:39 -0500
Received: from mail-eopbgr1310041.outbound.protection.outlook.com ([40.107.131.41]:65257
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfKLOkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:40:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2KuCY+WC5RnEtc1+l9X0mFywZbYwF8TatQg/5CADzvjvv6nM/uSUaxFSJpla6/738jQnfaNQIL0YXHXKsRxMJVCyqKMvI497mauUzQMM44yHXsC21K/e6dyhN9S5lTpn6Z+VRVcZt+sgQTguz431Q5cel1fVFfZnf09pLpWwH4XUvZbd5raLmDZl1Ca1v/3iBMM6jBHQ/LF124bTtbTmdVFav+pGysXSH2yDDw+0ZPzJOj7kVw70CIzWuK1otAuesLBV7cEkHtU2HjGqyV436Bh+VLxMVTAFBWJUtbasGFaC7WK7lZpPzNesYsqRoIjrmt5fYv502J5QVytG6IEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZtVyGHaQuahF155qe6t/LZA0ztH4wGjm8lT3PxmYWM=;
 b=VBjt9J34tpKCeDbEbEm3/3pnYforsYz/MDimIQ5909+SQKLMnObbxbI9Yl5wenNU1cLPtNBW3EqwiZrD1leud/wUeJgluOHEmHoYHbmLZPjFpdNRtUY0Yw1PdyT2mvzC+b6tL3OGNoTZzEUYoUt1Ys1Z5J+qylONMBOCmcBa7UMkmDMIUd1FLinR2s5l4bZNiXX/aUmlMQ7Ys7eXC4PxBhn5por4cAe+ioNHzvBcidY5NaGCwsySfpnrG97q8a5w88h81P+1bTKWdVAAivvHsSZSMoZDMDAhWnAke+MuZxEnqklIqsTDnX29bFBKGoaOg5SdNfWOJIVCPW1CuAPkpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZtVyGHaQuahF155qe6t/LZA0ztH4wGjm8lT3PxmYWM=;
 b=Yhc9XCkMOZiel4nam70xvnCFO4MxzsT/hgC/tQIUVfkSHSSWEgIBVwSkQxEncAGAgiiVqFZpptwI2Qe0FpSsDxj76sfhAR5nX/vTqYDxu1H8jjIKUg2uBk6qU5OVNZ3c8knNBNPYcPjsQTODRXjiZD0k9Z1rDVxRAi8BgPjo2TE=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3014.apcprd01.prod.exchangelabs.com (20.177.92.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 14:40:33 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a%2]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 14:40:32 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: I just got to know another 2 Singaporeans who were denied/refused
 government jobs because of their remarks on the Singapore Government
Thread-Topic: I just got to know another 2 Singaporeans who were
 denied/refused government jobs because of their remarks on the Singapore
 Government
Thread-Index: AdWZZxdPvq3SYczMTZWMjeK/fJhP1Q==
Date:   Tue, 12 Nov 2019 14:40:32 +0000
Message-ID: <SG2PR01MB21418AD61EA6B2BFCBF0753D87770@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a95adc45-c292-451d-5d20-08d7677e45bb
x-ms-traffictypediagnostic: SG2PR01MB3014:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB301406A6BD5D5E5A98EEA0AA87770@SG2PR01MB3014.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39830400003)(396003)(366004)(346002)(376002)(189003)(199004)(2906002)(7736002)(305945005)(14454004)(74316002)(25786009)(486006)(966005)(81156014)(8676002)(81166006)(86362001)(7696005)(476003)(8936002)(33656002)(316002)(6506007)(4326008)(9686003)(26005)(66946007)(76116006)(6916009)(66556008)(99286004)(6306002)(66446008)(64756008)(55016002)(66476007)(71190400001)(71200400001)(66066001)(6436002)(6116002)(3846002)(508600001)(14444005)(186003)(107886003)(5660300002)(256004)(102836004)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3014;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vnnyYO1CqGGUeoaXjmuPWStf9IHRGtDWil+SEENA5MJU8OOmnjblMWOMRVMeARLUBdVOFALaMvupLsqH1aYzb231JbBQ10OJ9f5CVWCgsqRpsaNB/RRxUeL5hRtGu5L2AZNeDxyibJKpxRbQwdxjEYx3Gs9q7SDqLiyyHB6QiTFAbirdv7HUc6FQb+SBW74iuAIlsF5EVhyiu8iXKpRO/uwMCicjhatjM/xX7Qe6d9jdlAIlFJPNFlg9X2BPyuJAn7y/PvKM1u98MWC8e091KLW+Ba1vNdDl82KjCqk0grfrZ5ksHYdKOZXyuegGecpF87zDZk2HoGoq1MgGAB1PEL4jWCw0cj59qpjc0VbFiG0k0RIeZ+NdZs1QFoYIF6AXkd+PkVwxRyoZvWVZrNpjB0DoDSAj0pdBU6tINQibgTuW5ae5xJI0KqSttW4f3h2RQVVxcmqdcxnWGpcZtbUxe3p16iEY/2nuPiuRMcCElnk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95adc45-c292-451d-5d20-08d7677e45bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 14:40:32.8212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zoz9ADt9dOZWRIXRg2gKMIHYVFleG2QF1q93d0I8vK0MbHd6Prs5IQRK/Mf4hkNwQazqCrngZXwFQCpo6Z2butxBB6xKUVgSv1kafLGE0LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: I just got to know another 2 Singaporeans who were denied/refused =
government jobs because of their remarks on the Singapore Government

Today, 12 November 2019 Tuesday Singapore Time, I got to know another 2 Sin=
gaporeans who were denied/refused government jobs because of their remarks =
on the Singapore Government.

Donald Trump (not his real name of course), who is a recruitment consultant=
 at job agency Nanotechnology Infocomms (not the real name of the job agenc=
y of course) in Singapore, communicated to me he is aware of another 2 Sing=
aporeans who were denied/refused government jobs because of their remarks o=
n the Singapore Government.

According to Donald Trump, the 1st Singaporean passed the first round of se=
curity clearance but failed the second round of security clearance. On furt=
her thoughts, the 1st Singaporean thought he may have been denied/refused t=
he government job because of his remarks on the Singapore Government.

According to Donald Trump, the 2nd Singaporean was working in a semi-govern=
ment job involving classified information of government ministers in Singap=
ore. According to Donald Trump, the 2nd Singaporean refused to sign Non-Dis=
closure Agreement (NDA) because he argued that government ministers in Sing=
apore are public figures. The 2nd Singaporean was subsequently forced to re=
sign or terminated from employment.

Due to privacy laws in Singapore (Personal Data Protection Act (PDPA)), Don=
ald Trump cannot reveal the names of the two Singaporean Targeted Individua=
ls to me. Privacy laws also exist in the European Union and the United Stat=
es.

The General Data Protection Regulation (EU) 2016/679 (GDPR) is a regulation=
 in EU law on data protection and privacy for all individual citizens of th=
e European Union (EU) and the European Economic Area (EEA). It also address=
es the transfer of personal data outside the EU and EEA areas. The GDPR aim=
s primarily to give control to individuals over their personal data and to =
simplify the regulatory environment for international business by unifying =
the regulation within the EU.[1] Superseding the Data Protection Directive =
95/46/EC, the regulation contains provisions and requirements related to th=
e processing of personal data of individuals (formally called data subjects=
 in the GDPR) inside the EEA, and applies to any enterprise established in =
the EEA or-regardless of its location and the data subjects' citizenship-th=
at is processing the personal information of data subjects inside the EEA.

The Privacy Act of 1974 (Pub.L. 93-579, 88 Stat. 1896, enacted December 31,=
 1974, Title 5 United States Code Section =A7 552a), a United States federa=
l law, establishes a Code of Fair Information Practice that governs the col=
lection, maintenance, use, and dissemination of personally identifiable inf=
ormation about individuals that is maintained in systems of records by fede=
ral agencies. A system of records is a group of records under the control o=
f an agency from which information is retrieved by the name of the individu=
al or by some identifier assigned to the individual. The Privacy Act requir=
es that agencies give the public notice of their systems of records by publ=
ication in the Federal Register. The Privacy Act prohibits the disclosure o=
f information from a system of records absent of the written consent of the=
 subject individual, unless the disclosure is pursuant to one of twelve sta=
tutory exceptions. The Act also provides individuals with a means by which =
to seek access to and amendment of their records and sets forth various age=
ncy record-keeping requirements. Additionally, with people granted the righ=
t to review what was documented with their name, they are also able to find=
 out if the "records have been disclosed".. and are also given the rights t=
o make corrections.[1]

I am now aware I am definitely not alone and I am definitely not the only T=
argeted Individual (TI) in Singapore. So far Donald Trump is the only recru=
itment consultant from only one job agency in Singapore whom I have spoken =
to. Hence there could be a lot more Targeted Individuals out there in Singa=
pore whom I am not aware of yet.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:=A0https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microw=
ave.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1]=A0https://tdtemcerts.wordpress.com/

[2]=A0https://tdtemcerts.blogspot.sg/

[3]=A0https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

