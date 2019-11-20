Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A51C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9D820679
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="enYhKFVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfKTTqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:46:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37110 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKTTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:46:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id k14so565726eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=719bsazi0dbFes8dSA1CK4DMOVZBwF8jI2z3H6EBZoU=;
        b=enYhKFVD/qQ/yKh2BY2CWczU4JbompieZuFI33y2NFFVSbXnOSqVl+SEHTkdWN1saQ
         4mQznt4mf2OphiR/z4qQ35SZgO3lTWW3+l/kFU5g85HINRlUuVCgz5Ua0zPcEjsJO4Y3
         DeWdV4VW6qrJ7mOVXfa1pSD1gJ3jq5oPFMFyLWWHu61mXxVCNxDkhoRawPsc2sQmkbey
         MOsyxkmKzNWyjWa4q63IYKfZP3mPtO4C2AkyulH+Umi3o8k1B8TeEltDQDHrEm4jvdwk
         a1/W+NOAwVZMhooXGi9iJYOICLNsW5IeoD7+UdJhtLXJ7KtGEmas1lYExqYwV8W9rE7w
         d9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=719bsazi0dbFes8dSA1CK4DMOVZBwF8jI2z3H6EBZoU=;
        b=kDgdCNQ7F5gLfXLwpiZgZax3kLXLVfNVSwGG6d14ZrOM95nrZ+EnqRKLP6z2e+J3yi
         1MHw354uIsvFBjQ4biIdmdaaDkL4A83JvZEDOKk23I7whH+maCPnajZ6zuiHCk2y6Y9+
         R/Ow5g6WKcrfTtJrSrRUY+vZNdopCaD71nKfz17SDurec/UBSJbIqARWd2hlLHUc/uP8
         IoHN+DoBsttP/p0HvgR2JFQoqUSbsTb6tY6YNBQzfeoMFtEVa9wMq+VTPEyK0tNsCMDn
         CVXIXAA4DcnAduNET9s9bJ1VcB9feHldN8LUxJhYgl6k/YTcxgsd2fKtEuvUaSNuDdti
         /9Dw==
X-Gm-Message-State: APjAAAXPAUrtOKWMDvSzmF3oL6WtEf5JrThPIggM0jgVpD4/YszXj9/b
        zoALPQ1Gl5gXUB3I++2aC6bK8hw0UHzR0gTcEcTBXw==
X-Google-Smtp-Source: APXvYqyGGB5Ejm+dAfU7oHFOo9IaMoTis9GuQGsrePKYkgnhdxKU0iaPnczimnWR29TkDLsiEwVXYHoZHPzaOMk4388=
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr7383771ejf.15.1574279175132;
 Wed, 20 Nov 2019 11:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20191119221006.1021520-1-pasha.tatashin@soleen.com>
 <20191120164307.GA19681@lakrids.cambridge.arm.com> <CA+CK2bAkb7zg6ne=PzA7UrQF49J2Sa7rmyWM3Bqugfe00-36ng@mail.gmail.com>
In-Reply-To: <CA+CK2bAkb7zg6ne=PzA7UrQF49J2Sa7rmyWM3Bqugfe00-36ng@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Nov 2019 14:46:03 -0500
Message-ID: <CA+CK2bCX+QGMPzhjj-UmVNb1jG8Z6WNW=L0GiVsTpGrhyqb9tA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kernel: memory corruptions due non-disabled PAN
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com
Content-Type: multipart/mixed; boundary="0000000000000326770597cc6f1e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000326770597cc6f1e
Content-Type: text/plain; charset="UTF-8"

> > I see that with CONFIG_ARM64_SW_TTBR0_PAN=y, this means that we may
> > leave the stale TTBR0 value installed across a context-switch (and have
> > reproduced that locally), but I'm having some difficulty reproducing the
> > corruption that you see.
>
> I will send the full test shortly. Note, I was never able to reproduce
> it in QEMU, only on real hardware. Also, for some unknown reason after
> kexec I could not reproduce it only during first boot, so it is
> somewhat fragile, but I am sure it can be reproduced in other cases as
> well, it is just my reproducer is not tunes for that.
>

Attached is the test program that I used to reproduce memory corruption.
Test on board with Broadcom's Stingray SoC.

Without fix:
# time /tmp/repro
Corruption: pid 1474 map[0] 1488 cpu 3
Terminated

real    0m0.088s
user    0m0.004s
sys     0m0.071s

With the fix:

# time /tmp/repro
Test passed, all good
Terminated

real    1m1.286s
user    0m0.004s
sys     0m0.970s



Pasha

--0000000000000326770597cc6f1e
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k37p5xni0>
X-Attachment-Id: f_k37p5xni0

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8bGludXgvcGVyZl9ldmVudC5oPgojaW5jbHVk
ZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN5cy9zeXNpbmZvLmg+CiNpbmNsdWRlIDxzeXMvaW9j
dGwuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxzeXMvd2FpdC5oPgojaW5j
bHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgoj
aW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNp
bmNsdWRlIDx1bmlzdGQuaD4KCiNkZWZpbmUgUlVOX1RJTUUJNjAKI2RlZmluZSBTSVpFCQk0MDk2
CiNkZWZpbmUgTlBST0NTCQk0MDk2CiNkZWZpbmUgTkNQVQkJZ2V0X25wcm9jc19jb25mKCkKI2Rl
ZmluZSBQQUdFTUFQX0xFTkdUSCA4CnVuc2lnbmVkIGxvbmcgZ2V0X3BhKHZvaWQgKmFkZHIpIHsK
ICAgRklMRSAqcGFnZW1hcCA9IGZvcGVuKCIvcHJvYy9zZWxmL3BhZ2VtYXAiLCAicmIiKTsKICAg
dW5zaWduZWQgbG9uZyBvZmZzZXQgPSAodW5zaWduZWQgbG9uZylhZGRyIC8gZ2V0cGFnZXNpemUo
KSAqIFBBR0VNQVBfTEVOR1RIOwogICB1bnNpZ25lZCBsb25nIHBmbiA9IDA7CgogICBpZihmc2Vl
ayhwYWdlbWFwLCAodW5zaWduZWQgbG9uZylvZmZzZXQsIFNFRUtfU0VUKSAhPSAwKSB7CiAgICAg
IGZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIHNlZWsgcGFnZW1hcCB0byBwcm9wZXIgbG9jYXRp
b25cbiIpOwogICAgICBleGl0KDEpOwogICB9CgogICBmcmVhZCgmcGZuLCAxLCBQQUdFTUFQX0xF
TkdUSC0xLCBwYWdlbWFwKTsKCiAgIHBmbiAmPSAweDdGRkZGRkZGRkZGRkZGOwoKICAgZmNsb3Nl
KHBhZ2VtYXApOwoKICAgcmV0dXJuIHBmbiAqIGdldHBhZ2VzaXplKCk7Cn0KCmludApkb193b3Jr
KCkKewoJaW50ICptYXAsIHBpZDsKCXVuc2lnbmVkIGxvbmcgcGE7CgoJaWYgKGZvcmsoKSkKCQll
eGl0KDApOwoKCXBpZCA9IGdldHBpZCgpOwoJbWFwID0gbW1hcChOVUxMLCBTSVpFLCBQUk9UX1JF
QUR8UFJPVF9XUklURSwgTUFQX1NIQVJFRCB8IE1BUF9BTk9OWU1PVVMsCgkJICAgLTEsIDApOwoJ
bWFwWzBdID0gcGlkOwoJc2NoZWRfeWllbGQoKTsKCWlmIChtYXBbMF0gIT0gcGlkKSB7CgkJZnBy
aW50ZihzdGRlcnIsICJDb3JydXB0aW9uOiBwaWQgJWQgbWFwWzBdICVkIGNwdSAlZFxuIiwKCQkJ
cGlkLCBtYXBbMF0sIHNjaGVkX2dldGNwdSgpKTsKCQlraWxsKDAsIFNJR1RFUk0pOwoJCXJldHVy
biAxOwoJfQoJbXVubWFwKG1hcCwgU0laRSk7CglyZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQgZXZl
bnRfb3BlbihzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICpjdHhfZXZlbnRfYXR0ciwgaW50IGNvbmZp
ZykKewoJaW50IGksIGZkOwoJY3R4X2V2ZW50X2F0dHItPmNvbmZpZyA9IGNvbmZpZzsKCWZvciAo
aSA9IDA7IGkgPCBOQ1BVOyBpKyspIHsKCQlmZCA9IHN5c2NhbGwoX19OUl9wZXJmX2V2ZW50X29w
ZW4sIGN0eF9ldmVudF9hdHRyLAoJCQktMSwgaSwgLTEsIDApOwoJCWlvY3RsKGZkLCBQRVJGX0VW
RU5UX0lPQ19FTkFCTEUsIDApOwoJfQp9CgpzdGF0aWMgdm9pZApwZXJmX2V2ZW50cygpCnsKCXN0
cnVjdCBwZXJmX2V2ZW50X2F0dHIgY3R4X2V2ZW50X2F0dHI7CgoJbWVtc2V0KCZjdHhfZXZlbnRf
YXR0ciwgMCwgc2l6ZW9mKHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIpKTsKCWN0eF9ldmVudF9hdHRy
LnR5cGUgPSBQRVJGX1RZUEVfU09GVFdBUkU7CgljdHhfZXZlbnRfYXR0ci5zaXplID0gc2l6ZW9m
IChzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyKTsKCWN0eF9ldmVudF9hdHRyLnNhbXBsZV9wZXJpb2Qg
PSAxOwoJY3R4X2V2ZW50X2F0dHIuc2FtcGxlX3R5cGUgPSBQRVJGX1NBTVBMRV9DQUxMQ0hBSU47
CgoJZXZlbnRfb3BlbigmY3R4X2V2ZW50X2F0dHIsIFBFUkZfQ09VTlRfU1dfQ1BVX0NMT0NLKTsK
fQoKaW50Cm1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7CglwaWRfdCBwW05QUk9DU107Cglp
bnQgaSwgZmQ7CgljcHVfc2V0X3QgIG1hc2s7CgoJQ1BVX1pFUk8oJm1hc2spOwoJZm9yIChpID0g
MDsgaSA8IE5DUFU7IGkrKykKCQlDUFVfU0VUKGksICZtYXNrKTsKCXNjaGVkX3NldGFmZmluaXR5
KDAsIHNpemVvZihtYXNrKSwgJm1hc2spOwoKCXBlcmZfZXZlbnRzKCk7Cglmb3IgKGkgPSAwOyBp
IDwgTlBST0NTOyBpKyspIHsKCQlwW2ldID0gZm9yaygpOwoJCWlmIChwW2ldID09IDApIHsKCQkJ
Zm9yICg7OykgewoJCQkJaWYgKGRvX3dvcmsoKSkgewoJCQkJCWZwcmludGYoc3RkZXJyLCAiQnVn
IGlzIGRldGVjdGVkXG4iKTsKCQkJCQlraWxsKDAsIFNJR1RFUk0pOwoJCQkJCWV4aXQoMSk7CgkJ
CQl9CgkJCX0KCQl9Cgl9CgoJc2xlZXAoUlVOX1RJTUUpOwoJcHJpbnRmKCJUZXN0IHBhc3NlZCwg
YWxsIGdvb2RcbiIpOwoJa2lsbCgwLCBTSUdURVJNKTsKCXJldHVybiAwOwp9Cg==
--0000000000000326770597cc6f1e--
