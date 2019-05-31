Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A654C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7C326DB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfEaSPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:15:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:51218 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfEaSPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:15:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 11:15:40 -0700
X-ExtLoop1: 1
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2019 11:15:40 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.47]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.182]) with mapi id 14.03.0415.000;
 Fri, 31 May 2019 11:15:39 -0700
From:   "Yang, Hyungwoo" <hyungwoo.yang@intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kadam, Rushikesh S" <rushikesh.s.kadam@intel.com>,
        "jettrink@chromium.org" <jettrink@chromium.org>
Subject: RE: [PATCH] platform/chrome: fix crash during suspend
Thread-Topic: [PATCH] platform/chrome: fix crash during suspend
Thread-Index: AQHVF5qm8M0/r/p6W0SmnQQR6VYnwKaFik0Q
Date:   Fri, 31 May 2019 18:15:38 +0000
Message-ID: <7A4F467111FEF64486F40DFE7DF3500A221AEE76@ORSMSX121.amr.corp.intel.com>
References: <1559189034-11268-1-git-send-email-hyungwoo.yang@intel.com>
 <8b7a8d63-d9e4-6a9e-1b13-423441416c8a@collabora.com>
In-Reply-To: <8b7a8d63-d9e4-6a9e-1b13-423441416c8a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTI3NjQyYTctM2U1ZS00MWQ2LWIyNzgtYTc1YzkxZTNmYTgwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib2VcL2g1bEVNMHAzZlhOOTI0RTkwdDhiaE90QlwveSs2NkxTQVwvQXE5dEpFcEx4NERqcENuTXkyT3RyM1Z1SXpmSiJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAzMC81LzE5IDY6MDMsIEh5dW5nd29vIFlhbmcgd3JvdGU6DQo+ID4gS2VybmVsIGNyYXNo
ZXMgZHVyaW5nIHN1c3BlbmQgZHVlIHRvIHdyb25nIGNvbnZlcnNpb24gaW4gc3VzcGVuZCBhbmQg
DQo+ID4gcmVzdW1lIGZ1bmN0aW9ucy4NCj4gPiANCj4gPiBVc2UgdGhlIHByb3BlciBoZWxwZXIg
dG8gZ2V0IGlzaHRwX2NsX2RldmljZSBpbnN0YW5jZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBIeXVuZ3dvbyBZYW5nIDxoeXVuZ3dvby55YW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9wbGF0Zm9ybS9jaHJvbWUvY3Jvc19lY19pc2h0cC5jIHwgNCArKy0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfaXNodHAuYyANCj4g
PiBiL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfaXNodHAuYw0KPiA+IGluZGV4IGU1
MDRkMjUuLjQzMDczMWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9jaHJvbWUv
Y3Jvc19lY19pc2h0cC5jDQo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS9jaHJvbWUvY3Jvc19l
Y19pc2h0cC5jDQo+ID4gQEAgLTcwNyw3ICs3MDcsNyBAQCBzdGF0aWMgaW50IGNyb3NfZWNfaXNo
dHBfcmVzZXQoc3RydWN0IGlzaHRwX2NsX2RldmljZSAqY2xfZGV2aWNlKQ0KPiA+ICAgKi8NCj4g
PiAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBjcm9zX2VjX2lzaHRwX3N1c3BlbmQoc3RydWN0
IGRldmljZSANCj4gPiAqZGV2aWNlKSAgew0KPiA+IC0Jc3RydWN0IGlzaHRwX2NsX2RldmljZSAq
Y2xfZGV2aWNlID0gZGV2X2dldF9kcnZkYXRhKGRldmljZSk7DQo+ID4gKwlzdHJ1Y3QgaXNodHBf
Y2xfZGV2aWNlICpjbF9kZXZpY2UgPSBpc2h0cF9kZXZfdG9fY2xfZGV2aWNlKGRldmljZSk7DQo+
ID4gIAlzdHJ1Y3QgaXNodHBfY2wJKmNyb3NfaXNoX2NsID0gaXNodHBfZ2V0X2RydmRhdGEoY2xf
ZGV2aWNlKTsNCj4gPiAgCXN0cnVjdCBpc2h0cF9jbF9kYXRhICpjbGllbnRfZGF0YSA9IA0KPiA+
IGlzaHRwX2dldF9jbGllbnRfZGF0YShjcm9zX2lzaF9jbCk7DQo+ID4gIA0KPiA+IEBAIC03MjIs
NyArNzIyLDcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBjcm9zX2VjX2lzaHRwX3N1c3Bl
bmQoc3RydWN0IGRldmljZSAqZGV2aWNlKQ0KPiA+ICAgKi8NCj4gPiAgc3RhdGljIGludCBfX21h
eWJlX3VudXNlZCBjcm9zX2VjX2lzaHRwX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXZpY2UpICAN
Cj4gPiB7DQo+ID4gLQlzdHJ1Y3QgaXNodHBfY2xfZGV2aWNlICpjbF9kZXZpY2UgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2aWNlKTsNCj4gPiArCXN0cnVjdCBpc2h0cF9jbF9kZXZpY2UgKmNsX2Rldmlj
ZSA9IGlzaHRwX2Rldl90b19jbF9kZXZpY2UoZGV2aWNlKTsNCj4gPiAgCXN0cnVjdCBpc2h0cF9j
bAkqY3Jvc19pc2hfY2wgPSBpc2h0cF9nZXRfZHJ2ZGF0YShjbF9kZXZpY2UpOw0KPiA+ICAJc3Ry
dWN0IGlzaHRwX2NsX2RhdGEgKmNsaWVudF9kYXRhID0gDQo+IGlzaHRwX2dldF9jbGllbnRfZGF0
YShjcm9zX2lzaF9jbCk7DQo+ID4gIA0KPiA+IA0KPiANCj4gQXMgdGhpcyBwYXRjaCBpcyBhIGZp
eCBmb3IgJzI2YTE0MjY3YWZmMiBwbGF0Zm9ybS9jaHJvbWU6IEFkZCBDaHJvbWVPUyBFQyBJU0hU
UCBkcml2ZXInIHdoaWNoIGlzIHN0aWxsIGZvci1uZXh0IG1hdGVyaWFsLCBkbyB5b3UgbWluZCBp
ZiBJIHNxdWFzaCBib3RoIHBhdGNoZXM/DQo+IA0KPiBJZiB5b3UgZG9uJ3QgbWluZCBJJ2xsIGFk
ZCB5b3VyIFNpZ25lZC1vZmYgYW5kIGEgc21hbGwgY29tbWVudCBzYXlpbmcgdGhhdCB5b3UgZml4
ZWQgdGhpcy4NCg0KSSBkb24ndCBtaW5kLiBwbGVhc2UgZG8gd2hhdGV2ZXIgeW91IHdhbnQuIGJ1
dCBpdCBoYXMgZGVwZW5kZW5jeSB3aXRoIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1pbnB1dC9saXN0Lz9zZXJpZXM9MTI0NzgwDQoNCj4gDQo+IFRoYW5rcywNCj4g
RW5yaWMNCg0KDQoNCg==
