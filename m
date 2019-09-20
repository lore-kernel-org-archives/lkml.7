Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D13C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EC320644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j2Opu3lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfITVqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:46:19 -0400
Received: from mail-eopbgr710110.outbound.protection.outlook.com ([40.107.71.110]:55648
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbfITVqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:46:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQYPSy867O4b/ls+Z4K9QtoKoq754Ty03rohnxDA2vgR9wzhTT8Su3JgLkNUHjLgLDEp9LhAKuAy7zU13xeEUH7yG5SKDmkPhH+CEhdn/Ote+Z5XiRZWLNoEYCA604FL+q+a0/CuJxB1rC3Z+a13SXWEHIGJnCdmUJyVurU+N4Iq5cI38HNTtXisnVtkISdlIks+yRfTUwo+OD5IoUkGz5meTXr3Ki+arr8Jq/Mha/ZAhoa+Hc9cwYE21sjCeLZhZ/EtF59kNoaDYGYLZBctnF9dSXivK46kC4+z41uPvdD8YgAeV9iFLuEfKAJ65AZ4n0Mfl77ARgguA4pmJmV1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2bIJGcGWbCjVdFa2oEqE5aHmBkFT7B04fpxP46e2iU=;
 b=gh/By04zHBoBXikSWcoiTKyQLjnzsLPUFjQFvPkKIOlIusXVxCyqWNtU4eZsEI8rckq3zTnwjts+FrrL7EN/DJHXLFdYbOpHjGMOb9pYYWMEmAX4W45KcJzLCfqiwtKuw9P+ReCQnsNrNMrsDhHki7jr2JXsZPNS4sfb9Y3V9lsperustPqu6+EcYAp8gy5m2K9X8tQ17rNBAccbs19WtK0/XOcWWAj3nfJzlN+DQtHtHEagNS3C6ICFKrU3wvTN4dos/M7D3xyZVDCPhKjgrltQMwaq3Q8ojWlMeMT5lsZ+aF9Ppfsq32FfPjy9q3nG7JDM6tz/UiSWBesKwpgMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2bIJGcGWbCjVdFa2oEqE5aHmBkFT7B04fpxP46e2iU=;
 b=j2Opu3lbFq4sOv3mqCccsUZlBNvJkJWtdga0qDNmdoxyZd7xMNC8sAJ0MHFDsuNzkaF4lgYwWXlH4tTdW0DuqewZZZvPphemLVXVu9IfHMxCdZBg03/3vIB+2qVhJ7KLCPxmG/G++CAk74DJkfPDJott5u94HggGL7fVnFe/hQg=
Received: from BN8PR21MB1362.namprd21.prod.outlook.com (20.179.76.155) by
 BN8PR21MB1267.namprd21.prod.outlook.com (20.179.74.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.5; Fri, 20 Sep 2019 21:46:16 +0000
Received: from BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::4506:fd59:ba74:46d]) by BN8PR21MB1362.namprd21.prod.outlook.com
 ([fe80::4506:fd59:ba74:46d%7]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 21:46:15 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>
Subject: RE: [PATCH] perf map: fix overlapped map handling
Thread-Topic: [PATCH] perf map: fix overlapped map handling
Thread-Index: AdVv5y6SzPv23L21QnSQJe3E6wWQgAAA9l0AAAMWwpA=
Date:   Fri, 20 Sep 2019 21:46:15 +0000
Message-ID: <BN8PR21MB1362B1921DF8ABF3A19B43A5F7880@BN8PR21MB1362.namprd21.prod.outlook.com>
References: <BN8PR21MB136261C1A4BB2C884F10FCECF7880@BN8PR21MB1362.namprd21.prod.outlook.com>
 <20190920193852.GI4865@kernel.org>
In-Reply-To: <20190920193852.GI4865@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-20T21:46:14.0220960Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fab38c1b-ef3a-4dc9-9413-1c4e641f36af;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b7fd220-3cfc-4819-9695-08d73e13f6a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR21MB1267;
x-ms-traffictypediagnostic: BN8PR21MB1267:|BN8PR21MB1267:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB126789DFCAE4FA3295D463A7F7880@BN8PR21MB1267.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(189003)(199004)(5660300002)(8936002)(55016002)(99286004)(74316002)(66476007)(2906002)(66066001)(76176011)(6506007)(7416002)(9686003)(229853002)(6916009)(33656002)(10090500001)(54906003)(8676002)(8990500004)(4326008)(81156014)(81166006)(22452003)(256004)(6246003)(7696005)(316002)(107886003)(64756008)(52536014)(3846002)(4744005)(26005)(86362001)(446003)(66446008)(66556008)(186003)(66946007)(6116002)(76116006)(486006)(11346002)(7736002)(102836004)(71200400001)(14454004)(71190400001)(6436002)(10290500003)(305945005)(25786009)(478600001)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1267;H:BN8PR21MB1362.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hIlV3jSG/NDW9wTdFO1w3ahcSRQLhAl7LKNxBNRDaAUFTO6e01tXVpdmJGg+IKSwWM42vSQycOjphlYt+hq3HXFHkn7oV/qEl6OO8xq2pirIuz4etcKC1uNx1q+5SC6kdAyS5w5zMPr93Z65TpmBW0fmKG9G+wgddkx1eCQ113ime+PRz84kMHBL3oxbRHnbDCQNY1eiKT8Ye3R+LEbpEFEDVeIW7SAPbfFDbp1Z1TxnrrnlG+eQVnHzP+te9+MMso7STbtbP1SlcbIq1QHShnyG+ewtwj9YKvNgezsXqJNQtt0+9TbIgZFSr5TFa6OS50XN4kkFQ88Swl1oqm0Ww9qFzMbeHYInO0zpBaPtOZaP/TpndLJeKNRta4nfEERK/6ItTUNrku28/Ghj979PlUHPkaVLbSOqbnVotOfwrTw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7fd220-3cfc-4819-9695-08d73e13f6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 21:46:15.7156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25W/HFk5lFeXPItOrI/f76lHccEczAdJllyU+G7HbZalbERMf4diEKxLJTTGHKBEitS/kDC/DOob6RBsrs9jfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  			after->start =3D map->end;
>> +			after->pgoff =3D pos->map_ip(pos, map->end);
>
> So is this equivalent to what __split_vma() does in the kernel, i.e.:
>
>        if (new_below)
>                new->vm_end =3D addr;
>        else {
>                new->vm_start =3D addr;
>                new->vm_pgoff +=3D ((addr - vma->vm_start) >> PAGE_SHIFT);
>        }
>
> where new->vm_pgoff starts equal to the vm_pgoff of the mmap being split?

It is roughly equivalent.  The pgoff in struct map is stored in bytes not i=
n pages, so it doesn't include the shift.

An earlier version of this patch used:
  			after->start =3D map->end;
+			after->pgoff +=3D map->end - pos->start;

Instead of the newer Functionally equivalent:
  			after->start =3D map->end;
+			after->pgoff =3D pos->map_ip(pos, map->end);

I preferred the latter form as it made more sense with the assertion that t=
he mapping of map->end should match in pos and after.

Steve
