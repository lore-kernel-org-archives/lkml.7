Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A9C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CB021897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567400787;
	bh=0gi89cCy9xxlFs7fXircWjX570dMhI6wNzFnwC31lBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KqvwJyMpTzuLOPv081Ku8t27TwE9fUBfj4bSo/Js/LiNKgDapGrBXYyn0ATO0CY0S
	 26F/XUZhZwq7KSQsRedomHWl6LyNVDhhFEdL4RRYAVr+62S0P14eY3EQ7xZcwBEPPp
	 NaojUXAcJI+xZCdCEFfNnuz1jNWS5ucbgyx1qE8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfIBE63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 00:58:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40617 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfIBE63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:58:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so2060273ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 21:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCcwVdx3CIrQ2iBXoqgR/Xj++7ikjChlwHWjCD8Ry5Q=;
        b=FGPvKanz4G3D1M0PUKtnrGALseLuiKp67NFFVO4lbN8C74KTOOkFim/hSQB3OiW40G
         Qmd3PiTbZdpClx9ghot4nEHjjdDZM00rPNvq/EeXydG9dS3boY6GUnGND54PbW1z1zAN
         m6u0xLOd375D/M8Ef0DRhnoGnd8NSzcr8Ahbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCcwVdx3CIrQ2iBXoqgR/Xj++7ikjChlwHWjCD8Ry5Q=;
        b=Ns7xU0jD2Mfzed+o3GvJ+yjI+FmzmFuCgNPO0LTRMKQgHv5JOPzMfRpEuZR45jrsw0
         bJWfp7oAJeSJzXn29m8asT0Yo76JdaUm09FRGPUCe8e2o6W3DPuS3+qcrLc8FuTE9wCM
         NoBASb/+gUrQBHX/3Zv5vyzqt4A+04vW/ZZAncH8xwjV9QOXofyjSYzjIjXK09D6pwy1
         CDgZ+8u5cWZ482IZXsWY+PVB7NXcfoegb8IYXJgpVJ1bvEPttFAZodwAPUpknjsRtX+f
         4qWEqrkBhYgODLykxoCpD4mUjOXQrBet3HdDGzH55pLwRberuLbNkcdIgVvpJMFQ33R4
         b40A==
X-Gm-Message-State: APjAAAW43o/DkRuRraOn47RGL2EdKGa4Tc7BUDUsdDfkyT40V/Gx79zc
        j5Raloa6m7/wGvUSh1s97VbFw6tIPAw=
X-Google-Smtp-Source: APXvYqxOZ5zLqGJ9bin0jYqi41Ir2iYtRZwGIOAKovyLsQV8BqYve6I1x7AzZA7OSTa4QqvwiniQVQ==
X-Received: by 2002:a2e:7013:: with SMTP id l19mr15190133ljc.141.1567400305131;
        Sun, 01 Sep 2019 21:58:25 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 20sm53044ljc.40.2019.09.01.21.58.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2019 21:58:24 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m24so11581727ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 21:58:23 -0700 (PDT)
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr2066396lja.84.1567400303649;
 Sun, 01 Sep 2019 21:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
 <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
 <CAHk-=whH+Wzj+h0WzgdLMu+xtFddokoVy8dWWvEJqJRGA_HLmw@mail.gmail.com>
 <6184ffdd-30bf-668a-cdee-88cc8eb2ead7@infradead.org> <98c83922-6ab1-98ca-7682-7796ae1facf4@infradead.org>
In-Reply-To: <98c83922-6ab1-98ca-7682-7796ae1facf4@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Sep 2019 21:58:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7BwJ7jFXxj5ZOU5VOw4Eg74TpTzip4P+LEJTYbZVhng@mail.gmail.com>
Message-ID: <CAHk-=wg7BwJ7jFXxj5ZOU5VOw4Eg74TpTzip4P+LEJTYbZVhng@mail.gmail.com>
Subject: Re: [PATCH v3] arch/microblaze: add support for get_user() of size 8 bytes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: multipart/mixed; boundary="000000000000520bfd05918ad220"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000520bfd05918ad220
Content-Type: text/plain; charset="UTF-8"

On Sun, Sep 1, 2019 at 7:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I guess we need a way to coerce that to call get_user_1(),
> such as a typecast.  This _seems_ to work (i.e., call get_user_1()):

No, I oversimplified.

Try this slightly modified patch instead.

                 Linus

--000000000000520bfd05918ad220
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k01xns400>
X-Attachment-Id: f_k01xns400

IGFyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS91YWNjZXNzLmggfCA0MiArKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MzMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9taWNyb2JsYXplL2luY2x1ZGUvYXNt
L3VhY2Nlc3MuaCBiL2FyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS91YWNjZXNzLmgKaW5kZXgg
YmZmMmE3MWM4MjhhLi5hMWYyMDZiOTA3NTMgMTAwNjQ0Ci0tLSBhL2FyY2gvbWljcm9ibGF6ZS9p
bmNsdWRlL2FzbS91YWNjZXNzLmgKKysrIGIvYXJjaC9taWNyb2JsYXplL2luY2x1ZGUvYXNtL3Vh
Y2Nlc3MuaApAQCAtMTYzLDQ0ICsxNjMsMTUgQEAgZXh0ZXJuIGxvbmcgX191c2VyX2JhZCh2b2lk
KTsKICAqIFJldHVybnMgemVybyBvbiBzdWNjZXNzLCBvciAtRUZBVUxUIG9uIGVycm9yLgogICog
T24gZXJyb3IsIHRoZSB2YXJpYWJsZSBAeCBpcyBzZXQgdG8gemVyby4KICAqLwotI2RlZmluZSBn
ZXRfdXNlcih4LCBwdHIpCQkJCQkJXAotCV9fZ2V0X3VzZXJfY2hlY2soKHgpLCAocHRyKSwgc2l6
ZW9mKCoocHRyKSkpCi0KLSNkZWZpbmUgX19nZXRfdXNlcl9jaGVjayh4LCBwdHIsIHNpemUpCQkJ
CQlcCi0oewkJCQkJCQkJCVwKLQl1bnNpZ25lZCBsb25nIF9fZ3VfdmFsID0gMDsJCQkJCVwKLQlj
b25zdCB0eXBlb2YoKihwdHIpKSBfX3VzZXIgKl9fZ3VfYWRkciA9IChwdHIpOwkJCVwKLQlpbnQg
X19ndV9lcnIgPSAwOwkJCQkJCVwKLQkJCQkJCQkJCVwKLQlpZiAoYWNjZXNzX29rKF9fZ3VfYWRk
ciwgc2l6ZSkpIHsJCQlcCi0JCXN3aXRjaCAoc2l6ZSkgewkJCQkJCVwKLQkJY2FzZSAxOgkJCQkJ
CQlcCi0JCQlfX2dldF91c2VyX2FzbSgibGJ1IiwgX19ndV9hZGRyLCBfX2d1X3ZhbCwJXAotCQkJ
CSAgICAgICBfX2d1X2Vycik7CQkJXAotCQkJYnJlYWs7CQkJCQkJXAotCQljYXNlIDI6CQkJCQkJ
CVwKLQkJCV9fZ2V0X3VzZXJfYXNtKCJsaHUiLCBfX2d1X2FkZHIsIF9fZ3VfdmFsLAlcCi0JCQkJ
ICAgICAgIF9fZ3VfZXJyKTsJCQlcCi0JCQlicmVhazsJCQkJCQlcCi0JCWNhc2UgNDoJCQkJCQkJ
XAotCQkJX19nZXRfdXNlcl9hc20oImx3IiwgX19ndV9hZGRyLCBfX2d1X3ZhbCwJXAotCQkJCSAg
ICAgICBfX2d1X2Vycik7CQkJXAotCQkJYnJlYWs7CQkJCQkJXAotCQlkZWZhdWx0OgkJCQkJCVwK
LQkJCV9fZ3VfZXJyID0gX191c2VyX2JhZCgpOwkJCVwKLQkJCWJyZWFrOwkJCQkJCVwKLQkJfQkJ
CQkJCQlcCi0JfSBlbHNlIHsJCQkJCQkJXAotCQlfX2d1X2VyciA9IC1FRkFVTFQ7CQkJCQlcCi0J
fQkJCQkJCQkJXAotCXggPSAoX19mb3JjZSB0eXBlb2YoKihwdHIpKSlfX2d1X3ZhbDsJCQkJXAot
CV9fZ3VfZXJyOwkJCQkJCQlcCisjZGVmaW5lIGdldF91c2VyKHgsIHB0cikgKHsJCQkJXAorCWNv
bnN0IHR5cGVvZigqKHB0cikpIF9fdXNlciAqX19ndV9wdHIgPSAocHRyKTsJXAorCWFjY2Vzc19v
ayhfX2d1X3B0ciwgc2l6ZW9mKCpfX2d1X3B0cikpID8JXAorCQlfX2dldF91c2VyKHgsIF9fZ3Vf
cHRyKSA6IC1FRkFVTFQ7CVwKIH0pCiAKICNkZWZpbmUgX19nZXRfdXNlcih4LCBwdHIpCQkJCQkJ
XAogKHsJCQkJCQkJCQlcCiAJdW5zaWduZWQgbG9uZyBfX2d1X3ZhbCA9IDA7CQkJCQlcCi0JLyp1
bnNpZ25lZCBsb25nIF9fZ3VfcHRyID0gKHVuc2lnbmVkIGxvbmcpKHB0cik7Ki8JCVwKIAlsb25n
IF9fZ3VfZXJyOwkJCQkJCQlcCiAJc3dpdGNoIChzaXplb2YoKihwdHIpKSkgewkJCQkJXAogCWNh
c2UgMToJCQkJCQkJCVwKQEAgLTIxMiw2ICsxODMsMTEgQEAgZXh0ZXJuIGxvbmcgX191c2VyX2Jh
ZCh2b2lkKTsKIAljYXNlIDQ6CQkJCQkJCQlcCiAJCV9fZ2V0X3VzZXJfYXNtKCJsdyIsIChwdHIp
LCBfX2d1X3ZhbCwgX19ndV9lcnIpOwlcCiAJCWJyZWFrOwkJCQkJCQlcCisJY2FzZSA4OgkJCQkJ
CQkJXAorCQlfX2d1X2VyciA9IF9fY29weV9mcm9tX3VzZXIoJl9fZ3VfdmFsLCBwdHIsIDgpOwkJ
XAorCQlpZiAoX19ndV9lcnIpCQkJCQkJXAorCQkJX19ndV9lcnIgPSAtRUZBVUxUOwkJCQlcCisJ
CWJyZWFrOwkJCQkJCQlcCiAJZGVmYXVsdDoJCQkJCQkJXAogCQkvKiBfX2d1X3ZhbCA9IDA7IF9f
Z3VfZXJyID0gLUVJTlZBTDsqLyBfX2d1X2VyciA9IF9fdXNlcl9iYWQoKTtcCiAJfQkJCQkJCQkJ
XAo=
--000000000000520bfd05918ad220--
