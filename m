Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09342CA9EA9
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C730B2190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="RvzrSRnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJTKL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 06:11:59 -0400
Received: from mail-eopbgr1310089.outbound.protection.outlook.com ([40.107.131.89]:6574
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfJTKL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:11:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmXlHlwdwmanHOLMiVYbdhzt0Q4LX4i/+4CakX0L8qt/0XpzEsTMNe0ExfJp9cLcYJfR8R4wvqUp0sMSJYHn3YI2pVhleqyamsL12Xjz6rd64uQB1PtCjerRff6YbgzMShX3lgko/aGEa7MXyqzhyxTol+8dZ1p8duRWxWhVNFQsGe2C6I0YSyg6jQ4nnd+vH0assv6fq4Uy4THI1bR2CvF18mDRCy203EwaCOWXfYv5I3cIeXgM0Q6FuWTfAJd1HM4HSK9JpJDnvrlglTgcL98TzLZLCtiNAF6AMxqkuWq86p8a4H4oMPeFAgvpaaip4mxI1Aqmw+boSEAwl2iyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eXyederqxVg5cyAP5Ou36J7ipAHL3ew/E/y1zgZz9c=;
 b=fAwu4/1iVgH0EWwj3Comvk9H/93MhgoR/ZxAoUc1t2N5Uxc3Svv/R0EQhyeYTzOK/Zz9Nw7B5ZFUp4fOsJBF1F++8pxFqPaHVI289a+SlBdGLwL1tZRsB1lpAuyoTiCRV4RDIqAyIO6LlNLUocWZgdYk//xN4W7uajjH39Xkvu67FD8AE1gob2Xh6ZTYwpM+7B29wzwrK5pxXsqg8Lidb73QyivRHKfu6/9A82965/9XGOyYQgdrdf2u6WV5mleywuI5cgGzesD5Ag/s1KacbaVEy7uuGy+K0DVpr+LSSOTj8a18Q5iJq5uY5b0FHm/bPs15zbBneWQGhnm7hAKb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eXyederqxVg5cyAP5Ou36J7ipAHL3ew/E/y1zgZz9c=;
 b=RvzrSRndVWQdkh8sVQ1G8jDmSK4I+oO9mDfA0e6A6darE3FEBbtsiaKVbNauvWYxA+OL4wmihr9VkXAc0F2p8ck5qhKgkVFK52OE1oLLbsGBSTWuNQC0Dxs1vFut7Tn7BP2nfcTC3tl+pG6OcB6bHsi+9ffaXUOn626l59SPD2o=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3158.apcprd01.prod.exchangelabs.com (20.178.135.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Sun, 20 Oct 2019 10:11:53 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8%6]) with mapi id 15.20.2367.019; Sun, 20 Oct 2019
 10:11:53 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: DNS Records for Teo En Ming Corporation (Office 365 Business Premium)
 (Using Linux command dig)
Thread-Topic: DNS Records for Teo En Ming Corporation (Office 365 Business
 Premium) (Using Linux command dig)
Thread-Index: AdWHLr7042ccU3QsQ4GXW5URRLzLZQ==
Date:   Sun, 20 Oct 2019 10:11:53 +0000
Message-ID: <SG2PR01MB21417B2FE0F0195DEEEE1116876E0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd266afc-3372-4ba3-da66-08d75545ee83
x-ms-traffictypediagnostic: SG2PR01MB3158:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB3158DE2C778DCB9874BAE611876E0@SG2PR01MB3158.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0196A226D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39830400003)(376002)(366004)(346002)(47610400004)(189003)(199004)(45080400002)(66946007)(8676002)(76116006)(14454004)(25786009)(52536014)(508600001)(66446008)(66476007)(66556008)(64756008)(5660300002)(6916009)(186003)(81156014)(81166006)(86362001)(966005)(8936002)(2906002)(74316002)(66066001)(4326008)(33656002)(102836004)(305945005)(6506007)(55016002)(26005)(6306002)(71200400001)(71190400001)(7736002)(107886003)(5640700003)(52230400001)(9686003)(99286004)(486006)(6436002)(3846002)(6116002)(476003)(7696005)(256004)(2501003)(316002)(2351001)(47845001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3158;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ieQCp/9DLYcdd4psbmt9scCOggL4N+T1asOnNG73PSsGsaLQmcw2T5SBmTrbJsmzwSpDibcPZBygOKymfQS1AlcIuvBWIb3KVAN/yBW0gZxXcgGFiGsMUryNDv1T0aYcDEbRQrxWKnobX4/Ea70+W5/0djTfk9jZaF5C8W+4QzJmeA4wPpA+Ng2Z36s95XpJQEMtmPtmy09BRbwymfu7WldlbvRynQKk/EDwiIZR0lzmxBD7NKXGAu9topgOklY88HTKBIa+NMzF/XmeeTHeVfQDzKSvJcMEVkdlS27SB4Sg19PqydHUz37F1QWdn8uBDQdyAJvSm04SvT5PxhUQm4h8w7bx9H2cqPJ6ODlPsy8e1SKjoo/M2hnDUfZarCd3Ku01UmE+5Jn15qvhdX4m09wRx4q+QJPR+0VOT+LO48jb5JFzAdGSEQhKW/CJ8hSsvnsMhg9NQbkhfPmK5luaTg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd266afc-3372-4ba3-da66-08d75545ee83
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2019 10:11:53.8347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bz5nQAbdXRbiSobYJk9wHVuHPJzBmkMIMTRFf2O4Yb8UPSV4PSO3/1rzAr8N+YNHOFq50ezPZZi+xU7eHBkpUgVrYlrogL8IbKiERgW/PCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: DNS Records for Teo En Ming Corporation (Office 365 Business Premi=
um) (Using Linux command dig)

Good day from Singapore,

Office 365 Business Premium User: CEO at teo-en-ming-corp.com

Linux command dig:

teo-en-ming@debian:~$ dig @8.8.8.8 teo-en-ming-corp.com ANY

; <<>> DiG 9.11.5-P4-5.1-Debian <<>> @8.8.8.8 teo-en-ming-corp.com ANY
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 32657
;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;teo-en-ming-corp.com.          IN      ANY

;; ANSWER SECTION:
teo-en-ming-corp.com.   599     IN      A       184.168.221.55
teo-en-ming-corp.com.   3599    IN      NS      ns37.domaincontrol.com.
teo-en-ming-corp.com.   3599    IN      NS      ns38.domaincontrol.com.
teo-en-ming-corp.com.   3599    IN      SOA     ns37.domaincontrol.com. dns=
.jomax.net. 2019101803 28800 7200 604800 600
teo-en-ming-corp.com.   3599    IN      MX      0 teoenmingcorp-com0iei.mai=
l.protection.outlook.com.
teo-en-ming-corp.com.   3599    IN      TXT     "v=3Dspf1 include:spf.prote=
ction.outlook.com -all"

;; Query time: 15 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Sun Oct 20 18:03:09 +08 2019
;; MSG SIZE  rcvd: 287




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

