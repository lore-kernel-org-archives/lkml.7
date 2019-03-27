Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B194C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC55021738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfC0WZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:25:47 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49533 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfC0WZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:25:47 -0400
Received: by ajax-webmail-mail (Coremail) ; Thu, 28 Mar 2019 06:25:33 +0800
 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
X-Originating-IP: [220.194.107.221]
Date:   Thu, 28 Mar 2019 06:25:33 +0800 (GMT+08:00)
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
Subject: Re:Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.6a_preview build
 20150605(69773.7394) Copyright (c) 2002-2019 www.mailtech.cn loongson
In-Reply-To: <CAD=FV=WAvzz+wXZzoLZvxBhO4P_RjV2op=uiX9dHD2dPdSCruw@mail.gmail.com>
References: <20190327150551.12851-1-qiaochong@loongson.cn>
 <CAD=FV=WAvzz+wXZzoLZvxBhO4P_RjV2op=uiX9dHD2dPdSCruw@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: hVRFB2Zvb3Rlcl90eHQ9MTc3MTo3MzQ=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <727cd934.9e92.169c1422cf2.Coremail.qiaochong@loongson.cn>
X-CM-TRANSID: QMiowPDx779e+JtcqVu0AA--.6105W
X-CM-SenderInfo: 5tld0upkrqwqxorr0wxvrqhubq/1tbiAQACDFEBqdSvPAAIs5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck15IG5hbWUgIGlzIFFpYW9DaG9uZ++8jCB3aGljaCBpcyBzYW1lIHRvIG15IHVzZXJuYW1lLgpR
aWFvIGlzIG15IGZhbWlseSBuYW1lLgpUaGFua3MgYSBsb3QuCgrlnKggMjAxOS0wMy0yOCAwMDoy
NTowNu+8jCJEb3VnIEFuZGVyc29uIiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPiDlhpnpgZPvvJoK
Cj5IaSwKPgo+T24gV2VkLCBNYXIgMjcsIDIwMTkgYXQgODowNiBBTSBxaWFvY2hvbmcgPHFpYW9j
aG9uZ0Bsb29uZ3Nvbi5jbj4gd3JvdGU6Cj4+Cj4+IEtHREJfY2FsbF9ubWlfaG9vayBpcyBjYWxs
ZWQgYnkgb3RoZXIgY3B1IHRocm91Z2ggc21wIGNhbGwuCj4+IE1JUFMgc21wIGNhbGwgaXMgcHJv
Y2Vzc2VkIGluIGlwaSBpcnEgaGFuZGxlciBhbmQgcmVncyBpcyBzYXZlZCBpbgo+PiAgaGFuZGxl
X2ludC4KPj4gU28ga2dkYl9jYWxsX25taV9ob29rIGdldCByZWdzIGJ5IGdldF9pcnFfcmVncyBh
bmQgcmVncyB3aWxsIGJlIHBhc3NlZAo+PiAgdG8ga2dkYl9jcHVfZW50ZXIuCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IHFpYW9jaG9uZyA8cWlhb2Nob25nQGxvb25nc29uLmNuPgo+Cj5Ob3RlIHRoYXQg
eW91IG1pZ2h0IHdhbnQgdG8gYWRqdXN0IHlvdXIgZ2l0IHNldHRpbmdzLiAgVXN1YWxseSBpbiB0
aGUKPmtlcm5lbCB0aGV5IHJlcXVpcmUgdGhhdCBhIFNpZ25lZC1vZmYtYnkgaGF2ZSB5b3VyIHJl
YWwgbmFtZSwgbm90IGp1c3QKPnlvdXIgdXNlcm5hbWUuICBZb3UgcHJvYmFibHkgbmVlZCB0byBz
cGluIHlvdXIgcGF0Y2ggdG8gZml4IHRoaXMuICBZb3UKPnNob3VsZCBtYWtlIHN1cmUgdGhhdCB0
aGUgYXV0aG9yc2hpcCBvZiB0aGUgcGF0Y2ggYWxzbyBoYXMgeW91ciByZWFsCj5uYW1lLgo+Cj4K
Pj4gLS0tCj4+ICBhcmNoL21pcHMva2VybmVsL2tnZGIuYyB8IDMgKystCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9h
cmNoL21pcHMva2VybmVsL2tnZGIuYyBiL2FyY2gvbWlwcy9rZXJuZWwva2dkYi5jCj4+IGluZGV4
IDZlNTc0YzAyZTRjM2IuLmVhNzgxYjI5ZjdmMTcgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvbWlwcy9r
ZXJuZWwva2dkYi5jCj4+ICsrKyBiL2FyY2gvbWlwcy9rZXJuZWwva2dkYi5jCj4+IEBAIC0zMyw2
ICszMyw3IEBACj4+ICAjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nvci5oPgo+PiAgI2luY2x1ZGUgPGFz
bS9zaWdjb250ZXh0Lmg+Cj4+ICAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgo+PiArI2luY2x1
ZGUgPGFzbS9pcnFfcmVncy5oPgo+Pgo+PiAgc3RhdGljIHN0cnVjdCBoYXJkX3RyYXBfaW5mbyB7
Cj4+ICAgICAgICAgdW5zaWduZWQgY2hhciB0dDsgICAgICAgLyogVHJhcCB0eXBlIGNvZGUgZm9y
IE1JUFMgUjN4eHggYW5kIFI0eHh4ICovCj4+IEBAIC0yMTQsNyArMjE1LDcgQEAgdm9pZCBrZ2Ri
X2NhbGxfbm1pX2hvb2sodm9pZCAqaWdub3JlZCkKPj4gICAgICAgICBvbGRfZnMgPSBnZXRfZnMo
KTsKPj4gICAgICAgICBzZXRfZnMoS0VSTkVMX0RTKTsKPj4KPj4gLSAgICAgICBrZ2RiX25taWNh
bGxiYWNrKHJhd19zbXBfcHJvY2Vzc29yX2lkKCksIE5VTEwpOwo+PiArICAgICAgIGtnZGJfbm1p
Y2FsbGJhY2socmF3X3NtcF9wcm9jZXNzb3JfaWQoKSwgZ2V0X2lycV9yZWdzKCkpOwo+Pgo+PiAg
ICAgICAgIHNldF9mcyhvbGRfZnMpOwo+PiAgfQo+Cj5BcyBwZXIgbXkgcmVwbHkgb24gVjEsIGZl
ZWwgZnJlZSB0byBhZGQ6Cj4KPlJldmlld2VkLWJ5OiBEb3VnbGFzIEFuZGVyc29uIDxkaWFuZGVy
c0BjaHJvbWl1bS5vcmc+Cg0KDQrljJfkuqzluILmtbfmt4DljLrkuK3lhbPmnZHnjq/kv53np5Hm
ioDnpLrojIPlm63pvpnoiq/kuqfkuJrlm60y5Y+35qW8IDEwMDA5NeeUteivnTogKzg2ICgxMCkg
NjI1NDY2NjjkvKDnnJ86ICs4NiAoMTApIDYyNjAwODI2d3d3Lmxvb25nc29uLmNu5pys6YKu5Lu2
5Y+K5YW26ZmE5Lu25ZCr5pyJ6b6Z6Iqv5Lit56eR5oqA5pyv5pyJ6ZmQ5YWs5Y+455qE5ZWG5Lia
56eY5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE
5Liq5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/
55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOoIOWIhuWcsOazhOmcsuOAgeWkjeWI
tuaIluaVo+WPke+8ieacrOmCruS7tuWPiuWFtumZhOS7tuS4reeahOS/oeaBr+OAguWmguaenOaC
qOmUmeaUtuacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7
tuS6uuW5tuWIoOmZpOacrOmCruS7tuOAgiANCg0KVGhpcyBlbWFpbCBhbmQgaXRzIGF0dGFjaG1l
bnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTG9vbmdzb24NClRlY2hu
b2xvZ3kgQ29ycG9yYXRpb24gTGltaXRlZCwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhl
IHBlcnNvbiBvciBlbnRpdHkNCndob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNl
IG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluDQphbnkgd2F5IChpbmNsdWRp
bmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLA0KcmVw
cm9kdWN0aW9uIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50KHMpDQppcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVt
YWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkNCnBob25lIG9yIGVtYWls
IGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQuIA==
