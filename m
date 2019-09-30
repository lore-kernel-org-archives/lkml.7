Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B28C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC87224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="lQQcHMDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfI3Ut0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:49:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:52671 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfI3UtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:49:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 11:27:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="194279360"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2019 11:27:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 11:27:45 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Sep 2019 11:27:45 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Sep 2019 11:27:45 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.55) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 30 Sep 2019 11:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVo9rP+LU5hpJJRCuJyLUZKXIWJqutUJUlVTiADpHiB0Y2SY8YZ0+6KgEr9hBT2ZqN3KVtA4F9OqcLEX+YcY7oKlAPm6yI8XvSSTaqsi8KhPSGigLs4zRpHjxTy2WJPcNAoAF5+D2gxSJwLaEg+mYv3X+8K64fycvu0wUsnAjvfLfsWTV7/2bTAPpow+MiXpx8juBvMnfvYXeEg46AbsuZbD3MtGHqODtiu6AhTHXYos07CqhwGIaaaoxLn6TZkFJD+l5n8WrHGZGiIPZ3zVkcqwhduXMDljvunW7Bc5+Rauec/ak9v3QywqUH0NtJP8zn+8DKjHKhIcxiVNwvWGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAnu/1ybbLlrux6KbT8hNxkB+iTGFLDF0ZCkR8rnses=;
 b=hBhnu4K60PYS7GxfJtBq9yYQiLe61dBmUvCIqB5kZMyHL/uLRCkz8+gYJj+EYpGPI/+6FY0jpgqGmVK12tuWw+4ms629TLMx3opDuozytkXUBoPu9UhofB+bBEB1IdBM3p8/gRCpwk9j8ERPzemeuhh6tAk2xfLZk1nebhwxxa+aE/yb3ELHmR3CRZPrAzQblaGoba7q5isOC0droQP4h9f8uuAAip6pRjo0RfE1yOn1x3K00f6huJ+q9IsGZ3cikCPoZIjgx1L1aZydWpTnsCXwwknnOFpUdRV3CjZMrjwoYVL96BiBArpZqcUoiymz/Z5alaCM3MDi+3d7qt6D0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAnu/1ybbLlrux6KbT8hNxkB+iTGFLDF0ZCkR8rnses=;
 b=lQQcHMDCjjh2eR+1ok0CXSbYQKKdTfOVMZxLL0Lob+GElN1Xonou3trKRm+uUqRRSc81BlL/TKk8HNIgnF4OTVHD17m1ZAxSNaU1ojaAxN8HueEQdWXuiESx+zSW6plZxmzCMf6HtiLQP2Uu80ivlO2Flhkdn1mq+Jzos8/TVQY=
Received: from BL0PR11MB3170.namprd11.prod.outlook.com (10.167.234.74) by
 BL0PR11MB3364.namprd11.prod.outlook.com (10.167.235.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 18:27:43 +0000
Received: from BL0PR11MB3170.namprd11.prod.outlook.com
 ([fe80::392e:e204:36d0:5351]) by BL0PR11MB3170.namprd11.prod.outlook.com
 ([fe80::392e:e204:36d0:5351%5]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 18:27:43 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core
 driver
Thread-Topic: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core
 driver
Thread-Index: AQHVdJpC9P0UAFBW3ky74xzBGKR04ac/CLOAgAABYgCABYUi4A==
Date:   Mon, 30 Sep 2019 18:27:43 +0000
Message-ID: <BL0PR11MB3170ECF632E1A8C90D26C08CF2820@BL0PR11MB3170.namprd11.prod.outlook.com>
References: <20190926192603.18647-1-gayatri.kammela@intel.com>
 <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
 <CAHp75VfwpYLVn2qWBMK11eR3D5VwnGf7VeYE=cQfq_y78ct75A@mail.gmail.com>
In-Reply-To: <CAHp75VfwpYLVn2qWBMK11eR3D5VwnGf7VeYE=cQfq_y78ct75A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWQzODhmOTktNTc2Zi00OTY0LTg5ZmEtMWM3MzNlZGRmNmE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRlQxeTBkcUI0WXR1WStNUG4wTzdpalBaOE83UUlnTlJ6akVMcDZTSGI2YWJjQUU4T3phN0k5bnZQbUg5cTF2aSJ9
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [134.134.136.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbfa0737-7e0b-4063-456d-08d745d3e281
x-ms-traffictypediagnostic: BL0PR11MB3364:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3364AEB56D59B7622F1DF308F2820@BL0PR11MB3364.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(136003)(346002)(189003)(199004)(316002)(3846002)(81156014)(81166006)(9686003)(6916009)(256004)(55016002)(476003)(86362001)(486006)(186003)(6436002)(8676002)(8936002)(66946007)(478600001)(76116006)(14454004)(66556008)(64756008)(66446008)(446003)(66476007)(229853002)(11346002)(33656002)(74316002)(6506007)(5660300002)(305945005)(4744005)(102836004)(52536014)(7696005)(2906002)(71200400001)(71190400001)(7736002)(26005)(76176011)(4326008)(54906003)(66066001)(25786009)(6246003)(99286004)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3364;H:BL0PR11MB3170.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kErcGuqid1GVcFR2sio02nN6M+PSyYbIj1ASgS0j8nyUCb40Pq7BBVR7RW/KipK9YQ0qYlcwxtCREfyTXEypFZrMKyUawt+diub0Vjsmq+Id8Dnpvjie+e27pQslVX39XPLQH6M+l16ePT+Omo/nIcVbjKnIVBIzTHm4dYljCT85iZHMAboSkhpe7wk7Q3gH0agyy+eIrbrcgQiA3qaVFxLO48mFNOEq5yV3OTS945VRzCAwCx/0ibJ/ky58QyWcIEuAHb5RRMjeAhTGT7dsPKxg1XG1fPAeZZDaOosDV5ZuWAIvcnqtj97EytlpHn+7JMjEvX1CCq+9MS+N0T5O3s/Vzgy7xJlsDIsRx2B0yOGUIp7qRriuqs4T13kv5Qspm2njdg/6yLbn7YM274P7qn768p+md61G4kLa2vjVnGY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfa0737-7e0b-4063-456d-08d745d3e281
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 18:27:43.4494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yI4wrr1K9nMrbGsy1t//IEpJ6DjE5ze82FXhT6s3vsukljDJwXF+mQskqRKCzfCTT91cwJqGOs62hzoth4EzAD2cKi1xbzxHSCAPOtdZ0ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3364
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiB0b3Agb2YgdGhhdCB0aGUgZnVsbHkgaW5jb25zaXN0ZW50IFNvQyBuYW1pbmcgdGhyb3Vn
aCB0aGUgZXhpc3RpbmcgY29kZSAvDQo+IG5ldyBhZGRpdGlvbnMuDQpJIHdpbGwgZml4IGl0IGlu
IHRoZSBleGlzdGluZyBjb2RlL25ldyBhZGRpdGlvbnMgaW4gdjIuDQo+IA0KPiBJJ20gcHJldHR5
IHN1cmUgeW91IG5lZWQgdG8gc3BlbGwgcGxhdGZvcm1zIGFzIFRpZ2VyIExha2UsIEVsa2hhcnQg
TGFrZSBhbmQgc28NCj4gb24gZXZlcnl3aGVyZS4NClNvcnJ5LCBJIHdhcyBjYXJlZnVsIGFib3V0
IG5hbWluZyBjb252ZW50aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZSBidXQgbm90IGluIHRoZSBj
b21tZW50cyDimLkuIEkgd2lsbCBmaXggaXQgaW4gdjIuDQo+IA0KPiBGaXggdGhpcywgYnV0IGRv
IG5vdCBzZW5kIG5ldyB2ZXJzaW9uIHRpbGwgSSBsb29rIGF0IHRoZSBjb2RlIGhlcmUuDQpTdXJl
IEFuZHkhIEkgd2lsbCB3YWl0LiBUaGFua3MhDQo+IA0K
