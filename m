Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE12CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F7A20821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="YV+CKVg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfDUSP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:15:28 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com ([40.107.7.117]:6072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfDUSP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaBZr3943G4wgLmSKdqXdDgcPBZGQh22Bd2yoEh0yek=;
 b=YV+CKVg/n0oSIV2LKeW/Fk2sKRN6KplbhnDy6ZAyFbLfIttfgP/jGQ03RLKXqe2yj3LCMs+9J0eyfR7WL22p4L5bDGtfiaV4VB4dqvGvU/crGky6uHW+fnH5Blmt4zpF/aNwzhwOivcgUhEl80Nkn+bkyP9m4ztiH014bCI+RpI=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3901.eurprd02.prod.outlook.com (20.177.58.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 18:15:21 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 18:15:21 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Wolfram Sang <wsa@the-dreams.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: use struct_size() in
 devm_kzalloc()
Thread-Topic: [PATCH] i2c: mux: demux-pinctrl: use struct_size() in
 devm_kzalloc()
Thread-Index: AQHUpFUEn95Lqs8wp0OAG6GalPASBKWfZ7AAgKgr/wA=
Date:   Sun, 21 Apr 2019 18:15:21 +0000
Message-ID: <d7950904-23ee-98e2-9a55-77e7cb802e0d@axentia.se>
References: <20190104174327.GA30932@embeddedor> <20190104180612.GE3009@kunai>
In-Reply-To: <20190104180612.GE3009@kunai>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P18901CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::24) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5c1e257-7ba9-4245-4191-08d6c68550e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB3901;
x-ms-traffictypediagnostic: VI1PR02MB3901:
x-microsoft-antispam-prvs: <VI1PR02MB390143CD06E1937D584A1B7BBC210@VI1PR02MB3901.eurprd02.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39830400003)(376002)(136003)(189003)(199004)(64126003)(4326008)(110136005)(6246003)(58126008)(6512007)(8676002)(316002)(54906003)(36756003)(6116002)(3846002)(81166006)(81156014)(74482002)(97736004)(8936002)(66946007)(66556008)(66476007)(31696002)(71200400001)(71190400001)(4744005)(64756008)(86362001)(256004)(53936002)(14454004)(66446008)(73956011)(2616005)(446003)(11346002)(305945005)(52116002)(508600001)(5660300002)(476003)(486006)(31686004)(76176011)(25786009)(7736002)(99286004)(68736007)(2906002)(66066001)(65956001)(65806001)(386003)(102836004)(6506007)(65826007)(53546011)(229853002)(6486002)(26005)(186003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3901;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uLyIJsf5S+tLQ8IJkYgyEgoELoxcn3Od7DzJM98ZY9o1rCjsMOCcFyWCm4fjuLc4oZcvHfdTjsFKfV+LZzB1/y96T0ZByz1afIrPC/Z5DHnR6v5vzcs7PDuqm74mmIvKyJeoYH2PdU0iU9IXyzulkCJu3Utcqbyl04TIwd4hgHFbUrtRCZoTDLepXYnPRtBTpUk/Auz9ONi04o9ExgoIudOQ3vKbcUqyRiJp0OQtiMkGJ6mm7Z4wrm+CgTmW5n/8ULo+W0Y21Gn75902t+PVeIKWrNbm0JzrYQ7pTQad8iBl0NoO42zuN3OAwrKpGCNpkHH1GLmPdbu3iGkpLyn9w6DpnRU6hxrqxG7mZfd0sDKS+iDzjXEIVToDqQOhMfCUvnC0nV8UwY0nLusMWYRQbeEyzKCFDngAd4FMsPzNqAc=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A3712A6FD9B7FC49A185DF7E87C89FEF@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c1e257-7ba9-4245-4191-08d6c68550e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 18:15:21.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-04 19:06, Wolfram Sang wrote:
>=20
>> Instead of leaving these open-coded and prone to type mistakes, we can
>> now use the new struct_size() helper:
>=20
> I am okay with this patch in general. However, I think the name of the
> helper 'struct_size' is a bit unfortunate. I really wondered on the
> first read why it needs 3 arguments to find out a struct size. I only
> understood on the second read. I think 'trailing_array_struct_size'
> would be way more clearer what it does.

I read that as an Acked-by... :-)

Cheers,
Peter

