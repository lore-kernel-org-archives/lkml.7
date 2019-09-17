Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B808C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F210520678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYLdnDQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfIQTV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:21:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41775 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfIQTV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:21:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so2714557pfh.8;
        Tue, 17 Sep 2019 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=gsX7Gct8xN0tKdmpqaZx5h4cf+DzwKB08UnKxaHcPdI=;
        b=VYLdnDQg+6MsvypYlg+F+1jO8p2b2kIVgaQWtBrN4YGTj5L2scy+fUDovmk6bdAdcW
         vYWAqPh/EGgzeNkx5UksLSGgMAKcnH35JRQzGJYaA63uu0YFibR2pFCp7alZwKzOVYkU
         Y7F3QEUdQ4fYmtcmrI8lGNWPdOIzaP+6DxtgWXw1HJmWBwm92ZF4w8M1o7P9KAZfhdu9
         +JEMnKBXgvTqmkckBcrg5E6bhz0O+pnta/xkqRF/k1d+6HEvBDa1siQ6Nr/gbbqtt9Aa
         X3pmHlxdwyTr08dpHhe26CGFSFXGol2HS5Of/q9JEyV4KLr+olh9No+voA669r4nnTMS
         DpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=gsX7Gct8xN0tKdmpqaZx5h4cf+DzwKB08UnKxaHcPdI=;
        b=m074/Rum0Dub9oF6yQ8pQ/z12okJ8wpftouZb23ccaAd7CW8iXejJO4FEgRVMawcNg
         IaTJKWFUDyLqR05Ls0DK0IGaK+URUtQQ3DPgBZre9Vy3Mvlm/fedLtks0X4bZtSIVFid
         8YCQ16rn04qIywP6+LUbcEMTcRPBSZ+5/szmSf8S7jAeteegjzX7rG/Xhwd0pxzDrGAJ
         eebJHvfWG9XXThysgGxftSkA3m6TkOfpzCcJOt+AETTv5tLL663YfQkJyHQI3Zlz8HkG
         Qt2ufFeJx9XDfHVOwQW6PIvTKkp8hCsUMdeP/hl6WULTCiJRXrBGZNn/gHmZDiv4vBew
         PGnQ==
X-Gm-Message-State: APjAAAWmt3k/fFOFNMIDt2wBpwY3pHWyVP/NWkNuCOJ8VMNcn15Hjm8N
        JNyRgDUWrqQBO8ugzPm2s6Y=
X-Google-Smtp-Source: APXvYqxMMLQwQT0BYDY7rcEIcI5guQR05eHdYMZ/tg2lzurIMejP+3FuOzL42MAQB+WMo7ONg1rbeQ==
X-Received: by 2002:a17:90a:3acf:: with SMTP id b73mr6585095pjc.88.1568748087166;
        Tue, 17 Sep 2019 12:21:27 -0700 (PDT)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id a17sm3644212pfc.26.2019.09.17.12.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 12:21:26 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>
CC:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] fbdev: s3c-fb: use devm_platform_ioremap_resource()
 to simplify code
Thread-Topic: [PATCH -next] fbdev: s3c-fb: use
 devm_platform_ioremap_resource() to simplify code
Thread-Index: AWdoLS4xn2UhU3LGYne7F+3+UfM8ENwKv88M
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 17 Sep 2019 19:21:21 +0000
Message-ID: <SL2P216MB0105ADD044BE3CA7B33CB6ECAA8F0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <20190904115523.25068-1-yuehaibing@huawei.com>
In-Reply-To: <20190904115523.25068-1-yuehaibing@huawei.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDkvNC8xOSwgNzo1NyBBTSwgWXVlSGFpYmluZyB3cm90ZToNCg0KPiBVc2UgZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkgdG8gc2ltcGxpZnkgdGhlIGNvZGUgYSBiaXQu
DQo+IFRoaXMgaXMgZGV0ZWN0ZWQgYnkgY29jY2luZWxsZS4NCj4NCj4gUmVwb3J0ZWQtYnk6IEh1
bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5n
IDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+DQpBY2tlZC1ieTogSmluZ29vIEhhbiA8amluZ29v
aGFuMUBnbWFpbC5jb20+DQo+DQo+IC0tLQ0KPiAgZHJpdmVycy92aWRlby9mYmRldi9zM2MtZmIu
YyB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3MzYy1mYi5jIGIvZHJp
dmVycy92aWRlby9mYmRldi9zM2MtZmIuYw0KPiBpbmRleCBiYTA0ZDdhLi40M2FjOGQ3IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3MzYy1mYi5jDQo+ICsrKyBiL2RyaXZlcnMv
dmlkZW8vZmJkZXYvczNjLWZiLmMNCj4gQEAgLTE0MTEsOCArMTQxMSw3IEBAIHN0YXRpYyBpbnQg
czNjX2ZiX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlwbV9y
dW50aW1lX2VuYWJsZShzZmItPmRldik7DQo+ICANCj4gLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVz
b3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAtCXNmYi0+cmVncyA9IGRldm1faW9y
ZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQo+ICsJc2ZiLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9p
b3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiAgCWlmIChJU19FUlIoc2ZiLT5yZWdzKSkgew0K
PiAgCQlyZXQgPSBQVFJfRVJSKHNmYi0+cmVncyk7DQo+ICAJCWdvdG8gZXJyX2xjZF9jbGs7DQo+
IC0tIA0KPiAyLjcuNA0KDQoNCg==
