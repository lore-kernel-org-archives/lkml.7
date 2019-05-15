Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C910C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F6220873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfEONvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:51:20 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48226 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEONvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:51:19 -0400
Received: from ambrosehua-X201 (unknown [175.152.210.209])
        by mail (Coremail) with SMTP id QMiowPAxGtUlGdxcr2kBAA--.62S2;
        Wed, 15 May 2019 21:50:31 +0800 (CST)
Date:   Wed, 15 May 2019 21:50:27 +0800
From:   "huangpei@loongson.cn" <huangpei@loongson.cn>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Paul Burton" <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
References: <20190424123656.484227701@infradead.org>, 
        <20190424124421.636767843@infradead.org>, 
        <20190424211759.52xraajqwudc2fza@pburton-laptop>, 
        <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>, 
        <20190425073348.GV11158@hirez.programming.kicks-ass.net>, 
        <20190425091258.GC14281@hirez.programming.kicks-ass.net>, 
        <20190514155813.GG2677@hirez.programming.kicks-ass.net>, 
        <CAHk-=wgxT24Z6Ba_4DKbMfBnQ0Cp4gzwp6Vq1aBkU5bsjqKUhg@mail.gmail.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.10.151[cn]
Mime-Version: 1.0
Message-ID: <201905152150256295825@loongson.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID: QMiowPAxGtUlGdxcr2kBAA--.62S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw18JFy3Zw4kKFWrJw1kXwb_yoW8Ary8pF
        WfKwnFkrZ5ZFs7C34qya17XFyrXryUA3ZxAr18Z3Z8ArZ8C34Ivr17tFs09FyqyrZ5Gw4Y
        v3yqqw1xuFs3AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Eb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4xvF2IEb7IF0Fy264kE64k0
        F24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFc
        xC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU5DHUPUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5PbiBUdWUsIE1heSAxNCwgMjAxOSBhdCA4OjU4IEFNIFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4+Cj4+IFNvIGlmIHR3byB2YXJpYWJsZXMgc2hhcmUgYSBs
aW5lLCBhbmQgb25lIGlzIGxvY2FsIHdoaWxlIHRoZSBvdGhlciBpcwo+PiBzaGFyZWQgYXRvbWlj
LCBjYW4gY29udGVudGlvbiBvbiB0aGUgbGluZSwgYnV0IG5vdCB0aGUgdmFyaWFibGUsIGNhdXNl
Cj4+IGlzc3VlcyBmb3IgdGhlIGxvY2FsIHZhcmlhYmxlPwo+Pgo+PiBJZiBub3Q7IHdoeSBub3Q/
IEJlY2F1c2Ugc28gZmFyIHRoZSBpc3N1ZSBpcyBsaW5lIGdyYW51bGFyIGR1ZSB0byB0aGUKPj4g
Y29oZXJlbmNlIGFzcGVjdC4KPgo+SWYgSSB1bmRlcnN0b29kIHRoZSBpc3N1ZSBjb3JyZWN0bHks
IGl0J3Mgbm90IHRoYXQgY2FjaGUgY29oZXJlbmNlCj5kb2Vzbid0IHdvcmssIGl0J3MgbGl0ZXJh
bGx5IHRoYXQgdGhlIHNjIHN1Y2NlZWRzIHdoZW4gaXQgc2hvdWxkbid0Lgo+Cj5JbiBvdGhlciB3
b3JkcywgaXQncyBub3QgZ29pbmcgdG8gYWZmZWN0IGFueXRoaW5nIGVsc2UsIGJ1dCBpdCBtZWFu
cwo+dGhhdCAibGwvc2MiIGlzbid0IGFjdHVhbGx5IHRydWx5IGF0b21pYywgYmVjYXVzZSB0aGUg
Y2FjaGVsaW5lIGNvdWxkCj5oYXZlIGJvdW5jZWQgYXJvdW5kIHRvIGFub3RoZXIgQ1BVIGluIHRo
ZSBtZWFudGltZS4KPgo+U28gd2UgKnRoaW5rKiB3ZSBnb3QgYW4gYXRvbWljIHVwZGF0ZSwgYnV0
IGRpZG4ndCwgYW5kIHRoZSAibGwvc2MiCj5wYWlyIGVuZHMgdXAgaW5jb3JyZWN0bHkgd29ya2lu
ZyBhcyBhIHJlZ3VsYXIgImxvYWQgLT4gc3RvcmUiIHBhaXIsCj5iZWNhdXNlIHRoZSAic2MnIGlu
Y29ycmVjdGx5IHRob3VnaHQgaXQgc3RpbGwgaGFkIGV4Y2x1c2l2ZSBhY2Nlc3MgdG8KPnRoZSBs
aW5lIGZyb20gdGhlICJsbCIuCj4KPlRoZSBhZGRlZCBtZW1vcnkgYmFycmllciBpc24ndCBiZWNh
dXNlIGl0J3MgYSBtZW1vcnkgYmFycmllciwgaXQncwo+anVzdCBrZWVwaW5nIHRoZSBzdWJzZXF1
ZW50IHNwZWN1bGF0aXZlIGluc3RydWN0aW9ucyBmcm9tIGdldHRpbmcgdGhlCj5jYWNoZWxpbmUg
YmFjayBhbmQgY2F1c2luZyB0aGF0ICJzYyIgY29uZnVzaW9uLgo+Cj5CdXQgbm90ZSBob3cgZnJv
bSBhIGNhY2hlIGNvaGVyZW5jeSBzdGFuZHBvaW50LCBpdCdzIG5vdCBhYm91dCB0aGUKPmNhY2hl
IGNvaGVyZW5jeSBiZWluZyB3cm9uZywgaXQncyBsaXRlcmFsbHkganVzdCBhYm91dCB0aGUgbGwv
c2Mgbm90Cj5naXZpbmcgdGhlIGF0b21pY2l0eSBndWFyYW50ZWVzIHRoYXQgdGhlIHNlcXVlbmNl
IGlzICpzdXBwb3NlZCogdG8KPmdpdmUuIFNvIGFuICJhdG9taWNfaW5jKCkiIGNhbiBiYXNpY2Fs
bHkgKHVuZGVyIGp1c3QgdGhlIHdyb25nCj5jaXJjdW1zdGFuY2VzKSBlc3NlbnRpYWxseSB0dXJu
IGludG8ganVzdCBhIG5vbi1hdG9taWMgIipwKysiLgo+IApBZ3JlZWTvvIx0aGF0IGlzIGV4YWN0
bHkgd2hhdCBJIHdhcyBsZWFybmVkLgoKPk5PVEUhIEkgaGF2ZSBubyBhY3R1YWwgaW5zaWRlIGtu
b3dsZWRnZSBvZiB3aGF0IGlzIGdvaW5nIG9uLiBUaGUgYWJvdmUKPmlzIHB1cmVseSBteSByZWFk
aW5nIG9mIHRoaXMgdGhyZWFkLCBhbmQgbWF5YmUgSSBoYXZlIG1pcy11bmRlcnN0b29kLgo+IAoK
eW91IGdvdCBpdCByaWdodC4KPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTGlu
dXM=


