Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40CCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5DA2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="T+q0m5SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfC0OKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:10:13 -0400
Received: from mail-eopbgr1300058.outbound.protection.outlook.com ([40.107.130.58]:22800
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfC0OKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-com0iei;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu3n/9L5FEksMHYZPucabstKkmIaNRBcGqt03eTyu7Q=;
 b=T+q0m5SIaZcIgycytKXDv+gApEDNo5U+DcdIWja8pXCJzOCsR0TIwBcIlfTxa7nTs1xktwGmM3iOhcaCfNjpyuyo4HztwGuZLhGLyj/1O/mA+j7wEdVW5PSNTknvzrCemf2HEz+Wf4ZMQrEfu8L3w8lMpgOsmveV+BfCyJ42G7s=
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com (20.177.148.141)
 by HK0PR01MB2929.apcprd01.prod.exchangelabs.com (20.177.166.209) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.17; Wed, 27 Mar
 2019 14:10:08 +0000
Received: from HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::7050:232d:ebc2:bb8e]) by HK0PR01MB2644.apcprd01.prod.exchangelabs.com
 ([fe80::7050:232d:ebc2:bb8e%5]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 14:10:08 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming's pfSense 2.4.4-p1 Firewall, IPsec VPN and Snort IPS
 Deployment Manual version 1.0
Thread-Topic: Teo En Ming's pfSense 2.4.4-p1 Firewall, IPsec VPN and Snort IPS
 Deployment Manual version 1.0
Thread-Index: AdTkpnhOedZ8gU98RJCmSfQgGo2olQ==
Date:   Wed, 27 Mar 2019 14:10:08 +0000
Message-ID: <HK0PR01MB2644EB7BEE1CCAA260363F5487580@HK0PR01MB2644.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65d7d576-f05e-4962-a1c8-08d6b2bdeb53
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600127)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7027125)(7031125)(7023125)(7093024)(2017052603328)(7153060)(7177060)(7172020)(7174020)(7193020);SRVR:HK0PR01MB2929;
x-ms-traffictypediagnostic: HK0PR01MB2929:
x-ms-exchange-purlcount: 9
x-microsoft-antispam-prvs: <HK0PR01MB2929629AC055D8D14C7AE97D87580@HK0PR01MB2929.apcprd01.prod.exchangelabs.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(34036004)(366004)(136003)(39830400003)(396003)(346002)(189003)(24433001)(199004)(6306002)(66066001)(5660300002)(33656002)(966005)(8936002)(8676002)(81156014)(86362001)(4326008)(99286004)(106356001)(81166006)(105586002)(107886003)(71190400001)(6436002)(6506007)(71200400001)(2351001)(5640700003)(45080400002)(3846002)(6116002)(7696005)(97736004)(2906002)(498600001)(55016002)(2501003)(25786009)(26005)(14444005)(68736007)(74316002)(38610400001)(102836004)(256004)(186003)(7736002)(52536014)(53936002)(6916009)(586005)(476003)(9686003)(486006)(14454004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR01MB2929;H:HK0PR01MB2644.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GtelwFgWIfkqFBQxRnVEKwEMbPliH0FvLXNkgHEmJG8CL6k/x08TCpwelCjlw5V7WqekuR73rxXQvTQERirIcp1gjmMd5lDhgtiPWLSAJWPa9sZafVLuOFlZcLDsHaJ0y/A5DopbdNdFt3j8Yv7b+njohqmXiKX4XGNHpae4MBuPAHCjrk/fWVPO3EdHRto5OC1rNKSgycCGo6c42EGSp2BG/h7UtfwaALI8dsYEaqmEY8e4DoGhIe9sfFNUvyLWI0fM7isqjExokk3XtqnspBN0rNQSaxs38WcxQxcuobctkshRnosTMP8glF8wS8V285XaghOzrMF79lvYEZjvYo9USQyW6m6/wBOXc6IjGiEme3CVXhS4QzxgsCREEZSK5eNf2EZCySRLK1bxcS0yomu7WpSBJqNfaeY/zPS/Emg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d7d576-f05e-4962-a1c8-08d6b2bdeb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:10:08.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Primary Subject/Topic: Teo En Ming's pfSense 2.4.4-p1 Firewall, IPsec VPN a=
nd Snort IPS Deployment Manual version 1.0

Secondary Subject/Topic: Installing and Configuring pfSense 2.4.4-p1 Firewa=
ll on Oracle VM VirtualBox 6.0.4 with IPsec Remote Access Mobile VPN and Sn=
ort Intrusion Prevention System (IPS)

Multiple Links to PDF Manual version 1.0 (101 pages)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. DocDroid Link

https://www.docdroid.net/pkHgk9V/teo-en-ming-pfsense-244-p1-firewall-instal=
lation-manual-v10.pdf

2. Google Drive Link

https://drive.google.com/open?id=3D1W-h_yAxmm4iYnuzKBT8ncwk8bwZZBCw6

3. Microsoft OneDrive Link

https://1drv.ms/b/s!ArahPxJAVR61hQ25G53nKyLZ5eXq

4. Scribd Link (Low Quality PDF)

https://www.scribd.com/document/403225640/Teo-En-Ming-s-pfSense-2-4-4-p1-Fi=
rewall-Installation-Manual-version-1-0

5. DocHub Link

https://dochub.com/enmingteo/1YwokQ/teo-en-ming-pfsense-2-4-4-p1-firewall-i=
nstallation-manual-v1-0-pdf?dt=3DcWyQH8uYyDpioEHi_-21


=3D=3D=3DBEGIN EMAIL SIGNATURE=3D=3D=3D

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

=3D=3D=3DEND EMAIL SIGNATURE=3D=3D=3D

