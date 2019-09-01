Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A312AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E17E22CE9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567359105;
	bh=WWdgaKJyZyKaroVl9SQxM1k9hOUIxLGJB8XqFrz2wpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z+D2axf5fXUm7NrXl/iiMXvRI+n1Gj0yOnzCBc7s9Xx4my5Oi6R2BZ2SLFealhMTA
	 hLdz5QsptlN1Zu5eGGB3tLYJ5MWdgGJVSpOBJpmgYHwppALT+5vkKjfneyIycUsLRc
	 vkkyCEi4KrBVC67GLdhGv+149Y7W+Qf4lIgRiBME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfIARbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 13:31:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46111 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfIARbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 13:31:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id n19so8743856lfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke57GzZYCLOgbAUdAf+tCKrlKxXab4Lu0TGrUur238Y=;
        b=FobRiCukALzeWeknK/SRZad8+x9Zz7bQxvJKvet2bAEGH7WO3o2xWUEXCfr8tZfPLe
         0j7hGBpecZGlttwiEE3OHRbTDzD8pOmiJRnfzRvwDW8p9kxWx1oQra5v1S9160yc1v9P
         DOwbtyK8I1dvp6QEp4QXFH7c5Yz/0gdGlsYFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke57GzZYCLOgbAUdAf+tCKrlKxXab4Lu0TGrUur238Y=;
        b=YPQz/IygNO+KRgH1MYJPPGy/lNJEZaof1qUgqHz0X4PzUMbu5hiyqietcGnqeO4ldv
         wxO2gIULbGwAVVSdqS6PbA8dbulakLFBdbFQFeyAbIJaGaVihPxIJ91UokZByCwwpDQn
         GuLC5A72m4a0EQhBVJlkWLNie8G/J5MUDXZ3QF3CqKzJtDPorZcaTTnbKUqtoBdmeKnU
         nz++kyLtxoUV79/6LnN9yA/Oj8JfpCduLtHa617sz2Er7Ie4XjPfAf0ta1vZPkHdp/MU
         slsuj58ODZo4PWOLANT8AOlMmpOdmJaBRMdHkhOzw626qguouRU6lAIV+Ow43HoqkPNY
         Ky3A==
X-Gm-Message-State: APjAAAUO3KUWZ+DbGx7RULxrjkRb+su4iL/GB547w2PKmMsdMi1WTmu7
        HItQFBDjK2zpG6gqs0PCU3hshYlZA20=
X-Google-Smtp-Source: APXvYqzhGyt+kHAGbVF3qChl1kFlX1Mu58xgn6ELY099En+lQ94qbP5C2OYcpPLNIIqsuKWvbEXcww==
X-Received: by 2002:ac2:5394:: with SMTP id g20mr15787298lfh.112.1567359100825;
        Sun, 01 Sep 2019 10:31:40 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id u8sm2077925lfq.61.2019.09.01.10.31.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2019 10:31:39 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c12so8790049lfh.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 10:31:39 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr1238291lfh.29.1567359098952;
 Sun, 01 Sep 2019 10:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org> <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
In-Reply-To: <CAHk-=wg4mE8pSEdWViqJBC9Teh8h1c9LrqqP6=_g8ud5hvkfmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Sep 2019 10:31:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH+Wzj+h0WzgdLMu+xtFddokoVy8dWWvEJqJRGA_HLmw@mail.gmail.com>
Message-ID: <CAHk-=whH+Wzj+h0WzgdLMu+xtFddokoVy8dWWvEJqJRGA_HLmw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="00000000000054c4cf0591813a94"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000054c4cf0591813a94
Content-Type: text/plain; charset="UTF-8"

On Sun, Sep 1, 2019 at 10:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guess I'll apply it. I'm not sure why you _care_ about microblaze, but ...

Ugh. As I was going to apply it, my code cleanliness conscience struck.

I can't deal with that unnecessary duplication of code. Does something
like the attached patch work instead?

Totally untested, but looks much cleaner.

               Linus

--00000000000054c4cf0591813a94
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k019380r0>
X-Attachment-Id: f_k019380r0

IGFyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS91YWNjZXNzLmggfCA0MiArKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MzMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9taWNyb2JsYXplL2luY2x1ZGUvYXNt
L3VhY2Nlc3MuaCBiL2FyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS91YWNjZXNzLmgKaW5kZXgg
YmZmMmE3MWM4MjhhLi44OGJkZTA2YTQxYTMgMTAwNjQ0Ci0tLSBhL2FyY2gvbWljcm9ibGF6ZS9p
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
CV9fZ3VfZXJyOwkJCQkJCQlcCisjZGVmaW5lIGdldF91c2VyKHgsIHB0cikgKHsJCQkJXAorCXR5
cGVvZihwdHIpIF9fZ3VfcHRyID0gKHB0cik7CQkJXAorCWFjY2Vzc19vayhfX2d1X3B0ciwgc2l6
ZW9mKCpfX2d1X3B0cikpID8JXAorCQlfX2dldF91c2VyKHgsIF9fZ3VfcHRyKSA6IC1FRkFVTFQ7
CVwKIH0pCiAKICNkZWZpbmUgX19nZXRfdXNlcih4LCBwdHIpCQkJCQkJXAogKHsJCQkJCQkJCQlc
CiAJdW5zaWduZWQgbG9uZyBfX2d1X3ZhbCA9IDA7CQkJCQlcCi0JLyp1bnNpZ25lZCBsb25nIF9f
Z3VfcHRyID0gKHVuc2lnbmVkIGxvbmcpKHB0cik7Ki8JCVwKIAlsb25nIF9fZ3VfZXJyOwkJCQkJ
CQlcCiAJc3dpdGNoIChzaXplb2YoKihwdHIpKSkgewkJCQkJXAogCWNhc2UgMToJCQkJCQkJCVwK
QEAgLTIxMiw2ICsxODMsMTEgQEAgZXh0ZXJuIGxvbmcgX191c2VyX2JhZCh2b2lkKTsKIAljYXNl
IDQ6CQkJCQkJCQlcCiAJCV9fZ2V0X3VzZXJfYXNtKCJsdyIsIChwdHIpLCBfX2d1X3ZhbCwgX19n
dV9lcnIpOwlcCiAJCWJyZWFrOwkJCQkJCQlcCisJY2FzZSA4OgkJCQkJCQkJXAorCQlfX2d1X2Vy
ciA9IF9fY29weV9mcm9tX3VzZXIoJl9fZ3VfdmFsLCBwdHIsIDgpOwkJXAorCQlpZiAoX19ndV9l
cnIpCQkJCQkJXAorCQkJX19ndV9lcnIgPSAtRUZBVUxUOwkJCQlcCisJCWJyZWFrOwkJCQkJCQlc
CiAJZGVmYXVsdDoJCQkJCQkJXAogCQkvKiBfX2d1X3ZhbCA9IDA7IF9fZ3VfZXJyID0gLUVJTlZB
TDsqLyBfX2d1X2VyciA9IF9fdXNlcl9iYWQoKTtcCiAJfQkJCQkJCQkJXAo=
--00000000000054c4cf0591813a94--
