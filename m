Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C51BCA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F454222CB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZhYfWgwt";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZhYfWgwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504825AbfJRHvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:51 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:61693
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504792AbfJRHvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaqdWlJszFRjvsBi+yaVGBtEHSJp1eD8AknJn4hJMio=;
 b=ZhYfWgwtljOj20zQK2fiVkH3Fj5kvlQNlydxCb1puxrnVm5dnchaJDay2kOscx1B5qip/znvlx5V0p4gWBrHaGzxjABGHiPsJE2XCDKfLQE3KDK03TNx+L/x+NX+/N7nHTbfdLPLdLPitXhYDFfTIqizh4DqTEyHpZskmGhaI3o=
Received: from VE1PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:803:104::49)
 by AM6PR08MB5126.eurprd08.prod.outlook.com (2603:10a6:20b:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Fri, 18 Oct
 2019 07:51:33 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by VE1PR08CA0036.outlook.office365.com
 (2603:10a6:803:104::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Fri, 18 Oct 2019 07:51:32 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 18 Oct 2019 07:51:29 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 18 Oct 2019 07:51:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 86cd0c72bf13b10b
X-CR-MTA-TID: 64aa7808
Received: from ef9e1f40a546.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E83F7E99-5364-4F93-AEF1-D94FE6CBC0F0.1;
        Fri, 18 Oct 2019 07:51:14 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2054.outbound.protection.outlook.com [104.47.5.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ef9e1f40a546.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Oct 2019 07:51:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eds6RqaGGOSjs+y9t8E9vckoxWww1T+miXzThSwVZcnk9S29yO1XuOk5GtW22NEnwNsZwU09GwKbFf1I33tBmkkSC3t0oVBFKqEo7hREJackMGIjyWkrd9AQZ3PdsTEOyfqTOnMTHfzNAkUw7Z8WMSMuEe4RZ6cwWiOWfzU0/N7lvUlECNOlqgXucW1mzjhR77R/fpbwAU/yXXUScSv8oZmxllH3lHLC69eM0/0QvL+5PYCZe4jqV9Ql0VMV1tEw13Y5MAQZxgzJydacnnaQfqdUMcc4rJfzNuxNaugDUlonE9/7viR0rq+xVSCDgi16/5cphntc72dnmGgNhQb+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaqdWlJszFRjvsBi+yaVGBtEHSJp1eD8AknJn4hJMio=;
 b=fc8oDVd9GjKfXjJnIyFunWeR9Bk8EDWEfUOh1sVJum21fhpcgzPSuM/brdLeR47yADmdwF0K422I7AJSFKWnpHTD9FaukyaeHZwPpyMm4ksNYSzQ/ERKR69dGVkvZk9cH9obQR9+WPyANkvQ6WPSr59TT/wjO6Bx4QOhkNZ9n144985YkHLSSSnq6QWLuWHINt4nEQSh/ZHmsoJB/yLZVf0R+y/djFI5TNGGjYU2UfhbV3VrAn6QJqlvc3pqHoJd/Av/XNKbtjUrp9ytyuVoWFqf1ETdvHxJkN2vhrIuQLezoWPeDuHa1eH98LvAirCmkmeXJbEK7vF30Zt9woMWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaqdWlJszFRjvsBi+yaVGBtEHSJp1eD8AknJn4hJMio=;
 b=ZhYfWgwtljOj20zQK2fiVkH3Fj5kvlQNlydxCb1puxrnVm5dnchaJDay2kOscx1B5qip/znvlx5V0p4gWBrHaGzxjABGHiPsJE2XCDKfLQE3KDK03TNx+L/x+NX+/N7nHTbfdLPLdLPitXhYDFfTIqizh4DqTEyHpZskmGhaI3o=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4910.eurprd08.prod.outlook.com (10.255.114.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 07:51:09 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 07:51:09 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v5 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v5 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVhA09wVtvHgqrOkmWUho1ovfOOaddGi2AgALvSoA=
Date:   Fri, 18 Oct 2019 07:51:09 +0000
Message-ID: <20191018075101.GA19928@jamwan02-TSP300>
References: <20191016103339.25858-1-james.qian.wang@arm.com>
 <20191016103339.25858-2-james.qian.wang@arm.com>
 <2404938.QDdPyV61sH@e123338-lin>
In-Reply-To: <2404938.QDdPyV61sH@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:203:2f::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c1318dbc-4271-490b-816a-08d7539ffcb8
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4910:|VE1PR08MB4910:|AM6PR08MB5126:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5126F290581B6A5022EF3238B36C0@AM6PR08MB5126.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01949FE337
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(366004)(346002)(39860400002)(396003)(376002)(189003)(199004)(229853002)(6436002)(71200400001)(8676002)(6512007)(8936002)(86362001)(55236004)(102836004)(6116002)(478600001)(81166006)(81156014)(66946007)(9686003)(6486002)(186003)(14454004)(6246003)(3846002)(66066001)(66476007)(66446008)(64756008)(66556008)(6862004)(33716001)(71190400001)(256004)(316002)(486006)(52116002)(76176011)(7736002)(305945005)(26005)(99286004)(386003)(4326008)(33656002)(476003)(6636002)(11346002)(2906002)(446003)(54906003)(6506007)(58126008)(25786009)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4910;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gYo44Z7Vw2gYK1hIOIy38fEC18Rx7hx10eN/w/2vPY7xVfO1EgPk+WLFx7Rg2zlrgPy8yRE2aPumyzvK1jn8gyggRFaQZLhc60ArZLvf/PFXlEToQcxuIn/qOC9RQR2K+q3W560if6BjRGCmlSS8ZyveaHcnP+A6OA/bje6KnpYhM6DakTemEbEXv3wiraQiom5H4DqDziaIpOjTQ4SwtklApdFAZ0ixiwh03KVfR/bSThHoNhOlfvswF8+qN7P1lKb1uHLYUN57Eoe3OgnQJ8eWbKuEIdPFlQzw9eVjUW00mZ9AQosetpVj65x1wOKy2afFUQ21X5uWBWtfsiKAlkjW26c6jCeacE65ImJcyNZStbQRvl4PpT4OY3wddm++aJOhkMzo+as9DKaKEKGyVEfu3Z/rWlKzaAujZbHwxo0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7431CF41A5800948AF2E0C43D6CAA3F3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4910
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(7736002)(6486002)(99286004)(86362001)(2906002)(33716001)(70206006)(229853002)(70586007)(76130400001)(6512007)(9686003)(46406003)(76176011)(1076003)(47776003)(5660300002)(6862004)(305945005)(97756001)(50466002)(107886003)(6246003)(66066001)(6506007)(54906003)(386003)(23726003)(63350400001)(58126008)(126002)(4326008)(486006)(6636002)(356004)(3846002)(102836004)(6116002)(81166006)(81156014)(26826003)(478600001)(316002)(33656002)(26005)(476003)(22756006)(8936002)(8746002)(8676002)(186003)(446003)(14454004)(25786009)(336012)(36906005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5126;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 98778f9a-3e92-470b-0e14-08d7539ff006
NoDisclaimer: True
X-Forefront-PRVS: 01949FE337
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dequynY+K+D0cRkZTb21iXQL9k6/2t+LZ99NoyGTUY3PZbWGe2u0PHqwURy/vaAeFEpCyuWnI5Uy7397UDeHRxwH+gHIZGz6LxwZOThGywiihWz2uuMVYq9rbzaC6w90DbJwAg1xyxAFAVzn6Q+GsexuXckMnnGHG9bYguyYYkfJu7tX4xU98JHKTGT+utL0iQXDdWL1fMAHRKfTAKfzfmf/zk4pQb0dO2hPAdMof+MQlgl7jUKjBxfWFqB8gsq1N54Z65z4XtmdzYo1P+riXQsvOHvF0mAo7MGwZTjzsFxS0t4xZsGPkroDLfullLE+zE45JKXZVChYIqLyS/n8Su8dK1pizrSlaSBGzQp0qScScSU21BYF6C5cP2o3dwrEtESwmNd499sFIhDDEaGyoRmvzG3l6SsDccPoGz9WBLBo/X+jW+0Z+ZZonUvv3h1G
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 07:51:29.8688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1318dbc-4271-490b-816a-08d7539ffcb8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:02:03AM +0000, Mihail Atanassov wrote:
> On Wednesday, 16 October 2019 11:34:08 BST james qian wang (Arm Technolog=
y China) wrote:
> > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
> > convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
> > hardware.
> >=20
> > V4: Address Mihai, Daniel and Ilia's review comments.
> > V5: Includes the sign bit in the value of m (Qm.n).
> >=20
> > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  drivers/gpu/drm/drm_color_mgmt.c | 27 +++++++++++++++++++++++++++
> >  include/drm/drm_color_mgmt.h     |  2 ++
> >  2 files changed, 29 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_col=
or_mgmt.c
> > index 4ce5c6d8de99..d313f194f1ec 100644
> > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > @@ -132,6 +132,33 @@ uint32_t drm_color_lut_extract(uint32_t user_input=
, uint32_t bit_precision)
> >  }
> >  EXPORT_SYMBOL(drm_color_lut_extract);
> > =20
> > +/**
> > + * drm_color_ctm_s31_32_to_qm_n
> > + *
> > + * @user_input: input value
> > + * @m: number of integer bits, include the sign-bit, support range is =
[1, 32]
>=20
> Any reason why numbers like Q0.32 are disallowed? In those cases, the
> 'sign' bit and the first fractional bit just happen to be the same bit.
> The longer I look at it, the more I think mentioning a 'sign-bit' here
> might confuse people more, since 2's complement doesn't have a
> dedicated bit just for the sign. How about reducing it simply to:

No, since the value is signed there must be dedicated sign-bit.

consider very simple 2 bit signed, Q1.1

 0.5  is 01
 0    is 00
-0.5  is 11
-1.0  is 10, sign-bit and value share same bit, but it is integer part.

See the wiki:

One convention includes the sign bit in the value of m,[1][2] and the other=
 convention
does not. The choice of convention can be determined by summing m+n. If the=
 value is equal
to the register size, then the sign bit is included in the value of m. If i=
t is one
less than the register size, the sign bit is not included in the value of m=
.

So for the 32bit value, all fractional:

a) M include sign-bit: Q1.31
b) M doesn't include sign-bit: Q0.31

>=20
>  * @m: number of integer bits, m <=3D 32.
>=20
> > + * @n: number of fractional bits, only support n <=3D 32
> > + *
> > + * Convert and clamp S31.32 sign-magnitude to Qm.n (signed 2's complem=
ent). The
> > + * higher bits that above m + n are cleared or equal to sign-bit BIT(m=
+n).
>=20
> [nit] BIT(m + n - 1) if we count from 0.

do we real need to consider this, convert to (Q1.0) :)
I think it can be easily caught by review.
>=20
> > + */
> > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > +				      uint32_t m, uint32_t n)
> > +{
> > +	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> > +	bool negative =3D !!(user_input & BIT_ULL(63));
> > +	s64 val;
> > +
> > +	WARN_ON(m < 1 || m > 32 || n > 32);
> > +
> > +	/* the range of signed 2's complement is [-2^(m-1), 2^(m-1) - 2^-n] *=
/
> > +	val =3D clamp_val(mag, 0, negative ?
> > +				BIT_ULL(n + m - 1) : BIT_ULL(n + m - 1) - 1);
> > +
> > +	return negative ? -val : val;
> > +}
> > +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> > +
> >  /**
> >   * drm_crtc_enable_color_mgmt - enable color management properties
> >   * @crtc: DRM CRTC
> > diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.=
h
> > index d1c662d92ab7..60fea5501886 100644
> > --- a/include/drm/drm_color_mgmt.h
> > +++ b/include/drm/drm_color_mgmt.h
> > @@ -30,6 +30,8 @@ struct drm_crtc;
> >  struct drm_plane;
> > =20
> >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_preci=
sion);
> > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > +				      uint32_t m, uint32_t n);
> > =20
> >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> >  				uint degamma_lut_size,
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
