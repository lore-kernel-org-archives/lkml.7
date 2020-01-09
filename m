Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C611C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0584206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="Jod6AUYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbgAIPUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:20:25 -0500
Received: from mail-eopbgr1310048.outbound.protection.outlook.com ([40.107.131.48]:10976
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727945AbgAIPUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:20:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh9/0ywScZIXfx0IIfP1DapTSDkdCUdQw5WnlXsyypb9C4O6KYSgfv6AG5eqDKESLkcKrj3sDkWJTDNfIH/Py6fP3N21JIKmBtx4ABYt1ddiKBquvGQMvaETCjPWNSlBuGiXgbgIGjFzQ0a3Zc/uWerMHo3gqBdPv0RrAeIp5LzW5eYY5LhUyJGpVkolkmmy8BmvqTkouj55DEXdelUBWe3gZu2p4YXkW8aGgOknZ4JV+jo53zvTqw5JjObWnOC7nTKkXaWsxpaVVIQpura2F+JHsDhA7jzO1R3IZ+fuy3MX8fea0i/BdXEXa4JmnJjeuun2zH8SqkVqlJhAimAPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzyTqtbOfq3Ig0yXTX1EWjydOU+uAenurCB81rAkFjg=;
 b=lW287cyde/2MrM9xZzpt4YMREY/YE3K1fd9pVFyFZJ/flCPJl0i8R9u7jOevE8yu45M7OQdDQYQfmjdOdZCI8+8m6zz9m3QqchyB5NOKbR3/QMeCsDgaE7BSA9AzbyOlLuD3/HMkqM7Jeo570vXu97gKXXfQ62aL8lXpq2qdyIOhph8DoBn9mrWnI9oWf08Ont/GmmlaY7tfKFMAHUeg99t/T6/IJvyGP/EiekjIgJqsfjqI6N2pSvDiF7bDs377z005oXvm8kfJdNveISVZhVDLqb+ahvR03JT3y6+F/qwgfTa46otXsLicZsA7G6RPWKt0MyklHd32u5TYMKErMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzyTqtbOfq3Ig0yXTX1EWjydOU+uAenurCB81rAkFjg=;
 b=Jod6AUYXL8h7VZCrGNmVmZ4hOLQF57yP4zzDA3dS01siuzuYT5kcIAZIVz43CBxnWNjjqy8fngbR+iauFpHNpJRQ9ylhWh61ZXGOxKFLypAtj1Fdi4deI2HdPBieQroabrYhvqaGAtl89g8ptwv5r7bCAQQBOoA8OBEDiPDZazM=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2345.apcprd01.prod.exchangelabs.com (20.177.84.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.14; Thu, 9 Jan 2020 15:20:19 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853%3]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 15:20:19 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as at 9
 Jan 2020 Thursday
Thread-Topic: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as
 at 9 Jan 2020 Thursday
Thread-Index: AdXHACaCEPYkDr+RQSml98jQTrZoTw==
Date:   Thu, 9 Jan 2020 15:20:19 +0000
Message-ID: <SG2PR01MB21413100A5DAA2A7AE950DBD87390@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:f1ab:6fde:d925:5c0c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b01e3bdd-6bc8-4a86-0d07-08d795177038
x-ms-traffictypediagnostic: SG2PR01MB2345:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB234565D33571D387D308117987390@SG2PR01MB2345.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39830400003)(366004)(376002)(199004)(189003)(4000180100002)(6916009)(4326008)(86362001)(9686003)(107886003)(2906002)(55016002)(33656002)(6506007)(5660300002)(966005)(81166006)(52536014)(71200400001)(316002)(64756008)(186003)(81156014)(7696005)(8936002)(76116006)(66946007)(8676002)(66476007)(66446008)(508600001)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2345;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6f2EgxWlS6O34Uu+j2RMzlXTiX1zfEdzMt8B3rgUjD0WbDTNEKoLyszBXd73w7Ou23Ps79Kcvne97G8jZVZMFQx/vIBowUiJITziyN5tzBcEDiSYWgaMUxjTLjy4Psc2fY9T36zUjMX/sj2Qs99pYYp2HxNX2m7s3ODkN8AdegWjrY5xanyCRLTy8N8ddsUkVUIHYGVm3iSLOygf5GWub+jtw+xHAtKcw0JSZxX3nthzrYbYxjl3lsqpyJsC0Al+lNlcRp1eve30BZHRkDUEljBPmo9Cr8ey+drMu2H4E6CKiGMlN/e9fh39/GWeCKE6CLKi5SlYw/g+Zn+D7badQepNdHYt0iUWNcmRdq4ivOpLtb14LNG+TDv1tyfG9dp187rviYJsK5tMxBF2XiYUqtK8M24RaJU51I6SozAbBmYzJm88kXUsDV8TFNpgNUxvdvFPRd1RxraOTdq07mO8nVPhd29GQaSRQX2Bm+l4CP1yGEfl3viRNNMahWW+mgEjQaU5PZphNinN3SXYDayzkg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01e3bdd-6bc8-4a86-0d07-08d795177038
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 15:20:19.4083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDjNJOyfMI/9pdQ1pFSDLHzUWekp3UkwzmsDpWzNXKakK12TE/R8yOs4nGZSd39kchgtkJff1NXLYpQuGq6eggX5+eLwK0/i5l5a+U5/8+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2345
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SUBJECT: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as at=
 9 Jan 2020 Thursday

In reverse chronological order:

[1] Application for Offshore Refugee/Humanitarian Visa to Australia, 25 Dec=
 2019 (Christmas) to 9 Jan 2020

Photo #1: Page 1 of Form 842 Application for an Offshore Humanitarian visa,=
 Refugee and Humanitarian (Class XB) visa

Photo #2: Front of DHL Express plastic envelope (yellow)

Photo #3: Back of DHL Express plastic envelope (white)

Photo #4: DHL Express Shipment Waybill

Photo #5: DHL Express Shipment Tracking Online Page, showing that my applic=
ation for offshore refugee visa to Australia=20
was picked up at 1619 hours on 25 Dec 2019 in Singapore and delivered to Ca=
nberra - Braddon - Australia
on 30 Dec 2019 at 11:10 AM Braddon, Australian Capital Territory (ACT) Time

Photo #6: DHL Express Electronic Proof of Delivery, showing that my applica=
tion for offshore refugee visa to Australia=20
was received and signed by staff Mohsin Mahmood at the Special Humanitarian=
 Processing Center,=20
3 Lonsdale Street, Braddon, Australian Capital Territory (ACT) 2612, Canber=
ra, Australia.

Photo #7: Page 5 of Form 842 Application for an Offshore Humanitarian visa,=
 Refugee and Humanitarian (Class XB) visa, bearing the=20
official stamp of the Australian Government Department of Home Affairs at N=
ew South Wales (NSW):=20
"COURIER RECEIVED; HOME AFFAIRS; NSW; 27 DEC 2019" and=20
"HOME AFFAIRS; NSW; 27 DEC 2019" at the bottom.

References:

For the above-mentioned seven photos, please refer to my RAID 1 mirroring r=
edundant Blogger and Wordpress blogs at

https://tdtemcerts.blogspot.sg/

https://tdtemcerts.wordpress.com/



[2] Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday

Photo #1: At the building of the National Immigration Agency, Ministry
of the Interior, Taipei, Taiwan, 5th August 2019

Photo #2: Queue ticket no. 515 at the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photo #3: Submission of documents/petition to the National Immigration
Agency, Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photos #4 and #5: Acknowledgement of Receipt (no. 03142) for the
submission of documents/petition from the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019, 10:00 AM

References:

(a) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Blogger blog)

Link: https://tdtemcerts.blogspot.sg/2019/08/petition-to-government-of-taiw=
an-for.html

(b) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Wordpress blog)

Link: https://tdtemcerts.wordpress.com/2019/08/23/petition-to-the-governmen=
t-of-taiwan-for-refugee-status/



[3] Application for Refugee Status at the United Nations High Commissioner =
for Refugees (UNHCR),=20
Bangkok, Thailand, 21st March 2017 Tuesday

References:

(a) [YOUTUBE] Vlog: The Road to Application for Refugee Status at the
United Nations High Commissioner for Refugees (UNHCR), Bangkok

Link: https://www.youtube.com/watch?v=3DutpuAa1eUNI

YouTube video Published on March 22nd, 2017

Views as at 9 Jan 2020: 659

YouTube Channel: Turritopsis Dohrnii Teo En Ming
Subscribers as at 9 Jan 2020: 3.14K
Link: https://www.youtube.com/channel/UC__F2hzlqNEEGx-IXxQi3hA






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

