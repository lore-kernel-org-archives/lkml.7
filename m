Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE09C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A521F21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103261;
	bh=Lnc3VDfaqhrbPuQsQE6dCBWqXJeDCTUOHX2uZl1gaCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yTYdMX/Tv07a/hWQ+emuTf8pM4XYQMpmgGr63uqw14n182vjglAdX6mgy0rqRPUVM
	 TWYOG19JEg6dEZn8/alNZtsHqI++qOuqQuuORMWdq/fAahPc2URbmuAqb9NzzINEGU
	 RXDhf3i9fnuVnBuMspqFYzJc6XcKPHVy74LRb+Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCTReU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:34:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44405 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCTReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:34:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id n18so2957806ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMa008u+CPP37jm9dCtVXhuN78KTgukXJ3KiTkmWRuA=;
        b=UgymFiln4Y2+fHJ2yDEWo+2EEIrb2iWjnF/kqvv3+Qm4NiuI7xeS17gMK/Hv0mVYEk
         JvdhdZ+BftCnkACp4rn6msMo6/diFXPWJ5SQDyEPzkgz/DGh1C/H3dp7IlhChwrUB60j
         jsQSolOnwl1LJZVNE/Z9oQqGTs+1eDUwjFRyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMa008u+CPP37jm9dCtVXhuN78KTgukXJ3KiTkmWRuA=;
        b=fRjUWFtwGiU7GmTP19AbDMapczF1CCfJpVib5OBUK5a2lVxZdVYQbILAGAiS/2w4lt
         mrZ2a3M7f55/yxmTeN/Trv9Xbsuo80k/hIi6rqVUcEdhjKYxAJ8FzUviOuugfVYmWSYM
         Wq5oTMLOX7iWzs/kKlsTF82R/XBFoTfJwgsZqtKqNjZcEVuSK7TgssT0DFgCy+krk2XR
         8si0XUqhTMwTPwSpT4+ZF5UmmxPlTIhpZk2JlCKXTD1DpdwJUKteqYuYvC+Ow7H+EcwM
         yUm8hBr9vtoI6Dht4fxU0ChbL+/NC0qN0rxkLc1Poy/bmO78r/8DpvlhLd7/T6FWCRM6
         mLdA==
X-Gm-Message-State: APjAAAVg9rLBpqyjO6JhG75gdhpRxRCGFHzKU1YCXEdPTeOQ5EG4co6M
        +eUC116LnalBYjRgYzVXU5rL0v9NIUg=
X-Google-Smtp-Source: APXvYqxsSWUjXKRNJEdOsIlMvZklrAHBtrhn25NzUBAFpIak8tUnkGL3yUsZE0m8GzxuyQwbz1lFlw==
X-Received: by 2002:a2e:2419:: with SMTP id k25mr17576085ljk.38.1553103256512;
        Wed, 20 Mar 2019 10:34:16 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n11sm480482lfk.59.2019.03.20.10.34.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:34:16 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 5so2500895lft.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:34:16 -0700 (PDT)
X-Received: by 2002:a19:2548:: with SMTP id l69mr14467867lfl.136.1553102794124;
 Wed, 20 Mar 2019 10:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190318153840.906404905@infradead.org> <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
In-Reply-To: <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Mar 2019 10:26:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
Message-ID: <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
To:     David Laight <David.Laight@aculab.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Content-Type: multipart/mixed; boundary="000000000000581cc5058489ec93"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000581cc5058489ec93
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 20, 2019 at 4:17 AM David Laight <David.Laight@aculab.com> wrote:
>
> >               ______r = !!(cond);                                     \
>
>         Is that (or maybe just the !!) needed any more??

It is, because the 'cond' expression might not be an int, it could be
a test for a pointer being non-NULL, or an u64 being non-zero, and not
having the "!!" would mean that you'd get a warning or drop bits when
assigning to 'int'.

And you do need the new temporary variable to avoid double evaluation
the way that code is written.

That said, I do think the code is really ugly. We could:

 - avoid the temporary by just simplifying things.

 - do the '!!' just once in the parent macro.

 - Steven has this crazy model of "more underscores are better". They
aren't. They don't help if things nest anyway, but what does help is
meaningful names. Both when things don't nest, and when looking at
generated asm files.

 - ,, and finally, what _is_ better is to chop things up so that they
are smaller and make each macro do only one thing

So maybe do the patch something like the attached instead? Completely
untested, but it looks sane to me.

                  Linus

--000000000000581cc5058489ec93
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jthh9j220>
X-Attachment-Id: f_jthh9j220

IGluY2x1ZGUvbGludXgvY29tcGlsZXIuaCB8IDM1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jb21waWxlci5oIGIvaW5jbHVkZS9saW51
eC9jb21waWxlci5oCmluZGV4IDQ0NTM0OGZhY2VhOS4uOGFhZjdjZDAyNmIwIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5o
CkBAIC01MywyMyArNTMsMjQgQEAgdm9pZCBmdHJhY2VfbGlrZWx5X3VwZGF0ZShzdHJ1Y3QgZnRy
YWNlX2xpa2VseV9kYXRhICpmLCBpbnQgdmFsLAogICogIkRlZmluZSAnaXMnIiwgQmlsbCBDbGlu
dG9uCiAgKiAiRGVmaW5lICdpZiciLCBTdGV2ZW4gUm9zdGVkdAogICovCi0jZGVmaW5lIGlmKGNv
bmQsIC4uLikgX190cmFjZV9pZiggKGNvbmQgLCAjIyBfX1ZBX0FSR1NfXykgKQotI2RlZmluZSBf
X3RyYWNlX2lmKGNvbmQpIFwKLQlpZiAoX19idWlsdGluX2NvbnN0YW50X3AoISEoY29uZCkpID8g
ISEoY29uZCkgOgkJCVwKLQkoewkJCQkJCQkJXAotCQlpbnQgX19fX19fcjsJCQkJCQlcCi0JCXN0
YXRpYyBzdHJ1Y3QgZnRyYWNlX2JyYW5jaF9kYXRhCQkJXAotCQkJX19hbGlnbmVkKDQpCQkJCQlc
Ci0JCQlfX3NlY3Rpb24oIl9mdHJhY2VfYnJhbmNoIikJCQlcCi0JCQlfX19fX19mID0gewkJCQkJ
XAotCQkJCS5mdW5jID0gX19mdW5jX18sCQkJXAotCQkJCS5maWxlID0gX19GSUxFX18sCQkJXAot
CQkJCS5saW5lID0gX19MSU5FX18sCQkJXAotCQkJfTsJCQkJCQlcCi0JCV9fX19fX3IgPSAhIShj
b25kKTsJCQkJCVwKLQkJX19fX19fZi5taXNzX2hpdFtfX19fX19yXSsrOwkJCQkJXAotCQlfX19f
X19yOwkJCQkJCVwKLQl9KSkKKyNkZWZpbmUgaWYoY29uZCwgLi4uKSBpZiAoIF9fdHJhY2VfaWZf
dmFyKCAhIShjb25kICwgIyMgX19WQV9BUkdTX18pICkgKQorCisjZGVmaW5lIF9fdHJhY2VfaWZf
dmFyKGNvbmQpIChfX2J1aWx0aW5fY29uc3RhbnRfcChjb25kKSA/IChjb25kKSA6IF9fdHJhY2Vf
aWZfdmFsdWUoY29uZCkpCisKKyNkZWZpbmUgX190cmFjZV9pZl92YWx1ZShjb25kKSAoewkJCVwK
KwlzdGF0aWMgc3RydWN0IGZ0cmFjZV9icmFuY2hfZGF0YQkJXAorCQlfX2FsaWduZWQoNCkJCQkJ
XAorCQlfX3NlY3Rpb24oIl9mdHJhY2VfYnJhbmNoIikJCVwKKwkJX19pZl90cmFjZSA9IHsJCQkJ
XAorCQkJLmZ1bmMgPSBfX2Z1bmNfXywJCVwKKwkJCS5maWxlID0gX19GSUxFX18sCQlcCisJCQku
bGluZSA9IF9fTElORV9fLAkJXAorCQl9OwkJCQkJXAorCShjb25kKSA/CQkJCQlcCisJCShfX2lm
X3RyYWNlLm1pc3NfaGl0WzFdKyssMSkgOgkJXAorCQkoX19pZl90cmFjZS5taXNzX2hpdFswXSsr
LDApOwkJXAorfSkKKwogI2VuZGlmIC8qIENPTkZJR19QUk9GSUxFX0FMTF9CUkFOQ0hFUyAqLwog
CiAjZWxzZQo=
--000000000000581cc5058489ec93--
