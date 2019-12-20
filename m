Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB9CC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330612146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="eJZam+dx";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vYzuoVdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLTJns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:43:48 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:5594 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727151AbfLTJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:43:47 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBK9bonO029064;
        Fri, 20 Dec 2019 01:43:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=RE4vMig+PT9w/TWht/8ag5I1tSRWJbwagzweBV6jHJo=;
 b=eJZam+dx9aa3bKndkT1fdIQ4Nx1eOAnNDLr5bf9S564/lGPNalzjp7MbwARiwcqxcd69
 r0GTSIYBxW2deBWCXmKhXAWKJNH9VxGsd4lJLQLbEg1J37yuBqt0gqH7pODsSPqXz5V/
 QWtu3BnH40nt5VikblR/70sCZORY5oPsgJoV9pvO6RKO6Q0k7IN4IdZqSBJRsfND+wGc
 f1+Sy0+59uFdf7N5upiZmPpTOMjTxC31AUwTo3wYaiC8nklrWJGseB0qYLGFXQuwUGAf
 YU67eHbUrm1zOMR1Uo2k9Oa2i5sXM+NnzT0D3ZO0D4UH1CFFEQE0NKBQd41jGK7Wr4gI cA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wyr9p721p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 01:43:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdjzhqcHNB8gyGgOZ0fcznHxTHRuCr0pc/QQWbHhoIO4tQY7eBDRY66SNDo6bi9VljP8SX7q2P1+H/thKUFURkbH/U//Boegn6IHl6KSqya3yL/BkpdMP52ZM9VmGXM2ZrPy1c6F6LcizCfiqYXFC3nE5fnW88x6p7hyJYwQWqMNKKJs+xsWGp0NoowM5zy0OKNd/76+aJkHVp6d8mOioGkV3DOqtCRMioKvZmyQ9sZ5P5ak7FDeIOgGhw7LMvy0HFBHsPQ0S+8pdr+33xdmLfyp15VvYqqyjHsfdReCxr9ubcj35Xgps+L0Uz4utOcZlOwMxTckYq03nMtk1dM0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE4vMig+PT9w/TWht/8ag5I1tSRWJbwagzweBV6jHJo=;
 b=AV9Q4p05nM9Pv29F41zeFmt+FjyDgCVY5Ydn3/0X2NXWdiQv7slcBLTXKkzoBRBYY24+BdmZnA3MoSJvUwsvwW17eb4mjLJyCkYGATbjK6uETgAj33abogt6LAAdncR+Vs/8rDl3ABesThEP+7B/6d7YoYvcZJ8iTf1ltm3VOu3NHEkne2WFUBBzN0Kb5JXpg62O2c2erKpcuN1cwMRGZpsIcXx7mJ2Af51jmwOmGU2jiRiOfp7NuILE4XuuzQvQwFVxKslOki/lv+FHEqY/gOVHgldp/uEbVr5QpBxIVe7tHMGA+RkhkYjseVlRqYO3v8IwLA2vPyVqpKTkxjZPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE4vMig+PT9w/TWht/8ag5I1tSRWJbwagzweBV6jHJo=;
 b=vYzuoVdffQGDO9aBkeSMUdYnukM4DWn9Sd7yFmqe5yfIXK7z3Lvqb+NjnEjYExWtP+W2v3SsA5X3qq5l4DgS9ykWT5xF4BlhVyvH0enDt3I6WSyhgVAWlp4mJf0UbUshBqTIJOk8geh0OE9Gj+8b6FBShi3W6vlULLafLtprHT0=
Received: from BYAPR07MB5110.namprd07.prod.outlook.com (20.176.255.14) by
 BYAPR07MB5317.namprd07.prod.outlook.com (20.177.124.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 20 Dec 2019 09:43:38 +0000
Received: from BYAPR07MB5110.namprd07.prod.outlook.com
 ([fe80::e4c9:23b3:78c1:acdd]) by BYAPR07MB5110.namprd07.prod.outlook.com
 ([fe80::e4c9:23b3:78c1:acdd%6]) with mapi id 15.20.2559.012; Fri, 20 Dec 2019
 09:43:37 +0000
From:   Yuti Suresh Amonkar <yamonkar@cadence.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Subject: RE: [RESEND PATCH v1 14/15] dt-bindings: phy: phy-cadence-torrent:
 Add platform dependent compatible string
Thread-Topic: [RESEND PATCH v1 14/15] dt-bindings: phy: phy-cadence-torrent:
 Add platform dependent compatible string
Thread-Index: AQHVsCRiubYlWLU7gEOgxTyYX3jPWafCBXcAgADA4cA=
Date:   Fri, 20 Dec 2019 09:43:37 +0000
Message-ID: <BYAPR07MB5110503F5B2B0A2B9E3E02F5D22D0@BYAPR07MB5110.namprd07.prod.outlook.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
 <1576069760-11473-15-git-send-email-yamonkar@cadence.com>
 <20191219212546.GA30631@bogus>
In-Reply-To: <20191219212546.GA30631@bogus>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 905f2aaa-d6b5-4193-f2cc-08d7853116dc
x-ms-traffictypediagnostic: BYAPR07MB5317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB53172AB26BEFE67AB2DE2009D22D0@BYAPR07MB5317.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(36092001)(199004)(13464003)(189003)(55016002)(9686003)(54906003)(66946007)(316002)(55236004)(5660300002)(7696005)(8676002)(4326008)(52536014)(6506007)(53546011)(478600001)(64756008)(33656002)(107886003)(2906002)(81156014)(86362001)(26005)(81166006)(71200400001)(6916009)(76116006)(66446008)(66476007)(8936002)(66556008)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5317;H:BYAPR07MB5110.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 29GlR+rMwndXG8ccnK5bhzDu6BnNyu/9IQGEXsczSZsCfRsnM5dmijbOxjq4GcivejZEY70Sn2lJUHhQLwLU87DwXz2M0NLRY3tJSFwLzhlE48AedGg8jAFCt9m324kEfbBUJJjV6rAGVbiIqO9siyxYQLWobOAP+eUNHu0GdoFeITtr9aEHw1Y25UAuu8jJa7PCIX3eUVFbvWBuhWdE/5sBoDBllGmuY3qhdFe3I3N8xoAuOVwz88J+v2LYX4LAIoeSSntGmIRtoLVPrriTca7LNC2kuWF1+HVVeOdfSoG3TV/Nnf0s6wfzr+A1h7o0AV9hft6P6iTTsKmpjX4NpIl3ijowUkqSYeIJds2v+NlzeRiZw8YO/reGU6AR7DS5VerRfLhDzKOgm057M6DIZNbmN784LeOWDmXtjLeoG7WqnTm45PzR79473rYE3GwMqwdXTfnHh40TIL6YyZ/8tDkCcXfy5T5kD5w5ttWFjkbOGdOUVAQsCNWxWH3PYfkS8b5XYL2MLPYdyqZUm2K4Yw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905f2aaa-d6b5-4193-f2cc-08d7853116dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 09:43:37.8426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0NuPtchbR+QCR2BKBte/ordnMg1tG9dPGbHmuoQK79IJccgi1fwKeFrtmQg/vmprHZvCUta0FccE0DaMBiaw8tifJJtLkSLTsXOpnZKYcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_08:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, December 20, 2019 2:56
> To: Yuti Suresh Amonkar <yamonkar@cadence.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> kishon@ti.com; mark.rutland@arm.com; jsarha@ti.com;
> tomi.valkeinen@ti.com; praneeth@ti.com; Milind Parab
> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Subject: Re: [RESEND PATCH v1 14/15] dt-bindings: phy: phy-cadence-
> torrent: Add platform dependent compatible string
>=20
> EXTERNAL MAIL
>=20
>=20
> On Wed, Dec 11, 2019 at 02:09:19PM +0100, Yuti Amonkar wrote:
> > Add a new compatible string used for TI SoCs using Torrent PHY.
> >
> > Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> > ---
> >  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 4
> > +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > index 8069498..60e024b 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > +++ b/Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.yaml
> > @@ -15,7 +15,9 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    const: cdns,torrent-phy
> > +    anyOf:
>=20
> Should be an enum or if both strings can be present then you need 2 oneOf
> entries for 1 string and 2 strings.
>

We can have only one compatible string at a time, so should I use like this=
?

compatible:
     enum:
          - cdns,torrent-phy
          - ti,j721e-serdes-10g

> > +      - const: cdns,torrent-phy
> > +      - const: ti,j721e-serdes-10g
> >
> >    clocks:
> >      maxItems: 1
> > --
> > 2.7.4
> >

Thanks & Regards,
Yuti Amonkar
