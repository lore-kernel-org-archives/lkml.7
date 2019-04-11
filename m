Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6940CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5B02070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uwy.onmicrosoft.com header.i=@uwy.onmicrosoft.com header.b="BMF4f9R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDKTuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:50:10 -0400
Received: from mail-eopbgr700116.outbound.protection.outlook.com ([40.107.70.116]:5856
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbfDKTuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwy.onmicrosoft.com;
 s=selector1-uwyo-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtZcc232sDjIOg5/3pirgpAMyf8Ya5oaT+yFewo9bQc=;
 b=BMF4f9R1jdjTdnW5PaqDjumvgnxZLaWZl9pmuoCtt9P5WRBkWAQCDwMGA/8STzorA99l5y64J6wzJJO8GpqfLznEeCX9JJp16z7hYCY0r2ZWc+umN63aVP9EZ1gOTbZaAqyhj811sYSp/ODlM+wdrw4VMw/K3xFb7/eCO+ir3jM=
Received: from DM6PR05MB5259.namprd05.prod.outlook.com (20.177.223.223) by
 DM6PR05MB5721.namprd05.prod.outlook.com (20.176.123.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.10; Thu, 11 Apr 2019 19:50:06 +0000
Received: from DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::ed6e:ffe4:83a:29c7]) by DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::ed6e:ffe4:83a:29c7%4]) with mapi id 15.20.1792.007; Thu, 11 Apr 2019
 19:50:06 +0000
From:   "Robert R. Howell" <RHowell@uwyo.edu>
To:     Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Topic: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Index: AQHU6eBClqunF/byekqefGejWfaC+aYqIfOAgAcThICAAL18AIAFeNOA
Date:   Thu, 11 Apr 2019 19:50:06 +0000
Message-ID: <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
In-Reply-To: <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [208.45.13.3]
x-clientproxiedby: CY4PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:903:99::34) To DM6PR05MB5259.namprd05.prod.outlook.com
 (2603:10b6:5:7f::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RHowell@uwyo.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d43956c-238c-45ba-6e5b-08d6beb6e523
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR05MB5721;
x-ms-traffictypediagnostic: DM6PR05MB5721:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR05MB5721D63E45BAF710B71CACABD32F0@DM6PR05MB5721.namprd05.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(31696002)(486006)(71200400001)(6116002)(80792005)(3846002)(71190400001)(106356001)(105586002)(66066001)(65956001)(5660300002)(186003)(65806001)(54906003)(52116002)(110136005)(316002)(386003)(6506007)(2501003)(99286004)(102836004)(2616005)(476003)(11346002)(446003)(2906002)(76176011)(26005)(256004)(58126008)(36756003)(72206003)(478600001)(65826007)(6306002)(14454004)(53936002)(93886005)(786003)(6486002)(14444005)(4326008)(75432002)(6246003)(88552002)(81166006)(25786009)(8676002)(6436002)(8936002)(81156014)(6512007)(97736004)(7736002)(86362001)(229853002)(31686004)(64126003)(305945005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR05MB5721;H:DM6PR05MB5259.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uwyo.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LTxfmJkyvMHWHxJb8Ncar6mW5SuzFcVmuEKJlU34E0eyvoLvBXPd5zl4G+8Gndll20KNAn+7xAXcD3cFOKocYHPFxtluvBiJ2SV+QFPpiebuhk4e7ODZiqhbW0UnU41PVOCtVZf1a6b+3d+E9Atzm+gG8rqgzz9KuhZ8NJkjzj5PqyUngN7GgWyjf+aBsN026d286jghrM8ycP5mMtwACI0uBOAV3Pd7niEQK2yGbGpckEu7puspbZ/FKY8k1379ujazpY7WJkm7oWLM6askidqsi1vLkr0K4su8Tc4hKnqrxntgWZtj+gH93Nh5Y2C2b18MR+LNkITP+RU+hRITQiboZUTZfKxtvmYhy+AGN3ArvPM5h6djRZ3UFLTVFj8t6ZKOq9k6BRVZN/mU+XIqVrFjPr8O11ixr1Xx/7Hr/FM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D16BFB7A35251D49BD198ED859E83233@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uwyo.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d43956c-238c-45ba-6e5b-08d6beb6e523
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 19:50:06.2567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9cdd7ad-825d-4601-8e9c-a325e02d52da
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC84LzE5IDI6MTYgQU0sIEhhbnMgZGUgR29lZGUgd3JvdGU6PiANCj4gDQo+IEhtbSwgaW50
ZXJlc3Rpbmcgc28geW91IGhhdmUgaGliZXJuYXRpb24gd29ya2luZyBvbiBhIFQxMDBUQQ0KPiAo
d2l0aCA1LjAgKyAwMmU0NTY0NmQ1M2IgcmV2ZXJ0ZWQpLCByaWdodCA/DQo+IA0KSGkgSGFucyBh
bmQgS2FpLUhlbmcNCg0KRmlyc3QsIGFwb2xvZ2llcyBmb3IgaG93IGxvbmcgaXQgdG9vayBtZSB0
byByZXBseSB0byBib3RoIHlvdXIgaW5xdWlyaWVzLiAgDQpJbiB0cnlpbmcgdG8gYW5zd2VyIHRo
ZW0gSSBkaXNjb3ZlcmVkIHNvbWUgaW5jb25zaXN0ZW5jaWVzIGluIGhvdyB0aGUgVDEwMFRBIHdh
cyANCmJlaGF2aW5nIG9uIGRpZmZlcmVudCBoaWJlcm5hdGlvbiBhdHRlbXB0cyBhbmQgSSd2ZSBi
ZWVuIHRyeWluZyB0byBzb3J0IHRob3NlIG91dC4gIA0KSSBoYXZlbid0IGJlZW4gY29tcGxldGVs
eSBzdWNjZXNzZnVsIGluIHRoYXQsIGJ1dCBoZXJlJ3MgYSBicmllZiBzdW1tYXJ5Lg0KDQpZZXMg
SSBkbyBoYXZlIGhpYmVybmF0aW9uIHdvcmtpbmcgKGF0IGxlYXN0IG1vc3Qgb2YgdGhlIHRpbWUp
IG9uIGEgVDEwMFRBLCANCndpdGggNS4wICsgMDJlNDU2NDZkNTNiIHJldmVydGVkIChtb3JlIGFi
b3V0IHRoYXQgYmVsb3cpLCBhbmQgd2l0aCBhIHN5c3RlbWQgDQpoaWJlcm5hdGUgc2NyaXB0IGFs
c28gZGVzY3JpYmVkIGJlbG93Lg0KDQpUcnlpbmcgdG8gYmUgbW9yZSBxdWFudGl0YXRpdmUgYWJv
dXQgIm1vc3Qgb2YgdGhlIHRpbWUiIGlzIGluIHBhcnQgd2FudCBJJ3ZlIGJlZW4gDQp0ZXN0aW5n
IHRoZSBsYXN0IGZldyBkYXlzLiAgSSBqdXN0IGZpbmlzaGVkIGEgY3ljbGUgb2YgMjAgaGliZXJu
YXRlcy9yZXN1bWVzIA0Kd2hpY2ggd2VyZSBhbGwgc3VjY2Vzc2Z1bCBhdCBsZWFzdCBpbiB0aGUg
c2Vuc2UgdGhhdCBhZnRlciByZXN1bWUgaW50ZXJuYWwgDQpzb3VuZCB3YXMgd29ya2luZywgYWxv
bmcgd2l0aCBhbGwgdGhlIG90aGVyIGNyaXRpY2FsIGZ1bmN0aW9ucyBJIGNhcmUgYWJvdXQgDQoo
V2lGaSwgQmx1ZXRvb3RoLCBldGMuKS4gIEhvd2V2ZXIgSSBoYXZlIG9jY2FzaW9uYWxseSAocGVy
aGFwcyAxIGluIDEwIHRpbWVzKSANCnNlZW4gc29tZXRoaW5nIGdvIHdyb25nIHdpdGggc291bmQg
b24gcmVzdW1lIGFuZCB0aGUgb25seSB3YXkgdG8gZ2V0IGl0IA0Kd29ya2luZyBhZ2FpbiB3YXMg
dG8gYSBmdWxsIHJlYm9vdC4gIER1cmluZyB0aGUgc3VjY2Vzc2Z1bCBjeWNsZXMgSSBhbHNvIA0K
c29tZXRpbWVzIHNlZSBpMmNfZGVzaWdud2FyZSBvciBpbnRlbF9zc3RfYWNwaSBlcnJvciBtZXNz
YWdlcyBidXQgdGhleSANCmRvbid0IHNlZW0gdG8gaW5kaWNhdGUgYW4gdW5yZWNvdmVyYWJsZSBm
YWlsdXJlLiAgSSB3YXMgaG9waW5nIHRvIHNvcnQgb3V0IA0Kd2hhdCBlcnJvcnMgSSB3YXMgc2Vl
biBvbiB0aGUgb2NjYXNpb25zIHdoZXJlIHNvdW5kIHdhcyBsb3N0IHRpbGwgYSByZWJvb3QsIA0K
YnV0IHRob3NlIGFyZSByYXJlIGVub3VnaCBJIGhhdmVuJ3QgYmVlbiBhYmxlIHRvIHNvcnQgb3V0
IHRoZSBkaWZmZXJlbmNlIA0KYmV0d2VlbiB0aG9zZSBhbmQgdGhlICJyZWNvdmVyYWJsZSIgZXJy
b3JzLg0KDQpSZWdhcmRpbmcgdGhlIHJldmVydCBvZiAwMmU0NTY0NmQ1M2IsIHRoZXJlIHdlcmUg
c29tZSBjb2RlIGNoYW5nZXMgaW4gDQphZGphY2VudCBsaW5lcyBzbyBhIHNpbXBsZSByZXZlcnQg
d291bGRuJ3QgYXBwbHkgY2xlYW5seSB0byA1LjAuMCANCmJ1dCB0aGUgY2hhbmdlcyB3ZXJlIHNt
YWxsIGVub3VnaCB0aGF0IEkgd2FzIGFibGUgdG8gbWFudWFsbHkgIm1lcmdlIiANCnRoZSByZXZl
cnQgYW5kIHRoZSA1LjAuMCBjaGFuZ2VzLiAgSSBoYXZlIHBvc3RlZCBhIHBhdGNoIGZpbGUgdW5k
ZXINCkJ1Z3ppbGxhOiA8aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0yMDIxMzk+DQpzaG93aW5nIHdoYXQgSSBhY3R1YWxseSBkaWQgdG8gcmV2ZXJ0IDAyZTQ1NjQ2
ZDUzYiBmb3IgNS4wLjAuICBBcyBJIG1lbnRpb25lZCANCmluIGFuIGVhcmxpZXIgbWVzc2FnZSwg
SSBoYXZlIE5PVCBiZWVuIGFibGUgdG8gcHJvZHVjZSBhIHdvcmtpbmcgcmV2ZXJ0IG9mIA0KMDJl
NDU2NDZkNTNiIGZvciB0aGUgNS4xLXJjMyBrZXJuZWwuDQoNClRvIG1ha2UgaGliZXJuYXRpb24g
d29yayBvbiB0aGUgVDEwMCBJIGFsc28gaGFkIHRvIGNyZWF0ZSBhIHNjcmlwdCAgDQovdXNyL2xp
Yi9zeXN0ZW1kL3N5c3RlbS1zbGVlcC90MTAwX2hpYmVybmF0ZS5zaCB3aGljaCB1bmxvYWRzIHZh
cmlvdXMgZHJpdmVycyANCihpbmNsdWRpbmcgc291bmQpIGJlZm9yZSBoaWJlcm5hdGUsIHRoZW4g
cmVzdGFydHMgdGhlbSBhZnRlcndvcmRzLiAgSSd2ZSBpbnNlcnRlZCANCml0IGJlbG93LiAgSSdt
IG5vdCBjZXJ0YWluIGFsbCB0aGUgc3RlcHMgaW4gaXQgYXJlIHN0aWxsIG5lY2Vzc2FyeSwgYnV0
IHRoZSANCmludGVybWl0dGVudCBmYWlsdXJlcyBtYWtlIGl0IHZlcnkgZGlmZmljdWx0IHRvIGRl
dGVybWluZSB3aGF0IGlzIGFic29sdXRlbHkgZXNzZW50aWFsLg0KDQotLS0tLXQxMDBfaGliZXJu
YXRlLnNoICBzeXN0ZW1kIHNjcmlwdC0tLS0tLS0NCiMhL2Jpbi9iYXNoDQplY2hvICJIaWJlcm5h
dGUgc2NyaXB0ICQxICQyIg0KWyAkMiAhPSAnaGliZXJuYXRlJyBdICYmIGV4aXQgMA0KDQpjYXNl
ICQxIGluDQogICAgICAgIHByZSkNCiAgICBlY2hvICJHb2luZyB0byAkMi4uLiINCiAgICAvc2Jp
bi9tb2Rwcm9iZSAtciBicmNtZm1hYw0KICAgIC9zYmluL21vZHByb2JlIC1yIGhjaV91YXJ0DQog
ICAgL3NiaW4vbW9kcHJvYmUgLXIgYmF0dGVyeQ0KICAgIC9zYmluL21vZHByb2JlIC1yIGhpZF9t
dWx0aXRvdWNoDQogICAgL3Vzci9iaW4va2lsbGFsbCBwdWxzZWF1ZGlvDQogICAgL3NiaW4vbW9k
cHJvYmUgLXIgc25kX3NvY19zc3RfYnl0Y3JfcnQ1NjQwDQogICAgL3NiaW4vbW9kcHJvYmUgLXIg
c25kX3NvY19ydDU2NDANCiAgICAvc2Jpbi9tb2Rwcm9iZSAtciBzbmRfc29jX3NzdF9hY3BpDQog
ICAgICAgIDs7DQogICAgICAgIHBvc3QpDQogICAgZWNobyAiV2FraW5nIGZyb20gJDIuLi4iDQog
ICAgL3NiaW4vbW9kcHJvYmUgYnJjbWZtYWMNCiAgICAvc2Jpbi9tb2Rwcm9iZSBoY2lfdWFydA0K
ICAgIC9zYmluL21vZHByb2JlIGJhdHRlcnkNCiAgICAvc2Jpbi9tb2Rwcm9iZSBoaWRfbXVsdGl0
b3VjaA0KICAgICMgSnVzdCBsb2FkIHRoZSBmb2xsb3dpbmcgYW5kIGl0IHdpbGwgcHVsbCBpbiBv
dGhlciBzbmQgbW9kdWxlcw0KICAgIC9zYmluL21vZHByb2JlIHNuZF9zb2Nfc3N0X2FjcGkNCiAg
ICAvdXNyL3NiaW4vc2VydmljZSBOZXR3b3JrTWFuYWdlciByZXN0YXJ0DQogICAgL3Vzci9zYmlu
L3NlcnZpY2Ugd3BhX3N1cHBsaWNhbnQgcmVzdGFydA0KICAgICMgVGhlIGFib3ZlIGlzIHVzdWFs
bHkgZW5vdWdoIGJ1dCBvY2Nhc2lvbmFsbHkgc291bmQgZG9lc24ndCBjb21lIHVwIHByb3Blcmx5
DQogICAgIyBhbmQgZG9pbmcgdGhlIGZvbGxvd2luZyBzZWVtcyB0byByZXN0b3JlIGl0IGluIHRo
b3NlIGNhc2VzLg0KICAgIC91c3IvYmluL2tpbGxhbGwgcHVsc2VhdWRpbw0KICAgIC91c3Ivc2Jp
bi9ybW1vZCBzbmRfc29jX3NzdF9ieXRjcl9ydDU2NDANCiAgICAvdXNyL3NiaW4vcm1tb2Qgc25k
X3NvY19ydDU2NDANCiAgICAvdXNyL3NiaW4gbW9kcHJvYmUgc25kX3NvY19ydDU2NDANCiAgICAv
dXNyL3NiaW4gbW9kcHJvYmUgc25kX3NvY19zc3RfYnl0Y3JfcnQ1NjQwDQogICAgICAgIDs7DQpl
c2FjDQotLS0tLWVuZCBvZiBzY3JpcHQtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoN
CkknbGwgc2VuZCBhIHNlY29uZCBtZXNzYWdlIHdpdGggdGhlIHN5c3RlbSBsb2dzIHdoaWNoIEth
aS1IZW5nIHJlcXVlc3RlZCwNCndpdGggaGlzIHBhdGNoIGFwcGxpZWQgdG8gNS4xLXJjMy4NCg0K
Qm9iIEhvd2VsbA0KDQo+IEkgbXVzdCBhZG1pdCBJIG5ldmVyIHRyeSBoaWJlcm5hdGlvbiBteXNl
bGYsIGluIGV4cGVyaWVuY2UgaXQgdGVuZHMgdG8NCj4gaGF2ZSBtb3JlIGlzc3VlcyB0aGVuIHJl
Z3VsYXIgc3VzcGVuZC9yZXN1bWUgYW5kIHRoZXJlIGFyZSBhbHJlYWR5IGVub3VnaA0KPiBvdGhl
ciBpc3N1ZXMgdG8gd29ycnkgYWJvdXQgb24gQmF5IGFuZCBDaGVycnkgVHJhaWwgYmFzZWQgZGV2
aWNlcy4NCj4gDQo+IEJ1dCBpZiBpdCB3b3JrcyBvbiB0aGUgVDEwMFRBIGFuZCAwMmU0NTY0NmQ1
M2IgYnJva2UgaXQgdGhlbiBJIHdpbGwNCj4gdHJ5IHRvIGZpeCB0aGlzLCBJJ3ZlIGEgVDEwMFRB
IG15c2VsZi4gQ3VycmVudGx5IG15IFQxMDBUQSBpcyBhdCBteQ0KPiBsb2NhbCBoYWNrZXJzcGFj
ZSwgc28gSSB3aWxsIG5vdCBoYXZlIGFjY2VzcyB0byBpdCB1bnRpbCBjb21pbmcgRnJpZGF5Lg0K
PiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCj4gDQo=
