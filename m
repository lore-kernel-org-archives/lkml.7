Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC17C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 04:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A6820B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 04:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554612998;
	bh=tAQQkWe/CqPvVoPSyAZmFu3+ckaqFog69rqXI88Se/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Um50Eyx++eblHpazHRnBJQ4SJLplK9llWsbkZbA/gluHL94R+A4ExpNW9r8Tmb9Rl
	 giG2Qzjq/tIXP6CDzWlZyFQHXKGG9EkUF6SXDCwKtBuIsuO5lkIO2GUDkxz/d7WayT
	 dPTBnBJyKvyIDHwPJ81Z+cQzTQ3WobEEsJEFQE6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfDGE4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 00:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfDGE4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 00:56:36 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E6F214AE
        for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2019 04:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554612996;
        bh=tAQQkWe/CqPvVoPSyAZmFu3+ckaqFog69rqXI88Se/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vThHVxOVXmxZ7xhfg2Ql5YdFAWM1VmLyP1Qlb1Ak3cUWvshBb89AlGUqaYJyorh5T
         NuvyCZNsYaCrkZsFYyhK6XrSBFxtWfoFZEyN/rW5Hkqe864115JbfsF6bLruF8yjjh
         pU3gCAI03rchelQMYECIc9uo7ietrhTYmEpZ4TEY=
Received: by mail-wr1-f48.google.com with SMTP id r4so12413858wrq.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 21:56:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUaoIIVsZzpf8F8rxxl3bfdmN8LQQPeidyNjIIEwciEeK7Y6t1b
        9FpMQzlV67fLmLYAT2yab6CZzCq2s7QBsn/jjuTyNw==
X-Google-Smtp-Source: APXvYqyaRS2z+3QuzmkVmFXBVA0Umsm+FJf288drPxwxyJQY4ulBV9bql+Ho2IgREwEyg5TlAkxW7FXJ8ulSjgh2ihY=
X-Received: by 2002:adf:efc1:: with SMTP id i1mr13780670wrp.199.1554612994300;
 Sat, 06 Apr 2019 21:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190405150658.237064784@linutronix.de> <20190405150930.967389183@linutronix.de>
In-Reply-To: <20190405150930.967389183@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 6 Apr 2019 21:56:21 -0700
X-Gmail-Original-Message-ID: <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com>
Message-ID: <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com>
Subject: Re: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard pages
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: multipart/mixed; boundary="0000000000004a142e0585e98b79"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004a142e0585e98b79
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 5, 2019 at 8:11 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Andy Lutomirski <luto@kernel.org>
>
> The IRQ stack lives in percpu space, so an IRQ handler that overflows it
> will overwrite other data structures.
>
> Use vmap() to remap the IRQ stack so that it will have the usual guard
> pages that vmap/vmalloc allocations have. With this the kernel will panic
> immediately on an IRQ stack overflow.

The 0day bot noticed that this dies with DEBUG_PAGEALLOC on.  This is
because the store_stackinfo() function is utter garbage and this patch
correctly detects just how broken it is.  The attached patch "fixes"
it.  (It also contains a reliability improvement that should probably
get folded in, but is otherwise unrelated.)

A real fix would remove the generic kstack_end() function entirely
along with __HAVE_ARCH_KSTACK_END and would optionally replace
store_stackinfo() with something useful.  Josh, do we have a generic
API to do a little stack walk like this?  Otherwise, I don't think it
would be the end of the world to just remove the offending code.

--Andy

--0000000000004a142e0585e98b79
Content-Type: text/x-patch; charset="US-ASCII"; name="fix.diff"
Content-Disposition: attachment; filename="fix.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ju6gfgc30>
X-Attachment-Id: f_ju6gfgc30

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMgYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L2NvbW1vbi5jCmluZGV4IDgwMWM2ZjA0MGZhYS4uZWI4OTM5ZDI4Zjk2IDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9j
cHUvY29tbW9uLmMKQEAgLTE1MTAsNiArMTUxMCwxMiBAQCBERUZJTkVfUEVSX0NQVShzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKiwgY3VycmVudF90YXNrKSBfX19fY2FjaGVsaW5lX2FsaWduZWQgPQogCSZp
bml0X3Rhc2s7CiBFWFBPUlRfUEVSX0NQVV9TWU1CT0woY3VycmVudF90YXNrKTsKIAorLyoKKyAq
IFRoZSBpbml0aWFsIGhhcmRpcnFfc3RhY2tfcHRyIHZhbHVlIG9mIE5VTEwgaXMgaW52YWxpZC4g
IFRvIHByZXZlbnQgaXQKKyAqIGZyb20gYmVpbmcgdXNlZCBpZiBhbiBJUlEgaGFwcGVucyB0b28g
ZWFybHksIHdlIGluaXRpYWxpemUgaXJxX2NvdW50IHRvIDEsCisgKiB3aGljaCBlZmZlY3RpdmVs
eSBkaXNhYmxlcyBFTlRFUl9JUlFfU1RBQ0suICBUaGUgY29kZSB0aGF0IG1hcHMgdGhlIElSUQor
ICogc3RhY2sgd2lsbCByZXNldCBpcnFfY291bnQgdG8gLTEuCisgKi8KIERFRklORV9QRVJfQ1BV
KHN0cnVjdCBpcnFfc3RhY2sgKiwgaGFyZGlycV9zdGFja19wdHIpOwogREVGSU5FX1BFUl9DUFUo
dW5zaWduZWQgaW50LCBpcnFfY291bnQpIF9fdmlzaWJsZSA9IC0xOwogCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvaXJxXzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvaXJxXzY0LmMKaW5kZXgg
NDhjYWEzZDMxNjYyLi42MWM2OTE4ODkzNjIgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9p
cnFfNjQuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvaXJxXzY0LmMKQEAgLTU2LDYgKzU2LDcgQEAg
c3RhdGljIGludCBtYXBfaXJxX3N0YWNrKHVuc2lnbmVkIGludCBjcHUpCiAJCXJldHVybiAtRU5P
TUVNOwogCiAJcGVyX2NwdShoYXJkaXJxX3N0YWNrX3B0ciwgY3B1KSA9IHZhICsgSVJRX1NUQUNL
X1NJWkU7CisJcHJfZXJyKCIqKiogQ1BVICV1OiBoYXJkaXJxX3N0YWNrX3B0ciA9IDB4JWx4XG4i
LCBjcHUsICh1bnNpZ25lZCBsb25nKSh2YSArIElSUV9TVEFDS19TSVpFKSk7CiAJcmV0dXJuIDA7
CiB9CiAjZWxzZQpAQCAtNzQsNyArNzUsMTQgQEAgc3RhdGljIGludCBtYXBfaXJxX3N0YWNrKHVu
c2lnbmVkIGludCBjcHUpCiAKIGludCBpcnFfaW5pdF9wZXJjcHVfaXJxc3RhY2sodW5zaWduZWQg
aW50IGNwdSkKIHsKKwlpbnQgcmV0OworCiAJaWYgKHBlcl9jcHUoaGFyZGlycV9zdGFja19wdHIs
IGNwdSkpCiAJCXJldHVybiAwOwotCXJldHVybiBtYXBfaXJxX3N0YWNrKGNwdSk7CisJcmV0ID0g
bWFwX2lycV9zdGFjayhjcHUpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlwZXJfY3B1
KGlycV9jb3VudCwgY3B1KSA9IC0xOworCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvbW0vc2xh
Yi5jIGIvbW0vc2xhYi5jCmluZGV4IDMyOWJmZTY3ZjJjYS4uMTk4ZTk5NDhhODc0IDEwMDY0NAot
LS0gYS9tbS9zbGFiLmMKKysrIGIvbW0vc2xhYi5jCkBAIC0xNDgxLDYgKzE0ODEsNyBAQCBzdGF0
aWMgdm9pZCBzdG9yZV9zdGFja2luZm8oc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlcCwgdW5zaWdu
ZWQgbG9uZyAqYWRkciwKIAkqYWRkcisrID0gY2FsbGVyOwogCSphZGRyKysgPSBzbXBfcHJvY2Vz
c29yX2lkKCk7CiAJc2l6ZSAtPSAzICogc2l6ZW9mKHVuc2lnbmVkIGxvbmcpOworCS8qCiAJewog
CQl1bnNpZ25lZCBsb25nICpzcHRyID0gJmNhbGxlcjsKIAkJdW5zaWduZWQgbG9uZyBzdmFsdWU7
CkBAIC0xNDk2LDYgKzE0OTcsNyBAQCBzdGF0aWMgdm9pZCBzdG9yZV9zdGFja2luZm8oc3RydWN0
IGttZW1fY2FjaGUgKmNhY2hlcCwgdW5zaWduZWQgbG9uZyAqYWRkciwKIAkJfQogCiAJfQorCSov
CiAJKmFkZHIrKyA9IDB4ODc2NTQzMjE7CiB9CiAK
--0000000000004a142e0585e98b79--
