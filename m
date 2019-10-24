Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2899CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F3120856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="icJlli+g";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="icJlli+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437468AbfJXFV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:21:26 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:17349
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408391AbfJXFVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5hAq8j8gBTK5QHkgFUl8QaQUjx95tk8DvfgDASyVRo=;
 b=icJlli+guT/kB0ZNsYRIxzwoj3s7wuiLHgJs37jMKdFGfiG5eh9rOZs1jAvsTlF4XVoaSvQ9oVa6Qi8UYeUnZaLnX9YdNPcVZ6Xo4O1s0giWIpVp0jOFp961ZY/9CwYydABm+bIeHV7OdhTFJRs6YJY116uDnFENhbM53rB5SR0=
Received: from AM4PR08CA0049.eurprd08.prod.outlook.com (2603:10a6:205:2::20)
 by AM6PR08MB3381.eurprd08.prod.outlook.com (2603:10a6:20b:43::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Thu, 24 Oct
 2019 05:21:15 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by AM4PR08CA0049.outlook.office365.com
 (2603:10a6:205:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Thu, 24 Oct 2019 05:21:15 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Thu, 24 Oct 2019 05:21:15 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Thu, 24 Oct 2019 05:21:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f63c213de579eb30
X-CR-MTA-TID: 64aa7808
Received: from e4f631f63c0f.2 (cr-mta-lb-1.cr-mta-net [104.47.12.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 40DC934D-6DB4-436F-88D0-D4552F8FA2D9.1;
        Thu, 24 Oct 2019 05:21:08 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e4f631f63c0f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Oct 2019 05:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2dMKLj+qzwUHG6gJUFlIIinFENvR0UhiYn5Nkpre9Wm+qqkewjrYP9BFM12ZddtZr3Zd9Pa3BhR4l/fspKckxv2JfHGq0jUE88u7WK7OQNdYtYFPjS4r1vkS2QkD43L0OX2+L5DEmXSin6hQ0RKA0bWXxsbu2wHBdRzk9sj+4D3+43cRC3PJZ8TamZuCiieHp3zqaJivZ4t8JJcnUkZrhml9rzmxgE2nyHdDL+n6Tm1RQhxfVrndPN36ETocsKnSxBr2Du+fH4KxbiOl9mQczZrP+aYHquXxQKamysKTROP5vCuLmfVD1HqMyC5RCbn0vJCs+Z+knT4LK1iPbpgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5hAq8j8gBTK5QHkgFUl8QaQUjx95tk8DvfgDASyVRo=;
 b=eV/lqCPTPV9iR2Xcsp0bFYBiIIfT4xmWHOmr7IplnQuBXsvnXE9CHxfvfrP7XIRM8h+Cly5btxClVmdReMaqluSoZ48/ADmexy2ihKrYWQljX3bm5zH20fR8lLQGTqpO2+RPBMMZjRJbHyKJvzTHwYjBy3Z1p7nSSy9bZD1UMPFh1oxQIwraSmhR7/9tp5bFMf8AXF+R5K/E49LjG/FoET72ftw1NALlIagPeLCaHSmoq6o79XADtr9cxZA3oG7foTMb5VQHAYBTUbBqwe8SXbhasgW/JjlVUZ3y+JOMMnfxDKHwRVW0IFdTHLsVXsNryF2MDo1mRT3vMWLNu9I+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5hAq8j8gBTK5QHkgFUl8QaQUjx95tk8DvfgDASyVRo=;
 b=icJlli+guT/kB0ZNsYRIxzwoj3s7wuiLHgJs37jMKdFGfiG5eh9rOZs1jAvsTlF4XVoaSvQ9oVa6Qi8UYeUnZaLnX9YdNPcVZ6Xo4O1s0giWIpVp0jOFp961ZY/9CwYydABm+bIeHV7OdhTFJRs6YJY116uDnFENhbM53rB5SR0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5021.eurprd08.prod.outlook.com (20.179.30.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 05:21:07 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2367.022; Thu, 24 Oct 2019
 05:21:07 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVfmX7+sBzYHhR8EiYyRUjNjETp6dddmWAgAAIg4CAALRsAIAAV3gAgAAhhoCAAAegAIAADuyAgAephQCAAAHAAIAAAKMAgALqEYA=
Date:   Thu, 24 Oct 2019 05:21:07 +0000
Message-ID: <20191024052059.GA10569@jamwan02-TSP300>
References: <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191017114137.GC25745@shell.armlinux.org.uk>
 <20191022084210.GX11828@phenom.ffwll.local>
 <20191022084826.GP25745@shell.armlinux.org.uk>
 <CAKMK7uHZ1Lw03LhZVH=oAa92WxZXucqooH1w6SG8HG20+g0Rbg@mail.gmail.com>
In-Reply-To: <CAKMK7uHZ1Lw03LhZVH=oAa92WxZXucqooH1w6SG8HG20+g0Rbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f9e0b0a-aff0-4249-6f9d-08d75841fe32
X-MS-TrafficTypeDiagnostic: VE1PR08MB5021:|VE1PR08MB5021:|AM6PR08MB3381:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3381312476E69369728D8821B36A0@AM6PR08MB3381.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0200DDA8BE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(51444003)(189003)(199004)(66946007)(14454004)(66446008)(71190400001)(71200400001)(966005)(66556008)(478600001)(33716001)(66066001)(6512007)(9686003)(4326008)(6246003)(6306002)(58126008)(66476007)(64756008)(7736002)(33656002)(229853002)(6436002)(6486002)(1076003)(6916009)(316002)(54906003)(11346002)(476003)(386003)(5660300002)(8676002)(446003)(26005)(76176011)(99286004)(52116002)(55236004)(86362001)(305945005)(186003)(53546011)(6506007)(8936002)(81156014)(81166006)(102836004)(6116002)(2906002)(3846002)(486006)(25786009)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5021;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Sh3+K1nlKjCbWws09ySN648Ungv04Hg1ynviINxi4gHic3TGbQVORS7+gOTTjuruA/IDT/6IDv3+IyrQEh85briQuhOOtyB3xEAzB61bS/I27gx7xVRmD3vcjLJ/rzEa5Zyb4Rfymg8sYNwIPE9gzKG5TM3StP5G91tgXmVU6T8880wKuBQP18m0fPx2V/JuVKoTq3893u6Y8xLWyzhfTdhreVPRgKNWzqTC/I2xIAeT3lAVN3S+1P1MUuSv988hDdXPUZNg/qegJOI27z/INEFa+TmOs1YLqEgeyM/urui1fs74QbcPztovHkJwWogAheYYVnjoklpWzznSXUcRlQO20DLFvmOTazjm6ElirCs22+1sM7ByEw01p67RmMHBxS11cG0SJUZE+d8CQsPFQax+nDog4jAAhHVmagLHk/IyKemjRrK6+qXtBoJLfJXXNNz1AiWRqE10XvmsTztSRqtxAjOYfE5QpCrGdXe+k6Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBA8E8164B6F85479ADE603C071C51F4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5021
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(39860400002)(346002)(376002)(1110001)(339900001)(51444003)(189003)(199004)(107886003)(47776003)(6862004)(76176011)(6512007)(6246003)(229853002)(8936002)(14444005)(5660300002)(76130400001)(36906005)(8746002)(50466002)(46406003)(86362001)(6306002)(81156014)(7736002)(2906002)(81166006)(6486002)(70206006)(54906003)(4326008)(9686003)(8676002)(305945005)(316002)(70586007)(58126008)(33716001)(966005)(476003)(1076003)(3846002)(126002)(33656002)(11346002)(446003)(336012)(26826003)(486006)(22756006)(23726003)(6116002)(105606002)(26005)(66066001)(102836004)(53546011)(6506007)(99286004)(14454004)(186003)(478600001)(356004)(25786009)(386003)(97756001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3381;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6552a1e0-83c7-4371-c146-08d75841f8ed
NoDisclaimer: True
X-Forefront-PRVS: 0200DDA8BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGq+gyPjB0gFH4gTI6qCIDeEGe+m5Y1KDN8rQFijuBFx0fwfvv3PnAwa7w7E5C/mlnTZCkFhiEMOWbFF63tO0fLKA00AvCbKIdO59qPdcsGGQ+Eb4cl/ukZjsdUIxF/dvnybzGpwBsENvNxEy52y5IytCiRJfXgGE89zlM+tndXpV2M9o+becSY3qhsl5tgS3RWiFZIRKgUiN02NI6wQcTw7I0g1FF+SeRkvCAc/IM40mO2sT37ZLcUv58ToB+y8WmbLY7Phy61JZ3yFKivwPWujhwPv796ohpp63EXJxkm+e5kiu5YtLGdl8T+nGrPGkQF2eiuKyAjAyL3JEQuAT5DasbmeiuD69P26dP5V2zPoh2Xa78fnXCUNpwPCHerZgi4tkyt227zeExlxl+JDWECYbHaaNfS8OsTsSvrxhHBYYd8MjWj4omMRrPvZTxLmB3i4CoKfQb1kHqEHZePj0GqfPjnzhjFGi5wIihOADGU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 05:21:15.6470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9e0b0a-aff0-4249-6f9d-08d75841fe32
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:50:42AM +0200, Daniel Vetter wrote:
> On Tue, Oct 22, 2019 at 10:48 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Oct 22, 2019 at 10:42:10AM +0200, Daniel Vetter wrote:
> > > On Thu, Oct 17, 2019 at 12:41:37PM +0100, Russell King - ARM Linux ad=
min wrote:
> > > > On Thu, Oct 17, 2019 at 10:48:12AM +0000, Brian Starkey wrote:
> > > > > On Thu, Oct 17, 2019 at 10:21:03AM +0000, james qian wang (Arm Te=
chnology China) wrote:
> > > > > > On Thu, Oct 17, 2019 at 08:20:56AM +0000, Brian Starkey wrote:
> > > > > > > On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Ar=
m Technology China) wrote:
> > > > > > > > On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wro=
te:
> > > > > > > > >
> > > > > > > > > If James is strongly against merging this, maybe we just =
swap
> > > > > > > > > wholesale to bridge? But for me, the pragmatic approach w=
ould be this
> > > > > > > > > stop-gap.
> > > > > > > > >
> > > > > > > >
> > > > > > > > This is a good idea, and I vote +ULONG_MAX :)
> > > > > > > >
> > > > > > > > and I also checked tda998x driver, it supports bridge. so s=
wap the
> > > > > > > > wholesale to brige is perfect. :)
> > > > > > > >
> > > > > > >
> > > > > > > Well, as Mihail wrote, it's definitely not perfect.
> > > > > > >
> > > > > > > Today, if you rmmod tda998x with the DPU driver still loaded,
> > > > > > > everything will be unbound gracefully.
> > > > > > >
> > > > > > > If we swap to bridge, then rmmod'ing tda998x (or any other br=
idge
> > > > > > > driver the DPU is using) with the DPU driver still loaded wil=
l result
> > > > > > > in a crash.
> > > > > >
> > > > > > I haven't read the bridge code, but seems this is a bug of drm_=
bridge,
> > > > > > since if the bridge is still in using by others, the rmmod shou=
ld fail
> > > > > >
> > > > >
> > > > > Correct, but there's no fix for that today. You can also take a l=
ook
> > > > > at the thread linked from Mihail's cover letter.
> > > > >
> > > > > > And personally opinion, if the bridge doesn't handle the depend=
ence.
> > > > > > for us:
> > > > > >
> > > > > > - add such support to bridge
> > > > >
> > > > > That would certainly be helpful. I don't know if there's consensu=
s on
> > > > > how to do that.
> > > > >
> > > > > >   or
> > > > > > - just do the insmod/rmmod in correct order.
> > > > > >
> > > > > > > So, there really are proper benefits to sticking with the com=
ponent
> > > > > > > code for tda998x, which is why I'd like to understand why you=
're so
> > > > > > > against this patch?
> > > > > > >
> > > > > >
> > > > > > This change handles two different connectors in komeda internal=
ly, compare
> > > > > > with one interface, it increases the complexity, more risk of b=
ug and more
> > > > > > cost of maintainance.
> > > > > >
> > > > >
> > > > > Well, it's only about how to bind the drivers - two different met=
hods
> > > > > of binding, not two different connectors. I would argue that carr=
ying
> > > > > our out-of-tree patches to support both platforms is a larger
> > > > > maintenance burden.
> > > > >
> > > > > Honestly this looks like a win-win to me. We get the superior app=
roach
> > > > > when its supported, and still get to support bridges which are mo=
re
> > > > > common.
> > > > >
> > > > > As/when improvements are made to the bridge code we can remove th=
e
> > > > > component bits and not lose anything.
> > > >
> > > > There was an idea a while back about using the device links code to
> > > > solve the bridge issue - but at the time the device links code wasn=
't
> > > > up to the job.  I think that's been resolved now, but I haven't bee=
n
> > > > able to confirm it.  I did propose some patches for bridge at the
> > > > time but they probably need updating.
> > >
> > > I think the only patches that existed where for panel, and we only
> > > discussed the bridge case. At least I can only find patches for panel=
,not
> > > bridge, but might be missing something.
> >
> > I had a patches, which is why I raised the problem with the core:
> >
> > 6961edfee26d bridge hacks using device links
> >
> > but it never went further than an experiment at the time because of the
> > problems in the core.  As it was a hack, it never got posted.  Seems
> > that kernel tree (for the cubox) is still 5.2 based, so has a lot of
> > patches and might need updating to a more recent base before anything
> > can be tested.
>=20
>=20
> For reference, the panel patch:
>=20
> https://patchwork.kernel.org/patch/10364873/
>=20
> And the huge discussion around bridges, that resulted in Rafael
> Wyzocki fixing all the core issues:
>=20
> https://www.spinics.net/lists/dri-devel/msg201927.html
>=20
> James, do you want to look into this for bridges?
>=20

Hi Daniel:

It's my honour. but I don't have much time in the next 3 weeks.

And I talked with Mihail, he will help to check this problem.

Thanks
James.
> Cheers, Daniel
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
