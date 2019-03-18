Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B24C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5383220854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cmr0mfSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCRPkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:40:10 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:24079
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726932AbfCRPkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uSxtNUSAj8VDMqVARMuCCZdDPQTSFuMGuLncn5xIyA=;
 b=Cmr0mfSyrgg6Bn8Z214negEuGTIhzKZyrMLNccC7eNC8zRiAofSusGnhpRsmrSKoVS8Ve5wYoP7J6dgAMzk/zZ+hGFLVIkBPTTnt+gRym8wUsMWYWTAxVYkx+LPz+L7/323Y4D24GN6YnwdmYI9BQqiOvtUtL6VlPR35XhHtOZg=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0PR08MB4114.eurprd08.prod.outlook.com (20.178.202.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 15:40:05 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::7e:6dfb:116b:befd%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 15:40:05 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>, nd <nd@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Swati Sharma <swati2.sharma@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Vidya Srinivas <vidya.srinivas@intel.com>
Subject: Re: [PATCH v4 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Topic: [PATCH v4 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
Thread-Index: AQHU2P+qA2ep7AXS+0OoMG0/Q7/SaqYRNbSAgABaAgA=
Date:   Mon, 18 Mar 2019 15:40:05 +0000
Message-ID: <20190318154004.2llnsarwx77kyqbf@DESKTOP-E1NTVVP.localdomain>
References: <1552414556-5756-1-git-send-email-ayan.halder@arm.com>
 <dea64e97-1d6b-e728-1e1c-3880e2f0a2e8@linux.intel.com>
In-Reply-To: <dea64e97-1d6b-e728-1e1c-3880e2f0a2e8@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::32) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61b161d3-b603-4b7a-f914-08d6abb7fe70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4114;
x-ms-traffictypediagnostic: AM0PR08MB4114:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB4114E037503355EF5F2932DFF0470@AM0PR08MB4114.eurprd08.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(446003)(6486002)(53936002)(1076003)(7416002)(6306002)(6512007)(9686003)(6436002)(256004)(316002)(66066001)(186003)(68736007)(6916009)(229853002)(86362001)(97736004)(5660300002)(3846002)(6116002)(26005)(11346002)(7736002)(14454004)(8936002)(54906003)(25786009)(305945005)(4326008)(81156014)(8676002)(45080400002)(6246003)(72206003)(966005)(478600001)(2906002)(81166006)(99286004)(58126008)(76176011)(386003)(6506007)(71190400001)(106356001)(105586002)(476003)(486006)(44832011)(52116002)(102836004)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4114;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BD73QoHP9lkPvIFUIB35f3FEC+kYy7R8zrDNo8BhTiIJIMQ54FAOZCeeEuiBElYStAOCRCLetaH/evFEB6yfJiWI+++nkwau3ix+CaA0v6NOu4C3K5gQ4r4CTNTBrIXi9IjojQNMaPAMl4rB1iKzX+y7vXFnpiS6WoOkgpryu7QRBG8Oim+DDvHSF1//yGPVSOirqsgbpOzDb6YJIkiBbIizBk8Wc+LBQkr2XEURKm27gjnmmm5KyjY2MdBYKGSPHD+LoM44HLotI+RbnZt+H4x4dSfMMWtbGE2JhObqMyGQAnvhMrtsgoHGdH8fcdaBJ9E9akmq8nfPG3kenRwOF1RS2YZEzb8eWcE1JOfdEX7pdLPwIUVKd6fg2IxyUnCNoeK8rmkTXPhVJKNLJHTGpSP9FXT9cKsN6x/9iK5/gMo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A1217FD59959949926952809B2DBE75@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b161d3-b603-4b7a-f914-08d6abb7fe70
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 15:40:05.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 18, 2019 at 11:17:55AM +0100, Maarten Lankhorst wrote:

<snip>

> Hey..
>=20
> There's a conflict with this patch and the merge of topic/hdr-formats, re=
sulting in double definitions for Y210, Y410 and P010.
>=20
> Worse still is that one has set has_alpha to true for Y41x and other to f=
alse.
>=20
> ~Maarten
>=20

Oh that's sad :-( I think this fell through the cracks on our side
when someone left our team. Also turns out I'm not subscribed to
igt-dev.

I see you commented the same on one of the previous patches, and that
there was some discussion of this on the test patches too.

I have been referring to Microsoft's page[1] as "the" source for these
formats, which does indeed call out Y410 as having 2 bits of alpha.
Our GPU expects alpha.

Was there a specific reason for opting to change the test instead of
the definition? Any way to get this changed now?

It doesn't seem that sensible for the kernel to call something Y410
which doesn't match an "existing" definition by the same name. If
alpha needs to be ignored on scanout, the alpha blend mode property
can be used (more archaeology - I see that was still giving CRC
failures, but that might be a "known issue" for all YUV on your HW?)

-Brian

[1] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-and-16=
-bit-yuv-video-formats#444-formats
