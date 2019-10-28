Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A01CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B5A21783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XdGGpAvE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="YnaKQ8o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404081AbfJ1RNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:13:31 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:54628 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbfJ1RNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:13:31 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6D184C0D0F;
        Mon, 28 Oct 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1572282811; bh=TQOzGCwZxYKVSix5VA4u9hGGaiQGKOAnP1BoqO3XY/8=;
        h=From:To:CC:Subject:Date:From;
        b=XdGGpAvELxRP/kFd89GtXVSW7MCdao+y43j8HEhxnGNKbSHdWaFfAh+C43v984qal
         dMOs++dVQlwBtJg3ho3du6Z1TmKeaXykvjgIq1d6xas4VwS1uEPr2oHILsBdOm4KTr
         aIVWnjL4r61gq+XaQnjOdHowlcBEmIbLCt8sR3jNqvY7WsMnjHzLzifQAoXCAdDh9n
         st0/SpZrS1/d6Ng6Dv5zIKmO50BtB7BGrvGs9lOhyFSaM9q/w0ZlR6Aas7OyFmUTTu
         FCFPM6qYYu9eEg0w2UGGkIiq2I3N769FqIqLzf1wRU1LN0pDFWLXfZX3N2XUtji2ng
         MAwMERE/XirZQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F08E0A0079;
        Mon, 28 Oct 2019 17:13:28 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 28 Oct 2019 10:12:36 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 28 Oct 2019 10:12:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNXlAdoXKyQldFJ/puo1RGo7Flmmc1zQnZ4f6v0Rfi9ri8E+zyeVb20UupX1RqSEUrsqRKTUa+QWI859eDVXi8w94casNk1JuTa25sI4T7P9w4DUHXTyNnr4ZoVH7lHX3rQniMhjsq+azM6zS8zOPXskqFYr02GnaGgY6r1Ogv2xYjRHH0l3IWByrhTl5NRQOLsPondDazOs42sIIM1QesyP/bBTcyRp8CcK/qHuhpTdhvcBzIhYT0B9Cqw5WREmKO6wwt6qbJpUjPpZezhJT2rZH25XGISlxFVBmLDs72QTS6uzcXpKbZ2K8D3yiK5W98z0xAGDF/T1wcja7V6EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQOzGCwZxYKVSix5VA4u9hGGaiQGKOAnP1BoqO3XY/8=;
 b=PM3fabDC8ZyAZB/PGL329QGbkzIOq3/gLjS2BfXOgiGM8AgTRCGm+8/+RJsQq55fM9Gwk/fxX0TqxiYz9gCa+su3bliQmSPh2g78kb0Kff1iApiayY8SAz1XB+Z+LMMSVXEudzBvq5F6J0lOb4EYKhj/0txKPVyKz+Tcs8lMrOoA1FXrelzJtTf5JWFeb1Vs86LqNjMFt1mTlwK05N44d6g7LGTDAdrezKpD2wV2VT9jF4SGHPwT9nCp2T6haLl79o1Iv6XYV+Hw8UkEixsaC/7QDvBRwUovj9I4fhArBb9bjckyqHdtDFm+zyTFQPqBo0l2F3fPJUFm486wccwMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQOzGCwZxYKVSix5VA4u9hGGaiQGKOAnP1BoqO3XY/8=;
 b=YnaKQ8o4uV/Rao57XIkR+haqnH6WJ1i7c/qNiiggPOEDPMFl7f4Uzg07OBLWGlUFO/zBhRJVqcHBcww+ffQLGjSI3PiqEYFCDE+KYtlZdbAIVl/JO8sb9OSbYAYF6s8sgUTGRQe96IMTsDx76e5Pbpr+D2/Qd547BoL6PhQbkDQ=
Received: from DM6PR12MB4089.namprd12.prod.outlook.com (10.141.184.211) by
 DM6PR12MB3051.namprd12.prod.outlook.com (20.178.30.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 17:13:18 +0000
Received: from DM6PR12MB4089.namprd12.prod.outlook.com
 ([fe80::19df:560:b8d3:e1cd]) by DM6PR12MB4089.namprd12.prod.outlook.com
 ([fe80::19df:560:b8d3:e1cd%5]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 17:13:18 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: [GIT PULL] ARC updates for 5.4-rc6
Thread-Topic: [GIT PULL] ARC updates for 5.4-rc6
Thread-Index: AQHVjbL+XnRHWNd0xkWypiJK2GmH5Q==
Date:   Mon, 28 Oct 2019 17:13:18 +0000
Message-ID: <7ad0416c-af35-48e9-2d79-479d4a9d3e85@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1990a7b-f0c2-483b-dbc9-08d75bca20e3
x-ms-traffictypediagnostic: DM6PR12MB3051:
x-microsoft-antispam-prvs: <DM6PR12MB3051BA644DAD48D2D0307316B6660@DM6PR12MB3051.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39860400002)(136003)(189003)(199004)(31696002)(6486002)(14454004)(4001150100001)(7736002)(4326008)(8936002)(99286004)(256004)(186003)(5660300002)(6436002)(76116006)(305945005)(25786009)(66066001)(65956001)(65806001)(58126008)(316002)(71200400001)(71190400001)(54906003)(36756003)(478600001)(2616005)(6506007)(8676002)(26005)(6512007)(476003)(6916009)(2906002)(31686004)(86362001)(81156014)(81166006)(66446008)(64756008)(66946007)(66556008)(66476007)(102836004)(6116002)(486006)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3051;H:DM6PR12MB4089.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDMNUr7cC79wENae5o6NCYQz7S3F1xkfs+4I5N9HIk+GkA8q4AUCJFr268gPC6Txd7kC9vER8ep2MhaRw/obMmRZj/JLr0X2PGlzUI0pm6U/gPVs64U405+/lz99MCUw4FgEnINy/j5eVVfZ8D/6pdxeNh+yUb3Y5qvmC9niQNtwZA8i+dQOAOoej3w1dfTaNt/6Ztj49QS0xciCXZzfbN08GbCpkA2GDy5w4ACNliNW/lqb75iECdJIp/YIKNNZ8/yW4gtqyut8tNTwuhp+YMmSzqovsBYs6gSBehuB83DHexxKovpU2zfRV8wsnnjdJlRupQ12z2RSlQ3kODkg8GsovRbowKVq7OLgD+BmT2jfB8OnBGPTK/YZWeE8J97xvtUfgVB1jQOFQdmuSMTHYkygZDfebj5fClS9C0yrXjYc8Dx4kGe2jsg2T6txlPl3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F479E99372690842B1584CD70F98DBDE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b1990a7b-f0c2-483b-dbc9-08d75bca20e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 17:13:18.8872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAl5AxiG22bIgDFTbCvmLlguLDXswmuzZhVRUHmOFtFsd34RfsBPK4Fj6s6NhgNcsOE/HQQd6/G/JhwoXNFT2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3051
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClNtYWxsIGZpeGVzIGZvciBBUkMuIFBsZWFzZSBwdWxsLg0KDQpUaHgsDQot
VmluZWV0DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+DQpUaGUgZm9sbG93aW5nIGNoYW5n
ZXMgc2luY2UgY29tbWl0IDdkMTk0YzIxMDBhZDJhNmRkZWQ1NDU4ODdkMDI3NTQ5NDhjYTUyNDE6
DQoNCiAgTGludXggNS40LXJjNCAoMjAxOS0xMC0yMCAxNTo1NjoyMiAtMDQwMCkNCg0KYXJlIGF2
YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3ZndXB0YS9hcmMuZ2l0LyB0YWdzL2FyYy01LjQt
cmM2DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA1ZWZmYzA5YzQ5MDc5MDFmMGU3
MWU2OGU1ZjJlMTQyMTFkOWEyMDNmOg0KDQogIEFSQzogcGVyZjogQWNjb21tb2RhdGUgYmlnLWVu
ZGlhbiBDUFUgKDIwMTktMTAtMjIgMDk6NTk6NDMgLTA3MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkFSQyBmaXhl
cyBmb3IgNS40LXJjNg0KDQogLSBwZXJmIGZpeCBmb3IgQmlnIEVuZGlhbiBidWlsZCBbQWxleGV5
XQ0KDQogLSBoYWRrIHBsYXRmb3JtIGVuYWJsZSBzb2VtIHBlcmlwaGVyYWxzIFtFdWdlbml5XQ0K
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpBbGV4ZXkgQnJvZGtpbiAoMSk6DQogICAgICBBUkM6IHBlcmY6IEFjY29tbW9k
YXRlIGJpZy1lbmRpYW4gQ1BVDQoNCkV1Z2VuaXkgUGFsdHNldiAoMik6DQogICAgICBBUkM6IFtw
bGF0LWhzZGtdOiBFbmFibGUgb24tYm9hcmQgU1BJIE5PUiBmbGFzaCBJQw0KICAgICAgQVJDOiBb
cGxhdC1oc2RrXTogRW5hYmxlIG9uLWJvYXJkaSBTUEkgQURDIElDDQoNCiBhcmNoL2FyYy9ib290
L2R0cy9oc2RrLmR0cyAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCiBhcmNoL2Fy
Yy9jb25maWdzL2hzZGtfZGVmY29uZmlnIHwgIDYgKysrKysrDQogYXJjaC9hcmMva2VybmVsL3Bl
cmZfZXZlbnQuYyAgICB8ICA0ICsrLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo=
