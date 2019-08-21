Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9917C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929ED2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cTtgCV/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfHUIUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:20:51 -0400
Received: from mail-eopbgr760113.outbound.protection.outlook.com ([40.107.76.113]:3385
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfHUIUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW34iFdoNF97GPo89Njq50q2mcVmj0iDwwa+pBHSGxLu/PBedDl+nFsHeq69iQf3am41oyoQbFDITiPtedPfJWr1isbNyM1QYX6vc+rmw1l9MmDYoMvSa8dzkjUcNLU7aETkZajo7cgk+ktpIeB9LEKqQS7dtaUuRJL6kXuavyE0CP3vQsjlxJM0kEUB3+Bmbary+fB7dtikQBRanMuFmu6OVYgWY68H0N45HL8EtZl+/x3YJyj3eAUiDwdG+P2TuIckZm3RQ9dPrZjhsFSTT4yOjJ+NmMNHrhXhqUaZ93LZP2zHDe8YpMiebkjlwFCN5HLy9mgWdX6LhkN+nfROHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJID8aVkaRli8tgOf9zk7nxZRI+HlJd14vABCHhffAM=;
 b=OuJnVj4mHtu8BS5bdVquMxcIW09dXjzaobNIZZCbwGMLF9HAD75nsGp3+QnWn6wJURp8k5ORW5tgqeG42uDUrqSZyRAfQZU+2fxTlM+Su86J4qmy7tqHozoHfzA7m8KcO4OiFipmdYbNM6u3x0kV3TSMKw6iYsvnbEB7OjYNahMGr1mAOTzZ2ibEEjI9HvGo90zb92e1LJfmN0PNBU6DZhRp+w4U0P9s/gGMjQVEbOH9btcvSOkanjUfM0PuIHQ5EJxhzTFM/M3KKolGTbHHp4eZ/Hl1IDWjwrYIES8C1Myj712aKc7BY4JfKbpH9787IA+S6XN83BxBGCumiTS0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJID8aVkaRli8tgOf9zk7nxZRI+HlJd14vABCHhffAM=;
 b=cTtgCV/qKimllwoUQklJq83YJ4JllyGpqVgXoBiFyyCt9Qb4asJQdvlyP0EQxuIOEXS3CaW/nZzRCJ2dXq+VngVZmTDNkCJH36Xk95I7N++rBEz2bOZjXieu+DFw7wlpSMhmdFXu5G9q2W4Z5QoElgpJSYVMnE9TfOIX85ocK3I=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.3; Wed, 21 Aug 2019 08:20:48 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Wed, 21 Aug
 2019 08:20:48 +0000
From:   Long Li <longli@microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] sched: define a function to report the number of
 context switches on a CPU
Thread-Topic: [PATCH 1/3] sched: define a function to report the number of
 context switches on a CPU
Thread-Index: AQHVVx6RDKHG9VfWZEyMN3Ch0Aa10acDx8yAgAFzq1A=
Date:   Wed, 21 Aug 2019 08:20:48 +0000
Message-ID: <CY4PR21MB0741F33BBC800C0774CB8C15CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-2-git-send-email-longli@linuxonhyperv.com>
 <20190820093827.GF2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190820093827.GF2332@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25bcab38-abf2-435e-8135-08d7261078c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840BD1158C477D6EF3A2391CEAA0@CY4PR21MB0840.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(189003)(199004)(10090500001)(14454004)(8990500004)(446003)(11346002)(53936002)(478600001)(476003)(46003)(7736002)(74316002)(305945005)(316002)(22452003)(5660300002)(6506007)(186003)(33656002)(52536014)(486006)(54906003)(102836004)(110136005)(76176011)(256004)(6436002)(229853002)(4326008)(25786009)(66446008)(2501003)(76116006)(64756008)(66556008)(66476007)(71190400001)(81156014)(10290500003)(66946007)(71200400001)(8936002)(81166006)(8676002)(6116002)(86362001)(99286004)(2906002)(6246003)(9686003)(7696005)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 065KlWxYsF4Vy2UpxSZN5AK2jpTLgj4pe04pW3jtodoxTAT1kqqAlpxhE1kHj6ZNbiXb5Bm/0pmPpOE2qUDKjJPPx9mTkvjwoue5d4V438UoPLr+gE/cwQL7w+80Bivq3kYvhlbMxREvzbETvMGD5ETVOPw7kL1ZTdJSOdbze/zY7GJSXQyGswfife2NfMyUiIapK/rXcOKK7iqb7idBqP0Jky4j/iTkuwOnNuktDG8a9E7l7tO4VLLE7H4aVfaWFF9+REf5fAgNlItfKxLSU3UkvuGc/sG2zZJGbhxAYo+t5PTNf0ZTfgCqpawIpw3qJhudSVSsV1Za1Px1wpnY1ahwsefYH/VvzAAsmxvydheBvsdAO9JqXu7iT4XhivEAJK+3L5nGUbaEDEk/fj79eSPWTUhNzlxjqM9njtJMbhU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bcab38-abf2-435e-8135-08d7261078c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 08:20:48.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/4JAb3/CL8Od9HfSy+oOiO5Qvwi15oRVpb1y8vuLUXUvOL1ZUbof1Vg2WTr+Vn+Lv59kK91BlxnJY6mZ0BzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Subject: Re: [PATCH 1/3] sched: define a function to report the number o=
f
>>>context switches on a CPU
>>>
>>>On Mon, Aug 19, 2019 at 11:14:27PM -0700, longli@linuxonhyperv.com
>>>wrote:
>>>> From: Long Li <longli@microsoft.com>
>>>>
>>>> The number of context switches on a CPU is useful to determine how
>>>> busy this CPU is on processing IRQs. Export this information so it can
>>>> be used by device drivers.
>>>
>>>Please do explain that; because I'm not seeing how number of switches
>>>relates to processing IRQs _at_all_!

Some kernel components rely on context switch to progress, for example watc=
hdog and RCU. On a CPU with reasonable interrupt load, it continues to make=
 context switches, normally a number of switches per seconds.=20

While observing a CPU with heavy interrupt loads, I see that it spends all =
its time in IRQ and softIRQ, and not to get a chance to do a switch (callin=
g __schedule()) for a long time. This will result in system unresponsive at=
 times. The purpose is to find out if this CPU is in this state, and implem=
ent some throttling mechanism to help reduce the number of interrupts. I th=
ink the number of switches is not accurate for detecting this condition in =
the most precise way, but maybe it's good enough.

I agree this may not be the best way. If you have other idea on detecting a=
 CPU is swamped by interrupts, please point me to where to look at.

Thanks

Long


