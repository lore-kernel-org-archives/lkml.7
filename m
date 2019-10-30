Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC8420874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AAEl3V1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfJ3DK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 23:10:27 -0400
Received: from mail-eopbgr820114.outbound.protection.outlook.com ([40.107.82.114]:61408
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbfJ3DK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 23:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdFRG1GRMpGGgxM8TgZL/6Ehaoi8RyygtC5mnD23sOACwdbEOLm/2bzsH3bF85DtZewNOuxlv05jmzUnNDZKPlEAx2XsqpYq7JREjE8YIjtaOzOUX7tXV4JUZ7939UAaOxQTVUj9DeOiEVkryDjDFtkJpRr4WSVbJK//4oykPONqTsrVk9cg68xtgoHni8pZ90xNGUAQtfZ2YyD9/WeKX0bi88TRjSgrjwW450e/d6zX15UmFxoy+YgnSJsxA0YTeh/oAQEdJgTNe/KpORKN7JO/MCD8eHV3VO5reBImRS2K7P7U835OCOTDs4wd2WWBxlOGu/fncMY5ZQYdaJzeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OCst72IAltq51oAqdaRvFgX7tKcJ3FVSJdMU8zr4nk=;
 b=D1WITrC5xznWFPaMxG4gOh2g2J3mVavliuMAQh2Nj9fziGjTAVTFwxoOC1CKUu9k1XmViZoA+yOlCVpI+MVKTNPF+Oeu0dhlsNg5iQPf+NUwbPuuisdPlqwcftCCgc7/rxOzst4iDeZRgC8gIjr4fck+RgQipP/hja056FrMQ43tkghvrZaBznMiElheJ+Z+rbOg8QtAk0MwRlbTJKJLMyn0f53hcSZIpiXUP3r+OqwwYHd8dqxRbCL7Y4xqxZ1FGrH3qMengz2Z4hw/T9fzC7ar4lhTVp32OFVeUhggR2iWo8Ml3PsLEP1v6fByY59AF/UNKe3RFGXL2WPf9IZzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OCst72IAltq51oAqdaRvFgX7tKcJ3FVSJdMU8zr4nk=;
 b=AAEl3V1L5rT5UDZOtYp3EDwEu7YeQbiS/t8Brm1iUR98nEY+hokK2E8Jugv0ojQkP4Y0DDrv3TB55IgSSVGSr9VFLyyGH/vzSDFOZTWFR2JmuZr96bIwWpAIZhjFY5IKKZJnQY5sqYWOrm8kSIU9BVSwL8XoaHXP0Wbq+HdXyD4=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1219.namprd21.prod.outlook.com (20.179.73.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.8; Wed, 30 Oct 2019 03:10:24 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::61ce:42d2:1a58:7239]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::61ce:42d2:1a58:7239%7]) with mapi id 15.20.2408.016; Wed, 30 Oct 2019
 03:10:24 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Steve MacLean <steve.maclean@linux.microsoft.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] perf inject --jit: Remove //anon mmap events
Thread-Topic: [PATCH 3/4] perf inject --jit: Remove //anon mmap events
Thread-Index: AQHVeWQ56mWbZMuS2UKJ/Lfd6rhxc6dIv9oAgCnrv5A=
Date:   Wed, 30 Oct 2019 03:10:23 +0000
Message-ID: <BN8PR21MB136298F3A0852DAC38E05DB3F7600@BN8PR21MB1362.namprd21.prod.outlook.com>
References: <1570049901-115628-1-git-send-email-steve.maclean@linux.microsoft.com>
 <20191003105716.GB23291@krava>
In-Reply-To: <20191003105716.GB23291@krava>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-30T03:10:22.2971541Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4b46e905-6d17-4bd9-97a8-7e8e04a67f74;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25f7be97-89cc-4087-6135-08d75ce6b4c6
x-ms-traffictypediagnostic: BN8PR21MB1219:|BN8PR21MB1219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB12199D823157B64DE9A2E5AEF7600@BN8PR21MB1219.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(52314003)(54094003)(199004)(189003)(66066001)(229853002)(102836004)(8990500004)(7696005)(2906002)(446003)(54906003)(256004)(110136005)(11346002)(478600001)(10290500003)(74316002)(52536014)(14454004)(33656002)(5660300002)(6506007)(4744005)(10090500001)(486006)(76176011)(476003)(66946007)(316002)(3846002)(8936002)(99286004)(81156014)(55016002)(86362001)(81166006)(9686003)(8676002)(186003)(26005)(6246003)(22452003)(1511001)(71200400001)(66556008)(305945005)(71190400001)(7736002)(4326008)(76116006)(64756008)(66446008)(6116002)(66476007)(6436002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1219;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLiEBTNeGAptcAIJIpBsGSf2iLDo9XpuUuxJGNejz/6dJnEQmPJnc0dNgvQaWLBY3k+kooEXwrG+MzZ8GP4glXro7rhYdQUbgX0XZVWSD9181ODm0ci6yW4sZvLG+jhYZObIcGDUI3bO7E0wmVAYFuURY0FaAUxqrzAeYDcMbrRFVnk2p+bofaLBqunkLX4pTQAAf/GCxn7MV0k0xqH42G/d9FPEumB2NVe8xl+kRiFJ+dNPtZo39il9yq77CX48ixv+QvxnBxcbt1se1WOCUGz538sI4h0xa8i4ffvKNhmnwZ/r6iWCO9GbPANBEOC6DmVsjWeQ3nlRZG4hnAvRd+cpGmNDB8u2x/o1z48jMnSjv9t3StylE3Xwrn68zB0j0RKQ91T3G/LDZt3OMbwxM2KWqtZGemgP/ZBgzKR0M52M1luJ3YTwL/b3RFBj5+sF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f7be97-89cc-4087-6135-08d75ce6b4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 03:10:24.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNvkKYGqhmZVULJ0tNCxQB/1W9UX+G8SzCSGyGwCQ4gvISm3FLy4y0u6ZE1r082byslDj2Pp6UymC2WAomtpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> anyway, I wonder if you could just use thread::priv flag for that, like:
>
>  thread =3D machine__findnew_thread(machine, pid, pid);
>  if (!thread)
>    bad
>
>  (int) thread->priv =3D 1;
>
> and check on thread->priv when ruling the pid out, should be faster then =
maintain rb tree
>
> thanks,
> jirka

I agree reusing the existing data structure is a better approach. I have dr=
afted a change reusing the void* priv field. It seems looks like it is curr=
ently safe to use during perf inject.

I will test it tomorrow then send the new patch
