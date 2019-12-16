Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8948C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5E624676
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576468246;
	bh=IiKO8ufJBC/PNXcr3wmtBM6Zg1VoYVvdFufsCOEtfpo=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=Wo6IBYLltIjiz45y2CaDDeRuHXvG62seXW4xpS/4I6NpHzMynSo7AQG1UtwzcgT4R
	 MEUAbbSrVD67VN1ITaF/wMQ2XJAV4p0+XQOHdbm24MyyRqAXtFBxuA0X/fxL5ljZyI
	 9owo78NU0YT0kXEZ+2kjIBxwCR9j7uauYNKN/CU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLPDup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:50:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46028 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfLPDup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:50:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so3139849lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DzovpH6K9q1+vGtZyEs3sJTZHwvK+GxotMXiiPk/JGI=;
        b=e5uHTIpFPL7zDnu9s6gGg7qofmVdzQwC85tXTNkszwg5TEZRJmJK1PKupjqoApNsMj
         Ml6wkDlhH2aP5HeyNBm6+ce1OAXf7+NK5DRDRWENV+yjxXii36pM4ktR9MRvD+vR0p8Y
         tXNviLPGehbYskjzEnscUDpWXEVmAK33JuxQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DzovpH6K9q1+vGtZyEs3sJTZHwvK+GxotMXiiPk/JGI=;
        b=bVy6TM6t/xR1gdaCiM6Ar7XPcpJPmElg8FQyY1TcLo36L1MZGZpWkY0mxTHRMyGwnW
         56Dj0CKNIMKRh8TeUVeWAEY7IplO7QJHw5Corg2S4PqDfuDDdhppR/1LNqKUvcRisLxV
         yZM4gAp91hOMHhLX1KYewRkvpEwHWqVDzzPjqSjzw2EU2Fs+PMg1TTRnOoICWD3B3Ylh
         pb4TyHDBDAKtLM2N6q5lnwry4eUjkXNIu174IzbG0E7CWZ1CTOxKtQiYFMY/uqZsfqis
         kQMcOHiUKUhxEHDBX8bh/IBN98KOCcLBYDemIBmRk4i1lsu1ieev2NJjTIYi/hT2epLr
         FvEQ==
X-Gm-Message-State: APjAAAU3xFF0lViEkzavZO6CBqWB3IJKEaAkQcjYAGMoGNup29r8gH3J
        dZxfGZfhj2KZMx5RqrbqQpCTTm50CZU=
X-Google-Smtp-Source: APXvYqz3BzOhXDH6gzIDhkN34M4OwvjdORXnLPcnr4GURTTgZhC9jGXNOSqrbAcUQVcIwUPC1G4Fdg==
X-Received: by 2002:a19:f00d:: with SMTP id p13mr15870092lfc.37.1576468242886;
        Sun, 15 Dec 2019 19:50:42 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h24sm9413318ljc.84.2019.12.15.19.50.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 19:50:41 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id m30so3154127lfp.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:50:40 -0800 (PST)
X-Received: by 2002:a19:4351:: with SMTP id m17mr15805672lfj.61.1576468240552;
 Sun, 15 Dec 2019 19:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20191212135724.331342-1-linux@dominikbrodowski.net>
 <20191212135724.331342-4-linux@dominikbrodowski.net> <20191216013536.5wyvq4vjv5efd35n@core.my.home>
In-Reply-To: <20191216013536.5wyvq4vjv5efd35n@core.my.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Dec 2019 19:50:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com>
Message-ID: <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007a8a160599ca1d80"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007a8a160599ca1d80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2019 at 5:35 PM Ond=C5=99ej Jirman <megi@xff.cz> wrote:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
00000000000

Duh. So much for the trivial obvious conversion.

It didn't take "data might be NULL" into account.

A patch like this, perhaps? Untested..

               Linus

--0000000000007a8a160599ca1d80
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k47wh53r0>
X-Attachment-Id: f_k47wh53r0

IGluaXQvZG9fbW91bnRzLmMgfCAyMyArKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lu
aXQvZG9fbW91bnRzLmMgYi9pbml0L2RvX21vdW50cy5jCmluZGV4IGY1NWNiZDljYjgxOC4uZDIw
NGY2MDVkYmNlIDEwMDY0NAotLS0gYS9pbml0L2RvX21vdW50cy5jCisrKyBiL2luaXQvZG9fbW91
bnRzLmMKQEAgLTM5MSwxNyArMzkxLDE5IEBAIHN0YXRpYyBpbnQgX19pbml0IGRvX21vdW50X3Jv
b3QoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqZnMsCiAJCQkJIGNvbnN0IGludCBmbGFn
cywgY29uc3Qgdm9pZCAqZGF0YSkKIHsKIAlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnM7Ci0JY2hhciAq
ZGF0YV9wYWdlOwotCXN0cnVjdCBwYWdlICpwOworCXN0cnVjdCBwYWdlICpwID0gTlVMTDsKKwlj
aGFyICpkYXRhX3BhZ2UgPSBOVUxMOwogCWludCByZXQ7CiAKLQkvKiBkb19tb3VudCgpIHJlcXVp
cmVzIGEgZnVsbCBwYWdlIGFzIGZpZnRoIGFyZ3VtZW50ICovCi0JcCA9IGFsbG9jX3BhZ2UoR0ZQ
X0tFUk5FTCk7Ci0JaWYgKCFwKQotCQlyZXR1cm4gLUVOT01FTTsKLQotCWRhdGFfcGFnZSA9IHBh
Z2VfYWRkcmVzcyhwKTsKLQlzdHJuY3B5KGRhdGFfcGFnZSwgZGF0YSwgUEFHRV9TSVpFIC0gMSk7
CisJaWYgKGRhdGEpIHsKKwkJLyogZG9fbW91bnQoKSByZXF1aXJlcyBhIGZ1bGwgcGFnZSBhcyBm
aWZ0aCBhcmd1bWVudCAqLworCQlwID0gYWxsb2NfcGFnZShHRlBfS0VSTkVMKTsKKwkJaWYgKCFw
KQorCQkJcmV0dXJuIC1FTk9NRU07CisJCWRhdGFfcGFnZSA9IHBhZ2VfYWRkcmVzcyhwKTsKKwkJ
c3RybmNweShkYXRhX3BhZ2UsIGRhdGEsIFBBR0VfU0laRSAtIDEpOworCQlkYXRhX3BhZ2VbUEFH
RV9TSVpFIC0gMV0gPSAnXDAnOworCX0KIAogCXJldCA9IGRvX21vdW50KG5hbWUsICIvcm9vdCIs
IGZzLCBmbGFncywgZGF0YV9wYWdlKTsKIAlpZiAocmV0KQpAQCAtNDE3LDcgKzQxOSw4IEBAIHN0
YXRpYyBpbnQgX19pbml0IGRvX21vdW50X3Jvb3QoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hh
ciAqZnMsCiAJICAgICAgIE1BSk9SKFJPT1RfREVWKSwgTUlOT1IoUk9PVF9ERVYpKTsKIAogb3V0
OgotCXB1dF9wYWdlKHApOworCWlmIChwKQorCQlwdXRfcGFnZShwKTsKIAlyZXR1cm4gcmV0Owog
fQogCg==
--0000000000007a8a160599ca1d80--
