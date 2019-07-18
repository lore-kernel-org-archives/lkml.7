Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E618C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92C72173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="iF6Lblqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbfGRJGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:06:39 -0400
Received: from m13-102.163.com ([220.181.13.102]:54801 "EHLO m13-102.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389532AbfGRJGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:06:38 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 05:06:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=vWG8X
        d+vw7pspWZS2Zgi9bzG7wBs4m0DBcDRl9qtqto=; b=iF6LblqsEePe2mkJkgRBr
        Eb0mezDCy9i3RflFOb4rFRNgZDSPRVHCGjLUUzMR+0la2izyQCe7DpUi+Nma6Vkx
        l/el99Y01I8XLwkPk79gDiCvrH61TxM6Z/Tzug5OZzpK8fI2gY/heekA7aH6AzrT
        aFIOvSBLd5zK+ZWcVX0lKI=
Received: from luferry$163.com ( [42.120.75.156] ) by ajax-webmail-wmsvr102
 (Coremail) ; Thu, 18 Jul 2019 16:50:52 +0800 (CST)
X-Originating-IP: [42.120.75.156]
Date:   Thu, 18 Jul 2019 16:50:52 +0800 (CST)
From:   luferry <luferry@163.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rik van Riel" <riel@surriel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] smp: avoid generic_exec_single cause system
 lockup
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 163com
In-Reply-To: <alpine.DEB.2.21.1907181007340.1778@nanos.tec.linutronix.de>
References: <20190718080308.48381-1-luferry@163.com>
 <alpine.DEB.2.21.1907181007340.1778@nanos.tec.linutronix.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5f5fbd7.1073c.16c0446ea63.Coremail.luferry@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZsGowAC3zfHtMjBdUqAmAQ--.48588W
X-CM-SenderInfo: poxiv2lu16il2tof0z/xtbBZhX1WlaD2nFzxAABsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCkF0IDIwMTktMDctMTggMTY6MDc6NTgsICJUaG9tYXMgR2xlaXhuZXIiIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOgo+T24gVGh1LCAxOCBKdWwgMjAxOSwgbHVmZXJyeUAxNjMu
Y29tIHdyb3RlOgo+Cj4+IEZyb206IGx1ZmVycnkgPGx1ZmVycnlAMTYzLmNvbT4KPj4gCj4+IFRo
ZSByYWNlIGNhbiByZXByb2R1Y2VkIGJ5IHNlbmRpbmcgd2FpdCBlbmFibGVkIElQSSBpbiBzb2Z0
aXJxL2lycSBlbnYKPgo+V2hpY2ggY29kZSBwYXRoIGlzIGRvaW5nIHRoYXQ/Cj4KPlRoYW5rcywK
Pgo+CXRnbHgKClRoYW5rcyBmb3IgeW91ciBraW5kbHkgcmVwbHkuCkkgY2hlY2tlZCBrZXJuZWwg
YW5kIGZvdW5kIG5vIGNvZGUgcGF0aCBjYW4gcnVuIGludG8gdGhpcy4KQWN0dWFsbHkgLCBpIGVu
Y291bnRlciB3aXRoIHRoaXMgcHJvYmxlbSBieSBteSBvd24gY29kZS4KSSBuZWVkIHRvIGRvIHNv
bWUgc3BlY2lmaWMgdXJnZW50IHdvcmsgcGVyaW9kaWNpdHkgYW5kIHRoZXNlIAp3b3JrIG1heSBy
dW4gZm9yIHF1aXRlIGEgd2hpbGUuIFNvIGkgY2FuJ3QgZGlzYWJsZSBpcnEgZHVyaW5nIHRoZXNl
IHdvcmsgCndoaWNoIHN0b3BzIG1lIGZyb20gdXNpbmcgaHJ0aW1lciB0byBkbyB0aGlzLiBTbyBp
IGRpZCBhZGQgYW4gZXh0cmEgCnNvZml0cnEgYWN0aW9uIHdoaWNoIG1heSBpbnZva2Ugc21wX2Nh
bGwu
