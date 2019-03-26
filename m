Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057182075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="YGbUuNOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbfCZPVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:21:24 -0400
Received: from m15-29.126.com ([220.181.15.29]:47375 "EHLO m15-29.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCZPVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=b0/RK
        zzp+5oKOQQwWeV+adVheJakuAyEinAyTntq0/E=; b=YGbUuNOozUbuiOdpwD/e5
        ga6JNJKtnYUGgrmWve8vtDrQ8dEY+Vj/+RrGCATCUAoE7MI1ZlCLePLOZgKetGry
        y8k10ariH5BnPq6vjTB+4fgvb3XxVUVjeElyZu4pAyX/TDlyg84WW6E10dGiO1cw
        fdYKnNKr8K67x47CHEXm0I=
Received: from liuxiang_1999$126.com ( [222.209.19.73] ) by
 ajax-webmail-wmsvr29 (Coremail) ; Tue, 26 Mar 2019 23:20:44 +0800 (CST)
X-Originating-IP: [222.209.19.73]
Date:   Tue, 26 Mar 2019 23:20:44 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     "Vignesh Raghavendra" <vigneshr@ti.com>
Cc:     "Liu Xiang" <liu.xiang6@zte.com.cn>, bbrezillon@kernel.org,
        richard@nod.at, linux-kernel@vger.kernel.org,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        computersforpeace@gmail.com, dwmw2@infradead.org
Subject: Re:Re: [PATCH v2] mtd: spi-nor: Return error when nor->addr_width
 does not match the device size
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180927(cd7136b6) Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <823dcd3f-8b9f-15c5-a072-06625120766e@ti.com>
References: <1552484753-3393-1-git-send-email-liu.xiang6@zte.com.cn>
 <823dcd3f-8b9f-15c5-a072-06625120766e@ti.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <209ad144.9c0a.169ba96e2ad.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HcqowADXTelNQ5pccQ0MAA--.9976W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiZhuDsFpD5zoPcgABs2
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKSGksIFZpZ25lc2gKCgoKCgoKQXQgMjAxOS0wMy0xOSAxMzoyMjoxNSwgIlZpZ25lc2ggUmFn
aGF2ZW5kcmEiIDx2aWduZXNockB0aS5jb20+IHdyb3RlOgo+SGksCj4KPk9uIDEzLzAzLzE5IDc6
MTUgUE0sIExpdSBYaWFuZyB3cm90ZToKPj4gSW4gc29tZSBpczI1bHAyNTYsIHRoZSBEV09SRDEg
b2YgSkVERUMgQmFzaWMgRmxhc2ggUGFyYW1ldGVyIEhlYWRlcgo+PiBpcyAweGZmZjkyMGU1LiBT
byB0aGUgRFdPUkQxWzE4OjE3XSBBZGRyZXNzIEJ5dGVzIGJpdHMgYXJlIDBiMDAsCj4+IG1lYW5z
IHRoYXQgMy1CeXRlIG9ubHkgYWRkcmVzc2luZy4gQnV0IHRoZSBkZXZpY2Ugc2l6ZSBpcyBsYXJn
ZXIKPj4gdGhhbiAxNk1CLCBub3ItPmFkZHJfd2lkdGggbXVzdCBiZSA0IHRvIGFjY2VzcyB0aGUg
d2hvbGUgYWRkcmVzcy4KPj4gQW4gZXJyb3Igc2hvdWxkIGJlIHJldHVybmVkIHdoZW4gbm9yLT5h
ZGRyX3dpZHRoIGRvZXMgbm90IG1hdGNoCj4+IHRoZSBkZXZpY2Ugc2l6ZSBpbiBzcGlfbm9yX3Bh
cnNlX2JmcHQoKS4gVGhlbiBpdCBjYW4gZ28gYmFjayB0bwo+PiB1c2Ugc3BpX25vcl9pZHNbXSBm
b3Igc2V0dGluZyB0aGUgcmlnaHQgYWRkcl93aWR0aC4KPj4gCj4+IFN1Z2dlc3RlZC1ieTogQm9y
aXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+Cj4+IFNpZ25lZC1vZmYt
Ynk6IExpdSBYaWFuZyA8bGl1LnhpYW5nNkB6dGUuY29tLmNuPgo+PiAtLS0KPj4gIGRyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgOCArKysrKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3Bp
LW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMKPj4gaW5kZXggNmUxM2JiZC4u
NjM5MzNjNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMKPj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMKPj4gQEAgLTI4MTEsNiArMjgxMSwx
NCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLAo+
PiAgCX0KPj4gIAlwYXJhbXMtPnNpemUgPj49IDM7IC8qIENvbnZlcnQgdG8gYnl0ZXMuICovCj4+
ICAKPj4gKwkvKgo+PiArCSAqIElmIHRoZSBkZXZpY2UgZXhjZWVkcyAxNk1pQiwgYWRkcl93aWR0
aCBtdXN0IGJlIDQuCj4+ICsJICogYWRkcl93aWR0aCA9PSAzIG1lYW5zIHRoZSBBZGRyZXNzIEJ5
dGVzIHdlIGFyZQo+PiArCSAqIHJlYWRpbmcgZnJvbSBCRlBUIGlzIHdyb25nLgo+PiArCSAqLwo+
Cj5KRVNEMjE2IHN0YW5kYXJkIGRvZXMgbm90IG1hbmRhdGUgZmxhc2ggZGV2aWNlcyA+MTZNaUIg
dG8gYWx3YXlzIHN1cHBvcnQKPjQgYnl0ZSBhZGRyZXNzaW5nIG9wY29kZS4gU28sIGl0cyBva2F5
IGZvciBmbGFzaCB2ZW5kb3IgdG8gc3VwcG9ydAo+PjE2TWlCIGZsYXNoIHdpdGggMyBieXRlIGFk
ZHJlc3NpbmcgYW5kIEJhbmsvZXh0ZW5kZWQgYWRkcmVzcyByZWdpc3Rlci4KPgo+PiArCWlmIChw
YXJhbXMtPnNpemUgPiAweDEwMDAwMDAgJiYgbm9yLT5hZGRyX3dpZHRoID09IDMpCj4+ICsJCXJl
dHVybiAtRUlOVkFMOwo+PiArCj4KPkFzc3VtaW5nIG9ubHkgRFdPUkQxWzE4OjE3XSBiaXRzIGFy
ZSB3cm9uZywgdGhlbiByZXR1cm5pbmcgZnJvbSBoZXJlCj53b3VsZCBtZWFuIHdlIG1pc3MgcGFy
c2luZyBTZWN0b3IgRXJhc2Ugc2V0dGluZ3MsIFF1YWQgRW5hYmxlCj5SZXF1aXJlbWVudHMgZXRj
IGZyb20gQkZQVCB3aGljaCBpcyBraW5kIG9mIGJhZC4KPkkgc3VnZ2VzdCB0byBtb3ZlIHRoZSBm
aXggdG9bMV0sIGFkZHJfd2lkdGggaW5kaWNhdGVkIGluIGZsYXNoX2luZm8KPnN0cnVjdCBvZiB0
aGUgZGV2aWNlIGNhbiB0YWtlIHByZWNlZGVuY2Ugb3ZlciBTRkRQLgo+Cj5bMV1odHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
c3BpLW5vci5jI0w0MTA2CgpCb3JpcyBoYXMgYWRkZWQgYSBmaXh1cCBmdW5jdGlvbiwgZG8geW91
IHRoaW5rIHRoaXMgaXMgbW9yZSBiZXR0ZXI6CgpzdGF0aWMgaW50CmlzMjVscDI1Nl9wb3N0X2Jm
cHRfZml4dXBzKHN0cnVjdCBzcGlfbm9yICpub3IsCgkJCSAgICBjb25zdCBzdHJ1Y3Qgc2ZkcF9w
YXJhbWV0ZXJfaGVhZGVyICpiZnB0X2hlYWRlciwKCQkJICAgIGNvbnN0IHN0cnVjdCBzZmRwX2Jm
cHQgKmJmcHQsCgkJCSAgICBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBhcmFtcykK
ewoJLyoKCSAqIElTMjVMUDI1NiBzdXBwb3J0cyA0QiBvcGNvZGVzLgoJICogVW5mb3J0dW5hdGVs
eSwgc29tZSBkZXZpY2VzIGdldCBCRlBUX0RXT1JEMV9BRERSRVNTX0JZVEVTXzNfT05MWSAgCgkg
KiBmcm9tIEJGUFQgdGFibGUgZm9yIGFkZHJlc3Mgd2lkdGguIFdlIHNob3VsZCBmaXggaXQuCgkg
Ki8KCWlmIChiZnB0LmR3b3Jkc1tCRlBUX0RXT1JEKDEpXSAmIEJGUFRfRFdPUkQxX0FERFJFU1Nf
QllURVNfTUFTSyA9PSAKCQlCRlBUX0RXT1JEMV9BRERSRVNTX0JZVEVTXzNfT05MWSkKCQlub3It
PmFkZHJfd2lkdGggPSA0OwoKCXJldHVybiAwOwp9CgpzdGF0aWMgc3RydWN0IHNwaV9ub3JfZml4
dXBzIGlzMjVscDI1Nl9maXh1cHMgPSB7CgkucG9zdF9iZnB0ID0gaXMyNWxwMjU2X3Bvc3RfYmZw
dF9maXh1cHMsCn07CgoKPgo+Cj4+ICAJLyogRmFzdCBSZWFkIHNldHRpbmdzLiAqLwo+PiAgCWZv
ciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHNmZHBfYmZwdF9yZWFkcyk7IGkrKykgewo+PiAgCQlj
b25zdCBzdHJ1Y3Qgc2ZkcF9iZnB0X3JlYWQgKnJkID0gJnNmZHBfYmZwdF9yZWFkc1tpXTsKPj4g
Cj4KPi0tIAo+UmVnYXJkcwo+VmlnbmVzaAo=
