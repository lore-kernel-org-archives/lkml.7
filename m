Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156F9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB42B2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dNSlLZPB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dNSlLZPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfJOKIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:08:14 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:4368
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbfJOKIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJjFVD/1IUqcd1WEqRaflOr0mBmZvSltw5iQOvjQDe4=;
 b=dNSlLZPBpcLVA6TDfRCHYPpKVEMGxHg923HOYFPYubxYNjwE4lnNiNx1E+6SmV7QCK0TGHK6wcYOGxCdjD6GBr4usiB2Ftroek00WgNpom5oxMDhqb0iEb4uIQ/mPN7JS+miTvBo2kdwC7GRHde7I0mudE8MZpBY8nH/SBSIrFA=
Received: from VI1PR0801CA0079.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::23) by VE1PR08MB4766.eurprd08.prod.outlook.com
 (2603:10a6:802:a9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Tue, 15 Oct
 2019 10:06:25 +0000
Received: from AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR0801CA0079.outlook.office365.com
 (2603:10a6:800:7d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 10:06:25 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT038.mail.protection.outlook.com (10.152.17.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 10:06:23 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Tue, 15 Oct 2019 10:06:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 83e296d17dcb401e
X-CR-MTA-TID: 64aa7808
Received: from eac64756631c.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 03D616CD-62E2-41DE-AF9C-8FAFEF5249D2.1;
        Tue, 15 Oct 2019 10:06:14 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eac64756631c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 10:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkqLGvspB/hYaUsJ9ulhp2mw9vh91iz3YQhBTP9mrDRWv8Nzf6VoKLSwGsi9fOtDgGK2Tcj63knO9Ue7HmzIMOopTNeEDL9JXVIyGw/DKNxicTv+aIxcvUvu6xUU19WCqybzQdGRuLdZlBLxP+7nWYRiZ5I3KzQy2gWbtb8Zz5dTBQiZOKzqOSyjXwu6NlfMrExCJUJZBmLQIBeAqFnvBffyHLhK6fNK2xFCNIBWnaX9hKqmKQCShmAVyzlNq9AqQp7dDX6ofjkGHLiMn7hDJS6DVsV7HKwKbqf2xQsETkjaD3MA86y28OUpWnz5ud43zJcW2ml8Te12PRsupEF04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJjFVD/1IUqcd1WEqRaflOr0mBmZvSltw5iQOvjQDe4=;
 b=JY41AfQHKQde7gNznDHWoERRYQCR5dY8/Rv4y/ptE4varAQ5KhqK0WXlwUIadl7QYzb9cjMByWRdC0INIh0dfiEYFi46HCgi2A9lQF4XLyw4+ceGsyAWIhv246P/j0QCCDxTXNVKngeer3Q1OfzZCZ8YZIQNn1s7BleHQLssFh6fQD790PgYU6guBrlhmd20SoLjVsPG00ixaQbjHybU70syQTl6caHNfVj+vqcRzD+7JIMyjtOq7p6w7OF7xm14rzTNOShlmDXJnC5TX6HTsJDEkefihx6yig1CIXemUTBU4tqeG1YN6bb/fwpXLSRic9FLaDRyqi7BdEAcZoggHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJjFVD/1IUqcd1WEqRaflOr0mBmZvSltw5iQOvjQDe4=;
 b=dNSlLZPBpcLVA6TDfRCHYPpKVEMGxHg923HOYFPYubxYNjwE4lnNiNx1E+6SmV7QCK0TGHK6wcYOGxCdjD6GBr4usiB2Ftroek00WgNpom5oxMDhqb0iEb4uIQ/mPN7JS+miTvBo2kdwC7GRHde7I0mudE8MZpBY8nH/SBSIrFA=
Received: from VE1PR08MB5182.eurprd08.prod.outlook.com (20.179.31.89) by
 VE1PR08MB5184.eurprd08.prod.outlook.com (20.179.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Tue, 15 Oct 2019 10:06:12 +0000
Received: from VE1PR08MB5182.eurprd08.prod.outlook.com
 ([fe80::a54d:cc87:644c:e3ba]) by VE1PR08MB5182.eurprd08.prod.outlook.com
 ([fe80::a54d:cc87:644c:e3ba%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 10:06:12 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc5MiiAgADp5ICAAhFyAIACqBcAgAVBDQCAF4p+gA==
Date:   Tue, 15 Oct 2019 10:06:12 +0000
Message-ID: <20191015100605.GA26326@lowli01-ThinkStation-P300>
References: <20190920094329.17513-1-lowry.li@arm.com>
 <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
 <20190924021313.GA15776@jamwan02-TSP300>
 <20190925094810.fbeyt7fxvyhaip33@DESKTOP-E1NTVVP.localdomain>
 <20190927022218.GA11732@jamwan02-TSP300>
 <20190930103626.de3p6rbowyerjbks@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190930103626.de3p6rbowyerjbks@DESKTOP-E1NTVVP.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0039.apcprd03.prod.outlook.com
 (2603:1096:203:2f::27) To VE1PR08MB5182.eurprd08.prod.outlook.com
 (2603:10a6:803:10c::25)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1613e6e9-03ea-4d4f-6ec5-08d7515755a1
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5184:|VE1PR08MB5184:|VE1PR08MB4766:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB47665E93969E26495C2FC62E9F930@VE1PR08MB4766.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(55236004)(256004)(66446008)(66556008)(8676002)(6636002)(81156014)(14454004)(8936002)(33656002)(64756008)(66476007)(66946007)(66066001)(81166006)(71190400001)(71200400001)(305945005)(99286004)(7736002)(33716001)(4326008)(186003)(26005)(76176011)(52116002)(102836004)(6506007)(6246003)(1076003)(5660300002)(9686003)(6512007)(25786009)(6436002)(6306002)(229853002)(478600001)(6862004)(476003)(6486002)(11346002)(446003)(2906002)(6116002)(3846002)(486006)(966005)(316002)(54906003)(58126008)(86362001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5184;H:VE1PR08MB5182.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Wlht+9gGzV2O5vQezxOuzER5+clz5CYUMog981J9LIADpH1BTo0LjNhTK4iC4eiB8BSKXxOI3jLtNaBLeMndlDSYBQhX3cLxDawAKKhJBI1ruFg/AgmbOs+R7cfNj4YUNHiKkYlanv9MiyRGTnaemJVagqF42TrBKiVA+oH2Hj1CDUCkIKhNuHSewBXuGJg+++VHXalXwStSiK2BnQZrX0FSx1rcepPBhNtarFLXHHMjhAQfsaJ2+5vG90nnpkfnDxp6+qnoKbK8WmfrMZ2/BxNZluYRj1ritUArC7eM1fbLKeiCqzGVfpTgA6jrBAXpR2k4ud9qzWlBPr9b2uTCoKtAmysHsFk57EEkbNPeVxRIFCCZ7F8UZJ3bO7pYBnZi2cFhbgi1768m6PkdMI2aRJaLMicfKDFyzOkebapQdGGRhBg+SNDWg1Q1iGTOVJEyuy4VoDCTgd5gbqAMnN1g8A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <221E5282F0F9EB42B7A16C6296309758@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5184
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(6636002)(356004)(76130400001)(70586007)(70206006)(316002)(36906005)(58126008)(47776003)(54906003)(102836004)(6246003)(33716001)(22756006)(76176011)(97756001)(33656002)(6506007)(26005)(14454004)(7736002)(6862004)(386003)(186003)(66066001)(966005)(478600001)(26826003)(126002)(46406003)(305945005)(336012)(2906002)(99286004)(4326008)(8676002)(6512007)(229853002)(8746002)(6306002)(25786009)(23726003)(3846002)(6116002)(476003)(5660300002)(50466002)(11346002)(446003)(486006)(6486002)(86362001)(9686003)(1076003)(63350400001)(81166006)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4766;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 64ea690a-ff94-4401-7635-08d751574ede
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe0RPIAbVk3NnC/3OajyXun1TUdzin4ttHK8A+/ebJB0gxqjMswqRnHsldvOsFhZwdzImqEBLRMKY6hQMaptvw5KE8JThSHxPa/xXVYwXKoTBjO7ZiwGxcSpEvgc7zunAGYpTOERC+Anw0LQ9HEL/u3xYsKBuXbPhSvbdnZaTY/7KdlYuPIQphdzk5mbnt5ZRNbQf9iTdB+KUWdVMRsdKU3kPktlcSw9hwRl0/rC8mJdSXWdoyIcxmo10SXtx1pMk8VAIDvDDq8ueiJjBNcKqzm1nnFIP1W5XUJUVGVRB42KH8tVnv6CCccS9gM930p8onrjDXqBN6hXJfv7AFfJb4mrj8Fcq0IKWW1bTKB9uAxz8pD0/i0uirZ+Lkif29HZYw2qXdRB5keYR+HvOKiLXEDJ0bftcYJrfbVoOjKY33BlXJnXqi8BCu3/cvuAH3+FDCzfnpEaVknvYXbVkyQiFg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 10:06:23.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1613e6e9-03ea-4d4f-6ec5-08d7515755a1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,
On Mon, Sep 30, 2019 at 10:36:27AM +0000, Brian Starkey wrote:
> On Fri, Sep 27, 2019 at 02:22:24AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > On Wed, Sep 25, 2019 at 09:48:11AM +0000, Brian Starkey wrote:
> > > Hi James,
> > >=20
> > > On Tue, Sep 24, 2019 at 02:13:27AM +0000, james qian wang (Arm Techno=
logy China) wrote:
> > > >=20
> > > > Hi Brian:
> > > >=20
> > > > Since one monitor can support mutiple color-formats, this DT proper=
ty
> > > > supply a way for user to select a specific one from this supported
> > > > color-formats.
> > >=20
> > > Modifying DT is a _really_ user-unfriendly way of specifying
> > > preferences. If we want a user to be able to pick a preferred format,
> > > then it should probably be via the atomic API as Ville mentioned.
> > >
> >=20
> > Hi Brian:
> >=20
> > Agree, a drm UPAI might be the best & right way for this.
> >=20
> > I can raise a new thread/topic to discuss the "HOW TO", maybe after the
> > Chinese national day.
> >=20
> > LAST:
> > what do you think about this patch:
> > - Just drop it, waiting for the new uapi
> > - or keep it, and replace it once new uapi is ready.
>=20
> The bit-depth stuff is clear and non-controversial, so you could split
> that out and merge it.
>=20
> For the YUV stuff, I think it would be fine to merge the
> implementation that we discussed here - force YUV for modes which must
> be YUV, and leave the user-preference stuff for a later UAPI.
>=20
> Thanks,
> -Brian
This patch has been split to two patches and this will be dropped.
Output bit-depth : https://patchwork.freedesktop.org/series/67730/
Output color format: https://patchwork.freedesktop.org/series/68012/

Regards,
Lowry
> >=20
> > Thanks
> > James
> >=20
> > > Cheers,
> > > -Brian
