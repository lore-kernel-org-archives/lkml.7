Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E00DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0198B217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GT7nCb+j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="72EWRZUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394573AbfITBOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 21:14:02 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:57095
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390887AbfITBOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 21:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1KkM5fZImdSNy1gmcbT119lrd2a/vJKKKXVUAyt78U=;
 b=GT7nCb+jigfRsLkYo3LgyRB3fmUk+UI3ok9/vZL+3ZG/9ePqwAZmxuggR8qPJxsLdjFUrju/NEE0z7Ksqg5yXhsp1XdffMmOaEQwwj3000XmRwZHebMssot1c8EXhNo+hdSzAQKiUag+ozvT9oKQ6+qzqC/2bVU23uf8bDhjeXs=
Received: from VI1PR08CA0263.eurprd08.prod.outlook.com (2603:10a6:803:dc::36)
 by DB8PR08MB5068.eurprd08.prod.outlook.com (2603:10a6:10:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.26; Fri, 20 Sep
 2019 01:13:50 +0000
Received: from DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR08CA0263.outlook.office365.com
 (2603:10a6:803:dc::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.21 via Frontend
 Transport; Fri, 20 Sep 2019 01:13:50 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT060.mail.protection.outlook.com (10.152.21.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Fri, 20 Sep 2019 01:13:48 +0000
Received: ("Tessian outbound 96594883d423:v31"); Fri, 20 Sep 2019 01:13:43 +0000
X-CR-MTA-TID: 64aa7808
Received: from e3994bbb2da5.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5B0B114F-BF0B-4C36-BBDD-355AAF049B60.1;
        Fri, 20 Sep 2019 01:13:38 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2059.outbound.protection.outlook.com [104.47.1.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e3994bbb2da5.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Sep 2019 01:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRHhj4kFbkv3O3yKvYmw3DFN/Oe9TSIORwilNdM3sQcFGVk5KXv9mD7fltQbFZULAUaW18zcRqTZfG4y7msCOk0mZAI5/v5hX/eieC0PfYTgHRqmSoPK48TG1lylyPcJwsiIE7qon8TKl6xFf2aK70xUzF6Vn5CHbl24gV0/j04dgPsGRDv9zI7JesMd6TtsGfy+4AVdoCHppomL5iGVgjrID55GXbzBmO7+Uav8+vWFdHuk0S5zKDzRpV9IljI/0k4mx4NzRKI9qdbooSuays/OQD6GaXpfaO82oAAoyB8s4gLUACJzOoNbx8H5MQhUszNXStpf6Ha9njlJDVmfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3zQfSGz4tvuC6JL4RNyaAokj+vDYHcNuD9daKD7P6Y=;
 b=J9N0QnAK3Mf4Xthtv3HgwX3DWBfYaMJGqkxzhr1MiFpReGycwV6NSuflXXyZUTvy2rUqJh2rTmJakob1hNa8ZgsHxj3hALPNdXNV25UZ5UW4aDmox8DmOHaBnkqvUGrj8Iqgfg4aL20fQ5yyfjh+iH+QwTYg8fBefdV7DKX49yo34x4Gs+NGwGFXicGauRvDnNoe9JkEVXRAmqccVPXnZ0fqSkS+0RxXgAQaaKoXBI3CfzEsiTQ1pcLCKe+0IGyB54XOe+1PPRVAW6zyF7BsKUCR2WcjkIWw+LpynpQvEiW6WRMQ7EXd3AIutWsyIvVwshKjkkRm6CYaA4VHFaEIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3zQfSGz4tvuC6JL4RNyaAokj+vDYHcNuD9daKD7P6Y=;
 b=72EWRZUFbxdJYaD1LhdNKKXJ4KQwLnyWTUSKdOupxjzWC7LwGLXiP5TSY8sPovuTGHcRymQ0iz7YH8pmC9rv07T8q0spnKw/DYWCiJAOZ8hm5oPigzZswqMWTs5LIunYNk623GAFC3MnDLc5abic6Dq/VXGL7mo6LypbEj1qtR8=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3738.eurprd08.prod.outlook.com (20.178.46.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 01:13:35 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d%5]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 01:13:35 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>
Subject: RE: [PATCH v5 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Topic: [PATCH v5 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Index: AQHVbwURI1klOwh68Uid9C9C9CS8OqczNE0AgACOsVA=
Date:   Fri, 20 Sep 2019 01:13:35 +0000
Message-ID: <DB7PR08MB3082C31A8A19B157FD5380A4F7880@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190919161204.142796-1-justin.he@arm.com>
 <20190919161204.142796-4-justin.he@arm.com>
 <20190919164206.GE6472@arrakis.emea.arm.com>
In-Reply-To: <20190919164206.GE6472@arrakis.emea.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 0667d540-0fd0-48bd-99dd-33fca3044ab0.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8ef9f62b-4fed-49c5-bfe2-08d73d67cad4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3738;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3738:|DB7PR08MB3738:|DB8PR08MB5068:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB506847AB451B16F9709E71A7F7880@DB8PR08MB5068.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:6108;
x-forefront-prvs: 0166B75B74
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(13464003)(189003)(199004)(229853002)(2906002)(86362001)(54906003)(76116006)(7696005)(76176011)(71200400001)(81156014)(71190400001)(14454004)(66476007)(66946007)(8676002)(6116002)(81166006)(3846002)(25786009)(8936002)(6636002)(99286004)(478600001)(316002)(33656002)(446003)(53546011)(476003)(5660300002)(7736002)(11346002)(6506007)(66574012)(305945005)(7416002)(55016002)(6246003)(256004)(14444005)(66066001)(26005)(6862004)(6436002)(52536014)(102836004)(55236004)(186003)(486006)(74316002)(66556008)(64756008)(66446008)(4326008)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3738;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: kwPbwb0Mdn3ulflA1RhcgBO9Qh0c3Wg2vaDM/1wiU57dY8e3X7ypsPoDuC9+j64gcK80Fnna3kOrtF2QSVtblhqyTQ56dwFSwyQgoeVaolQvi8vUpXWWTGweVGgPAY7efdCpIZmEcWYF0oYMopZowc2ps8KUc5v6rgEVPmDifW+9zqk022BKdYf9QuWyYllT/PdIl4v8UsoAxn7XMOORlkU31ovxX3EYtXbH1TkkmKUYEfl2ICTsEY3d6UReHwloFafRHmB/mtMs3B5P9BGZvTpq1EhdAEuUMhZIJFNebkZy91hSTtQrR9mshB8LldI2Dbz4JIJgqh5++thaYIZ+vqzcD6yXy+hMUIu7llmyR+Cyo8znNK989INR3rN7gudGZV6Kx/VlyTZaj8vo7tb7otQJ0pHPnPVWDFIA/qwBIRc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3738
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(199004)(189003)(13464003)(40434004)(7736002)(26826003)(305945005)(11346002)(66574012)(336012)(14454004)(22756006)(446003)(81156014)(436003)(8676002)(81166006)(63350400001)(47776003)(6862004)(476003)(66066001)(486006)(8936002)(6116002)(3846002)(478600001)(229853002)(4326008)(74316002)(6636002)(33656002)(86362001)(5660300002)(50466002)(126002)(6246003)(76130400001)(5024004)(14444005)(54906003)(25786009)(70206006)(70586007)(356004)(52536014)(53546011)(6506007)(102836004)(55016002)(2906002)(23676004)(7696005)(99286004)(186003)(76176011)(26005)(316002)(2486003)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5068;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2c76bf8e-b96a-415b-4363-08d73d67c2be
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR08MB5068;
X-Forefront-PRVS: 0166B75B74
X-Microsoft-Antispam-Message-Info: gOF5Y+8VbN2eokUZTearfV+sX/yKxvAaX3kNJQDYMTcPunRY7zf8/kMTbBPWaPqCKFJfag2prQ3WunPtX3zp6ygOt+Pc4xvBTPcFHbf9RvJsr++nF4pOYLDmeRnKbKlAmlvaDL9fDaNUdcI1HIxq8VaQD+d9saIpiTvlWEe8eUZG7SUkwyXH1SzpgrO6gMQawLJc6YKFUHGd24y/WW0Uq7993GIWLYuemj9U+RUXjn3p+9KTBgBNje8HAMRWKmozzZxpfnz8LXRhLoi9wX4+kqAw3jBLvrbEs9eDtWX8TNU+QqfG+ugl29urJfRNXVtjuQSxKbmqVLCkSPPqSW21hpVWuYIRndd4N7CYBQd+JP+JdfYkcqLOlq+zhIgVneUgffyHlLtIzgrDrnp0bBjH2UnuKyryfRMN+T6D7UoQVHM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 01:13:48.9580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef9f62b-4fed-49c5-bfe2-08d73d67cad4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2F0YWxpbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENhdGFs
aW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IFNlbnQ6IDIwMTnlubQ55pyI
MjDml6UgMDo0Mg0KPiBUbzogSnVzdGluIEhlIChBcm0gVGVjaG5vbG9neSBDaGluYSkgPEp1c3Rp
bi5IZUBhcm0uY29tPg0KPiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IE1hcmsg
UnV0bGFuZA0KPiA8TWFyay5SdXRsYW5kQGFybS5jb20+OyBKYW1lcyBNb3JzZSA8SmFtZXMuTW9y
c2VAYXJtLmNvbT47IE1hcmMNCj4gWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+OyBNYXR0aGV3IFdp
bGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IEtpcmlsbCBBLg0KPiBTaHV0ZW1vdiA8a2lyaWxs
LnNodXRlbW92QGxpbnV4LmludGVsLmNvbT47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtbUBr
dmFjay5vcmc7IFN1enVraSBQb3Vsb3NlIDxTdXp1a2kuUG91bG9zZUBhcm0uY29tPjsgUHVuaXQN
Cj4gQWdyYXdhbCA8cHVuaXRhZ3Jhd2FsQGdtYWlsLmNvbT47IEFuc2h1bWFuIEtoYW5kdWFsDQo+
IDxBbnNodW1hbi5LaGFuZHVhbEBhcm0uY29tPjsgQWxleCBWYW4gQnJ1bnQNCj4gPGF2YW5icnVu
dEBudmlkaWEuY29tPjsgUm9iaW4gTXVycGh5IDxSb2Jpbi5NdXJwaHlAYXJtLmNvbT47DQo+IFRo
b21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC0NCj4gZm91bmRhdGlvbi5vcmc+OyBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0
LmNvbT47IFJhbHBoIENhbXBiZWxsDQo+IDxyY2FtcGJlbGxAbnZpZGlhLmNvbT47IGhlamlhbmV0
QGdtYWlsLmNvbTsgS2FseSBYaW4gKEFybSBUZWNobm9sb2d5DQo+IENoaW5hKSA8S2FseS5YaW5A
YXJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAzLzNdIG1tOiBmaXggZG91YmxlIHBh
Z2UgZmF1bHQgb24gYXJtNjQgaWYgUFRFX0FGDQo+IGlzIGNsZWFyZWQNCj4NCj4gT24gRnJpLCBT
ZXAgMjAsIDIwMTkgYXQgMTI6MTI6MDRBTSArMDgwMCwgSmlhIEhlIHdyb3RlOg0KPiA+IEBAIC0y
MTUyLDcgKzIxNjMsMjkgQEAgc3RhdGljIGlubGluZSB2b2lkIGNvd191c2VyX3BhZ2Uoc3RydWN0
IHBhZ2UNCj4gKmRzdCwgc3RydWN0IHBhZ2UgKnNyYywgdW5zaWduZWQgbG8NCj4gPiAgICAgICov
DQo+ID4gICAgIGlmICh1bmxpa2VseSghc3JjKSkgew0KPiA+ICAgICAgICAgICAgIHZvaWQgKmth
ZGRyID0ga21hcF9hdG9taWMoZHN0KTsNCj4gPiAtICAgICAgICAgICB2b2lkIF9fdXNlciAqdWFk
ZHIgPSAodm9pZCBfX3VzZXIgKikodmEgJiBQQUdFX01BU0spOw0KPiA+ICsgICAgICAgICAgIHZv
aWQgX191c2VyICp1YWRkciA9ICh2b2lkIF9fdXNlciAqKShhZGRyICYgUEFHRV9NQVNLKTsNCj4g
PiArICAgICAgICAgICBwdGVfdCBlbnRyeTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgLyogT24g
YXJjaGl0ZWN0dXJlcyB3aXRoIHNvZnR3YXJlICJhY2Nlc3NlZCIgYml0cywgd2Ugd291bGQNCj4g
PiArICAgICAgICAgICAgKiB0YWtlIGEgZG91YmxlIHBhZ2UgZmF1bHQsIHNvIG1hcmsgaXQgYWNj
ZXNzZWQgaGVyZS4NCj4gPiArICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICBpZiAoYXJj
aF9mYXVsdHNfb25fb2xkX3B0ZSgpICYmICFwdGVfeW91bmcodm1mLT5vcmlnX3B0ZSkpDQo+IHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jayh2bWYtPnB0bCk7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICBpZiAobGlrZWx5KHB0ZV9zYW1lKCp2bWYtPnB0ZSwgdm1mLT5vcmlnX3B0
ZSkpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudHJ5ID0gcHRlX21reW91
bmcodm1mLT5vcmlnX3B0ZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChw
dGVwX3NldF9hY2Nlc3NfZmxhZ3Modm1hLCBhZGRyLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZtZi0+cHRlLCBlbnRyeSwgMCkpDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXBkYXRlX21tdV9jYWNoZSh2
bWEsIGFkZHIsIHZtZi0NCj4gPnB0ZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICB9IGVsc2Ug
ew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBPdGhlciB0aHJlYWQgaGFzIGFs
cmVhZHkgaGFuZGxlZCB0aGUNCj4gZmF1bHQNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICogYW5kIHdlIGRvbid0IG5lZWQgdG8gZG8gYW55dGhpbmcuIElmIGl0J3MNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICogbm90IHRoZSBjYXNlLCB0aGUgZmF1bHQgd2lsbCBi
ZSB0cmlnZ2VyZWQNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICogYWdhaW4gb24g
dGhlIHNhbWUgYWRkcmVzcy4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKHZtZi0+cHRs
KTsNCj4NCj4gUmV0dXJuaW5nIHdpdGggdGhlIHNwaW5sb2NrIGhlbGQgZG9lc24ndCBub3JtYWxs
eSBnbyB2ZXJ5IHdlbGwgOykuDQpZZXMsIG15IGJhZC4gV2lsbCBmaXggYXNhcA0KDQotLQ0KQ2hl
ZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRz
IG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBt
YXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNj
bG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVy
cG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhh
bmsgeW91Lg0K
