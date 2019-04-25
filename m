Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1481BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF956217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfDYHMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:12:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:34603 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYHMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:12:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="152203197"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2019 00:12:04 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 00:12:04 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.92]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.147]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:12:02 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Auger Eric <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Thread-Topic: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Thread-Index: AQHU+ixO5S5+AaAF5kG+2g9ZvMdrCaZLC6IAgAFX7DA=
Date:   Thu, 25 Apr 2019 07:12:02 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
 <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
In-Reply-To: <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2ZkM2E5NjQtMjBlNS00NDBmLThlMzMtMWZlODkxZjUyNDk3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNURNT2gxTlZBZnRtMG91SUZnenJzaTJNNmozRGlleGdBVXlOOE9TT240eXR6TFQxN0xrSnFMaVdDNDgzVTZaMiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXJpYywNCg0KPiBGcm9tOiBBdWdlciBFcmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQu
Y29tXQ0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjUsIDIwMTkgMToyOCBBTQ0KPiBUbzogSmFj
b2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT47IGlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnOw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA5LzE5XSBpb21tdS92
dC1kOiBFbmxpZ2h0ZW5lZCBQQVNJRCBhbGxvY2F0aW9uDQo+IA0KPiBIaSBKYWNvYiwNCj4gDQo+
IE9uIDQvMjQvMTkgMTozMSBBTSwgSmFjb2IgUGFuIHdyb3RlOg0KPiA+IEZyb206IEx1IEJhb2x1
IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4NCj4gPiBJZiBJbnRlbCBJT01NVSBydW5z
IGluIGNhY2hpbmcgbW9kZSwgYS5rLmEuIHZpcnR1YWwgSU9NTVUsIHRoZSBJT01NVQ0KPiA+IGRy
aXZlciBzaG91bGQgcmVseSBvbiB0aGUgZW11bGF0aW9uIHNvZnR3YXJlIHRvIGFsbG9jYXRlIGFu
ZCBmcmVlDQo+ID4gUEFTSUQgSURzLg0KPiBEbyB3ZSBtYWtlIHRoZSBkZWNpc2lvbiBkZXBlbmRp
bmcgb24gdGhlIENNIG9yIGRlcGVuZGluZyBvbiB0aGUgVkNDQVBfUkVHPw0KPiANCj4gVkNDQVBf
UkVHIGRlc2NyaXB0aW9uIHNheXM6DQo+IA0KPiBJZiBTZXQsIHNvZnR3YXJlIG11c3QgdXNlIFZp
cnR1YWwgQ29tbWFuZCBSZWdpc3RlciBpbnRlcmZhY2UgdG8gYWxsb2NhdGUgYW5kIGZyZWUNCj4g
UEFTSURzLg0KDQpUaGUgYW5zd2VyIGlzIGl0IGRlcGVuZHMgb24gdGhlIEVDQVAuVkNTIGFuZCB0
aGVuIHRoZSBQQVNJRCBhbGxvY2F0aW9uIGJpdCBpbg0KVkNDQVBfUkVHLiBCdXQgVkNTIGJpdCBp
bXBsaWVzIHRoZSBpb21tdSBpcyBhIHNvZnR3YXJlIGltcGxlbWVudGF0aW9uDQoodklPTU1VKSBv
ZiB2dC1kIGFyY2hpdGVjdHVyZS4gUGxzIHJlZmVyIHRvIHRoZSBkZXNjcmlwdGlvbnMgb2YgIlZp
cnR1YWwNCkNvbW1hbmQgU3VwcG9ydCIgaW4gdnQtZCAzLjAgc3BlYy4NCg0KIkhhcmR3YXJlIGlt
cGxlbWVudGF0aW9ucyBvZiB0aGlzIGFyY2hpdGVjdHVyZSByZXBvcnQgYSB2YWx1ZSBvZiAwDQpp
biB0aGlzIGZpZWxkLiBTb2Z0d2FyZSBpbXBsZW1lbnRhdGlvbnMgKGVtdWxhdGlvbikgb2YgdGhp
cw0KYXJjaGl0ZWN0dXJlIG1heSByZXBvcnQgVkNTPTEuIg0KDQpUaGFua3MsDQpZaSBMaXUNCg0K
