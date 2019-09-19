Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288A1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0E321848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mHKvC3e4";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mHKvC3e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391135AbfISPNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:13:33 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:56128
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388792AbfISPNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDe4fnpdt0/NxxMC2o+OYJvDeNmXC4tvIz6hILWxmVo=;
 b=mHKvC3e4JsE5FGAYvzmK55HhRxMjxZPBkKN3nMB5TbS0mKyxyCev+EmytxSYiOevDkpHhczYw8ACviZt453IbFLmOoikOTAY0BaR+FO5XZ3GyAoVDqomyBkodeJpqNTNKoKTIPSLPbO44RNPT3KVOv8smWLByWEukZzzD5TCd50=
Received: from VI1PR0801CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::29) by DB7PR08MB3193.eurprd08.prod.outlook.com
 (2603:10a6:5:24::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 19 Sep
 2019 15:13:24 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by VI1PR0801CA0085.outlook.office365.com
 (2603:10a6:800:7d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 19 Sep 2019 15:13:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 15:13:22 +0000
Received: ("Tessian outbound 968ab6b62146:v31"); Thu, 19 Sep 2019 15:13:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f7e7bfd89acc9074
X-CR-MTA-TID: 64aa7808
Received: from d673e86a8d06.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3B291DE2-265F-4034-B709-10FD1FE2E296.1;
        Thu, 19 Sep 2019 15:13:13 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d673e86a8d06.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 19 Sep 2019 15:13:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwrZwFE5DXf88UhVN5ZYiE/ZLB50dVhSu4iN8CBSSVaZIFDuH6DsrlgKn9xApZKAbGEm/5f6mOaq1Br0M3IfMptaKtZJh+GcBUxxsmE//TE20ldhw8IbJZwaBfEut/8DIO/VEzBI1Qt2yh9I9Jai9+cNn6Wt59IyV+7Vr3uNe/gUCanfB2NGeGn/w3gCt4NOSqive4flv5oJfSBoRVzlWOk13D57tI/mp2i8BgM/GY+jMMCc3bS2mKmPG6ZB1NNfdIJ0+ublPVD8gC3kXaBGR8kjQgAHpQiD0WpDuF9ID8PQrH3vJS4qNObrr4OoD4IyHRNLa/OJr8RoRiIj0lxmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDe4fnpdt0/NxxMC2o+OYJvDeNmXC4tvIz6hILWxmVo=;
 b=UNGr8pIOA2med0v4/RrLskn3Fe+TxrqbWvSoHzzBNbh1Y/VMw/UZXFgYHdgK4SQzMTYPg9kZMsA5IHkTjsvIHC1A8V3i4hKBURQrmi/hevRlmHQfKERUQTRJbLiLBs/z/DbyqmZ8PXqTbFxO9awO9YqKntBy56pGostER7Lfxze7qXsqHbuKY/eCIy/pV5M1d4GmXMuU/htzjEkgrH/KPsThwjbPunOrLt2sFoFCEHunU+II0BMObK+6X0ZYYYLi4KrW+c20RsrVQoldTm5ISIbPTDiJq31/6w+Fl0rc2VVx0d2C994dmDh1ZsEPwJEvosilaaky+YgiyUdJVAV+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDe4fnpdt0/NxxMC2o+OYJvDeNmXC4tvIz6hILWxmVo=;
 b=mHKvC3e4JsE5FGAYvzmK55HhRxMjxZPBkKN3nMB5TbS0mKyxyCev+EmytxSYiOevDkpHhczYw8ACviZt453IbFLmOoikOTAY0BaR+FO5XZ3GyAoVDqomyBkodeJpqNTNKoKTIPSLPbO44RNPT3KVOv8smWLByWEukZzzD5TCd50=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5334.eurprd08.prod.outlook.com (10.141.172.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 15:13:12 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::c81a:63b1:5826:cf74]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::c81a:63b1:5826:cf74%2]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 15:13:12 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Daniel Stone <daniel@fooishbar.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>, nd <nd@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Thread-Topic: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Thread-Index: AQHVZxR6T7KOwVbC3kmqPMMH1PUhIKcv34OAgAFOWACAADZTAIAAnioAgAEVfoCAAAILAIAAEXQA
Date:   Thu, 19 Sep 2019 15:13:11 +0000
Message-ID: <20190919151310.GA12236@arm.com>
References: <20190909134241.23297-1-ayan.halder@arm.com>
 <20190917125301.GQ3958@phenom.ffwll.local>
 <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com>
 <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
 <CAPj87rOc3MvkjrX1qHpGuVUaGLuZiC7QYBO9v3T2NS+dicLC1g@mail.gmail.com>
 <20190919140323.GA3456@arm.com>
 <CAKMK7uHYy9pfmqV_qE948QMPOaxHsJ2sy3+J4kQqixanLP_SUQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHYy9pfmqV_qE948QMPOaxHsJ2sy3+J4kQqixanLP_SUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0317.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::17) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1cb9b1f4-11e1-4e1d-abbc-08d73d13e982
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM7PR08MB5334;
X-MS-TrafficTypeDiagnostic: AM7PR08MB5334:|AM7PR08MB5334:|DB7PR08MB3193:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3193E52A192E946FDCE7BFFDE4890@DB7PR08MB3193.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 016572D96D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(53754006)(478600001)(14444005)(229853002)(6306002)(2616005)(476003)(446003)(11346002)(66066001)(44832011)(305945005)(14454004)(486006)(6246003)(25786009)(71200400001)(6486002)(33656002)(6512007)(6916009)(6436002)(36756003)(966005)(71190400001)(7736002)(81156014)(8676002)(2906002)(4326008)(81166006)(8936002)(52116002)(256004)(66476007)(76176011)(99286004)(5660300002)(86362001)(3846002)(1076003)(66446008)(386003)(66556008)(26005)(64756008)(53546011)(102836004)(186003)(316002)(6506007)(54906003)(66946007)(6116002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5334;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: +y+NAggt8WeTGhykNsLtoZ9pnmJG44l2ZxbnYO0esIZ5yOQWlq+KtRhPXbZc9a/NIe8K8u2/xZi9CQwad6jgMj/a0JZiEYBM1E8sJYjhOqjLdfzQbcaK4c7gouVHD+d2V1vXtZD+usw1mqLBrZ708vC5/8d8JomQXUJEe8EERn1BnudLw7o2XKeobnLUnFHA0q/1/0KO1cDVBobAE8GtB/1MRoUiC6yw0cGpq3xvm/AeG+TXdyu1Ui6ZUmJr2Ju5FTCiehc/AsYkHHIpRHDqeCBJLGFFP2a6R/Cq9t0cAN3hHpCzDEQ3W4k9q0WORYPtfi1U6xlEkVL4Yh6zccLK0gzqIPUQBwPU870VMq7zi5LnTVZEwfS8KfFRyreNBIdL8++uTsmYDY9CEn7pxT9fQ/WL6fCug4RxgI+H72vGL/A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC2653E39A52E74F9CAB3ED1A53E7132@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(53754006)(6512007)(4326008)(229853002)(22756006)(97756001)(446003)(6246003)(63350400001)(5660300002)(70206006)(6862004)(76176011)(50466002)(6486002)(53546011)(23726003)(3846002)(102836004)(336012)(33656002)(99286004)(25786009)(76130400001)(186003)(6306002)(26005)(46406003)(2906002)(386003)(6116002)(66066001)(6506007)(47776003)(316002)(107886003)(36906005)(8676002)(54906003)(7736002)(26826003)(356004)(966005)(8746002)(8936002)(1076003)(2616005)(81166006)(81156014)(476003)(126002)(36756003)(14444005)(305945005)(486006)(14454004)(478600001)(86362001)(11346002)(70586007)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3193;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 32f70d15-19e2-46e7-c826-08d73d13e2b1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3193;
NoDisclaimer: True
X-Forefront-PRVS: 016572D96D
X-Microsoft-Antispam-Message-Info: Fu52MnrX1aaPK/z0rOgAsayHxUcppWTGilUfHcUbRzU9+1fIFuSANPPDkAvDp01NKS6m77CrSBJ57SwK1fgeYcG+PgGeOv1lruhp8izzxX2zwqvddYJEMBuSY2LlZZh2QPjBLyqu/pHi3j93/C/FyHc/4B9qhRxvcJgyVMhFgJ1tAX4kaLnr9NBLcYJf4mHUcL9FaEqUCUSCg/MkNFFoqAFkFbl+1mLpji1w2Q4GUUWb1AWh8QdK+bMNRjzr53sa8QQS199UsqXakfX7zxaANY0412ZUMVK/L4VL6NWkeq2CB0AVmAzxBEVYSFRKgC1OwtGx4J6BfUO9joaoX8PHC2iTLwWv+KxwxoYyPGY3OOkXyFv5GkCORTuXrJQZJS1oxxDtST/kx3VLkW7B0XTHy1ATwjTE5RujzIW5Hci/HPg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 15:13:22.6131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb9b1f4-11e1-4e1d-abbc-08d73d13e982
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:10:42PM +0200, Daniel Vetter wrote:
> On Thu, Sep 19, 2019 at 4:03 PM Ayan Halder <Ayan.Halder@arm.com> wrote:
> >
> > On Wed, Sep 18, 2019 at 10:30:12PM +0100, Daniel Stone wrote:
> >
> > Hi All,
> > Thanks for your suggestions.
> >
> > > Hi Liviu,
> > >
> > > On Wed, 18 Sep 2019 at 13:04, Liviu Dudau <Liviu.Dudau@arm.com> wrote=
:
> > > > On Wed, Sep 18, 2019 at 09:49:40AM +0100, Daniel Stone wrote:
> > > > > I totally agree. Framebuffers aren't about the underlying memory =
they
> > > > > point to, but about how to _interpret_ that memory: it decorates =
a
> > > > > pointer with width, height, stride, format, etc, to allow you to =
make
> > > > > sense of that memory. I see content protection as being the same =
as
> > > > > physical contiguity, which is a property of the underlying memory
> > > > > itself. Regardless of the width, height, or format, you just cann=
ot
> > > > > access that memory unless it's under the appropriate ('secure eno=
ugh')
> > > > > conditions.
> > > > >
> > > > > So I think a dmabuf attribute would be most appropriate, since th=
at's
> > > > > where you have to do all your MMU handling, and everything else y=
ou
> > > > > need to do to allow access to that buffer, anyway.
> > > >
> > > > Isn't it how AMD currently implements protected buffers as well?
> > >
> > > No idea to be honest, I haven't seen anything upstream.
> > >
> > > > > There's a lot of complexity beyond just 'it's protected'; for
> > > > > instance, some CP providers mandate that their content can only b=
e
> > > > > streamed over HDCP 2.2 Type-1 when going through an external
> > > > > connection. One way you could do that is to use a secure world
> > > > > (external controller like Intel's ME, or CPU-internal enclave lik=
e SGX
> > > > > or TEE) to examine the display pipe configuration, and only then =
allow
> > > > > access to the buffers and/or keys. Stuff like that is always goin=
g to
> > > > > be out in the realm of vendor & product-policy-specific add-ons, =
but
> > > > > it should be possible to agree on at least the basic mechanics an=
d
> > > > > expectations of a secure path without things like that.
> > > >
> > > > I also expect that going through the secure world will be pretty mu=
ch transparent for
> > > > the kernel driver, as the most likely hardware implementations woul=
d enable
> > > > additional signaling that will get trapped and handled by the secur=
e OS. I'm not
> > > > trying to simplify things, just taking the stance that it is usersp=
ace that is
> > > > coordinating all this, we're trying only to find a common ground on=
 how to handle
> > > > this in the kernel.
> > >
> > > Yeah, makes sense.
> > >
> > > As a strawman, how about a new flag to drmPrimeHandleToFD() which set=
s
> > > the 'protected' flag on the resulting dmabuf?
> >
> > To be honest, during our internal discussion james.qian.wang@arm.com ha=
d a
> > similar suggestion of adding a new flag to dma_buf but I decided
> > against it.
> >
> > As per my understanding, adding custom dma buf flags (like
> > AMDGPU_GEM_CREATE_XXX, etc) is possible if we(Arm) had our own allocato=
r. We
> > rely on the dumb allocator and ion allocator for framebuffer creation.
> >
> > I was looking at an allocator independent way of userspace
> > communicating to the drm framework that the framebuffer is protected.
> >
> > Thus, it looked to me that framebuffer modifier is the best (or the lea=
st
> > corrupt) way of going forth.
> >
> > We use ion and dumb allocator for framebuffer object creation. The way
> > I see it is as follows :-
> >
> > 1. For ion allocator :-
> > Userspace can specify that it wants the buffer from a secure heap or an=
y other
> > special region of heap. The ion driver will either fault into the secur=
e os to
> > create the buffers or it will do some other magic. Honestly, I have sti=
ll not
> > figured that out. But it will be agnostic to the drm core.
>=20
> Allocating buffers from a special heap is what I expected the
> interface to be. The issue is that if we specify the secure mode any
> time later on, then it could be changed. E.g. with Daniel Stone's idea
> of a handle2fd flag, you could export the buffer twice, once secure,
> once non-secure. That sounds like a silly thing to me, and better to
> prevent that - or is this actually possible/wanted, i.e. do we want to
> change the secure mode for a buffer later on?
>=20
> > The userspace gets a handle to the buffer and then it calls addFB2 with
> > DRM_FORMAT_MOD_ARM_PROTECTED, so that the driver can configure the
> > dpu's protection bits (to access the memory with special signals).
>=20
> If we allocate a secure buffer there's no need for flags anymore I
> think - it would be a property of the underlying buffer (like a
> contiguous buffer). All we need are two things:
> - make sure secure buffers can only be imported by secure-buffer aware dr=
ivers
> - some way for such drivers to figure out whether they deal with a
> secure buffer or not.

I am with you on this. Yes, we need to communicate the above two
things.

>=20
> There's no need for any flags anywhere else with the ion/secure
> dma-buf heap solution. E.g. for contig buffer we also dont pass around
> a DRM_FORMAT_MOD_PHYSICALLY_CONTIG for addfb2.

Sorry, I could not follow you here. For the driver to know if it is importi=
ng
a secure buffer or using a secure buffer, it needs some flags, right?

Or on a second thought, are you suggesting that we should stick with
a dma_buf flag (IS_PROTECTED) only ?

>=20
> > 2. For dumb allocator :-
> > I am curious to know if we can add 'IS_PROTECTED' flag to
> > drm_mode_create_dumb.flags. This can/might be used to set dma_buf
> > flags. Let me know if this is an incorrect/forbidden path.
>=20
> dumb is dumb, this definitely feels like the wrong interface to me.
>=20
> > In a nutshell, my objective is to figure out if the userspace is able
> > to communicate to the drm core about the 'protection' status of the
> > buffer without introducing Arm specific buffer allocator.
>=20
> Why does userspace need to communicate this again? What's the issue
> with using an ARM specific allocator for this?

We never felt the need to create an Arm specific allocator. Either
Dumb or Ion allocator would always suffice our purpose.

To upstream 'protected mode' feature of our komeda driver, if we need to
write our own allocator, it will be a big overhead. :)

Also to answer your earlier question

"But if it's a generic flag, how do you combine that with other
modifiers? Like if you have a tiled buffer, but also encrypted? Or
afbc compressed, or whatever else. I'd expect for your hw encryption
is orthogonal to the buffer/tiling/compression format used?"

Yes, hw encryption(protected mode) is orthogonal/independent to AFBC compre=
ssion.
Thus, any/all AFBC buffers can be supported with/without protected
mode.

> -Daniel
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
