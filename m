Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000AAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB86206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="X6ehOSDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfH0XzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:55:06 -0400
Received: from mail-eopbgr800080.outbound.protection.outlook.com ([40.107.80.80]:59921
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfH0XzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:55:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B74RvDE4EcBurb+nbJ2Q/0qyO/piUI+DMNcogQLHo6pfT/mvYjXeGyejw6plImd94qdoqs/wOuSK6kSUF85JGcLWFPXIp0e/x8sumoFmpu8Eb02VXjxks+PZu3sOPfFwJYVSyjpz+gLi/AbpElJ3uUI0XUHdj4nMiFXw5zxwz3ihZVIZBHqjT25WIVNGVl2UENGy1a11L2LWh+rpO8K6ExWB4FhgWLnPPTtpWmbLjMuA0xtnAxfDWj+Gtjuld3weci499yARGZhsYFuoPRlbqnBBsladJqWf8OyY3gHLRCMy32ih4/jzkJjnTttnjCMLwHSKVPdUMU/kHovu3u1SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bputIZ0TbPZc2A4zSDCQi/bLMjxAyWl6uw2vh9BPk8=;
 b=FptCXBjXRo3fuXkYHI+kMmZVkchvtBDBXKifMpFUtHal4KZRZ2ipmbnTYpotH+bhoFsl7N0uQzDJfLYr/By9YJEuSEdq65GnKKMtq1Jbe//IvITkw0ReatYJR8GdLxQ0+qiICVHq6qdHL9vCdLLaQgHAF42NxHqcciRWHzz/Ao9JSRcfEzCzIBhidpQiSFg8J8TT4poTWNQ/NvUUbTyN71WvoL3XKg4pvI41LVnJXenddzwaUjoxf6drOltztssTjGXWgO5cFYPJc9cZ1/UVKVvd7XJ5hO20L3hC+JyGhKDzCd6lZuPAeXIFkoqDfXe9ApwQYE+L0c456XEo8HiOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bputIZ0TbPZc2A4zSDCQi/bLMjxAyWl6uw2vh9BPk8=;
 b=X6ehOSDyHaSrJY/j7ANsvzNd+YFP6dROZa3TBIBUCKfhv6SkrXAZVB/SVKXwAdR+yes+F28fyTm7eUl77eBqsuMR7T6SSDFEJR83KCDIiLWTzKkiQNcOT4QTiqh6qbGdDasAsQr9JB/pEJOTWM+qSlLTbnKp7/mTKzaKXq8oeSc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4454.namprd05.prod.outlook.com (52.135.203.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.14; Tue, 27 Aug 2019 23:55:02 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d%3]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 23:55:02 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH v2 2/3] x86/mm/tlb: Defer PTI flushes
Thread-Topic: [RFC PATCH v2 2/3] x86/mm/tlb: Defer PTI flushes
Thread-Index: AQHVWkMLtq80nSu65U6cmIhUDbm/8KcPpWwAgAALu4A=
Date:   Tue, 27 Aug 2019 23:55:01 +0000
Message-ID: <154B90AD-7EC3-4B86-8061-D737A948A77C@vmware.com>
References: <20190823225248.15597-1-namit@vmware.com>
 <20190823225248.15597-3-namit@vmware.com>
 <CALCETrX91RqYsetbTjfrsMHH8LhTW=YMPuatHuo0bdTJeejP=Q@mail.gmail.com>
In-Reply-To: <CALCETrX91RqYsetbTjfrsMHH8LhTW=YMPuatHuo0bdTJeejP=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:6d44:2c40:29b9:7215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ed310c8-13a3-4125-44af-08d72b49f9de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4454;
x-ms-traffictypediagnostic: BYAPR05MB4454:
x-microsoft-antispam-prvs: <BYAPR05MB4454EF7232167B25C411415AD0A00@BYAPR05MB4454.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(6116002)(11346002)(2616005)(6486002)(102836004)(53546011)(6916009)(5660300002)(186003)(6512007)(6436002)(8676002)(6506007)(476003)(446003)(486006)(14454004)(46003)(76176011)(54906003)(316002)(2906002)(86362001)(66446008)(64756008)(66556008)(66476007)(76116006)(7736002)(66946007)(71200400001)(8936002)(81156014)(478600001)(33656002)(14444005)(256004)(81166006)(4326008)(53936002)(36756003)(25786009)(71190400001)(6246003)(99286004)(305945005)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4454;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AAgMxG7KcM3c5SXSjtnC8aKrldGws9+dIoB5d0lxxG7xsSMHEGwcYFVgAztot+lsFxgAj6ANAGcDK+g5Ltj7UDS4dlQzRLjZdgKXk3fgzu+R4OyVIQ5H7h5rH/M71Bx/F778IirW6tnsFAkUnLJi5vJVOIzUO6ux529qDS5ERg9oB1IgNPBlvsTsP+K8d+AujOWZ8FvBgVjIp2p6SB8NH/Zvh4K3vQ1b50+EUkCL1lL2neMYPbeFmUeDazllQpu7GiV5kvAK6zHdiODfqmejz5Vm5DT7SJYlwmcNw+uAb6ApHQjNaDSDb7UBqPYao638eGUT235PIEzEdNSNu6n/9QBF/Mx4WUuoyRKfZ7r86Y0+7JFwTrN1sMJNFgW/7EFPAVORkx2Zf6V99qXaqzyAc2PlNTcMyXVFeJDtsmr5SWk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B442341B4645FD45B3467639FB21C33A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed310c8-13a3-4125-44af-08d72b49f9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 23:55:01.9215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olOiqPRoMsUYnnIcYcRWLpov9nyMBApDfLTnEiG0u+m7DRzSJ1/CS0Wv9uhEAcOibqM5s+CqJtLMt2u4d7B3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Aug 27, 2019, at 4:13 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Fri, Aug 23, 2019 at 11:13 PM Nadav Amit <namit@vmware.com> wrote:
>> INVPCID is considerably slower than INVLPG of a single PTE. Using it to
>> flush the user page-tables when PTI is enabled therefore introduces
>> significant overhead.
>>=20
>> Instead, unless page-tables are released, it is possible to defer the
>> flushing of the user page-tables until the time the code returns to
>> userspace. These page tables are not in use, so deferring them is not a
>> security hazard.
>=20
> I agree and, in fact, I argued against ever using INVPCID in the
> original PTI code.
>=20
> However, I don't see what freeing page tables has to do with this.  If
> the CPU can actually do speculative page walks based on the contents
> of non-current-PCID TLB entries, then we have major problems, since we
> don't actively flush the TLB for non-running mms at all.

That was not my concern.

>=20
> I suppose that, if we free a page table, then we can't activate the
> PCID by writing to CR3 before flushing things.  But we can still defer
> the flush and just set the flush bit when we write to CR3.

This was my concern. I can change the behavior so the code would flush the
whole TLB instead. I just tried not to change the existing behavior too
much.

