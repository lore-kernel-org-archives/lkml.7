Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F156C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5891C20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JtCtdhZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCGSQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:16:22 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:28236 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCGSQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:16:21 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c815ff00000>; Fri, 08 Mar 2019 02:16:16 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Mar 2019 10:16:14 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 07 Mar 2019 10:16:14 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Mar
 2019 18:16:12 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.58) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Mar 2019 18:16:12 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3511.namprd12.prod.outlook.com (20.179.94.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Thu, 7 Mar 2019 18:16:08 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%5]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 18:16:08 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Ritesh Harjani <riteshh@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Asutosh Das <asutoshd@codeaurora.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Thread-Topic: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Thread-Index: AQHU0Le8XNfDXr1Gi0eUvv60djK956X+l9EAgADl9YCAAP/PoA==
Date:   Thu, 7 Mar 2019 18:16:08 +0000
Message-ID: <BYAPR12MB33984D80A404EF919F3A86A0C24C0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
 <a320c841-7e58-4d3e-5df6-61e10520d9d8@intel.com>
 <a544bc6d-7b23-53e8-16d0-ee0eaf576eb2@codeaurora.org>
In-Reply-To: <a544bc6d-7b23-53e8-16d0-ee0eaf576eb2@codeaurora.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 126fe9e3-c57d-4239-327a-08d6a328f8cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3511;
x-ms-traffictypediagnostic: BYAPR12MB3511:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIzNTExOzIzOk9lWHNGazhSSlI4V21QOWtvWVZYKzRXbXZh?=
 =?utf-8?B?VlVpQ0NOYXE5UlZkK09BTzdlcVhTd3FHVUthRzNZS3BrcjNKTHA3aUtNbzNz?=
 =?utf-8?B?RTNHVGZYRGVLMEZxVkVjYlhwVUZzUjlVQzF0OCsvdnBFd29IcE5uLzZmbmFs?=
 =?utf-8?B?M1hKM2hiWEVlQTE3TjYzcVNjVGpLdHJ6S0NuRFVSRjVMTmJBVW1hWlB0OHlH?=
 =?utf-8?B?TUwwMHllV0ovTXk4TUkzMXJSMUU3UllrWUlqdkRrK2ZvYnZkdVNqWVNFUEFo?=
 =?utf-8?B?RUtBdGdCUEEyam9NWWhncTFUcGd0UEhQcHFKSENvY0NCczJhZUQwL3RDWitw?=
 =?utf-8?B?OXA4Njc1RVpvci9qTVhuTHZta1psVFZzaHZycXByUFpybDBNcVU5cGNqUWpu?=
 =?utf-8?B?R2hVVjVwaDZMMHY3bDBSL2VDek9PaDh1eERxN1NzcDJMaHpMVW9WNUtLci9G?=
 =?utf-8?B?cmsvREl2ODUzdWh6dDNobk1GWFN0OUo1MjFpTGV0dS9XdGgzeURpS3paRjFL?=
 =?utf-8?B?S0hZc1V0ZXJVeVFhZjd6eitjVFI3Mm8zcStSR0FTN0lON053bjIrUWZyUmtI?=
 =?utf-8?B?Z1JLdUVtcFdKeGxTYUhmQk13SDg5UHhSdzRnUlo2d3dlWFhYY3oyeGw4bUpQ?=
 =?utf-8?B?cjZhYlFjWGlFbEhoSjE2WldKTXM1M1hmT3NFQlJTWG5zWkNrMmpKcUF4R09a?=
 =?utf-8?B?VjdvcTgwejlmZWdHWlZQdkgyQmY2REt1RU80YWphQjBRa2R3S2ZLL1RCR0pq?=
 =?utf-8?B?aHU2T0tDWWVBaER1WUF4TkNOTUFLZUNmTXV4SHFpMnpsYjNCVTh4VTR4OVR6?=
 =?utf-8?B?TTJLNnpaaVp4UDVERk9GaHk5M0V3UWpWSXlEMnJwZFpyYjhFL0tIUXprVFBr?=
 =?utf-8?B?RUp6MThUODRrQ1pndmgvVThHTGtQVjFjZGs4cmE0VllCNUVBSmk2aFhhRTF1?=
 =?utf-8?B?WHhTV2Y3Q2ZBbFAzMEZhZkFUd0FOZWdGTG5hbjdjRDUza1B1QzFUelFFTFV4?=
 =?utf-8?B?VlRNMTJzZGRCMzIzQitxZ1k2QU56bTIrVTZtWDkzWjBvcGRadlRRNDMrNU9S?=
 =?utf-8?B?RUpNcmlEKzFYeFd4SERqeHJNaGEzOTlqb2JmR1RJc005MXQvZGhHSFI0TGRY?=
 =?utf-8?B?Uk1HV2U0TlVncDA4eWZ6Ny9rUFB2cStZTzY5ZUNjcFRsYnVOc1ZnQjgrWnda?=
 =?utf-8?B?MENWbStsdXl3YUxpMHBjV0cvajJYREk4Yng3eHAxWnVIK2I0YVhiL3B6Sm5z?=
 =?utf-8?B?emJwM3hOYnpqLzFvVjFLUElKYkFvVmt1VTNnTjFpQ0h6clYxVk40d2M2WjR4?=
 =?utf-8?B?Y2FnSzR2cFdCaTViTTJOUUxzbnlLSkdXUHNQZUFOWnBNYVhpU1RjM1A5Y1JH?=
 =?utf-8?B?R2xhcDA0Q1YwSTErRFpFUE83MEd6bU1HSFZ1UkVPUDd2VDNwb1Z3MlF4LzVk?=
 =?utf-8?B?N0NEQkZXWkk5em1DUnVXNm9EdUYrSUtPWS9MUDR4aUVydFlndWI0SEdSR1BF?=
 =?utf-8?B?VHFaRmNnKzR4Z1RxUWlPODlkSmIwS1RBZlp4eWpCWUVaY1VBKzRyWVBTYmtl?=
 =?utf-8?B?WkZkUkNiTDJWeVVmaVBjNDFHYzZyd3A4K01hWEoxQ3JmbXNmL1lJSHp0MWxQ?=
 =?utf-8?B?aEJlbFYxSzJBUitDMW53VFg3MithZkFTNmdHKzBvekgxMlhVNjJVd3gwN2Uw?=
 =?utf-8?B?WkJ6bWFXeks4bGI5aUhmb3htNFRxTm50Y2pCc1JNNFM1WktaK1NOVE1yQ1dM?=
 =?utf-8?Q?VvrddPRIqKHIBvRyW1gTBvNLCCPhOyNSK4evw=3D?=
x-microsoft-antispam-prvs: <BYAPR12MB3511549200785F91CCE76AA0C24C0@BYAPR12MB3511.namprd12.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(446003)(476003)(99286004)(71190400001)(11346002)(25786009)(8936002)(3846002)(6116002)(6436002)(2501003)(6506007)(102836004)(53546011)(256004)(186003)(14444005)(26005)(7696005)(4326008)(76176011)(86362001)(486006)(66066001)(71200400001)(105586002)(106356001)(5660300002)(52536013)(9686003)(97736004)(478600001)(6246003)(55016002)(14454004)(316002)(33656002)(68736007)(2906002)(54906003)(110136005)(93886005)(8676002)(74316002)(7736002)(305945005)(7416002)(81166006)(81156014)(229853002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3511;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fpKrUIfZUEMG8UVkJ9Zj/jkVbZ4InKIIQpgXq2rPId5iD+Vyl/RsyTtP57jyL0Qc8dsJmkEbShGEf5auBq6duZlmcqZicn3HfsxdwCOWGFAzIRemjN9V0UgZAzWqCW+ta+WPxIM0V24WV/r8rDoDPvb0BmRBWS8O2+Xj2CqT/+hXKrZDTMVZ2toNN8M0l8VM12Ix9Y7E8u+iFn9de8rjv+HAyYMJIUlyGRo+MzBIjts4D8eYV+IlMGVKOt7q4dQxw6jcXXdhNUfj5DDlwFXosWp62Fu8i78HCvoa2r0lmyXJjDDsiBH08rMLnHx/L1BurUOdAzssa73T9us4X03GHOXEqCvDdYIxwAtxeJFwHn/uhChMONHmvXGmWEGEmxW0iU7Y77LLpb4WluEZQp2tiQGa/1MaKTTI4KkyOoDWPas=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 126fe9e3-c57d-4239-327a-08d6a328f8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 18:16:08.6288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3511
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551982576; bh=JMyNkdJNtC0GxNAPt9O9RQLyVINcQqEYq4BFehm4PJY=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-exchange-diagnostics:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=JtCtdhZPohBZqVBLQ6TAPYyR3S9P03whRjqI1TwIVnTOY8NSmsbkezXzWdxLsa0A2
         Zymt4Yqbhg4QcgjiIkScNQc727ccyZ3rWTDiPIrpvNHfx5w8VltFbrcIlFV486TTRe
         Q+HHgC8bQpmPAgWwu0Ol9MJWTk6YV12+eeBzRPZSMFBexAhtxJXUN5GEokN1TNS1Sf
         vlLebjou4kymAepmfEeRswAPDO3gH3CNqUJWUEKSOGkfXbCqW84G0gLcfDdd0leJGp
         zH8yUfN18HG4fiNhFplQf/GUpbPeH9PDx+xc8laekVJBhqKenYEwsNHtO23LVaDwtK
         Tq4I3KPgySMTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDMvNi8yMDE5IDY6MzAgUE0sIEFkcmlhbiBIdW50ZXIgd3JvdGU6DQo+PiBPbiAyLzAz
LzE5IDc6MjAgQU0sIFNvd2phbnlhIEtvbWF0aW5lbmkgd3JvdGU6DQo+Pj4gVGhpcyBwYXRjaCBh
ZGRzIGEgcXVpcmsgZm9yIHNldHRpbmcgQ01EX1RJTUlORyB0byAxIGluIGRlc2NyaXB0b3IgZm9y
IA0KPj4+IERDTUQgd2l0aCBSMUIgcmVzcG9uc2UgdHlwZSB0byBhbGxvdyB0aGUgY29tbWFuZCB0
byBiZSBzZW50IHRvIGRldmljZSANCj4+PiBkdXJpbmcgZGF0YSBhY3Rpdml0eSBvciBidXN5IHRp
bWUuDQo+Pj4NCj4+PiBUZWdyYTE4NiBDUUhDSSBob3N0IGhhcyBidWcgd2hlcmUgaXQgc2VsZWN0
cyBEQVRBX1BSRVNFTlRfU0VMRUNUIHRvIDEgDQo+Pj4gYnkgQ1FIQ0kgY29udHJvbGxlciBmb3Ig
RENNRHMgd2l0aCBSMUIgcmVzcG9uc2UgdHlwZSBhbmQgc2luY2UgRENNRCANCj4+PiBkb2VzIG5v
dCB0cmlnZ2VyIGFueSBkYXRhIHRyYW5zZmVyLCBEQ01EIHRhc2sgY29tcGxldGUgaGFwcGVucyAN
Cj4+PiBsZWF2aW5nIHRoZSBEQVRBIEZTTSBvZiBob3N0IGNvbnRyb2xsZXIgaW4gd2FpdCBzdGF0
ZSBmb3IgZGF0YS4NCj4+Pg0KPj4+IFRoaXMgZWZmZWN0cyB0aGUgZGF0YSB0cmFuc2ZlciB0YXNr
IGlzc3VlZCBhZnRlciBSMUIgRENNRCB0YXNrIGFuZCBubyANCj4+PiBpbnRlcnJ1cHQgaXMgZ2Vu
ZXJhdGVkIGZvciB0aGUgZGF0YSB0cmFuc2ZlciB0YXNrLg0KPj4+DQo+Pj4gU1cgV0FSIGZvciB0
aGlzIGlzc3VlIGlzIHRvIHNldCBDTURfVElNSU5HIGJpdCB0byAxIGluIERDTUQgdGFzayANCj4+
PiBkZXNjcmlwdG9yIGFuZCBhcyBEQ01EIHRhc2sgZGVzY3JpcHRvciBwcmVwYXJhdGlvbiBpcyBk
b25lIGJ5IGNxaGNpIA0KPj4+IGRyaXZlciwgdGhpcyBwYXRjaCBhZGRzIGNxZXF1aXJrIHRvIGhh
bmRsZSB0aGlzLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU293amFueWEgS29tYXRpbmVuaSA8
c2tvbWF0aW5lbmlAbnZpZGlhLmNvbT4NCj4+PiAtLS0NCj4+PiAgIGRyaXZlcnMvbW1jL2hvc3Qv
Y3FoY2kuYyB8IDUgKysrKy0NCj4+PiAgIGRyaXZlcnMvbW1jL2hvc3QvY3FoY2kuaCB8IDEgKw0K
Pj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmMgYi9kcml2ZXJzL21t
Yy9ob3N0L2NxaGNpLmMgDQo+Pj4gaW5kZXggYThhZjY4MmE5MTgyLi5iMzRjMDcxMjVmMzIgMTAw
NjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5jDQo+Pj4gKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9jcWhjaS5jDQo+Pj4gQEAgLTUyMSw3ICs1MjEsMTAgQEAgc3RhdGljIHZvaWQg
Y3FoY2lfcHJlcF9kY21kX2Rlc2Moc3RydWN0IG1tY19ob3N0ICptbWMsDQo+Pj4gICAJfSBlbHNl
IHsNCj4+PiAgIAkJaWYgKG1ycS0+Y21kLT5mbGFncyAmIE1NQ19SU1BfUjFCKSB7DQo+Pj4gICAJ
CQlyZXNwX3R5cGUgPSAweDM7DQo+Pj4gLQkJCXRpbWluZyA9IDB4MDsNCj4+PiArCQkJaWYgKGNx
X2hvc3QtPnF1aXJrcyAmIENRSENJX1FVSVJLX0NNRF9USU1JTkdfUjFCX0RDTUQpDQo+Pj4gKwkJ
CQl0aW1pbmcgPSAweDE7DQo+Pj4gKwkJCWVsc2UNCj4+PiArCQkJCXRpbWluZyA9IDB4MDsNCj4+
IEkgd2FzIHRoaW5raW5nIGl0IHdvdWxkIGJlIG5pY2UgaWYgdGhlcmUgd2FzIGEgZ2VuZXJpYyB3
YXkgZm9yIGRyaXZlcnMgDQo+PiB0byBtYWtlIGNoYW5nZXMgdG8gZGVzY3JpcHRvcnMgYmVmb3Jl
IGEgdGFzayBpcyBzdGFydGVkLiAgQ3VycmVudGx5IA0KPj4gdGhlcmUgaXMNCj4+IGhvc3QtPm9w
cy0+d3JpdGVfbCgpIHdoaWNoIHdvdWxkIG1ha2UgaXQgcG9zc2libGUgYnkgY2hlY2tpbmcgZm9y
IA0KPj4gaG9zdC0+b3BzLT5DUUhDSV9UREJSDQo+PiByZWdpc3RlciBhbmQsIGluIHRoaXMgY2Fz
ZSwgdGhlIERDTUQgdGFnLiAgV2Ugd291bGQgbmVlZCB0byBleHBvcnQgDQo+PiBnZXRfZGVzYygp
LCBwZXJoYXBzIHJlbmFtZSBpdCBjcWhjaV9nZXRfZGVzYygpIGFuZCBwdXQgaXQgaW4gY3FoY2ku
aCANCj4+IHNpbmNlIGl0IGlzIGFuIGlubGluZSBmdW5jdGlvbi4NCj4NCj5XZSB0YWtlIHNwaW5f
bG9ja19pcnFzYXZlIGFmdGVyIHRoZSBkZXNjcmlwdG9yIGlzIHByZXBhcmVkIGFuZCBiZWZvcmUg
d3JpdGluZyB0byBUREJSLg0KPk5vdCBzdXJlIGJ1dCB0b21vcnJvdyB0aGlzIG1heSBiZWNvbWUg
YSBsaW1pdGF0aW9uIGZvciBkcml2ZXJzIHRvIG1ha2UgY2hhbmdlcyB0byBkZXNjcmlwdG9ycyBp
ZiB0aGV5IGVkaXQgZGVzY3JpcHRvcnMgaW4gaG9zdC0+b3BzLT53cml0ZV9sKCkgY2FsbC4NCj5U
aG91Z2ggaW4gdGhpcyBjYXNlIGl0IGlzIG5vdCByZXF1aXJlZCBoZXJlLg0KPg0KPj4NCj4+IEFs
dGVybmF0aXZlbHkgd2UgY291bGQgYWRkIGhvc3QtPm9wcyBmb3IgZGVzY3JpcHRvciBwcmVwYXJh
dGlvbi4NCj4NCj5Cb3RoIHdheXMgc291bmRzIGdvb2QgdG8gbWUuDQo+QnV0IG1heWJlIGFkZGlu
ZyBhIGhvc3QtPm9wcyBmb3IgZGVzY3JpcHRvciBwcmVwYXJhdGlvbiBpcyBiZXR0ZXIgd2F5IHRv
IGdvLA0KPnNpbmNlIHRoYXQgd2lsbCBiZSB0aGUgcmlnaHQgaW50ZXJmYWNlIGV4cG9zZWQgdG8g
bWFrZSBjaGFuZ2VzIHRvIA0KPmRlc2NyaXB0b3JzLg0KPg0KDQpEQ01EIGRlc2NyaXB0b3IgYXR0
cmlidXRlcyByZW1haW4gc2FtZSBmb3IgYW55IGhvc3QgYW5kIGFsc28gdGFzayBwYXJhbWV0ZXJz
IGFzIFFCUiBuZWVkIHRvIGJlIGVuYWJsZWQgd2l0aCBEQ01ELg0KU28gSSBiZWxpZXZlIGl0IHNo
b3VsZCBiZSBvayBpZiB3ZSBqdXN0IGFkZCBjYWxsYmFjayB0byBhbGxvdyBob3N0cyB0byB1cGRh
dGUgY29tbWFuZCBwYXJhbWV0ZXJzIG9mIERDTUQgZGVzY3JpcHRvciBvbmx5IHRocnUgY3FoY2lf
aG9zdF9vcHMuDQoNCkFsc28sIGRvbuKAmXQgc2VlIGFueSByZXF1aXJlbWVudCBmb3IgaG9zdCBz
cGVjaWZpYyBUYXNrIHBhcmFtZXRlciB1cGRhdGVzIGluIFRhc2sgZGVzY3JpcHRvciBzbyBub3Qg
c3VyZSBpZiB0aGVyZSBpcyBhbnkgbmVlZCB0byBwcm92aWRlIGNhbGxiYWNrIGZvciB0YXNrIGRl
c2NyaXB0b3IgZGF0YSBwcmVwYXJhdGlvbiB0byBob3N0cy4NClBsZWFzZSBjb25maXJtLg0KDQo+
Pg0KPj4gV2hhdCBkbyBwZW9wbGUgdGhpbms/DQo+Pg0KPj4+ICAgCQl9IGVsc2Ugew0KPj4+ICAg
CQkJcmVzcF90eXBlID0gMHgyOw0KPj4+ICAgCQkJdGltaW5nID0gMHgxOw0KPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmggYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmgN
Cj4+PiBpbmRleCA5ZTY4Mjg2YTA3YjQuLmY5NmQ4NTY1Y2MwNyAxMDA2NDQNCj4+PiAtLS0gYS9k
cml2ZXJzL21tYy9ob3N0L2NxaGNpLmgNCj4+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNp
LmgNCj4+PiBAQCAtMTcwLDYgKzE3MCw3IEBAIHN0cnVjdCBjcWhjaV9ob3N0IHsNCj4+PiAgIA0K
Pj4+ICAgCXUzMiBxdWlya3M7DQo+Pj4gICAjZGVmaW5lIENRSENJX1FVSVJLX1NIT1JUX1RYRlJf
REVTQ19TWgkweDENCj4+PiArI2RlZmluZSBDUUhDSV9RVUlSS19DTURfVElNSU5HX1IxQl9EQ01E
CTB4Mg0KPj4+ICAgDQo+Pj4gICAJYm9vbCBlbmFibGVkOw0KPj4+ICAgCWJvb2wgaGFsdGVkOw0K
Pj4+DQo=
