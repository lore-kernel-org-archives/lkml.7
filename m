Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD810C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 23:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7496020659
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 23:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569714857;
	bh=AKlzoKfPzPLuGXHNe0X+ERZzopfv1k5X5Dp6EZvzenM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hx7UH9U6vYOAR9RzSeE9lqCoLqLBO4PbI0Ajcce2L31DY5L+mYQFOXY2PBgZz3AGA
	 4QQO4LwDjJ7Ixp7nZrNNi7tnip+R0GzHITDrdBuJZQfwDl+bEUAT8tJhwOYgCWfKdm
	 25cFYdpzN7ewMjR4ZCQyrb6mT1JT5nwmcL+59tvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfI1XyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 19:54:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36357 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI1XyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 19:54:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so4453087lff.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5Blx5Rw1kuKNqzpF3MvhTcd69iMGs38JsVjPY/aSnk=;
        b=DvVngU86ZmgWZBk8pRFX6ej/bTnVwQ5tnvMd0pisIIbixU8BX5RUPHZ2MSGCmlXr5U
         R7qoXgjp/F0mkYFsSJ8v2YQFVxxFm63bHGzW5JA5UzfkL824yKMnz9xH28GAHYZlMdF9
         e0D7kpeu/h07Q8dxuXqxMiECYLFEHpRyd6ZqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5Blx5Rw1kuKNqzpF3MvhTcd69iMGs38JsVjPY/aSnk=;
        b=Gc41Q/Z2aDrPATcj4J2Q6vdARg0J0/XedZeonX2idvpLWR/EB0iKcnAPT/cpK6mnX4
         cTgx+MWOnT+OGkUbsys0jY+szV2jvyHg5iAwCXyU8bc2sFi5+AQiUHE/EHJU/OphHHST
         jpMoe8aJ+kOIKv0QieGBXQ54YoCCqPWjIgQM0kZdCFfWHIAvgrtGs5VgyalTT4kk/tP0
         HTHHxQQAKY1mLWsABMjDCY2v0BbjPeDe2KyJbmiQC65wm8+cNbA1YfQDYPIMTmB7Ifrr
         cfRReaJ4XHeoT+c+BTm8QCuEyx34TK3xmGPdJ0uHT2+wrFG8Z4aO1f3lV3vk+Y6Rs5eC
         wKyQ==
X-Gm-Message-State: APjAAAVGaLJzk2rdErvT+R0vYryFvB6c063ZFjo0wrhmtrRKZ0O5atDp
        zrWdWOvtf8LftfVH4P8nO5ERigT/2nQ=
X-Google-Smtp-Source: APXvYqxb4sBz/8BiwuUGd9NqdC472NFBGa+j+w2+5yLCYyB6NWcW+5cC0oivIDJT7DxeDaQPaf1ZXA==
X-Received: by 2002:a19:dc10:: with SMTP id t16mr7028880lfg.85.1569714851894;
        Sat, 28 Sep 2019 16:54:11 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q19sm1616719ljj.73.2019.09.28.16.54.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2019 16:54:09 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id w6so4445900lfl.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 16:54:09 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr7206393lfp.134.1569714848803;
 Sat, 28 Sep 2019 16:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Sep 2019 16:53:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
Message-ID: <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: multipart/mixed; boundary="000000000000f65c4e0593a5b7bc"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f65c4e0593a5b7bc
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 28, 2019 at 3:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nicholas presented the idea to (ab)use speculative execution for random
> number generation years ago at the Real-Time Linux Workshop:

What you describe is just a particularly simple version of the jitter
entropy. Not very reliable.

But hey, here's a made-up patch. It basically does jitter entropy, but
it uses a more complex load than the fibonacci LFSR folding: it calls
"schedule()" in a loop, and it sets up a timer to fire.

And then it mixes in the TSC in that loop.

And to be fairly conservative, it then credits one bit of entropy for
every timer tick. Not because the timer itself would be all that
unpredictable, but because the interaction between the timer and the
loop is going to be pretty damn unpredictable.

Ok, I'm handwaving. But I do claim it really is fairly conservative to
think that a cycle counter would give one bit of entropy when you time
over a timer actually happening. The way that loop is written, we do
guarantee that we'll mix in the TSC value both before and after the
timer actually happened. We never look at the difference of TSC
values, because the mixing makes that uninteresting, but the code does
start out with verifying that "yes, the TSC really is changing rapidly
enough to be meaningful".

So if we want to do jitter entropy, I'd much rather do something like
this that actually has a known fairly complex load with timers and
scheduling.

And even if absolutely no actual other process is running, the timer
itself is still going to cause perturbations. And the "schedule()"
call is more complicated than the LFSR is anyway.

It does wait for one second the old way before it starts doing this.

Whatever. I'm entirely convinced this won't make everybody happy
anyway, but it's _one_ approach to handle the issue.

Ahmed - would you be willing to test this on your problem case (with
the ext4 optimization re-enabled, of course)?

And Thomas - mind double-checking that I didn't do anything
questionable with the timer code..

And this goes without saying - this patch is ENTIRELY untested.  Apart
from making people upset for the lack of rigor, it might do
unspeakable crimes against your pets. You have been warned.

               Linus

--000000000000f65c4e0593a5b7bc
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k147oizl0>
X-Attachment-Id: f_k147oizl0

IGRyaXZlcnMvY2hhci9yYW5kb20uYyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9yYW5kb20uYyBiL2RyaXZl
cnMvY2hhci9yYW5kb20uYwppbmRleCBkM2JlZWQwODRjMGEuLmRlNDM0ZmViODczYSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9jaGFyL3JhbmRvbS5jCisrKyBiL2RyaXZlcnMvY2hhci9yYW5kb20uYwpA
QCAtMTczMiw2ICsxNzMyLDU2IEBAIHZvaWQgZ2V0X3JhbmRvbV9ieXRlcyh2b2lkICpidWYsIGlu
dCBuYnl0ZXMpCiB9CiBFWFBPUlRfU1lNQk9MKGdldF9yYW5kb21fYnl0ZXMpOwogCisKKy8qCisg
KiBFYWNoIHRpbWUgdGhlIHRpbWVyIGZpcmVzLCB3ZSBleHBlY3QgdGhhdCB3ZSBnb3QgYW4gdW5w
cmVkaWN0YWJsZQorICoganVtcCBpbiB0aGUgY3ljbGUgY291bnRlci4gRXZlbiBpZiB0aGUgdGlt
ZXIgaXMgcnVubmluZyBvbiBhbm90aGVyCisgKiBDUFUsIHRoZSB0aW1lciBhY3Rpdml0eSB3aWxs
IGJlIHRvdWNoaW5nIHRoZSBzdGFjayBvZiB0aGUgQ1BVIHRoYXQgaXMKKyAqIGdlbmVyYXRpbmcg
ZW50cm9weS4uCisgKgorICogTm90ZSB0aGF0IHdlIGRvbid0IHJlLWFybSB0aGUgdGltZXIgaW4g
dGhlIHRpbWVyIGl0c2VsZiAtIHdlIGFyZQorICogaGFwcHkgdG8gYmUgc2NoZWR1bGVkIGF3YXks
IHNpbmNlIHRoYXQganVzdCBtYWtlcyB0aGUgbG9hZCBtb3JlCisgKiBjb21wbGV4LCBidXQgd2Ug
ZG8gbm90IHdhbnQgdGhlIHRpbWVyIHRvIGtlZXAgdGlja2luZyB1bmxlc3MgdGhlCisgKiBlbnRy
b3B5IGxvb3AgaXMgcnVubmluZy4KKyAqCisgKiBTbyB0aGUgcmUtYXJtaW5nIGFsd2F5cyBoYXBw
ZW5zIGluIHRoZSBlbnRyb3B5IGxvb3AgaXRzZWxmLgorICovCitzdGF0aWMgdm9pZCBlbnRyb3B5
X3RpbWVyKHN0cnVjdCB0aW1lcl9saXN0ICp0KQoreworCWNyZWRpdF9lbnRyb3B5X2JpdHMoJmlu
cHV0X3Bvb2wsIDEpOworfQorCisvKgorICogSWYgd2UgaGF2ZSBhbiBhY3R1YWwgY3ljbGUgY291
bnRlciwgc2VlIGlmIHdlIGNhbgorICogZ2VuZXJhdGUgZW5vdWdoIGVudHJvcHkgd2l0aCB0aW1p
bmcgbm9pc2UKKyAqLworc3RhdGljIHZvaWQgdHJ5X3RvX2dlbmVyYXRlX2VudHJvcHkodm9pZCkK
K3sKKwlzdHJ1Y3QgeworCQl1bnNpZ25lZCBsb25nIG5vdzsKKwkJc3RydWN0IHRpbWVyX2xpc3Qg
dGltZXI7CisJfSBzdGFjazsKKworCXN0YWNrLm5vdyA9IHJhbmRvbV9nZXRfZW50cm9weSgpOwor
CisJLyogU2xvdyBjb3VudGVyIC0gb3Igbm9uZS4gRG9uJ3QgZXZlbiBib3RoZXIgKi8KKwlpZiAo
c3RhY2subm93ID09IHJhbmRvbV9nZXRfZW50cm9weSgpKQorCQlyZXR1cm47CisKKwl0aW1lcl9z
ZXR1cF9vbl9zdGFjaygmc3RhY2sudGltZXIsIGVudHJvcHlfdGltZXIsIDApOworCXdoaWxlICgh
Y3JuZ19yZWFkeSgpKSB7CisJCWlmICghdGltZXJfcGVuZGluZygmc3RhY2sudGltZXIpKQorCQkJ
bW9kX3RpbWVyKCZzdGFjay50aW1lciwgamlmZmllcysxKTsKKwkJbWl4X3Bvb2xfYnl0ZXMoJmlu
cHV0X3Bvb2wsICZzdGFjay5ub3csIHNpemVvZihzdGFjay5ub3cpKTsKKwkJc2NoZWR1bGUoKTsK
KwkJc3RhY2subm93ID0gcmFuZG9tX2dldF9lbnRyb3B5KCk7CisJfQorCisJZGVsX3RpbWVyX3N5
bmMoJnN0YWNrLnRpbWVyKTsKKwlkZXN0cm95X3RpbWVyX29uX3N0YWNrKCZzdGFjay50aW1lcik7
CisJbWl4X3Bvb2xfYnl0ZXMoJmlucHV0X3Bvb2wsICZzdGFjay5ub3csIHNpemVvZihzdGFjay5u
b3cpKTsKK30KKwogLyoKICAqIFdhaXQgZm9yIHRoZSB1cmFuZG9tIHBvb2wgdG8gYmUgc2VlZGVk
IGFuZCB0aHVzIGd1YXJhbnRlZWQgdG8gc3VwcGx5CiAgKiBjcnlwdG9ncmFwaGljYWxseSBzZWN1
cmUgcmFuZG9tIG51bWJlcnMuIFRoaXMgYXBwbGllcyB0bzogdGhlIC9kZXYvdXJhbmRvbQpAQCAt
MTc0Niw3ICsxNzk2LDE3IEBAIGludCB3YWl0X2Zvcl9yYW5kb21fYnl0ZXModm9pZCkKIHsKIAlp
ZiAobGlrZWx5KGNybmdfcmVhZHkoKSkpCiAJCXJldHVybiAwOwotCXJldHVybiB3YWl0X2V2ZW50
X2ludGVycnVwdGlibGUoY3JuZ19pbml0X3dhaXQsIGNybmdfcmVhZHkoKSk7CisKKwlkbyB7CisJ
CWludCByZXQ7CisJCXJldCA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1lb3V0KGNybmdf
aW5pdF93YWl0LCBjcm5nX3JlYWR5KCksIEhaKTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQg
PiAwID8gMCA6IHJldDsKKworCQl0cnlfdG9fZ2VuZXJhdGVfZW50cm9weSgpOworCX0gd2hpbGUg
KCFjcm5nX3JlYWR5KCkpOworCisJcmV0dXJuIDA7CiB9CiBFWFBPUlRfU1lNQk9MKHdhaXRfZm9y
X3JhbmRvbV9ieXRlcyk7CiAK
--000000000000f65c4e0593a5b7bc--
