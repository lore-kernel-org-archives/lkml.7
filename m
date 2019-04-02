Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04763C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75A020830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="apiNni+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfDBInz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:43:55 -0400
Received: from mail-eopbgr130100.outbound.protection.outlook.com ([40.107.13.100]:10369
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729477AbfDBInz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvG46Gpe9O94tN+O0q5N1jR9NYWDJeyQ0lY9M8qh43g=;
 b=apiNni+f/i9NfuGTqx5jYdJvVYLytDEuZ2FC4aFZUn30oyUa+GQypR6sfZ0C2uyVACOHuIE70f5rimkgenCP9DSG8wHY4brTjf0FKHByvVzGIBNUOmTI5ji3Jtd0o2juHEqRrvPWlP522MCy/tjOGgd7ps00zFJsiaiHxX+avow=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2094.EURPRD10.PROD.OUTLOOK.COM (52.134.29.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 08:43:51 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826%5]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 08:43:51 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Thread-Topic: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Thread-Index: AQHU5KmsQtL43pgBMESWjpaISK6vd6Ym8XMAgAGlmgA=
Date:   Tue, 2 Apr 2019 08:43:51 +0000
Message-ID: <ce9e8ca8-6db7-1be8-5ea3-c098b1c1c813@prevas.dk>
References: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
 <20190401073450.GG2059@sirena.org.uk>
In-Reply-To: <20190401073450.GG2059@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0051.eurprd09.prod.outlook.com
 (2603:10a6:7:15::40) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 365a824b-1920-4bbc-0ee8-08d6b747548b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR10MB2094;
x-ms-traffictypediagnostic: VI1PR10MB2094:
x-microsoft-antispam-prvs: <VI1PR10MB2094ECD70251F11AB746F30D8A560@VI1PR10MB2094.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(346002)(136003)(376002)(199004)(189003)(68736007)(42882007)(186003)(106356001)(2906002)(6246003)(31696002)(5660300002)(25786009)(14454004)(305945005)(7736002)(8676002)(11346002)(3846002)(6116002)(71190400001)(44832011)(4326008)(81156014)(486006)(8936002)(6916009)(36756003)(8976002)(102836004)(446003)(99286004)(66066001)(316002)(31686004)(476003)(97736004)(107886003)(478600001)(6506007)(229853002)(74482002)(81166006)(2616005)(6436002)(76176011)(386003)(52116002)(256004)(105586002)(72206003)(71200400001)(26005)(54906003)(6512007)(53936002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2094;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DsMdzpXzDs9fuA3+1VJW/G1fAlO15XuHvaLDI8gz5iVuWFkS0isFdppDX6sDuTfthtOW22O60pwKFLzi3QyKtS+ddTtadDmpNnBZdulO4CQlVbKMU1LfyV+kHpt9zWbfbmBXyuLFqKwOLy87Q5YEVgBOZswQvTxfWRpLO/9Nv3isPXncad/XEG6NZBO1CAeQByDb94gq8FHZfjuab6y3wm1mlfk6nQ66+J57ee1WxM88pL8EkhHN7YrE9K3fHBkLbUW7Anh4VryYkX3X9B2LQVPisxVTtXgMNocKQbh/Fb5u9L3Mha6Uqe+2TR2+TkW2odzXLg8QJN3zz/gPuYSQMQXm7bOdSuJy/POsF6c9TQ4muG3+Q48CGv5aArgVVzUG9KlSwBJxJoaX53VLFZ7wMy2mzgUs+EpIovd3OSOwHB4=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F259E65989CB92429186EC3522A6D6EC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 365a824b-1920-4bbc-0ee8-08d6b747548b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 08:43:51.5579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 09.34, Mark Brown wrote:
> On Wed, Mar 27, 2019 at 02:30:48PM +0000, Rasmus Villemoes wrote:
>> I doubt patches 3 and 4 are acceptable, but I'd still like to get
>> comments and/or alternative suggestions for making large transfers
>> faster.
>=20
> I see no problem with this from a framework point of view FWIW, it's
> going to be a question of if there's any glitches like you say.  I'm not
> sure how we can get wider testing/review unless the patches actually get
> merged though...  I'll leave them for a bit longer but unless someone
> sees a problem I'll probably go ahead and apply them.
>=20

Thanks! There's one other option I can think of: don't do the interrupts
at all, but just busy-wait for the completion of each word transfer (in
a cpu_relax() loop). That could be guarded by something like
1000000*bits_per_word < hz (roughly, the word transfer takes less than 1
us). At least on -rt, having the interrupt thread scheduled in and out
again easily takes more than 1us of cpu time, and AFAIU we'd still be
preemptible throughout - and/or one can throw in a cond_resched() every
nnn words. But this might be a bit -rt specific, and the 1us threshold
is rather arbitrary.

Rasmus
