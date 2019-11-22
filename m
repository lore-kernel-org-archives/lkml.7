Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53CF2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ibvbw5YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKVWb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:31:28 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:62571 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKVWb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:31:27 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd861b70000>; Sat, 23 Nov 2019 06:31:19 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 22 Nov 2019 14:31:16 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 22 Nov 2019 14:31:16 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov
 2019 22:31:15 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.55) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 22 Nov 2019 22:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBWockxZ0XPYj6xhMAMYPiuHOab0EN9GPDQDrArP4qgw4qT/OoEEh7ieXuU3Q0/RbGI0tDYDdvbIX3Pk5nZIdH7VkJ15FdJkcctiXJBqSeTJu6k18kIopXRyNn193VSW1cHWln4B8P+L4m+K/ODX1+pQFJfYO69pAzI+Bl1pbFoOXaCAk+fE4JFDwBK5y36kxB2KR97Skh8Nnv0aAu/eN4mBbiIjv6SBS+KfzWC5jv7HgQ0qLvhg5KDv48nVbFJlYycfDgYsnRkcvlSndz3VQ6bxNMAMawKfVLrj4AR/5iFuG5dSyfjdnPfcbLJtRoLUgDzbJf7PelZnev1lUY/T3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Prqh6+t8gEEKWepCKiw7SXcP9gPdduzAx1n49uCII=;
 b=gBRV5ISf7PsyGTZERd5HPyFJEtmBgx3LWVZSB3xIVMtP0aLO3ardoeIKA7kbE+Jx7doeaeUVoyRebrJwHR2+94oXYvLnKfEya0BUtAyO3lDajgotV2oJ9908LiELcC5qzZS4h76cowIMYzf7mj6nUyK+mm+ohqXQNLo7b9g+/nqifJsU31xxfArLWrzHMNEbNmPlvcoAhC6U1dXOmqQuqhx/aZqBG6Bcf0S3vmJv594cZOu+vbrptkigkHYHe7vVPJXA0fvwqA4hPrj2+6mn1CtHJOSy7RriXoFtoXAC3JIUAjRNhBlOSfUaC3xie7+3ANen7IjuF2C31fmZm/uUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3015.namprd12.prod.outlook.com (20.178.55.78) by
 BYAPR12MB2790.namprd12.prod.outlook.com (20.176.255.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 22 Nov 2019 22:31:13 +0000
Received: from BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::9d0d:f8e5:7241:1704]) by BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::9d0d:f8e5:7241:1704%4]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 22:31:12 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     David Rientjes <rientjes@google.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [RFC] mm: Proactive compaction
Thread-Topic: [RFC] mm: Proactive compaction
Thread-Index: AQHVVHvSPOoT6GjwikqO8JNrunJOkacu7k6AgGlwfIA=
Date:   Fri, 22 Nov 2019 22:31:12 +0000
Message-ID: <BYAPR12MB3015C0746B50A129FCDD9E47D8490@BYAPR12MB3015.namprd12.prod.outlook.com>
References: <20190816214413.15006-1-nigupta@nvidia.com>
 <alpine.DEB.2.21.1909161312050.118156@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1909161312050.118156@chino.kir.corp.google.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=nigupta@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-11-22T22:29:59.2507752Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=4bbb62ef-f3fb-47e0-8842-295d058e84d3;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nigupta@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f3bfb9a-a755-4e85-6a7f-08d76f9bae2f
x-ms-traffictypediagnostic: BYAPR12MB2790:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR12MB27909F34E8B2DAC24319EE38D8490@BYAPR12MB2790.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(13464003)(966005)(561944003)(33656002)(86362001)(7696005)(76176011)(3846002)(102836004)(186003)(446003)(229853002)(6116002)(11346002)(66066001)(53546011)(6506007)(2906002)(6436002)(6306002)(55016002)(9686003)(4326008)(26005)(6246003)(7416002)(71200400001)(305945005)(316002)(66476007)(66446008)(64756008)(66556008)(66946007)(76116006)(256004)(14444005)(54906003)(7736002)(71190400001)(6916009)(81166006)(8676002)(8936002)(478600001)(81156014)(5660300002)(52536014)(14454004)(25786009)(99286004)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2790;H:BYAPR12MB3015.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PapLyi1iC9bzdyDrab8guIRcTpzXKtXvI3+o9SarPpySnYyb+fZjnNuyfIYxjxmId56lx13SjfrGq8cbOPDZa/euwAAg7JMy+guFm6Mc+UKshZgjvB7ydogugAftcf/8d7WeRmW7ZHeJJWrpbTXepf3jGol99CzY1Bpw+C3ERiPinAZpl8FORU0/fyCWIs3QOUCrQhB3F7PQawGTswFxFKhqWTtmNP5hpSoYxDdvDWTypm4ltbXedJ4Pw3sQpvKMQcq92FXK4io059zthrJt3a2NxQ64Vx7m0/x6wimuNcP+egr2wr6W7Yf0AKAum95Ad4PnAC/dmsMf4ZqcvRYaedNDDEGQ87NpvqodehUtzUxGtclLc8KCM9Qe552AAeEj25mWgJG9ApXhMFH1j8dnyI25m25MSb3TB/Fw20awFBVvC4L9yisxSIs2hmIr33Kd39f7EH9G/Ycd9Lo5DXflvC+2Jc/8AGuxYO3r8fm8+rU=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3bfb9a-a755-4e85-6a7f-08d76f9bae2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 22:31:12.6902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSsZQ+ftQqZw7zESnDWUJwwA8wyLRy/1kjD04DVW6qvRKpeYgdJfXkHiPx0TbKdACjvbBYhv9eLPAVsLb4DC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574461880; bh=J2Prqh6+t8gEEKWepCKiw7SXcP9gPdduzAx1n49uCII=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-purlcount:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-ms-exchange-transport-forked:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=ibvbw5YQNcmWxcvKubdPSkLfTLE8k/JeXe1SFAoqkq6YQp/ELmHWFJftOkAJvo6x9
         e9HEWbrr/r3jiAL59uhpbalI1Xz7PYHbnpfDc1p+P9r9bzz4n9b66xHlHhurHCMn9l
         yMSwz5OCMeiNbNrJxhWdIb2aBvOYgJg1+vtKoO+qfm4wStV5ehT0dwHK9a8Q8IKdTg
         NPU9Usb630PBRDEYAvnUx18chX7MO0xlrojgp3/RtDQ8zSYYupilxp8Symv1+6Xy17
         FB5HIE+MCLCkeBep4RbvPZFLlspHjDkJAO+/wk7TR8ArYyqplMMqrzOE/YAkCodDeD
         K3WdMf4rvZZlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: owner-linux-mm@kvack.org <owner-linux-mm@kvack.org> On Behalf
> Of David Rientjes
> Sent: Monday, September 16, 2019 1:17 PM
> To: Nitin Gupta <nigupta@nvidia.com>
> Cc: akpm@linux-foundation.org; vbabka@suse.cz;
> mgorman@techsingularity.net; mhocko@suse.com;
> dan.j.williams@intel.com; Yu Zhao <yuzhao@google.com>; Matthew Wilcox
> <willy@infradead.org>; Qian Cai <cai@lca.pw>; Andrey Ryabinin
> <aryabinin@virtuozzo.com>; Roman Gushchin <guro@fb.com>; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>; Kees Cook
> <keescook@chromium.org>; Jann Horn <jannh@google.com>; Johannes
> Weiner <hannes@cmpxchg.org>; Arun KS <arunks@codeaurora.org>; Janne
> Huttunen <janne.huttunen@nokia.com>; Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru>; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org
> Subject: Re: [RFC] mm: Proactive compaction
>=20
> On Fri, 16 Aug 2019, Nitin Gupta wrote:
>=20
> > For some applications we need to allocate almost all memory as
> > hugepages. However, on a running system, higher order allocations can
> > fail if the memory is fragmented. Linux kernel currently does
> > on-demand compaction as we request more hugepages but this style of
> > compaction incurs very high latency. Experiments with one-time full
> > memory compaction (followed by hugepage allocations) shows that kernel
> > is able to restore a highly fragmented memory state to a fairly
> > compacted memory state within <1 sec for a 32G system. Such data
> > suggests that a more proactive compaction can help us allocate a large
> > fraction of memory as hugepages keeping allocation latencies low.
> >
> > For a more proactive compaction, the approach taken here is to define
> > per page-order external fragmentation thresholds and let kcompactd
> > threads act on these thresholds.
> >
> > The low and high thresholds are defined per page-order and exposed
> > through sysfs:
> >
> >   /sys/kernel/mm/compaction/order-[1..MAX_ORDER]/extfrag_{low,high}
> >
> > Per-node kcompactd thread is woken up every few seconds to check if
> > any zone on its node has extfrag above the extfrag_high threshold for
> > any order, in which case the thread starts compaction in the backgrond
> > till all zones are below extfrag_low level for all orders. By default
> > both these thresolds are set to 100 for all orders which essentially
> > disables kcompactd.
> >
> > To avoid wasting CPU cycles when compaction cannot help, such as when
> > memory is full, we check both, extfrag > extfrag_high and
> > compaction_suitable(zone). This allows kcomapctd thread to stays
> > inactive even if extfrag thresholds are not met.
> >
> > This patch is largely based on ideas from Michal Hocko posted here:
> > https://lore.kernel.org/linux-
> mm/20161230131412.GI13301@dhcp22.suse.cz
> > /
> >
> > Testing done (on x86):
> >  - Set /sys/kernel/mm/compaction/order-9/extfrag_{low,high} =3D {25, 30=
}
> > respectively.
> >  - Use a test program to fragment memory: the program allocates all
> > memory  and then for each 2M aligned section, frees 3/4 of base pages
> > using  munmap.
> >  - kcompactd0 detects fragmentation for order-9 > extfrag_high and
> > starts  compaction till extfrag < extfrag_low for order-9.
> >
> > The patch has plenty of rough edges but posting it early to see if I'm
> > going in the right direction and to get some early feedback.
> >
>=20
> Is there an update to this proposal or non-RFC patch that has been posted
> for proactive compaction?
>=20

I recently posted a non-RFC patch for proactive compaction:

https://lkml.org/lkml/2019/11/15/1099

Please let me know if you try it out or if you have any feedback.

Thanks,
Nitin



> We've had good success with periodically compacting memory on a regular
> cadence on systems with hugepages enabled.  The cadence itself is defined
> by the admin but it causes khugepaged[*] to periodically wakeup and invok=
e
> compaction in an attempt to keep zones as defragmented as possible
> (perhaps more "proactive" than what is proposed here in an attempt to kee=
p
> all memory as unfragmented as possible regardless of extfrag thresholds).
> It also avoids corner-cases where kcompactd could become more expensive
> than what is anticipated because it is unsuccessful at compacting memory =
yet
> the extfrag threshold is still exceeded.
>=20
>  [*] Khugepaged instead of kcompactd only because this is only enabled
>      for systems where transparent hugepages are enabled, probably better
>      off in kcompactd to avoid duplicating work between two kthreads if
>      there is already a need for background compaction.

