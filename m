Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8456C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 16:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A845E207FF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 16:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UTmhAv58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfKIQtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 11:49:41 -0500
Received: from mail-eopbgr720096.outbound.protection.outlook.com ([40.107.72.96]:63120
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfKIQtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 11:49:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APDsb2ZSNU/wX9QpB8rV0RT1r9cjVRd1b4hjzlltqLwta3Op1kmGMN4eY18LOz1aA99jPXqH+ueG5RnUAEKAlnGMEwknq63+9QjNS97g0HNCO4Y8N9xVyHtnkNBLZwPid/TnDhAzsStimFR59GmtqzXHI+XBOxn3URqET4gDQ5p/IznbLTBRvzv0SSGBQ21/hY/bvDocI+np4qcpr2qXzT1B+pcIY3AxB5Rspkhqjuc0k5NTANQJEpoih2Am3UVyEQhrzDHplmobjgXaJi3TcM8oX/LpBKRxT0XEl72vaJBfyZ6wCI6W5X0+T/3s7Qw6mxJW1AKaj17KVmO8RT09dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omY5101RjdtYpBWWy4OSTCaA3M0tokpxgRNZY9YIas0=;
 b=cwiieZanfTUZVu3FS75VvXpB9w7ILycgLthf1wluYqvRYPayx9sKMyDzLodRVS6dCh5vStP5/rt6PPUcOx6TVE++Py+X8MT/yqGJ9TrOV+4p9QlSk0ZR6rhsdrUbVdTtJlI8j6s5Mkdhl+xia2Rk2Gqt7D5Oq9xJxodzHChgwrY7SEOjxrlg+DhWa2J0L2e4VuPQm1dCN/WY8VxhYu2zIIwCsHz6Yi2cQpPZAXw4giwAMmB+6ducbwYCav13k7FRvQyaciDSITsmfaiLUM3OSHWPDS2f1ex8FprQ+FZWsR+XU309LX5ZMbf+9nMBWS/NxDgiZTVA6ZwjCSE/uTO2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omY5101RjdtYpBWWy4OSTCaA3M0tokpxgRNZY9YIas0=;
 b=UTmhAv58NbS7Hn/m2xO/idpVffYFfts26hY+C0O5dUnpeFRrSNt7Y7dzRpE8RSIPwtK3fDceGG4Iy0IK9Bd53HAuMAg9xQTdGZSx2HG9BYxy+KXnHfsjW0gfW6diHmEc9g8cnA3ly4i7fv8ccle1jomwSQ6Hkq47D0CFeigbO4A=
Received: from CY4PR21MB0632.namprd21.prod.outlook.com (10.175.115.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.13; Sat, 9 Nov 2019 16:49:25 +0000
Received: from CY4PR21MB0632.namprd21.prod.outlook.com
 ([fe80::682f:8f22:15f7:798c]) by CY4PR21MB0632.namprd21.prod.outlook.com
 ([fe80::682f:8f22:15f7:798c%8]) with mapi id 15.20.2451.018; Sat, 9 Nov 2019
 16:49:25 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Steve MacLean <steve.maclean@linux.microsoft.com>,
        Stephane Eranian <eranian@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] perf inject --jit: Remove //anon mmap events
Thread-Topic: [PATCH v3] perf inject --jit: Remove //anon mmap events
Thread-Index: AQHVkCoSdDKHEwaGv0G9a4q1EVvH9qd1/B4AgAnxV+A=
Date:   Sat, 9 Nov 2019 16:49:25 +0000
Message-ID: <CY4PR21MB063262D81AB2BE5FEE88057EF77A0@CY4PR21MB0632.namprd21.prod.outlook.com>
References: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
 <20191101082740.GB2172@krava>
In-Reply-To: <20191101082740.GB2172@krava>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-Mentions: eranian@google.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-09T16:49:23.6433884Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e78fe58-8862-426c-9762-cd79c1063ded;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b475ec9-9399-490b-ee95-08d76534c782
x-ms-traffictypediagnostic: CY4PR21MB0135:|CY4PR21MB0135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0135B087B1AD948FE79E0DADF77A0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 021670B4D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(229853002)(7696005)(76176011)(102836004)(6436002)(6506007)(14444005)(256004)(5024004)(478600001)(25786009)(10290500003)(5660300002)(52536014)(86362001)(1511001)(33656002)(99286004)(2906002)(8676002)(81166006)(8936002)(81156014)(14454004)(316002)(4326008)(22452003)(8990500004)(9686003)(54906003)(7736002)(26005)(55016002)(110136005)(186003)(486006)(6116002)(3846002)(66066001)(71190400001)(71200400001)(66946007)(66556008)(66476007)(305945005)(74316002)(64756008)(66446008)(76116006)(6246003)(476003)(10090500001)(446003)(11346002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0632.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OvsKHkwrGXjab85NjFOCRheJWKJAJM6/m7saS4ohjhSb1BvwnH6pIS8CLkdvj/z8rlSQfDm+SNUZkLjoB2IlGeyQDA/TBNyS5CEQ0CZLuRnNCo6BQIBQ9lnvn94UZbuP66PMnnRIVdNn5aIYlCcLOi/RZvaF+T/zoD+QbH1HCLktSh8CVf10NIaJ/s3oL6FGxKaUE/Y0fSrpy4DRHM/T0xE+Kgg9u8/qJvINj62pH7lQ8waNjIcWvTkA3pBWVyO2KqQIn+IOdSLLtHufklHF/tAk9GUhaZNYTAJue3uFp3huzD2B73xd4hGC08q/8NeLQointz9OmD/1IMyl4UFWAegpp0QIjtRt0ceWCdzkdT/79/81vAli0S0llFfL1qyMhKl13qGqmzBBZYjoMxFFffTJ5y3K6zLaric2uCa9OeT1FMngUJR16U87IHZbI3wW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b475ec9-9399-490b-ee95-08d76534c782
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2019 16:49:25.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cS7Igd7kdpd1UQu19qDp6f+p9q2S0Vr3+9zAh3P7GVeQhiOZiT0VW1lMYvRIfy4l6FSsNA0bZbeqK7yTvuTi4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > While a JIT is jitting code it will eventually need to commit more=20
> > pages and change these pages to executable permissions.
> >=20
> > Typically the JIT will want these colocated to minimize branch displace=
ments.
> >=20
> > The kernel will coalesce these anonymous mapping with identical=20
> > permissions before sending an MMAP event for the new pages. This means=
=20
> > the mmap event for the new pages will include the older pages.
> >=20
> > These anonymous mmap events will obscure the jitdump injected pseudo ev=
ents.
> > This means that the jitdump generated symbols, machine code, debugging=
=20
> > info, and unwind info will no longer be used.
> >=20
> > Observations:
> >=20
> > When a process emits a jit dump marker and a jitdump file, the=20
> > perf-xxx.map file represents inferior information which has been=20
> > superceded by the jitdump jit-xxx.dump file.
> >=20
> > Further the '//anon*' mmap events are only required for the legacy=20
> > perf-xxx.map mapping.
> >=20
> > When attaching to an existing process, the synthetic anon map events=20
> > are given a time stamp of -1. These should not obscure the jitdump=20
> > events which have an actual time.
> >=20
> > Summary:
> >=20
> > Use thread->priv to store whether a jitdump file has been processed
>=20
> I'm ok wih the implementation but not sure about the described JIT/mmap l=
ogic, Stephane?
>=20
> jirka

The kernel only seems to coalesce the anonymous mappings when the allocatio=
ns grow beyond 64K. It may not affect JITs for smaller sets of JITted code.=
  I would guess a javascript JIT engine might not hit this type of problem =
often.

@Stephane Eranian could you comment.

@Jiri Olsa I am happy to expand the explanation if it would be helpful.

