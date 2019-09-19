Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1096C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BC120882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9mruijbh";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9mruijbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbfISODr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:03:47 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:60759
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732252AbfISODq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV9r3NqvjYe5KgnxzsMtlnnFgb0PAkx3/8wo4YY6kdU=;
 b=9mruijbh/mHAllWMod4LBSaeXJlEosK2Cf+NfM4Wgwj0qE09FiM+OMeM1oa2KBx0Nb22e/FudzeQKh6c5gPOQf6odHSv+fx13Y04TzodfgfmJqBbLnYNDVAOHhXIZSsdgaDMgszBufXCThPuDotRjaCSfbVH+u2L+byV7jAaZG8=
Received: from VE1PR08CA0015.eurprd08.prod.outlook.com (2603:10a6:803:104::28)
 by AM6PR08MB3991.eurprd08.prod.outlook.com (2603:10a6:20b:a8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.23; Thu, 19 Sep
 2019 14:03:36 +0000
Received: from DB5EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by VE1PR08CA0015.outlook.office365.com
 (2603:10a6:803:104::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 19 Sep 2019 14:03:35 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT030.mail.protection.outlook.com (10.152.20.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 14:03:34 +0000
Received: ("Tessian outbound d5a1f2820a4f:v31"); Thu, 19 Sep 2019 14:03:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 59fe04fe57f35db1
X-CR-MTA-TID: 64aa7808
Received: from a6aaa50599c3.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 923AE822-DA90-4D61-ACB4-74500B72BE7E.1;
        Thu, 19 Sep 2019 14:03:25 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a6aaa50599c3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 19 Sep 2019 14:03:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xti6Rdraway7ikWTNWm1eZFjkRGMBNnqTmIxUdmY1JtGUeDqLFDORbsw3AykVpSSGKM3cOBy+QPnA0uBgr6Yy6BrUZlJUmsa9+2YXhbk260/OEHZNRB1rRJZItEXrxF5jLXiskowtJnMSKiJBb5F6oDsDuzRHAkRRR49WT7ntgyhK05GgYFhHNw5rfVgWRClEW+f3H0EgsoD8hkHbUiFSTXA/6rfK/kNCB5cV4V8tMulkL2W0N5ir2UcAUCKSaDT9HT3YFnAAtUSrQaBYQxQ0pryTkVmiTIN6wNN4u2qS2HY2I+GAZtYFhNi6fpf/5MSixypXCb/fra1wX5HyWUKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV9r3NqvjYe5KgnxzsMtlnnFgb0PAkx3/8wo4YY6kdU=;
 b=Su4oc8zSnxIfG/0XZKAGl35n8FASvzeByvLnSflJKQmvFcKQZalOSRGkmAT42PToMsYBPzVQmdCmrL3bwstoe1BjtaSbJpuDDrrKOPZaBv0jMMv+hN7eznWhTNudhNTJ0P/gnHerVIc/neKQclzeZ0ZimSHt+cwoGJWyEzPmXld6I/GQ2anixo1EQrMh4rxdYCH5Y7a1UrZagS31oRU54zql+XATahETPn7BM1RAcpeA5cJz9TsrYLV2SNUKgdMEkc4pSyKy8vFksVyGXWbOo/0nruL07Fy7QdvULnBgwWACJss+8AtFILPBhjnMEHQ4RRWM+gEmmhHV7wT+zf/+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV9r3NqvjYe5KgnxzsMtlnnFgb0PAkx3/8wo4YY6kdU=;
 b=9mruijbh/mHAllWMod4LBSaeXJlEosK2Cf+NfM4Wgwj0qE09FiM+OMeM1oa2KBx0Nb22e/FudzeQKh6c5gPOQf6odHSv+fx13Y04TzodfgfmJqBbLnYNDVAOHhXIZSsdgaDMgszBufXCThPuDotRjaCSfbVH+u2L+byV7jAaZG8=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5479.eurprd08.prod.outlook.com (10.141.174.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 14:03:24 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::c81a:63b1:5826:cf74]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::c81a:63b1:5826:cf74%2]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 14:03:24 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Daniel Stone <daniel@fooishbar.org>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>, Daniel Vetter <daniel@ffwll.ch>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>, nd <nd@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Thread-Topic: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Thread-Index: AQHVZxR6T7KOwVbC3kmqPMMH1PUhIKcv34OAgAFOWACAADZTAIAAnioAgAEVfoA=
Date:   Thu, 19 Sep 2019 14:03:24 +0000
Message-ID: <20190919140323.GA3456@arm.com>
References: <20190909134241.23297-1-ayan.halder@arm.com>
 <20190917125301.GQ3958@phenom.ffwll.local>
 <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com>
 <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
 <CAPj87rOc3MvkjrX1qHpGuVUaGLuZiC7QYBO9v3T2NS+dicLC1g@mail.gmail.com>
In-Reply-To: <CAPj87rOc3MvkjrX1qHpGuVUaGLuZiC7QYBO9v3T2NS+dicLC1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::31) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 17e4d43e-095d-4e78-9daf-08d73d0a2918
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM7PR08MB5479;
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:|AM7PR08MB5479:|AM6PR08MB3991:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB39911C3CFB00A005682D57CEE4890@AM6PR08MB3991.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 016572D96D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(53754006)(189003)(199004)(478600001)(25786009)(256004)(66066001)(2906002)(44832011)(14444005)(316002)(86362001)(6486002)(6436002)(6246003)(7736002)(54906003)(229853002)(476003)(305945005)(5660300002)(486006)(6512007)(76176011)(11346002)(446003)(102836004)(8936002)(6506007)(386003)(6916009)(2616005)(81156014)(186003)(26005)(81166006)(33656002)(8676002)(52116002)(1076003)(99286004)(71190400001)(71200400001)(64756008)(36756003)(66446008)(66556008)(3846002)(6116002)(4326008)(66946007)(66476007)(14454004)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5479;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 45UjFLmTktj259ut57z1uLTKD+CGDsYNRUcDQivsE/3y3+NIz/czy46iemAKfx0tkKW4U9akJGfOMG4sm8E+v8Yp0tvHn/vE0bcjXuTgPVpBgKwqUjlc+i2gISHUxSc7vUN5YavcxTJ7CZikkuSKPTot0CovYCi0ryT4P/pVgVL6KhMwPh4MFsNCWyi2YenGI3idRY8cbjC/AQtwEQ4Q+sKcGEETd0Cv/bGuc7paXtJnWQD378+pVJJyoo1UM/1fXQ7xT+pXiYyBxVOZxFe04SXNYxihEvSgBeHcky4HBFV97zIVTcmBYzLPazmUY/NbEFpmzxeTRphLgz42sjeXNU9z8VxEnhCYFXEjyC/In7etjdgx31WcRgGOTaJO8qwjjv6iC472cGIahiloE8Nx1Gc2mcYcnaBrT/QlzHmojqY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAF5456A58E7B847A350984515AACE6E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(53754006)(199004)(189003)(26005)(107886003)(70586007)(70206006)(186003)(6246003)(46406003)(33656002)(3846002)(6116002)(22756006)(316002)(336012)(6862004)(23726003)(229853002)(50466002)(5660300002)(99286004)(6486002)(6512007)(102836004)(76130400001)(356004)(14444005)(386003)(6506007)(76176011)(8936002)(8676002)(81166006)(86362001)(7736002)(97756001)(305945005)(26826003)(54906003)(4326008)(8746002)(478600001)(81156014)(2906002)(36756003)(25786009)(66066001)(446003)(11346002)(2616005)(476003)(486006)(1076003)(14454004)(47776003)(63350400001)(126002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3991;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: df64c9cb-2e2f-4767-6392-08d73d0a22fe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB3991;
NoDisclaimer: True
X-Forefront-PRVS: 016572D96D
X-Microsoft-Antispam-Message-Info: fy3Z+jaGMXeJiZVbvMpyUJQv+b3aO6kNwZ9x4EYInZUKGpPMxIv9bUOlJciHbO8F2pj+fCXwvZovyefKyJ9kEA/VlUUCLsJVCCOEBJMr8NavF7M/E0oK3XVvkeYjE7tAy3/YFGq+WD1/Mp14zPoIjnbBOw6gqiKb8azDHBFluibfRnWQ/x9D+7D1Wv6hrzv5vAiSW6sKovSVc8++cE7oVapY2tP7UPwA33JCPHtiLMYkamJ8CqZ8i0hrUEr7HHUwHusNDct7F4464+LOLSlgl5m9C0NMH3AVb0igv24/MOBPlCyEHWXm4cOi+JVnA+oL4DNnA3a6CFaEEGrFE7OcEDvFo2JYfxbs3Im8y7c+fpS05uMPTFQLGFPYGd7zdsc9L5v4KeWcmLM0Pxrai71gTpCs4H47lI/r9vscTDs4290=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 14:03:34.4160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e4d43e-095d-4e78-9daf-08d73d0a2918
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3991
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:30:12PM +0100, Daniel Stone wrote:

Hi All,
Thanks for your suggestions.

> Hi Liviu,
>=20
> On Wed, 18 Sep 2019 at 13:04, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > On Wed, Sep 18, 2019 at 09:49:40AM +0100, Daniel Stone wrote:
> > > I totally agree. Framebuffers aren't about the underlying memory they
> > > point to, but about how to _interpret_ that memory: it decorates a
> > > pointer with width, height, stride, format, etc, to allow you to make
> > > sense of that memory. I see content protection as being the same as
> > > physical contiguity, which is a property of the underlying memory
> > > itself. Regardless of the width, height, or format, you just cannot
> > > access that memory unless it's under the appropriate ('secure enough'=
)
> > > conditions.
> > >
> > > So I think a dmabuf attribute would be most appropriate, since that's
> > > where you have to do all your MMU handling, and everything else you
> > > need to do to allow access to that buffer, anyway.
> >
> > Isn't it how AMD currently implements protected buffers as well?
>=20
> No idea to be honest, I haven't seen anything upstream.
>=20
> > > There's a lot of complexity beyond just 'it's protected'; for
> > > instance, some CP providers mandate that their content can only be
> > > streamed over HDCP 2.2 Type-1 when going through an external
> > > connection. One way you could do that is to use a secure world
> > > (external controller like Intel's ME, or CPU-internal enclave like SG=
X
> > > or TEE) to examine the display pipe configuration, and only then allo=
w
> > > access to the buffers and/or keys. Stuff like that is always going to
> > > be out in the realm of vendor & product-policy-specific add-ons, but
> > > it should be possible to agree on at least the basic mechanics and
> > > expectations of a secure path without things like that.
> >
> > I also expect that going through the secure world will be pretty much t=
ransparent for
> > the kernel driver, as the most likely hardware implementations would en=
able
> > additional signaling that will get trapped and handled by the secure OS=
. I'm not
> > trying to simplify things, just taking the stance that it is userspace =
that is
> > coordinating all this, we're trying only to find a common ground on how=
 to handle
> > this in the kernel.
>=20
> Yeah, makes sense.
>=20
> As a strawman, how about a new flag to drmPrimeHandleToFD() which sets
> the 'protected' flag on the resulting dmabuf?

To be honest, during our internal discussion james.qian.wang@arm.com had a
similar suggestion of adding a new flag to dma_buf but I decided
against it.

As per my understanding, adding custom dma buf flags (like
AMDGPU_GEM_CREATE_XXX, etc) is possible if we(Arm) had our own allocator. W=
e
rely on the dumb allocator and ion allocator for framebuffer creation.

I was looking at an allocator independent way of userspace
communicating to the drm framework that the framebuffer is protected.

Thus, it looked to me that framebuffer modifier is the best (or the least
corrupt) way of going forth.

We use ion and dumb allocator for framebuffer object creation. The way
I see it is as follows :-

1. For ion allocator :-
Userspace can specify that it wants the buffer from a secure heap or any ot=
her
special region of heap. The ion driver will either fault into the secure os=
 to
create the buffers or it will do some other magic. Honestly, I have still n=
ot
figured that out. But it will be agnostic to the drm core.

The userspace gets a handle to the buffer and then it calls addFB2 with
DRM_FORMAT_MOD_ARM_PROTECTED, so that the driver can configure the
dpu's protection bits (to access the memory with special signals).

2. For dumb allocator :-
I am curious to know if we can add 'IS_PROTECTED' flag to
drm_mode_create_dumb.flags. This can/might be used to set dma_buf
flags. Let me know if this is an incorrect/forbidden path.

In a nutshell, my objective is to figure out if the userspace is able
to communicate to the drm core about the 'protection' status of the
buffer without introducing Arm specific buffer allocator.

Thanks,
Ayan

> Cheers,
> Daniel
