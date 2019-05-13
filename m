Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4072EC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12ECD21479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cSXFz5U5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfEMJKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:10:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22272 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbfEMJKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:10:41 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4D92P8b008551;
        Mon, 13 May 2019 11:10:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=542weskigKoJ42ITdEuds81sog7neozb87KgExSQchc=;
 b=cSXFz5U5+rl87jTLh3kdexVxm5fRCNpouuv96sL1JOgXGaa0b8KPKsrLNRt9aIHp29vS
 Xq6SOif1jgsxrp1XLoyRvpZixzwSl7L50Kk/cEKtHY6Wm9ZMXAO7tgM98zStFrid6RAx
 /gaYxiQ2ZcqQrVtqksTZpbWWKAqds1hX3OSj9np1UAC8bGcw4XzUOsQzwAPqeD5dBng6
 vJR6skv4YXWaWKzpM7j6lrt63LWRzi3tY2IbRWEJ4xfE1a+9FPmKDyECc13gAMUMnmqk
 eQm3kBhSuIPmIAHWEbwAoRrFBQb9bHe59nyZ4cUexNiobiiI+PgecrKj4Nl+OA+ZNlml 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sdkuyj0d4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 May 2019 11:10:36 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C90664;
        Mon, 13 May 2019 09:10:35 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE83F1334;
        Mon, 13 May 2019 09:10:34 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 13 May
 2019 11:10:34 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Mon, 13 May 2019 11:10:34 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH 0/2] hwspinlock: add the 'in_atomic' API
Thread-Topic: [PATCH 0/2] hwspinlock: add the 'in_atomic' API
Thread-Index: AQHU1P6fLTW2AJMeL0au0cFYbaNSr6ZpC+wA
Date:   Mon, 13 May 2019 09:10:34 +0000
Message-ID: <41036bca-1266-70e9-6485-b718c9741c3f@st.com>
References: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1551974303-24542-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC814E615EC016498780E18E25E92ACE@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KDQpHZW50bGUgcmVtaW5kZXINCg0KDQpGYWJpZW4NCg0KT24gMDcvMDMvMjAxOSA0OjU4
IFBNLCBGYWJpZW4gRGVzc2VubmUgd3JvdGU6DQo+IEluIGl0cyBjdXJyZW50IGltcGxlbWVudGF0
aW9uLCB0aGUgaHdzcGlubG9jayBmcmFtZXdvcmsgcmVsaWVzIG9uIGppZmZpZXMNCj4gdG8gaGFu
ZGxlIHRoZSB0aW1lb3V0IG9mIHRoZSBod3NwaW5fbG9ja190aW1lb3V0X3h4eCgpIEFQSS4NCj4g
SW4gYW4gYXRvbWljIGNvbnRleHQgKG9yIG1vcmUgcHJlY2lzZWx5IHdoZW4gaXJxIGFyZSBkaXNh
YmxlZCkgamlmZmllcyBkb2VzIG5vdA0KPiBpbmNyZWFzZSwgd2hpY2ggcHJldmVudHMgdGhlIHRp
bWVvdXQgdG8gcmVhY2ggaXRzIHRhcmdldCB2YWx1ZSAoaW5maW5pdGUgbG9vcCkuDQo+DQo+IE5v
dGUgdGhhdCB0aGVyZSBpcyBhbHJlYWR5IGFuIGh3c3BpbmxvY2sgdXNlciB0aGF0IHJ1bnMgaW4g
YXRvbWljIGNvbnRleHQNCj4gKGRyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzItZXh0aS5jKSBhbmQg
dGhhdCBoYXMgdG8gaGFuZGxlIGJ5IGl0c2VsZiB0aGUNCj4gdGltZW91dC4NCj4NCj4gVGhlIGZp
cnN0IHBhdGNoIG9mIHRoZSBzZXJpZXMgY29tcGxldGVzIHRoZSBEb2N1bWVudGF0aW9uICh0aGUg
J3JhdycgQVBJDQo+IGlzIG5vdCBkb2N1bWVudGVkKSwgYW5kIHRoZSBzZWNvbmQgcGF0Y2ggcHJv
dmlkZXMgd2l0aCB0aGUgJ2luX2F0b21pYycgQVBJLg0KPg0KPiBGYWJpZW4gRGVzc2VubmUgKDIp
Og0KPiAgICBod3NwaW5sb2NrOiBkb2N1bWVudCB0aGUgaHdzcGlubG9jayAncmF3JyBBUEkNCj4g
ICAgaHdzcGlubG9jazogYWRkIHRoZSAnaW5fYXRvbWljJyBBUEkNCj4NCj4gICBEb2N1bWVudGF0
aW9uL2h3c3BpbmxvY2sudHh0ICAgICAgICAgfCA4MSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gICBkcml2ZXJzL2h3c3BpbmxvY2svaHdzcGlubG9ja19jb3JlLmMgfCA0
MyArKysrKysrKysrKysrLS0tLS0tDQo+ICAgaW5jbHVkZS9saW51eC9od3NwaW5sb2NrLmggICAg
ICAgICAgIHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgMyBmaWxlcyBjaGFu
Z2VkLCAxNjkgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+
