Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5494206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bU+ACQL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCKQsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:48:41 -0400
Received: from mail-eopbgr720045.outbound.protection.outlook.com ([40.107.72.45]:35061
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfCKQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NrZVNwwDDLQc/U9MgeXVIxD9AAgHxAbzu5mwRnz7tc=;
 b=bU+ACQL2D0tBUvG1RgOVGvUYPoXbSXv9tDhOEstXDUkIDdT7D8z0S8LUgN5G3Pu6df8IOJYcgLtsEbKL/Xg3yUEHcSOHZ6T8nXl+dvFtXw2vwgLvAtncVUjAiXiABMG+6CHput4YUIBn6QKlnz/XG+UkeVLIv401HU5ZtkMwm40=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2891.namprd12.prod.outlook.com (20.179.71.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 16:48:37 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:48:37 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [RFC PATCH 0/2] x86/perf/amd: AMD PMC counters and NMI latency
Thread-Topic: [RFC PATCH 0/2] x86/perf/amd: AMD PMC counters and NMI latency
Thread-Index: AQHU2CpGvrvxJvPkeE6o6tNV7tk6yA==
Date:   Mon, 11 Mar 2019 16:48:37 +0000
Message-ID: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0006.namprd04.prod.outlook.com
 (2603:10b6:803:21::16) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e40d5153-01c9-438c-1f72-08d6a6416867
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2891;
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2891;20:bc3sEnqj6QUeGnmpTkUY5SeoyQI05ayWEXmh6uSUxrgNe/LmBcLyxn7ImLlgQXxoZ15VnSlofR4HBrOkE8/chgTwcuLW56JpAx1UsNL/HdZnZiRQ5oyJNwZXSQ/+QM9yexOb+wHVlyi2DlmgNjpG02GzfuXdMKhIOJNGnRnrfoMuS7kPvcM/NcO1yO2gws+ckZCBJd151mrikhmfljUbXYzhCr0YbWAX3sPUXR+n5xGYhahPP5eJez0MHitxQP0t
x-microsoft-antispam-prvs: <DM6PR12MB28919DBEB047C6F992A24143EC480@DM6PR12MB2891.namprd12.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(4326008)(25786009)(6116002)(966005)(72206003)(103116003)(9686003)(102836004)(66066001)(68736007)(186003)(476003)(256004)(478600001)(8676002)(71200400001)(6436002)(97736004)(6486002)(81156014)(81166006)(71190400001)(6512007)(86362001)(316002)(110136005)(54906003)(2906002)(106356001)(7416002)(105586002)(2501003)(53936002)(5660300002)(3846002)(14454004)(486006)(6306002)(26005)(8936002)(7736002)(305945005)(52116002)(6506007)(386003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2891;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t/+FB9NlwNxlfyEBHE8UqNNl9JAI8cMjMq/leON5NwIWXani6uU2+OTNmxTOgBYoaOHKwb8O6OfHqbb2sd9/tFn8cXE/g95WiqmvdLV232njvMCQkP8E84OIUTH7ayjTAUwbmI1HeHbuF1pV40db8NXAHe3VIu7jYAqvrURJISoWPYaM8zSSCE0xqm4lm47QVzc8hJiRJZ2OKfD+cSXXAxavkLtZxfKRr2K6siJ2ZT/55QJtio0eblZiqpG5qX05haiEMSiGwoU69vebrjCzvsPpt0SMNOP0yylI2Eo9vr6iHb/DcxcmCupnufpr0PyPsFPB2lo1UersNt54S8qrXHRhmsHxPnr2x1jjVfzH1lEhNw2N/uInlr3QVg7GdvIECe86uus7uY8JKO/GomUI7xOtRB9AxOTRrJ6mJPVaUXU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC3D7DFB095C1B4BB12BF5BA81A033F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d5153-01c9-438c-1f72-08d6a6416867
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:48:37.5958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcmVzc2VzIGlzc3VlcyB3aXRoIGluY3JlYXNlZCBOTUkgbGF0
ZW5jeSBpbiBuZXdlcg0KQU1EIHByb2Nlc3NvcnMgdGhhdCBjYW4gcmVzdWx0IGluIHVua25vd24g
Tk1JIG1lc3NhZ2VzIHdoZW4gUE1DIGNvdW50ZXJzDQphcmUgYWN0aXZlLg0KDQpUaGUgZm9sbG93
aW5nIGZpeGVzIGFyZSBpbmNsdWRlZCBpbiB0aGlzIHNlcmllczoNCg0KLSBSZXNvbHZlIGEgcmFj
ZSBjb25kaXRpb24gd2hlbiBkaXNhYmxpbmcgYW4gb3ZlcmZsb3dlZCBQTUMgY291bnRlciwNCiAg
c3BlY2lmaWNhbGx5IHdoZW4gdXBkYXRpbmcgdGhlIFBNQyBjb3VudGVyIHdpdGggYSBuZXcgdmFs
dWUuDQotIFJlc29sdmUgaGFuZGxpbmcgb2YgbXVsdGlwbGUgYWN0aXZlIFBNQyBjb3VudGVyIG92
ZXJmbG93cyBpbiB0aGUgcGVyZg0KICBOTUkgaGFuZGxlciBhbmQgd2hlbiB0byByZXBvcnQgdGhh
dCB0aGUgTk1JIGlzIG5vdCByZWxhdGVkIHRvIGEgUE1DLg0KDQpJJ20gbG9va2luZyBmb3IgZmVl
ZGJhY2sgb24gdGhlIGRpcmVjdGlvbiB1c2VkIGluIHRoZXNlIHR3byBwYXRjaGVzLiBJbg0KdGhl
IGZpcnN0IHBhdGNoLCB0aGUgcmVzZXQgY2hlY2sgbG9vcCB0eXBpY2FsbHkgb25seSBydW5zIG9u
ZSBpdGVyYXRpb24sDQphbmQgdmVyeSByYXJlbHkgZXZlciByYW4gMyBvciA0IHRpbWVzLiBJIGFs
c28gbG9va2VkIGF0IGFuIGFsdGVybmF0aXZlIHRvDQp0aGUgZmlyc3QgcGF0Y2ggd2hlcmUgSSBz
ZXQgYSBwZXItQ1BVLCBwZXItUE1DIGZsYWcgdGhhdCBjYW4gYmUgY2hlY2tlZA0KaW4gdGhlIE5N
SSBoYW5kbGVyIHdoZW4gaXQgaXMgZm91bmQgdGhhdCB0aGUgUE1DIGhhc24ndCBvdmVyZmxvd2Vk
LiBUaGF0DQp3b3VsZCBtZWFuIHRoZSBzYW1wbGUgd291bGQgYmUgbG9zdCwgdGhvdWdoIChvbiBh
dmVyYWdlIEkgd2FzIHNlZWluZyBhYm91dA0KYSAwLjIwJSBzYW1wbGUgbG9zcyB0aGF0IHdheSku
DQoNCi0tLQ0KDQpUaGlzIHBhdGNoIHNlcmllcyBpcyBiYXNlZCBvZmYgb2YgdGhlIHBlcmYvY29y
ZSBicmFuY2ggb2YgdGlwOg0KICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90aXAvdGlwLmdpdCBwZXJmL2NvcmUNCg0KICBDb21taXQgYzk3OGI5NDYwZmUx
ICgiTWVyZ2UgdGFnICdwZXJmLWNvcmUtZm9yLW1pbmdvLTUuMS0yMDE5MDIyNScgb2YgZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FjbWUvbGludXggaW50byBw
ZXJmL2NvcmUiKQ0K
