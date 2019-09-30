Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFC2C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E6A21721
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ki9rlH4P";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ki9rlH4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfI3Jv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:51:59 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:55336
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbfI3Jv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPhTPf5jouzaxkU6CmT9g5wBKpSBXBDjVQlZ7MFikbY=;
 b=Ki9rlH4PcN/R7RalZGwcFOyECLZU7FsAqG49jsjNUt7lKcStGFNqApq8wYgu4/GFTpG3MwnpnomT215MxGL8XN9hOn5SvLuNrPpD4f/X92MNkTkfNM7PFF9nTXkhmx8lKcgDWli+re2OgVtPAMNPHyv8crsRAYCNtdruIBTuKVo=
Received: from AM6PR08CA0011.eurprd08.prod.outlook.com (2603:10a6:20b:b2::23)
 by AM4PR0802MB2179.eurprd08.prod.outlook.com (2603:10a6:200:5c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 09:51:47 +0000
Received: from VE1EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by AM6PR08CA0011.outlook.office365.com
 (2603:10a6:20b:b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Mon, 30 Sep 2019 09:51:46 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT023.mail.protection.outlook.com (10.152.18.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 09:51:46 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 30 Sep 2019 09:51:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: acb176955efe3b9f
X-CR-MTA-TID: 64aa7808
Received: from 44bb75865738.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1DADCC40-96D0-463B-B9E6-A0F05B3826FE.1;
        Mon, 30 Sep 2019 09:51:37 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 44bb75865738.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 09:51:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhhEunOwIzmKRruMDAScDX6Cq2YW0AvO7HkAILs/ZRs/flbewlMd1vHnYcPZROZliDJjIRtreq5HvPOmDtjasgAi50QDE+RCWtYnyGgHViY1mJGkdzWIEQbau4n/oDWi9SqZqbcz9yZ/bXBuqURaHkDeb+/8sMIDXR0QucKdfJvJMJINojcRVLVVFtSZTt2OypUs8inKkYRFn49tOBKhYO6frjBz4vXEX+XPC2P6B6IRvCQCX6GCj+iEix5aeBDL2/5bB2FCBPohIDP6dhQ6UNH0kCQ5nJG5HCvEYy8Vknz8G/glpsSxVhRMBcvtW33jkuk4kI+91owBJ4NERt4r9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPhTPf5jouzaxkU6CmT9g5wBKpSBXBDjVQlZ7MFikbY=;
 b=RZIO8CO509tZIImU6U8B40HvrOJRpdBynzfDPl+0Tgt4pF/fsKH41dh3adGyz17wu0zukmpF4p+sGWwnnRFtUYmZ8DLI3JbmjZxtQICgWfKaZFKLGuwB11JqofNIa3yYVCpuztluBJPnIbWDMhBk+elURt/cg51ZMFwdPxhVsdbN6q7QBrRZCjSMPNveqnlIdsUNnqUkFu0V3O7w+UJ8CqSchBZkhA+xwHMOvBZ/0GkxDWLPEN7Zt81gZenTcDJLzTea0ikpQSW0d0hNSy/4OGXoVA7/3/PEjDmmFCj2CON4L+OwzMraljjzbHbmUCk9PYt448kcvQB5j69UR81qAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPhTPf5jouzaxkU6CmT9g5wBKpSBXBDjVQlZ7MFikbY=;
 b=Ki9rlH4PcN/R7RalZGwcFOyECLZU7FsAqG49jsjNUt7lKcStGFNqApq8wYgu4/GFTpG3MwnpnomT215MxGL8XN9hOn5SvLuNrPpD4f/X92MNkTkfNM7PFF9nTXkhmx8lKcgDWli+re2OgVtPAMNPHyv8crsRAYCNtdruIBTuKVo=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3958.eurprd08.prod.outlook.com (20.179.1.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 09:51:35 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.028; Mon, 30 Sep 2019
 09:51:35 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Thread-Topic: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Thread-Index: AQHVZxR6T7KOwVbC3kmqPMMH1PUhIKcv34OAgAA2WICAAAJKAIAAFqWAgBPsVgA=
Date:   Mon, 30 Sep 2019 09:51:35 +0000
Message-ID: <20190930095134.xjcucw2rrij5f4np@DESKTOP-E1NTVVP.localdomain>
References: <20190909134241.23297-1-ayan.halder@arm.com>
 <20190917125301.GQ3958@phenom.ffwll.local>
 <20190917160730.hutzlbuqtpmmtdz3@e110455-lin.cambridge.arm.com>
 <11689dc3-6c3e-084b-b66d-e6ccf75cb8fb@baylibre.com>
 <CAKMK7uF7oKV4609Ca4mLj7gYC1rkWnWAV7_hM5Z48Ez1cBoMqA@mail.gmail.com>
In-Reply-To: <CAKMK7uF7oKV4609Ca4mLj7gYC1rkWnWAV7_hM5Z48Ez1cBoMqA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LNXP123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::25) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 89cb0eda-133c-482e-56a1-08d7458bced2
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3958:|AM6PR08MB3958:|AM4PR0802MB2179:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB217937671BDC3EA6BD69BDA6F0820@AM4PR0802MB2179.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(199004)(189003)(6436002)(6486002)(66066001)(229853002)(2906002)(587094005)(14444005)(44832011)(486006)(446003)(11346002)(5024004)(476003)(58126008)(71190400001)(99286004)(71200400001)(54906003)(26005)(102836004)(186003)(52116002)(53546011)(316002)(386003)(6506007)(76176011)(6116002)(256004)(81156014)(5660300002)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(81166006)(9686003)(966005)(6306002)(8676002)(14454004)(3846002)(7736002)(8936002)(305945005)(6246003)(86362001)(6916009)(478600001)(4326008)(6512007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3958;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: smIWcOVoK2yQEq0GmGhAvwXtAPbfKky0Vh6kuDYIWPUBA0pI6X6mnpSsGp22yOVYRSMnL74YMySCAYXevksI3lO9ovJGtNySrKIQ1JEdyfmjYlOXxH9UVBOFoZhwFMbnWQg9pJuOX3JzKpKB/hADk+EhQiK+jEOvEzT+6RGMGL2mBg/T9VC1nUUYUJPkQr2XMlQaWDlI0hiAHNxptMvMIi6xrW7FnKI5PX7YY2bzI+bU1QuCYBkLrk9H+J7AoJE2aknMEguEYetQt2VXEhmO/bjEw+DUEd7hvTAe4GFEG83Tt+qBn4ubqNr0p8WvzWNIPlFT/jn2Xjz4ZQqudSAiEhcNpSer35yVWfs+VXTL05tblXor1/W1TKLIp/G0WPk6nIjjcJdITzR0XMl7A2VQdmzRYi4k9PjhZ8M4ZiQdyl+mFbGMiK3OlCYY4xYlyMvDjVJa76h08LMaoVPILu09KQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A0EC6A769066D4DB8227B972297CE24@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3958
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(1110001)(339900001)(199004)(189003)(3846002)(476003)(486006)(8936002)(102836004)(105606002)(14454004)(356004)(2906002)(23726003)(5660300002)(6116002)(47776003)(66066001)(126002)(50466002)(305945005)(8746002)(76176011)(1076003)(966005)(6246003)(81166006)(81156014)(336012)(446003)(6306002)(6862004)(99286004)(9686003)(70586007)(6486002)(76130400001)(53546011)(6506007)(70206006)(22756006)(478600001)(26005)(229853002)(8676002)(26826003)(386003)(7736002)(5024004)(46406003)(11346002)(186003)(97756001)(316002)(14444005)(36906005)(25786009)(587094005)(54906003)(86362001)(4326008)(6512007)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2179;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 91b96540-ad21-4fee-d5b1-08d7458bc7d6
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImRNJ6WuWU3+FbUnJiKo3mpTkeSNS1LMf1iz+gxfkavKdjkFXGY9aQpVbfvghyEG4sj3nFdZWYcNMfkg++KWFpwpK9Zr0DuO4ijm9iqcTJXm0iKMkGYcZ3nV8S/UsDW8wu99kcWDgxrUCWqDH7LF49S+jMoioXDJZoOlWQuTEXkWQgxo+cHUifEtfEKduSB/1Ee0Y1Vh/SKBF6L3HEVUYH3kzFOwpY5+OVC6bpGtcjRJd30x8WZjlqDqQkoE5YTTcnNSo/r+8SRSeeYsCSQIqf8aPpGcibGtk7kGdFYUPvUpnGxOeqnNeG80j8Ooov3kH+81i7tu5KlK2r5VriAqrzgJP+L11YI+m6pzWrzNWggigy179WUqZMAYByjXWY6HFWJyrPucxl/gtiNzz2Wj+yQ+eSTeLeS0vR5UpvOll8dpBC3Rpz6xBuivwNJj7AL6qfc5SElFvdZYq5WmhU0VDQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 09:51:46.7465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cb0eda-133c-482e-56a1-08d7458bced2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 17, 2019 at 07:36:45PM +0200, Daniel Vetter wrote:
> On Tue, Sep 17, 2019 at 6:15 PM Neil Armstrong <narmstrong@baylibre.com> =
wrote:
> >
> > Hi,
> >
> > On 17/09/2019 18:07, Liviu Dudau wrote:
> > > On Tue, Sep 17, 2019 at 02:53:01PM +0200, Daniel Vetter wrote:
> > >> On Mon, Sep 09, 2019 at 01:42:53PM +0000, Ayan Halder wrote:
> > >>> Add a modifier 'DRM_FORMAT_MOD_ARM_PROTECTED' which denotes that th=
e framebuffer
> > >>> is allocated in a protected system memory.
> > >>> Essentially, we want to support EGL_EXT_protected_content in our ko=
meda driver.
> > >>>
> > >>> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > >>>
> > >>> /-- Note to reviewer
> > >>> Komeda driver is capable of rendering DRM (Digital Rights Managemen=
t) protected
> > >>> content. The DRM content is stored in a framebuffer allocated in sy=
stem memory
> > >>> (which needs some special hardware signals for access).
> > >>>
> > >>> Let us ignore how the protected system memory is allocated and for =
the scope of
> > >>> this discussion, we want to figure out the best way possible for th=
e userspace
> > >>> to communicate to the drm driver to turn the protected mode on (for=
 accessing the
> > >>> framebuffer with the DRM content) or off.
> > >>>
> > >>> The possible ways by which the userspace could achieve this is via:=
-
> > >>>
> > >>> 1. Modifiers :- This looks to me the best way by which the userspac=
e can
> > >>> communicate to the kernel to turn the protected mode on for the kom=
eda driver
> > >>> as it is going to access one of the protected framebuffers. The onl=
y problem is
> > >>> that the current modifiers describe the tiling/compression format. =
However, it
> > >>> does not hurt to extend the meaning of modifiers to denote other at=
tributes of
> > >>> the framebuffer as well.
> > >>>
> > >>> The other reason is that on Android, we get an info from Gralloc
> > >>> (GRALLOC_USAGE_PROTECTED) which tells us that the buffer is protect=
ed. This can
> > >>> be used to set up the modifier/s (AddFB2) during framebuffer creati=
on.
> > >>
> > >> How does this mesh with other modifiers, like AFBC? That's where I s=
ee the
> > >> issue here.
> > >
> > > AFBC modifiers are currently under Arm's namespace, the thought behin=
d the DRM
> > > modifiers would be to have it as a "generic" modifier.
>=20
> But if it's a generic flag, how do you combine that with other
> modifiers? Like if you have a tiled buffer, but also encrypted? Or
> afbc compressed, or whatever else. I'd expect for your hw encryption
> is orthogonal to the buffer/tiling/compression format used?

This bit doesn't overlap with any of the other AFBC modifiers, so as
you say it'd be orthogonal, and could be set on AFBC buffers (if we
went that route).

>=20
> > >>> 2. Framebuffer flags :- As of today, this can be one of the two val=
ues
> > >>> ie (DRM_MODE_FB_INTERLACED/DRM_MODE_FB_MODIFIERS). Unlike modifiers=
, the drm
> > >>> framebuffer flags are generic to the drm subsystem and ideally we s=
hould not
> > >>> introduce any driver specific constraint/feature.
> > >>>
> > >>> 3. Connector property:- I could see the following properties used f=
or DRM
> > >>> protected content:-
> > >>> DRM_MODE_CONTENT_PROTECTION_DESIRED / ENABLED :- "This property is =
used by
> > >>> userspace to request the kernel protect future content communicated=
 over
> > >>> the link". Clearly, we are not concerned with the protection attrib=
utes of the
> > >>> transmitter. So, we cannot use this property for our case.
> > >>>
> > >>> 4. DRM plane property:- Again, we want to communicate that the fram=
ebuffer(which
> > >>> can be attached to any plane) is protected. So introducing a new pl=
ane property
> > >>> does not help.
> > >>>
> > >>> 5. DRM crtc property:- For the same reason as above, introducing a =
new crtc
> > >>> property does not help.
> > >>
> > >> 6. Just track this as part of buffer allocation, i.e. I think it doe=
s
> > >> matter how you allocate these protected buffers. We could add a "is
> > >> protected buffer" flag at the dma_buf level for this.

I also like this approach. The protected-ness is a property of the
allocation, so makes sense to store it with the allocation IMO.

> > >>
> > >> So yeah for this stuff here I think we do want the full userspace si=
de,
> > >> from allocator to rendering something into this protected buffers (n=
o need
> > >> to also have the entire "decode a protected bitstream part" imo, sin=
ce
> > >> that will freak people out). Unfortunately, in my experience, that k=
ills
> > >> it for upstream :-/ But also in my experience of looking into this f=
or
> > >> other gpu's, we really need to have the full picture here to make su=
re
> > >> we're not screwing this up.
> > >
> > > Maybe Ayan could've been a bit clearer in his message, but the ask he=
re is for ideas
> > > on how userspace "communicates" (stores?) the fact that the buffers a=
re protected to
> > > the kernel driver. In our display processor we need to the the hardwa=
re that the
> > > buffers are protected before it tries to fetch them so that it can 1)=
 enable the
> > > additional hardware signaling that sets the protection around the str=
eam; and 2) read
> > > the protected buffers in a special mode where there the magic happens=
.
>=20
> That was clear, but for the full picture we also need to know how
> these buffers are produced and where they are allocated. One approach
> would be to have a dma-buf heap that gives you encrypted buffers back.
> With that we need to make sure that only encryption-aware drivers
> allow such buffers to be imported, and the entire problem becomes a
> kernel-internal one - aside from allocating the right kind of buffer
> at the right place.
>=20

In our case, we'd be supporting a system like TZMP-1, there's a
Linaro connect presentation on it here:
https://connect.linaro.org/resources/hkg18/hkg18-408/

The simplest way to implement this is for firmware to set up a
carveout which it tells linux is secure. A linux allocator (ion, gem,
vb2, whatever) can allocate from this carveout, and tag the buffer as
secure.

In this kind of system, linux doesn't necessarily need to know
anything about how buffers are protected, or what HW is capable of -
it only needs to carry around the "is_protected" flag.

Here, the TEE is ultimately responsible for deciding which HW gets
access to a buffer. I don't see a benefit of having linux decide which
drivers can or cannot import a buffer, because that decision should be
handled by the TEE.

For proving out the pipeline, IMO it doesn't matter whether the
buffers are protected or not. For our DPU, all that matters is that if
the buffer claims to be protected, we have to set our protected
control bit. Nothing more. AFAIK it should work the same for other
TZMP-1 implementations.

> > > So yeah, we know we do want full userspace support, we're prodding th=
e community on
> > > answers on how to best let the kernel side know what userspace has do=
ne.
> >
> > Actually this is interesting for other multimedia SoCs implementing sec=
ure video decode
> > paths where video buffers are allocated and managed by a trusted app.
>=20
> Yeah I expect there's more than just arm wanting this. I also wonder
> how that interacts with the secure memory allocator that was bobbing
> around on dri-devel for a while, but seems to not have gone anywhere.
> That thing implemented my idea of "secure memory is only allocated by
> a special entity".
> -Daniel

Like I said, for us all we need is a way to carry around a 1-bit
"is_protected" flag with a buffer. Could other folks share what's
needed for their systems so we can reason about something that works
for all?

Thanks!
-Brian

>=20
> >
> > Neil
> >
> > >
> > > Best regards,
> > > Liviu
> > >
> > >
> > >> -Daniel
> > >>
> > >>>
> > >>> --/
> > >>>
> > >>> ---
> > >>>  include/uapi/drm/drm_fourcc.h | 9 +++++++++
> > >>>  1 file changed, 9 insertions(+)
> > >>>
> > >>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_f=
ourcc.h
> > >>> index 3feeaa3f987a..38e5e81d11fe 100644
> > >>> --- a/include/uapi/drm/drm_fourcc.h
> > >>> +++ b/include/uapi/drm/drm_fourcc.h
> > >>> @@ -742,6 +742,15 @@ extern "C" {
> > >>>   */
> > >>>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> > >>>
> > >>> +/*
> > >>> + * Protected framebuffer
> > >>> + *
> > >>> + * The framebuffer is allocated in a protected system memory which=
 can be accessed
> > >>> + * via some special hardware signals from the dpu. This is used to=
 support
> > >>> + * 'GRALLOC_USAGE_PROTECTED' in our framebuffer for EGL_EXT_protec=
ted_content.
> > >>> + */
> > >>> +#define DRM_FORMAT_MOD_ARM_PROTECTED       fourcc_mod_code(ARM, (1=
ULL << 55))
> > >>> +
> > >>>  /*
> > >>>   * Allwinner tiled modifier
> > >>>   *
> > >>> --
> > >>> 2.23.0
> > >>>
> > >>
> > >> --
> > >> Daniel Vetter
> > >> Software Engineer, Intel Corporation
> > >> http://blog.ffwll.ch
> > >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
>=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
