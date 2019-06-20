Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D78C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C93F20675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QE4URSfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbfFTPTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:19:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38120 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbfFTPTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:19:08 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KFHhOE011982;
        Thu, 20 Jun 2019 17:18:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=3awahpLzjIg/zQ8bAq/yq4u/Eajukl1uJeabfahZE1k=;
 b=QE4URSfxjpHaljx4dsJHe7OiqHVN6fRUApZ7Yc2CHBNzWUJ0sELxztHUhoNWPWJA9H+p
 7bAVnFzPrpkMJ3zKoP/vmqvYoJ4dvQ5bE4U89jwhIRfnJy0I9BTc5ljcBwXAxVp35OOo
 etfmfe+F7NIo7hFUzjXFv7uPJfEX03p44gkNNV77syS3TtMiB5Q7hP6BEzSII79JKmfW
 WrkyoyNiAjxyV8RxFpUuCChqDuS3ZJjIL6C3PNr2uosibu4XfNu9UMTZJo7+S7utW3W5
 RegGBa6tbYoq9e3OhzSxlmX92P8iXb18fHvUVSYGxZCyFtNmyGYvv9XKNGyLWikcjlPp lA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t78132f08-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 20 Jun 2019 17:18:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC41831;
        Thu, 20 Jun 2019 15:18:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8FE02C8C;
        Thu, 20 Jun 2019 15:18:03 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 20 Jun
 2019 17:18:03 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 20 Jun 2019 17:18:03 +0200
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mfd: stmfx: Fix an endian bug in stmfx_irq_handler()
Thread-Topic: [PATCH] mfd: stmfx: Fix an endian bug in stmfx_irq_handler()
Thread-Index: AQHVJT/EzC9etQZAeEm7fd3OYhvByKag8E+AgADT/ICAAJenAIACLrsA
Date:   Thu, 20 Jun 2019 15:18:03 +0000
Message-ID: <f0ff1e54-c1b9-4a08-c7ff-2ff545e398c3@st.com>
References: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
 <20190617190605.GA21332@mwanda> <20190618081645.GM16364@dell>
 <CAHk-=wghW+AKvRGevUiVWwTqWObygSZSdq6Dz2ad81H73VeuRQ@mail.gmail.com>
 <20190619055816.GF18371@dell>
In-Reply-To: <20190619055816.GF18371@dell>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <18B2C5B8D6D879419D1A363687D100BA@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xOS8xOSA3OjU4IEFNLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9uIFR1ZSwgMTggSnVuIDIw
MTksIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPiANCj4+IE9uIFR1ZSwgSnVuIDE4LCAyMDE5IGF0
IDE6MTYgQU0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pj4NCj4+
Pj4gUmVwb3J0ZWQtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9u
Lm9yZz4NCj4+Pg0KPj4+IElkZWFsbHkgd2UgY2FuIGdldCBhIHJldmlldyB0b28uDQo+Pg0KPj4g
TG9va3MgZmluZSB0byBtZSwgYnV0IG9idmlvdXNseSBzb21lYm9keSBzaG91bGQgYWN0dWFsbHkg
X3Rlc3RfIGl0IHRvby4NCj4gDQo+IEFtZWxpZSwgd291bGQgeW91IGJlIHNvIGtpbmQ/DQo+IA0K
DQpUZXN0ZWQgb24gc3RtMzJtcDE1N2MtZXYxLg0KDQpUZXN0ZWQtYnk6IEFtZWxpZSBEZWxhdW5h
eSA8YW1lbGllLmRlbGF1bmF5QHN0LmNvbT4=
