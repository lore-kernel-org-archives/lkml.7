Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0E9CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C919620856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="noabvc+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfJaC3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 22:29:45 -0400
Received: from m15-46.126.com ([220.181.15.46]:27282 "EHLO m15-46.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfJaC3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 22:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=uuul/
        vsBqxOrfvaaSzuKfYJEsXn3GpsJGojS0uHuWRI=; b=noabvc+hsq6I2GRPjX/Ib
        zhifETt+0kSJRYX3KJHIYLJyC4ljhZI9Q0CxvJs2nzuzvlMbyYLFByP1ZkPK/pdT
        ke4bHFWm7+/qdpjTDotsqbkYJ+M8HpfQG/3WynkX+vZMOqfO+E91Vb66D9dFN6tY
        y4Nr2mmco0FzwxGZFzdEt4=
Received: from liuxiang_1999$126.com ( [125.70.163.129] ) by
 ajax-webmail-wmsvr46 (Coremail) ; Thu, 31 Oct 2019 10:29:38 +0800 (CST)
X-Originating-IP: [125.70.163.129]
Date:   Thu, 31 Oct 2019 10:29:38 +0800 (CST)
From:   "Liu Xiang" <liuxiang_1999@126.com>
To:     "Rasmus Villemoes" <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] lib: string: reduce unnecessary loop in strncpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <c6452618-0161-eefc-0730-b10eac823228@rasmusvillemoes.dk>
References: <1572444859-3687-1-git-send-email-liuxiang_1999@126.com>
 <c6452618-0161-eefc-0730-b10eac823228@rasmusvillemoes.dk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <fd65c09.2464.16e1fa59f3b.Coremail.liuxiang_1999@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LsqowAAnPQkTR7pdPe2cAA--.19823W
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/1tbiZxNfsF16cA0xEgAAsi
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCkF0IDIwMTktMTAtMzAgMjI6NTk6NTgsICJSYXNtdXMgVmlsbGVtb2VzIiA8bGlu
dXhAcmFzbXVzdmlsbGVtb2VzLmRrPiB3cm90ZToKPk9uIDMwLzEwLzIwMTkgMTUuMTQsIExpdSBY
aWFuZyB3cm90ZToKPj4gTm93IGluIHN0cm5jcHksIGV2ZW4gc3JjWzBdIGlzIDAsIGxvb3Agd2ls
bCBleGVjdXRlIGNvdW50IHRpbWVzIHVudGlsCj4+IGNvdW50IGlzIDAuIEl0IGlzIGJldHRlciB0
byBleGl0IHRoZSBsb29wIGltbWVkaWF0ZWx5IHdoZW4gKnNyYyBpcyAwLgo+Cj5QbGVhc2UgcmVh
ZCAibWFuIHN0cm5jcHkiLgo+Cj5UaGVyZSdzIGEgcmVhc29uIHRoZSBsb29wIGlzIHdyaXR0ZW4g
aW4gdGhhdCBzb21ld2hhdCBjb252b2x1dGVkIHdheToKPlRoZSBiZWhhdmlvciBvZiBzdHJuY3B5
IGlzIG1hbmRhdGVkIGJ5IHRoZSBDIHN0YW5kYXJkLCBhbmQgaWYgdGhlIHNyYwo+c3RyaW5nIGlz
IHNob3J0ZXIgdGhhbiB0aGUgZGVzdGluYXRpb24gYnVmZmVyLCB0aGUgcmVzdCBtdXN0IGJlCj4w
LWZpbGxlZC4gU28gaWYgd2UgaGl0IGEgbnVsIGJ5dGUgYmVmb3JlIHJ1bm5pbmcgb3V0IG9mIGNv
dW50LCB3ZSBrZWVwCj5jb3B5aW5nIHRoYXQgbnVsIGJ5dGUgdG8gdGhlIHJlc3Qgb2YgdGhlIGRl
c3RpbmF0aW9uLgo+Cj5SYXNtdXMKCkhpIFJhc211cywKClRoYW5rcyBmb3IgeW91ciBleHBsYW5h
dGlvbi4gSSBpZ25vcmVkIHRoZSBDIGxpYnJhcnkgc3RhbmRhcmQuCgpSZWdhcmRzCgpMaXUgWGlh
bmc=
