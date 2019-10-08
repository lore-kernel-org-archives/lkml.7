Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA91C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2290206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Tgelro89";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Tgelro89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfJHK2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:28:52 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:53732
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729790AbfJHK2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPNGZySh5tbQWwzpDrCrSOF1r9jnKxKVQYd9aaqlqQ4=;
 b=Tgelro89Wl+I6PrlZzegY9NEjXPrW6x3AkXHsdBXSDeW5tfiscz9EisQdYhi57c0bJZxjHMYOXy6HsH9SIzLSnMB7eryWHHGR7W7l1A9mW210l3wnq7hl4elCA4dHehcFOzGJy9fOpHtNVn8MoRnEF+8Q0lHXVVf/xSKn7hJ8rM=
Received: from VE1PR08CA0009.eurprd08.prod.outlook.com (2603:10a6:803:104::22)
 by AM6PR08MB5030.eurprd08.prod.outlook.com (2603:10a6:20b:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 10:28:39 +0000
Received: from DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VE1PR08CA0009.outlook.office365.com
 (2603:10a6:803:104::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 8 Oct 2019 10:28:39 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT028.mail.protection.outlook.com (10.152.20.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 10:28:37 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 08 Oct 2019 10:28:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fcdc1b926c903599
X-CR-MTA-TID: 64aa7808
Received: from 7d1a11ecc814.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3E5DA66B-3A34-46F3-988A-BD55F1132A2D.1;
        Tue, 08 Oct 2019 10:28:28 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7d1a11ecc814.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Oct 2019 10:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJbZCaggQ1QpRxU0JAyjSuqjHKebOGRPp993iLpd0DZg+Ioah8DPHqUEhB+KmmW7RJzssvklJ9/Unp5W4yYD9+Ar6P4ZtSSVxXqP7fIfK1t/WqE/FuQbLubI0I1C9J2WP/uH9OScguBGRXqIK20Vppp6IDG/Rwj7QezWV9/2WwTwGTFgDBaaElt7k7bOfP5wKerP+wWT9gH7Za7NjRxB88/kdG+tmE8k8lZWEYyS4MiivndCBXyubmZe/kO3Kwpvrw1zEmrQ1Y5v846vXx7Hf8kOjBm1+Uf1OfnwNxgD+wS5gtZKHG20kr4FV8VKAJYbfBfGAUKOcAV2z66AImiVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPNGZySh5tbQWwzpDrCrSOF1r9jnKxKVQYd9aaqlqQ4=;
 b=Z6l1YIVVuURy05eLeQEWP4yhOFzXaDPaPHefQd2P0SMfiWj+jlRzO4+yUV85JCyOkmoszcq4zqQTn+vmsVMX2Juf1b0dR69E5kFchTET+cer7m0HDiG4xKKn+FbU1ZHxVkhm59FV9EWAjaztNIfxDzRLu4hm1iX/TOflRisaPfoFMPBZmWShr4cG5HSYudVnOTzH9tRRjrNC3p0IewF3PyccpYSCasF/Zcz2Ff+M2tH+77i+x5VYFPAFUTxR8JFl3iBvqYm3dQ0l3ELctM57tpgUWHr+cwazkm4Tv0N1yTFf2gFEsapqHpdjc2nR2hY3seaKFllhiIcBw1viOJRZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPNGZySh5tbQWwzpDrCrSOF1r9jnKxKVQYd9aaqlqQ4=;
 b=Tgelro89Wl+I6PrlZzegY9NEjXPrW6x3AkXHsdBXSDeW5tfiscz9EisQdYhi57c0bJZxjHMYOXy6HsH9SIzLSnMB7eryWHHGR7W7l1A9mW210l3wnq7hl4elCA4dHehcFOzGJy9fOpHtNVn8MoRnEF+8Q0lHXVVf/xSKn7hJ8rM=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB4366.eurprd08.prod.outlook.com (20.179.27.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 10:28:25 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9%4]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 10:28:24 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
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
Subject: Re: [PATCH] drm/komeda: Set output color depth for output
Thread-Topic: [PATCH] drm/komeda: Set output color depth for output
Thread-Index: AQHVfblD7I+ubO1huUCp0qQz7Z0Q4adQfC0AgAAOlYA=
Date:   Tue, 8 Oct 2019 10:28:24 +0000
Message-ID: <20191008102818.GB16398@lowli01-ThinkStation-P300>
References: <20191008091734.19509-1-lowry.li@arm.com>
 <20191008093608.eyr5ygc2lkkaaqia@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191008093608.eyr5ygc2lkkaaqia@DESKTOP-E1NTVVP.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 22d36424-a984-4066-c104-08d74bda47ee
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4366:|VI1PR08MB4366:|AM6PR08MB5030:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5030DE9E91AE76942A9DEF619F9A0@AM6PR08MB5030.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:6108;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(33716001)(66066001)(6506007)(66446008)(386003)(66556008)(2906002)(256004)(66946007)(64756008)(66476007)(5660300002)(3846002)(81166006)(81156014)(8936002)(8676002)(6116002)(86362001)(4326008)(6862004)(71200400001)(71190400001)(14444005)(1076003)(486006)(6636002)(476003)(11346002)(446003)(14454004)(186003)(305945005)(7736002)(6436002)(6486002)(9686003)(58126008)(6246003)(52116002)(102836004)(55236004)(26005)(229853002)(76176011)(478600001)(6512007)(99286004)(316002)(25786009)(54906003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4366;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2Oq984W2kMQwIBfNEbOj0YlF0aVULdMQqjfOFzBlYYkoD5WbNMEiMKlxmkru9+4L+C/X9uphjqx+/OnUMxiC2MZXzNra/8OSofuJxHo9htfV6jHfO8efHLDnsYzcqKqIzcqjzoFbBE7lmyvnoSt9sGk+aCo97bEhObLj0LFigkmk39gHp9APb1eH15BLw2EtK56DbYvVeYKbIOChMeLlcXc5rlHSCNHm/JBURB7GLSD0pE6AK2D7Z3qWyxkAUAdSpk9zVlG+HXFw6/ou0wGcB5TIOMq4pY4p1MV6UXazcVoKLQIIJ1aAOf6EoBSTn4YJOK++VLO9wU9zHcQEL/rvpBUP4kqk2WzeGkJpQqUgsWA1OQkUw+lReBL/+o1RdsgcE/iWayG9ivMKV2YTCGDZ3aT9ZPXxxaMj3ijcBpX7hlo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <371424AD66FA3C48A41751D5F5BBDE57@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4366
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(8936002)(7736002)(305945005)(22756006)(186003)(26826003)(26005)(229853002)(486006)(478600001)(102836004)(386003)(6506007)(33656002)(70586007)(70206006)(476003)(8676002)(126002)(33716001)(86362001)(6636002)(50466002)(81166006)(81156014)(8746002)(5660300002)(76130400001)(14444005)(6862004)(6246003)(97756001)(66066001)(4326008)(76176011)(47776003)(99286004)(46406003)(25786009)(6486002)(356004)(446003)(63350400001)(54906003)(11346002)(58126008)(1076003)(336012)(14454004)(9686003)(23726003)(6116002)(3846002)(6512007)(2906002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5030;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f2253c33-aebd-4ea4-fb40-08d74bda4014
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdxIbsAMI2GMnyZnAJq68Naa+ld3L6e5QcQOPoHpYvRt1kTk2dn/TzzDk3p99vFR7q24Lt3+x9W5EA8SHn//oKgP+NEwbAxLpmuYzRqhDOxZNg2q/IxaIjZlESBtxklgEK/HjytGHVueeqY/3Nhjgagf6bL0FMkaHORg521XiQjZ9ohzk/vpo4mVYMxq8SOV6m1h9DJ3sOelE+UmppW4rwoyYJYCIjRp29DXKGDrxy1A/3elR7tOAq8GiuC6U88pW10KqfBVBoDYluav4CuOEms1sEeiMeVGaAenBt9vGk9XXn2guT7nirZrRvfsgV+T9SZC6JsL0WS65pL8uJJlFpgl6VIAg8PLrT7ZONPQ9LqW0GwnwZBClzMX9R+6q7K0ryLjo2kGFLMMWTzl8TXYpr/obh7jyoFyIT2A3PRLrHo=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 10:28:37.7086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d36424-a984-4066-c104-08d74bda47ee
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,
On Tue, Oct 08, 2019 at 09:36:09AM +0000, Brian Starkey wrote:
> Hi Lowry,
>=20
> On Tue, Oct 08, 2019 at 09:17:52AM +0000, Lowry Li (Arm Technology China)=
 wrote:
> > Set color_depth according to connector->bpc.
> >=20
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  .../arm/display/komeda/d71/d71_component.c    |  1 +
> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 +++++++++++++++++++
> >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
> >  .../display/komeda/komeda_pipeline_state.c    | 19 ++++++++++++++++++
> >  .../arm/display/komeda/komeda_wb_connector.c  |  4 ++++
> >  6 files changed, 47 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index c3d29c0b051b..27cdb03573c1 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -951,6 +951,7 @@ static void d71_improc_update(struct komeda_compone=
nt *c,
> >  			       to_d71_input_id(state, index));
> > =20
> >  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> > +	malidp_write32(reg, IPS_DEPTH, st->color_depth);
> >  }
> > =20
> >  static void d71_improc_dump(struct komeda_component *c, struct seq_fil=
e *sf)
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 75263d8cd0bd..baa986b70876 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -17,6 +17,26 @@
> >  #include "komeda_dev.h"
> >  #include "komeda_kms.h"
> > =20
> > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > +				  u32 *color_depths)
> > +{
> > +	struct drm_connector *conn;
> > +	struct drm_connector_state *conn_st;
> > +	int i, min_bpc =3D 31, conn_bpc =3D 0;
> > +
> > +	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
> > +		if (conn_st->crtc !=3D crtc_st->crtc)
> > +			continue;
> > +
> > +		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
>=20
> We can have multiple connectors on a single CRTC (e.g. normal +
> writeback), so what's the expected behaviour here in that case?
>=20
> > +
> > +		if (conn_bpc < min_bpc)
> > +			min_bpc =3D conn_bpc;
> > +	}
> > +
> > +	*color_depths =3D GENMASK(conn_bpc, 0);
> > +}
> > +
> >  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *k=
crtc_st)
> >  {
> >  	u64 pxlclk, aclk;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.h
> > index 45c498e15e7a..a42503451b5d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > @@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
> >  		return !!(rotation & DRM_MODE_REFLECT_X);
> >  }
> > =20
> > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > +				  u32 *color_depths);
> >  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st)=
;
> > =20
> >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_d=
ev *mdev);
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index b322f52ba8f2..7653f134a8eb 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -323,6 +323,7 @@ struct komeda_improc {
> > =20
> >  struct komeda_improc_state {
> >  	struct komeda_component_state base;
> > +	u8 color_depth;
> >  	u16 hsize, vsize;
> >  };
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index 0ba9c6aa3708..e68e8f85ab27 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -743,6 +743,7 @@ komeda_improc_validate(struct komeda_improc *improc=
,
> >  		       struct komeda_data_flow_cfg *dflow)
> >  {
> >  	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
> > +	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
> >  	struct komeda_component_state *c_st;
> >  	struct komeda_improc_state *st;
> > =20
> > @@ -756,6 +757,24 @@ komeda_improc_validate(struct komeda_improc *impro=
c,
> >  	st->hsize =3D dflow->in_w;
> >  	st->vsize =3D dflow->in_h;
> > =20
> > +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> > +		u32 output_depths;
> > +		u32 avail_depths;
> > +
> > +		komeda_crtc_get_color_config(crtc_st,
> > +					     &output_depths);
> > +
> > +		avail_depths =3D output_depths & improc->supported_color_depths;
> > +		if (avail_depths =3D=3D 0) {
> > +			DRM_DEBUG_ATOMIC("No available color depths, conn depths: 0x%x & di=
splay: 0x%x\n",
> > +					 output_depths,
> > +					 improc->supported_color_depths);
> > +			return -EINVAL;
> > +		}
> > +
> > +		st->color_depth =3D __fls(avail_depths);
> > +	}
> > +
> >  	komeda_component_add_input(&st->base, &dflow->input, 0);
> >  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > index 2851cac94d86..740a81250630 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > @@ -142,6 +142,7 @@ static int komeda_wb_connector_add(struct komeda_km=
s_dev *kms,
> >  	struct komeda_dev *mdev =3D kms->base.dev_private;
> >  	struct komeda_wb_connector *kwb_conn;
> >  	struct drm_writeback_connector *wb_conn;
> > +	struct drm_display_info *info;
> >  	u32 *formats, n_formats =3D 0;
> >  	int err;
> > =20
> > @@ -171,6 +172,9 @@ static int komeda_wb_connector_add(struct komeda_km=
s_dev *kms,
> > =20
> >  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs=
);
> > =20
> > +	info =3D &kwb_conn->base.base.display_info;
> > +	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
> > +
>=20
> The IPS color depth doesn't really apply to writeback. Maybe we should
> just skip the writeback connector?
>=20
> Thanks,
> -Brian
>=20
Yes, the color depth not apply to writeback. We adds it because:

In the komeda_crtc_get_color_config() will loop all connectors of CRTC
including the wb_conn, since crtc always has wb_conn. If not setting
here, wb_conn->bpc will be set it to 8bit forcely in komeda_crtc_get_color_=
config() which will lead crtc bpc to 8bits all the time. So we are setting =
the
largest supported depth to kwb_conn->bpc here.

> >  	kcrtc->wb_conn =3D kwb_conn;
> > =20
> >  	return 0;
> > --=20
> > 2.17.1
> >=20
