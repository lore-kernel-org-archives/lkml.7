Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A67C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBA0214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dDC2Xz9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfDYJGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:06:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56964 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726150AbfDYJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:06:48 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P8vtgt010204;
        Thu, 25 Apr 2019 11:05:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=9gcnowIpP07YBTGHpsa+ga9c245iPiuAayjtVomVP2Y=;
 b=dDC2Xz9F7q132dOW+AZg4cvlBV7TPVcSixnVdmUDlkbc+KHQlpfRsOvfyMhOvTOe4qTg
 w/6fGaiwHihjeCZi5Q/Ey5AVhfWCINf0LxJxgIa7ov+FaXKKRmYBO/H/05pRAp0QZ4V3
 uzG40RA23YS6dXSLnoCSRe01azl5Ax+45Q2HIL5Jw+aCbRTsLwDnWFOJSN3oC55DXySi
 5LqGkVI8kgZdbb8ygpaNJVr3LLxXpBfAtTS8dk0bQfqPouhC7cdEgKTgls2ZEN++CvOX
 cQKV4EtIQaMzkTgHtd+yC8nsZ/yYntQpf4Agw0/ByZoPXFhF8aquEGMaNpNDicWKQJF9 Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytadbwq9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 11:05:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30AA93D;
        Thu, 25 Apr 2019 09:05:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4C9815AA;
        Thu, 25 Apr 2019 09:05:22 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 25 Apr
 2019 11:05:23 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 25 Apr 2019 11:05:22 +0200
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: stm32: i2s: return the get_irq error
Thread-Topic: [PATCH] ASoC: stm32: i2s: return the get_irq error
Thread-Index: AQHU+rJqRAfgtovdak6IJCRw7t7aO6ZMdRoA
Date:   Thu, 25 Apr 2019 09:05:22 +0000
Message-ID: <215557bf-19f5-7353-e929-f45123f1886e@st.com>
References: <1556119724-9873-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1556119724-9873-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4F5BBA671AEAC43BE4CED75A915CD6E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjQvMTkgNToyOCBQTSwgRmFiaWVuIERlc3Nlbm5lIHdyb3RlOg0KPiBEdXJpbmcg
cHJvYmUsIHJldHVybiB0aGUgImdldF9pcnEiIGVycm9yIHZhbHVlIGluc3RlYWQgb2YgLUVOT0VO
VC4gVGhpcw0KPiBhbGxvd3MgdGhlIGRyaXZlciB0byBiZSBkZWZlcnJlZCBwcm9iZWQgaWYgbmVl
ZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmFiaWVuIERlc3Nlbm5lIDxmYWJpZW4uZGVzc2Vu
bmVAc3QuY29tPg0KDQpBY2tlZC1ieTogT2xpdmllciBNb3lzYW4gPG9saXZpZXIubW95c2FuQHN0
LmNvbT4NCg0KPiAtLS0NCj4gICBzb3VuZC9zb2Mvc3RtL3N0bTMyX2kycy5jIHwgNSArKystLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3N0bS9zdG0zMl9pMnMuYyBiL3NvdW5kL3NvYy9zdG0v
c3RtMzJfaTJzLmMNCj4gaW5kZXggOTUyNjM0Mi4uOTdkNWU5OSAxMDA2NDQNCj4gLS0tIGEvc291
bmQvc29jL3N0bS9zdG0zMl9pMnMuYw0KPiArKysgYi9zb3VuZC9zb2Mvc3RtL3N0bTMyX2kycy5j
DQo+IEBAIC04MzgsOCArODM4LDkgQEAgc3RhdGljIGludCBzdG0zMl9pMnNfcGFyc2VfZHQoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gICAJLyogR2V0IGlycXMgKi8NCj4gICAJaXJx
ID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gICAJaWYgKGlycSA8IDApIHsNCj4gLQkJ
ZGV2X2VycigmcGRldi0+ZGV2LCAibm8gaXJxIGZvciBub2RlICVzXG4iLCBwZGV2LT5uYW1lKTsN
Cj4gLQkJcmV0dXJuIC1FTk9FTlQ7DQo+ICsJCWlmIChpcnEgIT0gLUVQUk9CRV9ERUZFUikNCj4g
KwkJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIGlycSBmb3Igbm9kZSAlc1xuIiwgcGRldi0+bmFt
ZSk7DQo+ICsJCXJldHVybiBpcnE7DQo+ICAgCX0NCj4gICANCj4gICAJcmV0ID0gZGV2bV9yZXF1
ZXN0X2lycSgmcGRldi0+ZGV2LCBpcnEsIHN0bTMyX2kyc19pc3IsIElSUUZfT05FU0hPVCwNCj4g
