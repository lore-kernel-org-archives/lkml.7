Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317C7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70882176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wayne.edu header.i=@wayne.edu header.b="Xi2lDENF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRVuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:50:00 -0500
Received: from mail-bn8nam11hn2207.outbound.protection.outlook.com ([52.100.171.207]:6133
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbfLRVuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:50:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+iX5WBzetQMNdxk0s7gH3RNDjVOrMx8ehnj5HYb3mn5ArXALTwBRotH4a3cP0W6BIY24Rrnohw9BKsBCD1viEU7xWGSBmS4/gJ8oEQf2mLH3mUR4bFSbpdUQgeWQxzGfMytJSx0uUQc7oi1LMTskwJJCW9AhPaGRsdKlKfFrc7JW5Vy9IxfJCx35zlN4v2iZejTRgmOppoEb8xQsuutgqAqLBU3RtYDLKSCL9mPI+lo+GnrfSm23psB3Le2UMRhvd2vY6ptnjrSeTNDG3z/po1d1HMOUv4IvAR5osX336IZ+ZegLeF350Z2dR258fBbyEj0PfoRmp3KUwN3T9La2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHQIneSYArpmnPzZuVRcoaEVA0RlSiV1pTLUsQ2NBEw=;
 b=LW+EaQ0CJFzFFoMrIqjsZKGKMdjIAy605Ms0htr+r67snHrBHpfz8WaJM0uqWT/SNCE5nFschgaOCy4WLp7WvzVGW06HiI02xH88WZLm9NFjv+Nwv64VpoO0T1d5ohTowY9HnQOv0VvkHeFo/Iziin7khMhpDg0qtXJ7gGYuGnIEz6D3NYNA2PJXz+D2y4ZtmZ6zoEs5NAug18uOGuf0UKDa4LWazE8xAXfOtjpcQIOo0Q1sSwx5WobaeP37yUNtUwKiqiNiydQEqhEAt0iki0SGo3gC0pqv45da2iDVhGKgVreN58IAkJ8sToCp6Qho12suh6OVTxzDbGloNkiQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wayne.edu; dmarc=pass action=none header.from=wayne.edu;
 dkim=pass header.d=wayne.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wayne.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHQIneSYArpmnPzZuVRcoaEVA0RlSiV1pTLUsQ2NBEw=;
 b=Xi2lDENFTgoHLQC8+ZlJ8bx+wXj+cURZrb9xJdm34JvFuWLP5CR+1UXvIv/jLWBqXo06JaWr3mwSWHVAzu6x/vwZi9YNUQlTwMLdT4XXkOUnseJwhtAbayRFoJdnJgIUzmT5/8EJPIRL+38Ljg0rRPsosnZ2xu6u+6T5j3M1Ybk=
Received: from DM5PR11MB1674.namprd11.prod.outlook.com (10.172.37.136) by
 DM5PR11MB2042.namprd11.prod.outlook.com (10.168.107.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 21:49:57 +0000
Received: from DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::ac44:ef50:c63c:472f]) by DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::ac44:ef50:c63c:472f%9]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 21:49:57 +0000
From:   Michael Donohue <af7176@wayne.edu>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: regards
Thread-Topic: regards
Thread-Index: AQHVte0Qn7QBufpUiUKDOnbeBQpmow==
Date:   Wed, 18 Dec 2019 21:49:47 +0000
Message-ID: <DM5PR11MB1674F31ABB2022ACC31B946AC4530@DM5PR11MB1674.namprd11.prod.outlook.com>
Reply-To: "tien8842@outlook.com" <tien8842@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::24) To DM5PR11MB1674.namprd11.prod.outlook.com
 (2603:10b6:4:b::8)
x-originating-ip: [105.112.121.43]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=af7176@wayne.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4473c91-6d1c-4af1-c640-08d784043341
x-ms-traffictypediagnostic: DM5PR11MB2042:
x-microsoft-antispam-prvs: <DM5PR11MB2042A1A20EF8833C3FE13116C4530@DM5PR11MB2042.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:182;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39850400004)(189003)(199004)(3480700005)(8796002)(71200400001)(2860700004)(8676002)(33656002)(6916009)(66806009)(75432002)(6666004)(7116003)(316002)(7696005)(52116002)(81166006)(52536014)(186003)(8936002)(786003)(81156014)(55016002)(2906002)(64756008)(66946007)(66556008)(86362001)(66446008)(26005)(5660300002)(62860400002)(6506007)(558084003)(66476007)(9686003)(5003540100004)(478600001)(55236004)(19580200005)(220243001);DIR:OUT;SFP:1501;SCL:1;SRVR:DM5PR11MB2042;H:DM5PR11MB1674.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wayne.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BkSWswaD9zRczf4pq3fO1kNjvU4klJFxktpvfbkrqwc35UOvyymfbFL8GJnOiwKP9DobFJLDEH6XTOlCgFO4HcnBkVDqxjA9/cPsfpz6OtLEkB7cEDSYfIPJt3vxZEa9f1zXhxgKQOUtkFR997WgmeVDPUeSfS9iuLopUGD37TazNXIm5RcErnlPh3sw5GadBRsY5g6j0yuO9TFEUk+182YkbKeEU1sEybqSsf+K+WV7jbD+m2uEp9pjJU8slfqA1afcbSupB8iEqXJp3eVX8k9aH138HIN+w38H40bOXCjrdLMtqSlh6uay2PGuaJpWYNpdTosEsHMl3iUJ97yRbFE7vfwyxm46tn0RcZB2V+Vtb/ruG1IJf39ZE7WWw4DwjcGkq/LyLMmcs1cH/1T6FyJXXDT238r70sVECtG3/fQ2ThM+Ard0HU1yFe4q4aATKnhFUeyxzb0DsVvYnT74T62RFN/AVkhn9dH06QhVXnFIBfTQk+CMiYlMUyc55nhDZdTNRnwDkLmuXrK35ODHJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F341290B334388408C29EE972988EE35@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wayne.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c4473c91-6d1c-4af1-c640-08d784043341
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 21:49:47.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e51cdec9-811d-471d-bbe6-dd3d8d54c28b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXeXRUJt1g+xvKSDxMguhePYUoA+tEXXiElUVyDxXHVLUmn5oTQo7sCEnYe6r1qUDEh8kaEDZRCupemVCgaOFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

 Our product sourcing agent gave us your contact that you are trusted,kindl=
y send us your catalog.
=20
Early reply is appreciated.

Mr. TIEN DONG, director of procurement.

ANC HOLDINGS
Warehouse 7
19/14c street off Umm Suquiemm street
Al Quoz 3
P.O.Box 49844
Dubai, UAE
Tel: +971 4321 4621
