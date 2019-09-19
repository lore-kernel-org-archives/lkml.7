Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8387BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A47217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568923463;
	bh=/Kx31+1733h/hPY+Ep/2r1fuHQ4UeKgt3QSQ1UIQzU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c8nB+9Rm+uv/9qYD6uyA0Jn87RhxfWbJov3LhS88EcfYXUw/Mc51mEPOG0wP21MZ8
	 MnmlfyGlr5435Zd6QGzqz+bmkirOGKLeWuvIeeQWizJmQgYWhqbTLSJqNHb3DeE1eJ
	 2fWfPH5Nvjykj0Bd9e9Lb5RDtLpEmbT/UrXqKrJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392426AbfISUEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:04:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36173 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390331AbfISUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:04:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so4882706ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4m5fsmM1D52MDhgJ8zhgndmWP49nchai632Fc7rhfU8=;
        b=PHHUgZsUDck1+0WgtGWev2ZlhzqlhCDdiuEQXHeHNB3isAv9qmIWo1voeYWP4xuA/T
         +xfLIMLS+z/qhyz5qZFANtXTjNrrdAV2+486tGTU1scf77F8RtXrqE4Kwsnq/Q6BF9nP
         mNagbYeNqWlvqvey2a6BlVYqNvoZoDpKMSclI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4m5fsmM1D52MDhgJ8zhgndmWP49nchai632Fc7rhfU8=;
        b=kh7EyWj1sCZzZ18aZy9+569/2Jvaff0ch/yQcu1JsTYjOHhiJI67p/Pv6268mw621L
         bChGyeV2AAZvOqfBZzZjZ6DGtKwegbSHcF1sUh7V+tbRblMN0JO+vh/viyj3Vi/voz2G
         VpldAWgJWfBlgZMuC1/0MS9Qc75qslGYQw7ALCMrWYZmtaXj/YVBFrHRfyrfJmZwIcZj
         VU3yd9I/Izh8CX+KrZhEieLccGHpEUuupLoPewXwrCiSXFdpMVczgSDTT8JmW2Z8QeNB
         zalcMtWuoaNX9yYyVgTUSEmao9YFgcxZ2LNJv0X7l9qrPLDIKUdqRMBozScu/9p3QEz9
         8iCw==
X-Gm-Message-State: APjAAAVwg6Erz9zbmgxXTDdikMBuSVrgWD4fwNgaqpVt349sPiPuiuiA
        Gf10ml8CwzO71fk87Xj4U2L1e3Qs9qI=
X-Google-Smtp-Source: APXvYqxAz0/H9AlZDnIZqs7NpXE/L+we+Yxh8eqdFD/bESXGPrAObx8puMmTfTN7XNMCnmhGUQEf+Q==
X-Received: by 2002:a2e:b045:: with SMTP id d5mr6534191ljl.105.1568923459054;
        Thu, 19 Sep 2019 13:04:19 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 77sm1857543ljj.84.2019.09.19.13.04.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 13:04:17 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u3so3274567lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:04:17 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr6044271lfp.61.1568923456905;
 Thu, 19 Sep 2019 13:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190919143427.GQ6762@mit.edu> <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 13:04:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTbpcyVevsy3g-syB5v9gk_rR-yRFrUAvTL8NFuGfCrw@mail.gmail.com>
Message-ID: <CAHk-=wjTbpcyVevsy3g-syB5v9gk_rR-yRFrUAvTL8NFuGfCrw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000545cbf0592ed7546"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000545cbf0592ed7546
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 19, 2019 at 8:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yes, it hashes it using a good hash, but it does so in a way that
> makes it largely possible to follow the hashing and repeat it and
> analyze it.
>
> That breaks if we have hw randomness, because it does the
>
>         if (arch_get_random_long(&v))
>                 crng->state[14] ^= v;
>
> so it always mixes in hardware randomness as part of the extraction,
> but we don't mix anything else unpredictable - or even
> process-specific - state in.

So this is the other actual _serious_ patch I'd suggest: replace the

          if (arch_get_random_long(&v))
                  crng->state[14] ^= v;

with

          if (!arch_get_random_long(&v))
                  v = random_get_entropy();
          crng->state[14] += v;

instead. Yeah, it still doesn't help on machines that don't even have
a cycle counter, but it at least means that you don't have to have a
CPU rdrand (or equivalent) but you do have a cycle counter, now the
extraction of randomness from the pool doesn't just do the
(predictable) mutation for the backtracking, but actually means that
you have some very hard to predict timing effects.

Again, in this case a cycle counter really does add a small amount of
entropy (everybody agrees that modern CPU's are simply too complex to
be predictable at a cycle level), but that's not really the point. The
point is that now doing the extraction really fundamentally changes
the state in unpredictable ways, so that you don't have that "if I
recognize a value, I know what the next value will be" kind of attack.

Which, as mentioned, is actually not a purely theoretical concern.

Note small detail above: I changed the ^= to a +=. Addition tends to
be better (due to carry between bits) when there might be bit
commonalities.  Particularly with something like a cycle count where
two xors can mostly cancel out previous bits rather than move bits
around in the word.

With an actual random input from rdrand, the xor-vs-add is immaterial
and doesn't matter, of course, so the old code made sense in that
context.

In the attached patch I also moved the arch_get_random_long() and
random_get_entropy() to outside the crng spinlock. We're not talking
blocking operations, but it can easily be hundreds of cycles with
rdrand retries, or the random_get_entropy() reading an external clock
on some architectures.

                 Linus

--000000000000545cbf0592ed7546
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k0r4ezrw0>
X-Attachment-Id: f_k0r4ezrw0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9yYW5kb20uYyBiL2RyaXZlcnMvY2hhci9yYW5kb20u
YwotLS0gYS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMKKysrIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5j
CkBAIC0xMDU3LDkgKzEwNTcsMTAgQEAgc3RhdGljIHZvaWQgX2V4dHJhY3RfY3JuZyhzdHJ1Y3Qg
Y3JuZ19zdGF0ZSAqY3JuZywKIAkgICAgKHRpbWVfYWZ0ZXIoY3JuZ19nbG9iYWxfaW5pdF90aW1l
LCBjcm5nLT5pbml0X3RpbWUpIHx8CiAJICAgICB0aW1lX2FmdGVyKGppZmZpZXMsIGNybmctPmlu
aXRfdGltZSArIENSTkdfUkVTRUVEX0lOVEVSVkFMKSkpCiAJCWNybmdfcmVzZWVkKGNybmcsIGNy
bmcgPT0gJnByaW1hcnlfY3JuZyA/ICZpbnB1dF9wb29sIDogTlVMTCk7CisJaWYgKCFhcmNoX2dl
dF9yYW5kb21fbG9uZygmdikpCisJCXYgPSByYW5kb21fZ2V0X2VudHJvcHkoKTsKIAlzcGluX2xv
Y2tfaXJxc2F2ZSgmY3JuZy0+bG9jaywgZmxhZ3MpOwotCWlmIChhcmNoX2dldF9yYW5kb21fbG9u
ZygmdikpCi0JCWNybmctPnN0YXRlWzE0XSBePSB2OworCWNybmctPnN0YXRlWzE0XSArPSB2Owog
CWNoYWNoYTIwX2Jsb2NrKCZjcm5nLT5zdGF0ZVswXSwgb3V0KTsKIAlpZiAoY3JuZy0+c3RhdGVb
MTJdID09IDApCiAJCWNybmctPnN0YXRlWzEzXSsrOwo=
--000000000000545cbf0592ed7546--
