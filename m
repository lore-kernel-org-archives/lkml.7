Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDABC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A853215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jFhQLoWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgABHgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:36:24 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24690 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgABHgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577950584; x=1609486584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k1Nzb8bZaT4m/b1dU7SsCqlqfBlTEdEx32bcxwJJuB0=;
  b=jFhQLoWDlQva9v+NEuBNazzbma0Rjrkslnv3EZzmvY1+zkLBHdJttR+P
   TzRC4tCz8FY+nYJe2nKMnYrdk4GJAqnMNyGmoI+aJxPxnnWny5FYZLm03
   ytje5c4H6YIx03KBdyKMeab6/P66wAPvj3TDkghqHARU/s+67avt2baGZ
   k=;
IronPort-SDR: B7ksXLAadvey2WJTLpGdmppAdnrvityxtYbn3quHgmH0v4XzNhIkGz4jcZGHQWSNKWMeLazSrc
 hktCfvc8MsAw==
X-IronPort-AV: E=Sophos;i="5.69,385,1571702400"; 
   d="scan'208";a="9796547"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Jan 2020 07:36:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 03347A2296;
        Thu,  2 Jan 2020 07:36:19 +0000 (UTC)
Received: from EX13D11UWB001.ant.amazon.com (10.43.161.53) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:36:19 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB001.ant.amazon.com (10.43.161.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:36:19 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Thu, 2 Jan 2020 07:36:18 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "=linux-block@vger.kernel.org" <=linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVuTIQS2D+6UASEUSut4lHWyy8r6fXDD6A
Date:   Thu, 2 Jan 2020 07:36:18 +0000
Message-ID: <507d6d24a15b76c9887b1746db37f4dc970e7800.camel@amazon.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
         <e452f6a638fe09f065b9e4cd1c25d5d3a2f29e5a.camel@amazon.com>
         <BYAPR04MB5749C2F13BD6F6C15509FE8586210@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749C2F13BD6F6C15509FE8586210@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.109]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BEEDDC95109554EBF79E5898A7A2D17@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTAxIGF0IDAzOjI2ICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+IE9uIDEyLzIyLzE5IDU6NTMgUE0sIFNpbmdoLCBCYWxiaXIgd3JvdGU6DQo+ID4gSSBt
ZXNzZWQgdXAgd2l0aCBsaW51eC1ibG9jayBNTCBhZGRyZXNzLCBJIGNhbiByZXNlbmQgd2l0aCB0
aGUgcmlnaHQNCj4gPiBhZGRyZXNzDQo+ID4gaWYgbmVlZGVkLiBNeSBhcG9sb2dpZXMNCj4gPiAN
Cj4gPiBCYWxiaXIgU2luZ2guDQo+IA0KPiANCj4gVW5sZXNzIHlvdSBoYXZlIHNlbnQgaXQgYWxy
ZWFkeSBhbmQgSSB0b3RhbGx5IG1pc3NlZCBpdCwNCj4gaWYgeW91IGFyZSBwbGFubmluZyB0byBy
ZXNlbmQgY2FuIHlvdSBwbGVhc2UgYWxzbyBhZGQgYSBjb3Zlci1sZXR0ZXIgPw0KDQpJIGRpZCBu
b3QgcmVzZW5kIGl0LCBJJ2xsIHJlc2VuZCBhbmQgYWRkIGEgY292ZXIgbGV0dGVyLg0KDQpCYWxi
aXIgU2luZ2guDQo=
