Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BDCC2D0C8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 04:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782D9206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 04:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="QK1shY08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfLYE0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 23:26:16 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:32447 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726347AbfLYE0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 23:26:15 -0500
IronPort-SDR: hJr1EkTJd3g8xOwIKYsTgzqT5ZBi4+so2g0hHW62WCperZZ0pkfPJzP+yzPbk4fnaS4A6k8bR1
 J1awoLKngPWw521rtm+l1P9xJ/qAvZnpKzWUhMp3nYbsg7HX6wUdCSsRoQTJ94xFb9xvlt8hbp
 RkDFm4TO5QLqDBpuQP00c4gd1cbnCOeUZy0Dx+pVTl8aT2C409ugHsEA807MX5a+54dRJxJV+x
 Ri0NWWpYuxZarVC9OMNsiUA52yoJBiVOhQDB21Eqg/2mwVTRu7sriNKKUVLSbMD/iv9U+KUN7s
 iAM=
X-IronPort-AV: E=McAfee;i="6000,8403,9481"; a="8838285"
X-IronPort-AV: E=Sophos;i="5.69,353,1571670000"; 
   d="scan'208";a="8838285"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 13:26:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYMhnZmmL4OPLsqiLANNwViuVtsaxecWqjtDqrQ2NWUu611QQbSLoXVOE4HWGe12mFxcWs0rHUMra5Uk74OGMP83J4SyKFSuC5P7/Ap8iT1dc9wIfPuGipKODnYwZYF84ongjPy6OZvVMscF+j8IAjtqj09Cbu3EEKUU7aoIDXyiFiEiQlBBjngP2LVQhsm2mGfRwlz6fUFrLtVR/o3xbopNseGPIP8a65U9562j36Q0yeDloj3Of2BCgr+KOIQ3yp7g2ggLzqgACQ2svcN0mNYlUIEEKCKPCnl66U3mdTOegYWdpfrq2PUa+UJ6+fxRieEYQSOzG8jEw+ITU3+y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJMC0jMTcYoNky8ElygjGx7cCKKn/570txqJbbsPK5Y=;
 b=RMhR7foWWi5zyLKoqeHC9rNm2/MSCaBzqmAnRGk0oOboa/aGM84t8Sx0G2jsJlpd7VPtLYx+4aFxnvj/dV3ouAXHCd+1l0s6oRO5IOYH6sN/dzMcZADFuE6vrDhTkTRgGTjokgtW2hr+IY0c+b1E1XfKkaQst+ihF/GXRKBZQixaCt7sYgksv2hzA9k/oGp3Awy2xrT9Yq29ZN4BA3MaYBthqq2zqtGU9hhtrxeIKTwjT8GgLWjfI6NEVjxA2DRU0c8raVNL/NqAO6rmq2sy+IAux/zdhVF6Mm+goh84dpPwChEyoIhDqhTwcxvZ5994PawAIoV1yYm1TQSEi4geuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJMC0jMTcYoNky8ElygjGx7cCKKn/570txqJbbsPK5Y=;
 b=QK1shY08txA4Rfm3xzU41tdpeO5VsXQueeQDeOgqByLx/1DQN1LToXi+W2JuqpVh6/+yQTkXaX9tmGvoNczxuIVFCuXP92VXOudunAiEnRcVOyD3SmjEwOPNxbSdxXGC+omo/lMSPdqnNgJU5L3/gZH5WgbLZ6cCyC6okbtNAYY=
Received: from OSBPR01MB4006.jpnprd01.prod.outlook.com (20.178.98.151) by
 OSBPR01MB4215.jpnprd01.prod.outlook.com (20.178.5.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Wed, 25 Dec 2019 04:26:08 +0000
Received: from OSBPR01MB4006.jpnprd01.prod.outlook.com
 ([fe80::1c51:734d:bcc3:8626]) by OSBPR01MB4006.jpnprd01.prod.outlook.com
 ([fe80::1c51:734d:bcc3:8626%5]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 04:26:08 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     "'dyoung@redhat.com'" <dyoung@redhat.com>,
        "'bhe@redhat.com'" <bhe@redhat.com>,
        "'vgoyal@redhat.com'" <vgoyal@redhat.com>,
        "'ebiederm@xmission.com'" <ebiederm@xmission.com>,
        "'mingo@kernel.org'" <mingo@kernel.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>
Subject: [RFD] kdump, kaslr: how to fix the failure of reservation of
 crashkernel low memory due to physical kaslr
Thread-Topic: [RFD] kdump, kaslr: how to fix the failure of reservation of
 crashkernel low memory due to physical kaslr
Thread-Index: AdW621PrfLWfeSyiSUOQtrg7XKymEQ==
Date:   Wed, 25 Dec 2019 04:26:08 +0000
Message-ID: <OSBPR01MB4006AF8B4D355200E385850E95280@OSBPR01MB4006.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=d.hatayama@fujitsu.com; 
x-originating-ip: [210.170.118.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7396d895-2780-464e-78e5-08d788f29055
x-ms-traffictypediagnostic: OSBPR01MB4215:
x-microsoft-antispam-prvs: <OSBPR01MB4215BFC983D917D0CFF49DBB95280@OSBPR01MB4215.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(2906002)(8676002)(52536014)(81166006)(4326008)(81156014)(8936002)(71200400001)(55016002)(33656002)(9686003)(186003)(85182001)(478600001)(5660300002)(66446008)(7696005)(26005)(6506007)(54906003)(110136005)(86362001)(64756008)(66556008)(66946007)(66476007)(76116006)(316002)(777600001)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB4215;H:OSBPR01MB4006.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WUe62EucEbZDGxyPxFH0jhk+pghr5K28sQ28nREcLCcMqTSwtEzXkp9B+Jax3RuPuHi3cMhGCbfKRalDXx+hNgXbjmt0zu0vvH1QmDVbOOtwolcVkYWA4ASfxtNH+7+fqtz4dTqG5qBDQqtTrfnz77RqHuw60jj8f5RLtTCVlDuybnXfH/HXZo3dhDalv05rbzgsWyB/6zRFVp9sYTOsMENRNrDh2a2bcaw/lZSYS2mq3gB5Z037WAJ20SmgQKPfFFF5O2SCqWktsDMV6iZPS/1UVPf0YrIFbiqfSTLUxfZ5AtD59RcejZ5z4tKOXG0rba1yHpEEg2dUEniUmibFMUFfAWLwpgBs0r04FbParjqEStt6V2ES38JN4c3Y7EVFOhKBWpl3xY5N/71K8NMHNqvhfJhv3TGNyx5ZFW7zUCj5MXSzCaxRXViV44qn0cp0rfkIjDJH3yJUafSmAm3UQExMylVsyFrka2yjNHVQ+L1e9iRNxAmu/RPrYmPelJygoIhrwMRNN1TaVGhWYyroxA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7396d895-2780-464e-78e5-08d788f29055
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 04:26:08.0588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tds9fsteMFPnMuPmqVfgDvGjpJyove/3wWTl+RFc5otAWBcKEZEaLNkBLfJn9AAUMrJJA7RVfLFsk6cM19p1/4uQ7JmMYpHlgvm0dc4T1BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, reservation of crashkernel low memory sometimes fails due
to a sparse memory caused by physical kaslr with the following
message:

    Cannot reserve 256MB crashkernel low memory, please try smaller size.

Kdump needs low memory, memory area less than 4GB, e.g. for swiotlb.
Its size is 256MB for low memory by default. OTOH, physical kaslr
loads kernel images in a random physical address for
security. Physical kaslr sometimes choose low memory and sparse
there and as a result, reservation of crash kernel low memory could fail.

This failure seldom occurs on systems with large memory. For example,
on our system with 128GB, the issue occurs once in hundreds of
reboots. Although it doesn't occur frequently and can be avoided in
practice simply by rebooting the system, it definitely occurs once in
hundreds of reboots. Once the issue occurs, it's difficult for ordinary
users to understand why it failed. I'd like to fix this current behavior.

I'm now coming up two ideas but don't know what is best. Please
discuss how to fix the issue in better way.

1) Add a kernel parameter to make physical kaslr to avoid specified
   memory area

  This is the simplest idea I came up with first just like
   kaslr_mem_avoid=3D4GB-0, which is similar syntax to memap=3D, meaning
   that kaslr, please avoid to load kernel image into the region [0,
   4GB).

  It looks to me that this can be implemented easily by taking
   advantage of the existing code about mem_avoid mechanism in
   arch/x86/boot/compressed/kaslr.c.

  This mechanism doesn't lose security provided by physical kaslr if
   system memory is large enough.

  Demerit of this is that users need configuration. Automatic way is
   better if possible.

2) Add special handling for crashkernel=3D low in physical kaslr

  The second idea I came up with is to add special handling for
   crashkernel=3D low in physical kaslr, i.e. physical kaslr recognizes
   crashkernel=3D in kernel parameters and keep enough memory for
   crashkenrel.

  To guarantee that the memory area kept by the special handling in
   physical kaslr is used for crashkernel, it is necessary to mark the
   area to indicate to the crashkernel code executed after kernel
   runs. To implement this, I imagine introducing a new type of memory
   a kind of E820_CRASHKERNEL_LOW.

  My concern on this idea is whether its worth implementing such
   special handling in physical kaslr simply because I don't find such
   code in physical kaslr now.

3) Any other better ideas?

Thanks.
HATAYAMA, Daisuke

