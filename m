Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B35C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F952082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfC0XMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:12:24 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49984 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0XMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:12:23 -0400
Received: by ajax-webmail-mail (Coremail) ; Thu, 28 Mar 2019 07:12:13 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [123.151.77.70]
Date:   Thu, 28 Mar 2019 07:12:13 +0800 (GMT+08:00)
From:   qiaochong <qiaochong@loongson.cn>
To:     "Doug Anderson" <dianders@chromium.org>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@mips.com>,
        "James Hogan" <jhogan@kernel.org>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Will Deacon" <will.deacon@arm.com>,
        "Christophe Leroy" <christophe.leroy@c-s.fr>,
        linux-mips <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re:Re: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <CAD=FV=UhqQh2i1CUfgGHPdUtFWsTznCL_1tNafG+F74oHXM1Ew@mail.gmail.com>
References: <20190327150551.12851-1-qiaochong@loongson.cn>
 <CAD=FV=WAvzz+wXZzoLZvxBhO4P_RjV2op=uiX9dHD2dPdSCruw@mail.gmail.com>
 <727cd934.9e92.169c1422cf2.Coremail.qiaochong@loongson.cn>
 <CAD=FV=UhqQh2i1CUfgGHPdUtFWsTznCL_1tNafG+F74oHXM1Ew@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: spvbGWZvb3Rlcl90eHQ9NjAyOjczNA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <419d0aab.9e93.169c16ce62c.Coremail.qiaochong@loongson.cn>
X-CM-TRANSID: QMiowPDxpuRNA5xc2mG0AA--.9549W
X-CM-SenderInfo: 5tld0upkrqwqxorr0wxvrqhubq/1tbiAQACDFEBqdSvPAALs6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG91ZywKCkkgaGF2ZSBjaGFuZ2VkIG5hbWUgYW5kIHNpZ25vZmYgaW5mbyAgZm9ybWF0IGFu
ZCByZXNlbnQgcGF0Y2ggIGp1c3Qgbm93LgpUaGFua3MgYSBsb3QuCgrlnKggMjAxOS0wMy0yOCAw
NjoyNzoyNu+8jCJEb3VnIEFuZGVyc29uIiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPiDlhpnpgZPv
vJoKCj5IaSwKPgo+T24gV2VkLCBNYXIgMjcsIDIwMTkgYXQgMzoyNSBQTSBxaWFvY2hvbmcgPHFp
YW9jaG9uZ0Bsb29uZ3Nvbi5jbj4gd3JvdGU6Cj4+Cj4+Cj4+IE15IG5hbWUgIGlzIFFpYW9DaG9u
Z++8jCB3aGljaCBpcyBzYW1lIHRvIG15IHVzZXJuYW1lLgo+PiBRaWFvIGlzIG15IGZhbWlseSBu
YW1lLgo+PiBUaGFua3MgYSBsb3QuCj4KPkkgZ3Vlc3MgaXQgd2lsbCBiZSB1cCB0byB3aGljaGV2
ZXIgbWFpbnRhaW5lciBsYW5kcyB0aGlzIChtYXliZQo+RGFuaWVsPykgb24gd2hldGhlciB0aGV5
IHdhbnQgeW91IHRvIHNwaW4gaXQuICBJIHRoaW5rIGZvbGtzIGV4cGVjdCB0bwo+c2VlIGEgcmVh
bCBuYW1lIHRoYXQgaXMgY2FwaXRhbGl6ZWQgYW5kIHVzdWFsbHkgYSBzcGFjZSBiZXR3ZWVuIHRo
ZQo+ZmFtaWx5IG5hbWUgYW5kIHRoZSBnaXZlbiBuYW1lLgo+Cj4tRG91ZwoNCg0K5YyX5Lqs5biC
5rW35reA5Yy65Lit5YWz5p2R546v5L+d56eR5oqA56S66IyD5Zut6b6Z6Iqv5Lqn5Lia5ZutMuWP
t+alvCAxMDAwOTXnlLXor506ICs4NiAoMTApIDYyNTQ2NjY45Lyg55yfOiArODYgKDEwKSA2MjYw
MDgyNnd3dy5sb29uZ3Nvbi5jbuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+aciem+meiKr+S4reen
keaKgOacr+aciemZkOWFrOWPuOeahOWVhuS4muenmOWvhuS/oeaBr++8jOS7hemZkOS6juWPkemA
gee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9
leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmD
qOaIlumDqCDliIblnLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5HvvInmnKzpgq7ku7blj4rlhbbp
mYTku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzpgq7ku7bvvIzor7fmgqjnq4vl
jbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bjgIIgDQoN
ClRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZv
cm1hdGlvbiBmcm9tIExvb25nc29uDQpUZWNobm9sb2d5IENvcnBvcmF0aW9uIExpbWl0ZWQsIHdo
aWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5DQp3aG9zZSBhZGRy
ZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVk
IGhlcmVpbiBpbg0KYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFs
IG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwNCnJlcHJvZHVjdGlvbiBvciBkaXNzZW1pbmF0aW9uKSBi
eSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKQ0KaXMgcHJvaGli
aXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGJ5DQpwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0LiA=

