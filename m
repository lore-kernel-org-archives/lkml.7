Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83ABFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA14D224D3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EKxBWMQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbfKHMZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:25:30 -0500
Received: from m12-14.163.com ([220.181.12.14]:43228 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbfKHMZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Mime-Version:Message-ID; bh=sXQMq
        3Mqv1FBKPWUPLWRvdfBQohYfVcpdQ2VLUApC3A=; b=EKxBWMQkXqRLBW+ET0XpU
        ewCrcYcB3V+EJZOeedsbfJAZSzOn8r72vxHkPZYwx4Uu3M+Za60fKkbiCUf6mVa2
        rzhNBT4YJCzRTPsp0K84CoZq14D/bW9AnolowlrADuEUiaKxTDUXQDdfAzxEEmY8
        bLEO64igE16Sq3neVIwSzU=
Received: from SKY-20180422ZRB (unknown [117.36.117.81])
        by smtp10 (Coremail) with SMTP id DsCowADXbtOWXsVdh_N6CA--.56297S2;
        Fri, 08 Nov 2019 20:24:55 +0800 (CST)
Date:   Fri, 8 Nov 2019 20:25:41 +0800
From:   "sxauwsk@163.com" <sxauwsk@163.com>
To:     "Shubhrajyoti Datta" <shubhrajyoti.datta@gmail.com>
Cc:     "Michal Simek" <michal.simek@xilinx.com>,
        "Shubhrajyoti Datta" <shubhrajyoti.datta@xilinx.com>,
        "Wolfram Sang" <wsa@the-dreams.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2] i2c: cadence: try reset when master receive arbitration lost
References: <20190219012447.5900-1-sxauwsk@163.com>, 
        <CAKfKVtEwHcydp=+hNhG91h3qbMoYOPq7jEYjbuAVrWXT53DC3Q@mail.gmail.com>, 
        <2019110516474778997625@163.com>, 
        <CAKfKVtH8OvA9Hku8V2CxRkX8hiouLzsEJTTDQWgBtQF8PGXyBQ@mail.gmail.com>
X-Priority: 3
X-GUID: B69C82CD-C26C-4FA3-8703-82AD1DB2BEFE
X-Has-Attach: no
X-Mailer: Foxmail 7.2.14.406[cn]
Mime-Version: 1.0
Message-ID: <201911082025396282138@163.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID: DsCowADXbtOWXsVdh_N6CA--.56297S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7KF45XFW3CF1fKrW7urg_yoW8CFy3pa
        y8Ja4fKF4DJF1SyrsF9F1v9FWjg3yxGF98Gr15Jw18uas0kryjyFy2kFZ8uFyxGrW7Aws0
        vr4vvwn2gas8ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeoGQUUUUU=
X-Originating-IP: [117.36.117.81]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/xtbBZBdnJlQHHiI53AAAs4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkhpIFNoaWthaSwKPgo+T24gVHVlLCBOb3YgNSwgMjAxOSBhdCAyOjE4IFBNIHN4YXV3c2tAMTYz
LmNvbSA8c3hhdXdza0AxNjMuY29tPiB3cm90ZToKPj4KPj4gPkhpIFNoaWthaSwKPj4gPgo+PiA+
T24gVHVlLCBGZWIgMTksIDIwMTkgYXQgODoxOSBBTSBTaGlrYWkgV2FuZyA8c3hhdXdza0AxNjMu
Y29tPiB3cm90ZToKPj4gPj4KPj4gPj4gV2hlbiB0aGUgYWRhcHRlciByZWNlaXZlIGFyYml0cmF0
aW9uIGxvc3QgZXJyb3IgaW50ZXJydXB0cywKPj4gPj4gY2Ruc19pMmNfbWFzdGVyX3hmZXIgcmV0
dXJuIHRvIHRoZSBjYWxsZXIgZGlyZWN0bHkgaW5zdGVhZCBvZiByZXNldHRpbmcKPj4gPj4gdGhl
IGFkYXB0ZXIgd2hpY2ggcmVzdWx0ZWQgaW4gdGhlIGFkYXB0ZXIgYmVpbmcgb3V0IG9mIGNvbnRy
b2wuCj4+ID4+Cj4+ID4+IFNvIHdoZW4gZHJpdmVyIGRldGVjdCBlcnJfc3RhdHVzIHN1Y2ggYXMg
YXJiaXRyYXRpb24gbG9zdCwKPj4gPj4gdGhlbiB0cnkgdG8gcmVwYWlyIGFuZCBmaXggaXQuCj4+
ID4+Cj4+ID5JIGFtIG1pc3NpbmcgdGhlIGlzc3VlIHRoYXQgeW91IGFyZSBmYWNpbmcuCj4+ID5Z
b3UgYXJlIGhhdmluZyBhIG11bHRpbWFzdGVyIHNjZW5hcmlvIGFuZCBnZXR0aW5nIGFyYml0cmF0
aW9uIGxvc3QuCj4+ID4KPj4gPnRoZSBjdXJyZW50IGNvZGUgd291bGQgYXR0ZW1wdCBhIHJldHJ5
IGRpZCB0aGF0IGxlYWQgdG8gYW55IGlzc3Vlcz8KPj4gPgo+PiA+Q2FuIHlvdSBleHBsYWluIHRo
ZSBpc3N1ZSB0aGF0IHlvdSBhcmUgZmFjaW5nPwo+Pgo+PiBPZiBjb3VyY2UswqAgVGhlIGZvbGxv
d2luZyBkZXNjcmliZSBteSBzaXR1YXRpb24uCj4+Cj4+IEluIG15IHByb2R1Y3QswqAgVG91Y2hz
Y3JlZW4gY29ubmVjdCB0byB6eW5xLTcwMDAgWEM3WjAxMCBieSBpMmMgYnVzKCBKdXN0IGNvbm5l
Y3Qgb25seSBvbmUgaTJjLWRldmljZSBvZiB0b3VjaHNjcmVlbiksCj4+IHdoZW4gdXNlciB0YXAg
VG91Y2hzY3JlZW4sIFRvdWNoc2NyZWVuIGludGVycnVwdCBzZW5kIHRvIENQVSBhbmQgbm90aWZ5
ZWQgaTJjLWRyaXZlciB0byBvYnRhaW4gbG9jYXRpb24gZGF0YSBieSBpMmMtYnVzLAo+Cj5TbyBp
dCBpcyBzaW5nbGUgbWFzdGVyIHNpbmdsZSBzbGF2ZS4KPj4KPj4gd2hlbiBUYXAgdGhlIHNjcmVl
biBmcmVxdWVudGx5LMKgIHNvbWV0aW1lcyBDUFUgZ2V0IGludGVycnVwdCBmcm9tIHRvdWNoc2Ny
ZWVuIGFuZCB0cnkgdG8gb2J0YWluIGRhdGEswqAgdGhlbiBkZXRlY3QgYXJiaXRyYXRpb24gbG9z
dCwKPnRoZSBhcmJpdHJhdGlvbiBsb3N0IGlzIHN1cnByaXNpbmcgaW4gbm9uLW11bHRpbWFzdGVy
IHNjZW5hcmlvLgo+SXMgdGhlcmUgYW55IG90aGVyIG1hc3RlciBpbiB0aGUgY29uZmlndXJhdGlv
biB0aGF0IHdlIG1heSBub3QgYmUgdHJpZ2dlcmluZy4KPk9yIGNhbsKgIHlvdSBwcm9iZSB0aGUg
bGluZXM/Cj4KPj4gQWx0aG91Z2ggaTJjLWRyaXZlciB0cnkgdGhyZWUgdGltZXMswqAgaXQncyB1
c2VsZXNzLgo+Cj5Zb3UgZ2V0IGJ1cyBidXN5PyB3aGF0IGlzIHRoZSBpc3N1ZS4KPj4KPj4gQWN0
dWFsbHkgaTJjIGNsb2NrLWxpbmUgYW5kIGRhdGEtbGluZSBrZWVwIGhpZ2gsIHRoYXQgbWVhbiBp
MmMgYnVzIGZyZWUuCj4+IE9uY2UgdGhpcyBzaXR1YXRpb24gb2NjdXIsIGkyYy1jb250cm9sIGRp
ZCd0IHdvcmsgYW55bmF5IGJ1dCBjcHUgcmVjZWl2ZSBpbnRlcnJwdXRzIHN0aWxsLgo+Pgo+PiBJ
IGFtIHNvcnJ5IHRoYXQgSSBoYXZlJ3QgZm91bmQgYSBnb29kIHNvbHV0aW9uIGZvciB0aGlzIGlz
c3VzZTsgCgpZZXMsIMKgSSBjYW4ndCBiZWxpZXZlIHRoYXQsIMKgTWF5YmUgY2F1c2VkIGJ5IHRo
ZSBoYXJkd2FyZSBlbnZpcm9ubWVudCBvciBhbnkgb3RoZXIgd2VsbC4KQWRkaXRpb25hbGx5IEkg
aGF2ZSd0IMKgcHJvYmUgdGhpcyBpc3N1ZSByZWNlbnRseS7CoA==


