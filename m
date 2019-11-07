Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10294C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D882E21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rcCKqK5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKGHvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:51:23 -0500
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:5773
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfKGHvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:51:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot6KtDEIaBB26gGvxMlr6fjoZPvwaL1QHMLgBcuI4NQD+ecxeEcPQ7XNDAsDAxtdmYy7C4lWg3rR2doe/Qt6zTlleKxNmQTnyid6LHmbsh+PJSgGUdMknbSUuBrec2t66ssp9lqbZFLjxdJaqHEWX8cMtrzeFjUx0b8+EegMgrFB5OWu+5T/pMnREDVdDFbgxr0w/b0Hxd9nOzbRVbrpCMxRjnqdw8l9ywUHMS5uYrbRTwvJaW/SnfiyhZT0CT43MbIhLh1SN09cqFzul7Ekv4CMfYO6Lq9Ds1hNt841mDaMNTS5HyU4Byp4dvxyV3J0f6nxfkWKsWuVNzFvVTnw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msFlGiKfaJwHoMxesxTXiLzxrZHaTCBWlBSEl36KY+I=;
 b=OPVFUTvCJPIcRp2A8qtP1dSzjvxx8x6oHkZOGL7s3fW7qaziYcfN6y9NlApr7aCqFZYwoQ833Lv5KbCTtq/RvFE1SgnQmsjl7SADPhBsE2Sl3CXjL5WgFhCj9gat7coUZcyaVr9daEjtV8EtAqVyUZcEKW98xxAZL52ohcg6uWwefl/HhhFuWHhTM++kk1mk13R7p+fCaj04jlDaxswcXAL4N4nNfuvav5n4DHBnXjjE/OcVpSPzgU83CEWRWHXb4S056uYqZyJsfwgRWlQ3/UyF1bDLSrrBSaDqlOY3fCvaYocrS9pAVBtKBHd+4/8gdAHU0EnzQV8rtZHq21PIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msFlGiKfaJwHoMxesxTXiLzxrZHaTCBWlBSEl36KY+I=;
 b=rcCKqK5ZPZw1uhN+L9ax24M+NemLTGhFVFo9FnNvKPZEmWOYbf5SgrcL7CRL07Z6WxfY1qGSR+hjWxu1uVxWL8UDkgSxIkVvLPd+Ik8AvCEDQXzaulS8XknrTR4W2UcMI9CePX9gQO0ZKQNusB5T6zBsI3OIL0RqAWFleprbVSg=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.254.214) by
 AM0PR04MB5490.eurprd04.prod.outlook.com (20.178.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 07:51:19 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::24aa:9d65:b376:5ae7]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::24aa:9d65:b376:5ae7%7]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 07:51:19 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] ASoC: dt-bindings: fsl_asrc: add compatible string
 for imx8qm
Thread-Topic: [PATCH V2 1/2] ASoC: dt-bindings: fsl_asrc: add compatible
 string for imx8qm
Thread-Index: AdWVP8IifFfTCEP2RpqREdYX4F5jzg==
Date:   Thu, 7 Nov 2019 07:51:19 +0000
Message-ID: <AM0PR04MB64687210E053B6ECE90C860DE3780@AM0PR04MB6468.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a974b462-1ec3-49b0-a903-08d76357468a
x-ms-traffictypediagnostic: AM0PR04MB5490:
x-microsoft-antispam-prvs: <AM0PR04MB549041657A3E54828C428181E3780@AM0PR04MB5490.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(66476007)(256004)(64756008)(33656002)(66446008)(8936002)(66556008)(7416002)(76116006)(4326008)(316002)(102836004)(6246003)(2906002)(3846002)(26005)(66946007)(5660300002)(6116002)(8676002)(6436002)(7696005)(52536014)(14454004)(55016002)(9686003)(229853002)(54906003)(186003)(71190400001)(14444005)(86362001)(6916009)(476003)(6506007)(486006)(66066001)(74316002)(478600001)(25786009)(81156014)(305945005)(7736002)(99286004)(81166006)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5490;H:AM0PR04MB6468.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYF7YZkKjc6AkWWhtQphLbiKkEqRiBxbRerpzWvNHaIVW9jDsmZYFDl1XMMQZVEKrGR4weR6MKQe/ZBCse4y/ImgP+r30EgVDiIa09Yf/vj3q8WwKDKJEdraEly38k4paqr6LacaqkjWI5hZCA3DBOTbDu1cewbqYSNvNo8hSVxGuCH/+JStE8kYgngYfF7hrL5s15rV2d0PFi6vc3kSaDPZUA34kFKMYZnWocTuFtyZlY2KxRMISqyMPMPwcvlNhb4pQ9dC1BoDfCuKXje3XgosAsAyi5woLHaFHTcvh5pXlczSWtNkNj6Gv7xCjGAvmfkCiHTOLbxuCTt4LQMBAh4ZsyzYoffrkN5V1aHxDOYbCK/I60w3hGhSO2ni1kh6I1qGb7/ATYegjEKPU7vBlaksrR/MGPbOk/szQnK8fNI4b0NUkpVDJBd+U+OoxhbH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a974b462-1ec3-49b0-a903-08d76357468a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 07:51:19.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwmEDG5SOPXnPhbGYXHnC/lRZmZOMeql6MrBDMXKQbjhc5MahvS2XNxO9j5RFME1VlSGjSB3n9zluQWGQDeWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob
>=20
> On Wed, Oct 30, 2019 at 07:41:26PM +0800, Shengjiu Wang wrote:
> > In order to support the two asrc modules in imx8qm, we need to add
> > compatible string "fsl,imx8qm-asrc0" and "fsl,imx8qm-asrc1"
>=20
> Are the blocks different in some way?
>=20
> If not, why do you need to distinguish them?
>=20
The internal clock mapping is different for each module.

Or we can use one compatible string, but need add another
property "fsl,asrc-clk-map" to distinguish the different clock map.

The change is in below.

Which one do you think is better?=20

Required properties:

-  - compatible         : Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
+  - compatible         : Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
+                         "fsl,imx8qm-asrc".

   - reg                        : Offset and length of the register set for=
 the device.

@@ -35,6 +36,11 @@ Required properties:

    - fsl,asrc-width    : Defines a mutual sample width used by DPCM Back E=
nds.

+   - fsl,asrc-clk-map   : Defines clock map used in driver. which is requi=
red
+                         by imx8qm
+                         <0> - select the map for asrc0
+                         <1> - select the map for asrc1
+
 Optional properties:


Best regards
Wang shengjiu
