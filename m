Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF2FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA3D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iupui.edu header.i=@iupui.edu header.b="neW2YHS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfKZCdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:33:55 -0500
Received: from belushi.uits.indiana.edu ([129.79.1.188]:26015 "EHLO
        hartman.uits.indiana.edu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbfKZCdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:33:55 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 21:33:54 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=iupui.edu; i=@iupui.edu; l=990; q=dns/txt; s=iu;
  t=1574735634; x=1606271634;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=jLALNnq3gD+Ik4gEh/clEneYjLUgy+WG4fFNEFl2+cM=;
  b=neW2YHS/gSuHObiTQ7siPvtKz5bv4jmq38Bd1t7bh0balPrbpCscWUVy
   XfVDn4lzn5j4nd/13i9MruQ+TzaIZDSDCmMi7Wu/he6lhCtvEhsllWR+r
   TtZBEVYZIjwvg9Td4EWFeUeV7WZu8yT2jl+YwyRWACvvNkqK3TqEMI6v9
   0=;
IronPort-SDR: 75Oy6lTxQivo0daJrdh3M+jsxClEyp7qbKsU9OtgCsx1SjgTdQv4bxekreYDf6L3bmu/8B35vK
 QmCJJ1SOTNFzkY0xbQomSeKXqq+kH8C98AdCDuy9IJ3kFV7DcWu0bOXP/mr3eF7R86B40MzFCj
 IyQGLgL10WEkQaOXk8pzbZsTlsa+XSBPLAdij4Abj/Gp0/d/Fp0GH7x/Q6Me00xiqSXHf42NHg
 VivQ8c+6EdB11Df8kWZCgp3PKhqq8bUBmHz9EZfZnQH80aP5n/99toasXHviINYCo3O3Q5KAMN
 BWI=
X-IronPort-AV: E=Sophos;i="5.69,244,1571716800"; 
   d="scan'208";a="188847297"
Received: from mssg-relay.indiana.edu ([129.79.1.73])
  by irpt-internal-relay.indiana.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2019 21:26:47 -0500
Received: from IN-CCI-D2S15.ads.iu.edu (in-cci-d2s15.ads.iu.edu [10.234.85.20])
        by mssg-relay.indiana.edu (8.14.7/8.14.7) with ESMTP id xAQ2Qlfs014795
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 21:26:47 -0500
Received: from BL-CCI-D2S05.ads.iu.edu (10.79.69.18) by
 IN-CCI-D2S15.ads.iu.edu (10.234.85.20) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 Nov 2019 21:26:47 -0500
Received: from BL-CCI-D2S05.ads.iu.edu ([fe80::500e:3613:3cb5:274c]) by
 BL-CCI-D2S05.ads.iu.edu ([fe80::500e:3613:3cb5:274c%12]) with mapi id
 15.00.1497.000; Mon, 25 Nov 2019 21:26:47 -0500
From:   "Paramasivam, Meenakshisundaram" <mparamas@iupui.edu>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: mdadm grow to double the capacity
Thread-Topic: mdadm grow to double the capacity
Thread-Index: AQHVpABCXbRhMZC0hkmo78Fa/ZRP/Q==
Date:   Tue, 26 Nov 2019 02:26:47 +0000
Message-ID: <1574735207490.32532@iupui.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [68.38.222.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4oCLSGksCgpJIGhhdmUgcmFpZC02IG1kYWRtIGFycmF5IHdpdGggOCBkcml2ZXMgKDUgVEIgZWFj
aCksIGFuZCBhIHRvdGFsIG9mIDMwIFRCIHVzYWJsZSBzcGFjZS4gWEZTIGlzIGNyZWF0ZWQgb24g
dGhpcyB2b2x1bWUuIFNpbmNlIEkgYW0gYWJvdXQgODUlIHVzZWQsICBJIHdhbnQgdG8gYWRkIDYg
bW9yZSBkcml2ZXMgdG8gdGhpcyBleGlzdGluZyBhcnJheSBpbiByYWlkLTYgdG8gdGFrZSB0aGlz
IGFycmF5IHRvIDYwIFRCIHdpdGggMTQgZHJpdmVzIGluIHJhaWQtNi4gIAoK4oCLV2hhdCB3b3Vs
ZCBiZSB0aGUgZmFzdGVzdCAoYW5kIHNhZmVzdCkgd2F5IHRvIGdyb3cgdGhlIHJhaWQtNiBhcnJh
eSBmcm9tIDggZGlza3MgdG8gMTQgZGlza3M/IEkgYW0gYXNzdW1pbmcgSSBjYW4gZmlyc3QgYWRk
IHRoZSA2IGRyaXZlcywgYW5kIGdyb3cgYWxsIGF0IG9uY2Ugd2l0aCB0aGUgY29tbWFuZDoKCm1k
YWRtIC12IC0tZ3JvdyAtLXJhaWQtZGV2aWNlcz0xNCAvZGV2L21kMgoKIEhvdyBsb25nIHdpbGwg
dGhpcyB0YWtlIChlc3RpbWF0ZSk/IFNob3VsZCBJIHVtb3VudCB4ZnMgYmVmb3JlIGF0dGVtcHRp
bmcgdG8gZ3JvdyB0aGUgbWRhZG0gYXJyYXk/IAoKSSBhbSBhd2FyZSB0aGF0IEkgbmVlZCB0byBn
cm93IHhmcyBhZnRlciB0aGUgbWRhZG0gZ3JvdyBvcGVyYXRpb24uIAoKUGxlYXNlIGxldCBtZSBr
bm93IG9yIHBvaW50IHRvIHRpcHMuIFRoYW5rcy4KClN1bmRhcg==
