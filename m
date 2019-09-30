Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC29C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CC6224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A4s4TX9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfI3UtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:49:04 -0400
Received: from mail-eopbgr760120.outbound.protection.outlook.com ([40.107.76.120]:8782
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727469AbfI3UtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLgBwCW56VrnKooQzekHc7FMQxl+CM7fvgrhYcHqT9OynmPDAe7bvQYdJLLLavpXMyKX8c6yfpyaeLVjhOSrHeo/+9EUPVzCXQ3G2Ui6KaaHZC5u2GyGvPwZjue6HEjGR7LvJ0+MZJVsl9IKP/0HgSjSK8G74/d6+bkx4ltIzYdx4qGzi23Q0ZmFaPyVaYqNJKKjkTsICmVv5a5SFDUqY1Ct7SNXIDALOcfWKxk0SmZ8whS1HpYBelkCXWORbMVxkR0kDdvkaUTO+8R5QHwznQoGjDVQqEsBHlYczkUcgxkn9uuF3/np8MAtv3IXJ5Xo0EEQFIFtmBnOEsRfVYS6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjqskgLXrbiANBgP+BTnluUb8GpYlHpwEUgWARo6x2g=;
 b=CXXOVel4sEpnRoDmqOqiysgo0JBnaRK7g8ez+AA91KxZMgM4AIckinZE8hiyCfpNygEaP/rmuLWIb63nm+QNXYRLFgkjrywZiAsXScgHJUQOx8CRS48dBNgBWe+EKA/YIibjn6HAihCfo13TiZrl6TzsMjJ8z4yjBncIj2beI4yicRnZPaGqlsXN7p9T5sjE+nJVvkxW66TashP7eVpjpVECsRUPFIJ+qpHZMH5K4pb5yj7kyc9i07M3KHcW4WAGsP0rdoqT+7tywx+EkiUIKlZPrviNXqs3jTPPScXhAemcrMqCUGL1ha8z3TRP6cMGurRpejvwGwuIkfLuwJB6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjqskgLXrbiANBgP+BTnluUb8GpYlHpwEUgWARo6x2g=;
 b=A4s4TX9TmmG1mc4Ng+duvyAW6sZUmWl7jSk5vSscEO9txr3eTIvFmVE9D2gXdW5lvVElnvCsjHIEUHNpHjrCOWHkJDpvSt1r7/T4OKucanLcVicXVjB/dOu/2H+VmtinCBWJOFwNpw9upjEAoZuPazZhvey4KpgNxlhQsDg6Iz8=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1171.namprd21.prod.outlook.com (20.179.73.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.6; Mon, 30 Sep 2019 20:49:01 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::6cea:8074:a394:f20d%9]) with mapi id 15.20.2327.004; Mon, 30 Sep 2019
 20:49:01 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: RE: [PATCH 3/4] perf inject --jit: Remove //anon mmap events
Thread-Topic: [PATCH 3/4] perf inject --jit: Remove //anon mmap events
Thread-Index: AdV1ng9CnlECXJYCQw+p/SiDI/4npABPJ12AAD1CyvA=
Date:   Mon, 30 Sep 2019 20:49:00 +0000
Message-ID: <BN8PR21MB136251826C3C22C6BCCF17B5F7820@BN8PR21MB1362.namprd21.prod.outlook.com>
References: <BN8PR21MB13625F8AD3E9C67C0918A750F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
 <20190929152721.GB16309@krava>
In-Reply-To: <20190929152721.GB16309@krava>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-30T20:48:59.3555872Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5cab8ff7-ab20-48f9-9122-1d4582162d5a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 578c9ae9-a580-4fe8-e871-08d745e79f73
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN8PR21MB1171:|BN8PR21MB1171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB1171479ED28880C271A26BC7F7820@BN8PR21MB1171.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(199004)(189003)(8936002)(86362001)(6116002)(3846002)(7416002)(11346002)(14454004)(10290500003)(76116006)(6916009)(5660300002)(8676002)(7736002)(81156014)(81166006)(2906002)(8990500004)(66556008)(71200400001)(6436002)(6506007)(186003)(66446008)(4744005)(7696005)(55016002)(14444005)(9686003)(4326008)(71190400001)(229853002)(76176011)(26005)(102836004)(74316002)(99286004)(66476007)(52536014)(54906003)(6246003)(476003)(25786009)(478600001)(22452003)(316002)(33656002)(10090500001)(305945005)(66066001)(446003)(64756008)(256004)(66946007)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1171;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IVESkVkUKTWC1jBQZ3TsN/pbtLq4lSuQK9ScFr3HpOXFLIgf245JMkC3jAaJrtvj5Bru642nen0Yo39YSAGCtC53rMzKX0lRJR0dSXgDLvfZYXpkjW+QiS3UZO7k6ZxAScMrUwZbfrE9TONwDH67TEM1zZswwTD9bFESP606mijMZcAhlokFNuCzeO8/uE1cZHCAvV4YD+pF+fvOlBHCLaguBxbfGw7QHs5upKgoG9+lAuPD3LdbbrkwLDI+lldRkLsZNMGQuoEVnVQtG7g2iYOxqG9bOgAyPgoQyyn7BhPhTk6FawL9jMBbH6R00Nb5Xe840fH0rgptm7tC7Ui4GH5eQpNRRvTdYZIEUii4BZ6OzjN1TGB7eWmk52vdHuidJUk1fVywC5mhGvKFF06VX0yv4kH7trVLsuEeO9jlw3U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578c9ae9-a580-4fe8-e871-08d745e79f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 20:49:00.8901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNSwQNESowS4B6DmkGcIkRvIsw8D13qtzcK9ehFplYRaiTQversiKu5P1ALxgZiKWHNw2erdTzex6J5Hy3PU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNIP

> I can't apply this one:

> patching file builtin-inject.c
> Hunk #1 FAILED at 263.
> 1 out of 1 hunk FAILED -- saving rejects to file builtin-inject.c.rej=20

I assume this is because I based my patches on the wrong tip.

> patching file util/jitdump.c
> patch: **** malformed patch at line 236: btree, node);

This doesn't make sense to me.  The patch doesn't try to inject near line 2=
36. There aren't 236 lines in the e-mail....

Looking at the MAINTAINERS file, it looks like I should have based my chang=
es on:
	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

I'll rebase the patch and resend.


