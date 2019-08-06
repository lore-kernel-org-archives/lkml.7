Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE35C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AF42070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hQds1suO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbfHFP7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:59:43 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:12545
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730028AbfHFP7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:59:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia19oBkJWIUYPsZNN3LEEJo8ihhEIUVRbEls+zLzelj+v64hexByvd2HwVwIDmy6oMkfEZSQsW9Xm8Rkz1UT+M5a/plGwRBvmDgyE0gWmNLvv3P2g171sQWoWiIg33Yjr2UnNy50ThsRhYzxLLY45th/EOrCX+urfM6KTauc7lg/4mpJ2ZS5Qi4ZHSf+RbqiBe6MECcPEYyMwwOdC9TvQjmvwSxdFITq+N+8RkS5UgQVw4G7GY5ZOF4wjrv3SLh5+0WgPQ1gL7VQz1tq1NMTLpqc7TITVvtdZvfq9z1SrLddzn5cCe1OyI6Q0MxZA4qceizzpP9kVB+kb9kpOBLFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s50ipMqJ9TIIGsNTYt3I+M9552nfib8XJO14l4pLCnM=;
 b=m1w5fdMm3RFLcA0L5xHFv22FX21/QaRHmoJEnxj/+tzIM0d+H0pWBjCwwkK6rcA7kD5tpQ7aAMDqS52Yhj2HUCJykEvokKJdx8It9zMSEpOtpLqF7RR/OUbrSTX9oHLD0J+wY9dHGQJhaLwUIWx6lwMfOEYNp989BMb1DZlrMFSDLQDkuawvYwjsrEEEiI4iGA/xNRKBsOztKlNr77QQz7dvjx18jD93wSzGGzwbxXONFa7u+doCO+wCN+Igpbw/5iknu+v48gWLO3aJ09u5A0gGgGWG5clQSfwnSB7AtthUOaCl2Tvc3Ok6v8OoP7LafDopOuRDi08hVBB4uwgcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s50ipMqJ9TIIGsNTYt3I+M9552nfib8XJO14l4pLCnM=;
 b=hQds1suO5xt6bRg/MX/6/EiYSC/+URFz1LMDLh+0tY9n3SCpapCvZLAFQcuyJHAUdNargzxTaGRZeqsdLYz20KnnbtHjYVMw2eZAnIaWlb9ePABLSI2y4zqBAORi5a6PjFb+HzRRl7T+rT61VlZaLG/Koc1BP1CdrW5sJl1LJ4c=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3372.namprd12.prod.outlook.com (20.178.198.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 15:59:40 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 15:59:40 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Thread-Topic: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Thread-Index: AQHVTDc5jxhkF6eBGE2vQ7mpw/Pby6bt/Q4AgAAjGICAAAcMAIAAAMsAgAADTYCAABhgAIAAA80A
Date:   Tue, 6 Aug 2019 15:59:40 +0000
Message-ID: <5bd42e33-8077-ea23-a9f3-c575db4edada@amd.com>
References: <1565082809.2323.24.camel@pengutronix.de>
 <20190806113318.GA20215@lst.de>
 <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
 <20190806140408.GA22902@lst.de> <1565100418.2323.32.camel@pengutronix.de>
 <78833204-cd30-1a4b-54e3-1580018c6d57@amd.com>
 <20190806154602.GB25050@lst.de>
In-Reply-To: <20190806154602.GB25050@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0014.namprd07.prod.outlook.com
 (2603:10b6:803:28::24) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e06a7f0-e288-4379-79f2-08d71a8716cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3372;
x-ms-traffictypediagnostic: DM6PR12MB3372:
x-microsoft-antispam-prvs: <DM6PR12MB3372829B3FD37BDAD14D8497ECD50@DM6PR12MB3372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(31696002)(14454004)(81156014)(6916009)(81166006)(6116002)(478600001)(36756003)(446003)(86362001)(68736007)(8676002)(6246003)(52116002)(8936002)(25786009)(99286004)(4326008)(305945005)(53936002)(7736002)(66946007)(316002)(53546011)(66476007)(66556008)(64756008)(66446008)(386003)(229853002)(2906002)(6506007)(71200400001)(486006)(76176011)(6512007)(6436002)(186003)(71190400001)(476003)(66066001)(102836004)(26005)(256004)(11346002)(5660300002)(6486002)(54906003)(3846002)(2616005)(4744005)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3372;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JayTaF7e7m7lsodtjsJdJjNNKNVD6QASYyCaY288FicUNHSsn3eHqfEA7xoGHX93Wy7nhHjezfuhqRKwKy8DxeE8q+keKVrfVi1fE5fvzQiDrmdt91qQDrUkvjbuCG479oDmuz+46T/Q36BFrVn6ovo6VyEsUxPaimEetd23ohc7DtD7vo/EbvB1kG9anXWfs1DBm2o4y1dilehoxaSaEVDiH5VAP0/1lgcU6zWShaajyP3NZ5PDq3uaOp2bubLK1jP/1JiCBQyEFce6OCFdWoDinmF/5Aw0IaeIiRYmOhmToVFo65LbS+pTtXUIxJUSWE/T5Uch93NzfjmQYduSENloabSY2xzz6m8w4f3F84AGmYgvnkvn1gmW9qCUoGO4qAh0m4tmYmIWNbpg8GT0gIg6CpKefQ+up8CS2XCxYOg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BEB945DE66C6D41B88ACA6F1C9FCD23@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e06a7f0-e288-4379-79f2-08d71a8716cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 15:59:40.3964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC82LzE5IDEwOjQ2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVHVlLCBB
dWcgMDYsIDIwMTkgYXQgMDI6MTg6NDlQTSArMDAwMCwgTGVuZGFja3ksIFRob21hcyB3cm90ZToN
Cj4+IEkgdGhpbmsgeW91IG5lZWQgdG8ga2VlcCBldmVyeXRoaW5nIGluc2lkZSB0aGUgb3JpZ2lu
YWwgaWYgc3RhdGVtZW50IHNpbmNlDQo+PiB0aGUgY2FsbGVyIGlzIGV4cGVjdGluZyBhIHBhZ2Ug
cG9pbnRlciB0byBiZSByZXR1cm5lZCBpbiB0aGlzIGNhc2UgYW5kIG5vdA0KPj4gdGhlIHBhZ2Vf
YWRkcmVzcygpIHdoaWNoIGlzIHJldHVybmVkIHdoZW4gdGhlIERNQV9BVFRSX05PX0tFUk5FTF9N
QVBQSU5HDQo+PiBpcyBub3QgcHJlc2VudC4NCj4gDQo+IERNQV9BVFRSX05PX0tFUk5FTF9NQVBQ
SU5HIGlzIGRlZmluZWQgdG8gcmV0dXJuIGFuIG9wYXF1ZSBjb29raWUsDQo+IHdoaWNoIGp1c3Qg
aGFwcGVucyB0byBiZSBhIHBhZ2UgcG9pbnRlci4gIFNvIGlmIHdlIGZpeCB1cCB0aGUgZnJlZSBz
aWRlDQo+IGFzIHBvaW50ZWQgb3V0IGJ5IEx1Y2FzIHdlIHNob3VsZCBiZSBmaW5lLg0KDQpBcyBs
b25nIGFzIHR3byBkaWZmZXJlbnQgY29va2llIHR5cGVzIChwYWdlIHBvaW50ZXIgZm9yIGVuY3J5
cHRlZCBETUENCmFuZCB2aXJ0dWFsIGFkZHJlc3MgcmV0dXJuZWQgZnJvbSBwYWdlX2FkZHJlc3Mo
KSBmb3IgdW5lbmNyeXB0ZWQgRE1BKQ0KaXMgb2suIEknbSBqdXN0IG5vdCBmYW1pbGlhciB3aXRo
IGhvdyB0aGUgY29va2llIGlzIHVzZWQgaW4gYW55IG90aGVyDQpmdW5jdGlvbnMsIGlmIGF0IGFs
bC4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo=
