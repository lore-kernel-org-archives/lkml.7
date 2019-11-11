Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6C2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C2B2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="B0SfIBy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKKVgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:36:00 -0500
Received: from mail-eopbgr770130.outbound.protection.outlook.com ([40.107.77.130]:39910
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbfKKVf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:35:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkw7adzmok8aDLIABozBfzRnL0uB4k/IMef3A7Ye0dqkS1UNbQ9Py0lUz0OjvW+oXS1tMh7Ut01ITvNuHxXw/SZaq9IWjSVW9YMwr9y+AnEw39b3hDCSQ0uJyEF7NFJsxR6zUPacndjNkEw846DOAQ2he2zlppCH8LRxYGUi4D6zXEcKCSIi0m2/UqqwvgwhDmvSPuPWt9Oowm5zCBAw/U6VClHB8XSRwhOuxwkY454w+E3qGBz4W4zjQ5zc8WLEhLOWemQ1CebhbspCWZu4FTxg5j8lsKj8m/nnTw+AOXGDFjwrUDftV10L18N9b9xQrfKyxzrnxuKFXcYD+E5oPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDSWiLPFenJXHfG2jhSOmoy+SH9lEBepxhSH+rWRaJE=;
 b=SP4nWzimAajbXXrz0HulQujdRYK/tCXdaVEbdjFPTVdpiyZmhbyVDaj1PK5CrhJ7FoVrvxZLpBoOpCMfCvoku9fQyp0HuHZ6sOCoN7zo0YMDxwZTBxfCfsWEQkMlPtd45USGJ6u+9h+noNLzCjC0rU+d+m1Q7k2a+BPqWBNCSil0eZ4i9Q0Xt5+fkdjOJEGliIRCfgAN5kTURpJjl7JIrcRYajw2ViWlc0C326lFsAKWZ7TB9Ihtw79KcF91MkKswNqXMMRd4zyqBUD3+A5id6R9NKrVdHDw3DdryT1kL/aDupZA6ezXZpbgQl8DZDaQBXXo2SgI4kk2VwPs+ZL8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDSWiLPFenJXHfG2jhSOmoy+SH9lEBepxhSH+rWRaJE=;
 b=B0SfIBy2uZesl2UGOorBFOrvm/vBXdRLOL8k1DObmTHwY0jgXJkPI+oqESjpalHCSQpekt9TppTtFcVZ541eB/oJt4NT0WXYsJt8JKjZ/AttOZTEWn1SPeV8t4jSW0QWUOAF4jNEBVKx9SOCy6nHp8Z5rDv5IbfhcY3PjXRDkPI=
Received: from CY4PR21MB0632.namprd21.prod.outlook.com (10.175.115.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.11; Mon, 11 Nov 2019 21:35:56 +0000
Received: from CY4PR21MB0632.namprd21.prod.outlook.com
 ([fe80::7942:9be6:a54d:446e]) by CY4PR21MB0632.namprd21.prod.outlook.com
 ([fe80::7942:9be6:a54d:446e%3]) with mapi id 15.20.2474.001; Mon, 11 Nov 2019
 21:35:56 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] perf inject --jit: Remove //anon mmap events
Thread-Topic: [PATCH v3] perf inject --jit: Remove //anon mmap events
Thread-Index: AQHVkCoSdDKHEwaGv0G9a4q1EVvH9qd1/B4AgAnxV+CABfnPgIAApblA
Date:   Mon, 11 Nov 2019 21:35:56 +0000
Message-ID: <CY4PR21MB0632B5EE447DA9B931CB114DF7740@CY4PR21MB0632.namprd21.prod.outlook.com>
References: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
 <20191101082740.GB2172@krava>
 <CY4PR21MB063262D81AB2BE5FEE88057EF77A0@CY4PR21MB0632.namprd21.prod.outlook.com>
 <20191111113311.GA9791@krava>
In-Reply-To: <20191111113311.GA9791@krava>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-11T21:35:54.8355878Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=803678eb-e808-48dd-8a22-5ef03782f866;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6edc2059-7ea0-4e03-2784-08d766ef22f0
x-ms-traffictypediagnostic: CY4PR21MB0503:|CY4PR21MB0503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0503140437F2C2211CC720D1F7740@CY4PR21MB0503.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(74316002)(316002)(10290500003)(186003)(6436002)(66446008)(55016002)(54906003)(6116002)(305945005)(66066001)(66946007)(66476007)(66556008)(102836004)(5024004)(256004)(22452003)(14444005)(86362001)(64756008)(6246003)(71190400001)(71200400001)(229853002)(76116006)(478600001)(76176011)(7736002)(10090500001)(6916009)(9686003)(6506007)(7696005)(81166006)(14454004)(26005)(8990500004)(33656002)(99286004)(11346002)(476003)(2906002)(4326008)(25786009)(81156014)(5660300002)(8676002)(52536014)(486006)(3846002)(8936002)(446003)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0632.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dI/aOaNYKrIFiDCFaO3F32952i6uR7LY4GTJc84dZj4WXzpMp7+ouM66626aw4NE/ZRkcuSqvIvpXH4C79SWQfWaZ27Ud34+cMtyyJw4qpWQCfzczz5aK+iioXfPKMww23tMqLPXqfcj5YziOcirS76zcIOZq7F1hxAYN4kl5DoTzkhKMrABxosnZ+ttxUCx/j/zQPMx/HYbWiGl5UmMvJqsnzlHj01RpOKqfT7QrP6r71tE9TmKRj1ctPtH5gmMlUYHOwiQNr28Dgc8RZLjB+MRqeJ+ZUOyBlaDAH/1bj7FerBOtdcHXTNVjM+zsDqgcHp9nG2lVAxmYeE4AgTvzxH9/pozG77ibxmU3dcPEI9Z29iVGpeGOxFgZAiDMYl6JTqKUlNstl2LPsPw7RjHrl6snVpG0snRz3V8ndQ76dNu4WwaswlD39PVqaM7fRHE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edc2059-7ea0-4e03-2784-08d766ef22f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 21:35:56.4026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwMSXI3nQ3oQmi0JYLnNB/epfoydaMZdtxnGk1hIfaKesDA7y0VAbLDR3xxlt5+QwH5crHFW0HO0HfFj3bcRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > While a JIT is jitting code it will eventually need to commit more=
=20
> > > > pages and change these pages to executable permissions.
> > > >=20
> > > > Typically the JIT will want these colocated to minimize branch disp=
lacements.
> > > >=20
> > > > The kernel will coalesce these anonymous mapping with identical=20
> > > > permissions before sending an MMAP event for the new pages. This=20
> > > > means the mmap event for the new pages will include the older pages=
.
> > > >=20
> > > > These anonymous mmap events will obscure the jitdump injected pseud=
o events.
> > > > This means that the jitdump generated symbols, machine code,=20
> > > > debugging info, and unwind info will no longer be used.
> > > >=20
> > > > Observations:
> > > >=20
> > > > When a process emits a jit dump marker and a jitdump file, the=20
> > > > perf-xxx.map file represents inferior information which has been=20
> > > > superceded by the jitdump jit-xxx.dump file.
> > > >=20
> > > > Further the '//anon*' mmap events are only required for the legacy=
=20
> > > > perf-xxx.map mapping.
> > > >=20
> > > > When attaching to an existing process, the synthetic anon map=20
> > > > events are given a time stamp of -1. These should not obscure the=20
> > > > jitdump events which have an actual time.
> > > >=20
> > > > Summary:
> > > >=20
> > > > Use thread->priv to store whether a jitdump file has been=20
> > > > processed
> > >=20
> > > I'm ok wih the implementation but not sure about the described JIT/mm=
ap logic, Stephane?
> > >=20
> > > jirka
> >=20
> > The kernel only seems to coalesce the anonymous mappings when the alloc=
ations grow beyond 64K. It may not affect JITs for smaller sets of JITted c=
ode.  I would guess a javascript JIT engine might not hit this type of prob=
lem often.
> >=20
> > @Stephane Eranian could you comment.
> >=20
> > @Jiri Olsa I am happy to expand the explanation if it would be helpful.
>=20
> that'd be great, thanks
>=20
> jirka
>=20

Here is an expanded description in markdown syntax.  If you need additional=
 or=20
different details let me know.

## perf-<pid>.map and jit-<pid>.dump designs:

When a JIT generates code to be executed, it must allocate memory and=20
mark it executable using an mmap call.=20

### perf-<pid>.map design

The perf-<pid>.map assumes that any sample recorded in an anonymous=20
memory page is JIT code. It then tries to resolve the symbol name by=20
looking at the process' perf-<pid>.map.

### jit-<pid>.dump design

The jit-<pid>.dump mechanism takes a different approach. It requires a JIT
to write a `<path>/jit-<pid>.dump` file. This file must also be mmapped
so that perf inject -jit can find the file. The JIT must also add
JIT_CODE_LOAD records for any functions it generates. The records are=20
timestamped using a clock which can be correlated to the perf record=20
clock.

After perf record,  the `perf inject -jit` pass parses the recording=20
looking for a `<path>/jit-<pid>.dump` file. When it finds the file, it=20
parses it and for each JIT_CODE_LOAD record:
* creates an elf file `<path>/jitted-<pid>-<code_index>.so=20
* injects a new mmap record mapping the new elf file into the process.=20

### Coexistence design

The kernel and perf support both of these mechanisms. We need to make=20
sure perf works on an app supporting either or both of these mechanisms.=20

Both designs rely on mmap records to determine how to resolve an ip
address.

The mmap records of both techniques by definition overlap. When the JIT=20
compiles a method, it must:
* allocate memory (mmap)=20
* add execution privilege (mprotect or mmap. either will=20
generate an mmap event form the kernel to perf)
* compile code into memory
* add a function record to perf-<pid>.map and/or jit-<pid>.dump

Because the jit-<pid>.dump mechanism supports greater capabilities, perf
prefers the symbols from jit-<pid>.dump. It implements this based on=20
timestamp ordering of events. There is an implicit ASSUMPTION that the=20
JIT_CODE_LOAD record timestamp will be after the // anon mmap event that=20
was generated during memory allocation or adding the execution privilege se=
tting.

## Problems with the ASSUMPTION

The ASSUMPTION made in the Coexistence design section above is violated=20
in the following scenario.

### Scenario

While a JIT is jitting code it will eventually need to commit more=20
pages and change these pages to executable permissions. Typically the=20
JIT will want these collocated to minimize branch displacements.

The kernel will coalesce these anonymous mapping with identical=20
permissions before sending an MMAP event for the new pages. The address
range of the new mmap will not be just the most recently mmap pages.

### Symptoms

The coalesced // anon mmap event will be timestamped after the=20
JIT_CODE_LOAD records. This means it will be used as the most recent=20
mapping for that entire address range. For remaining events it will look at=
 the
inferior perf-<pid>.map for symbols.

If both mechanisms are supported, the symbol will appear twice with=20
different module names. This causes weird behavior in reporting.

If only jit-<pid>.dump is supported, the symbol will no longer be resolved.

## Proposed solution

This patch solves the issue by removing // anon mmap events for any=20
process which has a valid jit-<pid>.dump file.

It tracks on a per process basis to handle the case where some running=20
apps support jit-<pid>.dump, but some only support perf-<pid>.map.

It adds new assumptions:
* // anon mmap events are only required for perf-<pid>.map support.
* An app that uses jit-<pid>.dump, no longer needs=20
perf-<pid>.map support. It assumes that any perf-<pid>.map info is=20
inferior.

## Alternative Solutions

These were also briefly considered

* Change kernel to not coalesce mmap regions.
* Change kernel reporting of coalesced mmap regions to perf. Only=20
include newly mapped memory.
* Only strip parts of // anon mmap events overlapping existing=20
jitted-<pid>-<code_index>.so mmap events.
