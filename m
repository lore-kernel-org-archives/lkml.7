Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C22C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7CD2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570404938;
	bh=ybxwHajWx+a4WH/89ROaCwglPRiLl9A7BkZFx7NmXOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uusQnsjw1Y5TphoyUlFCb1FqN+xfpb5b/Xt7Zy+8t02YyVBsB8HquzOdtp+REDxd8
	 20KzZOi3AnoHo02uKk6zckGmkCy7kaQ0Zrfm9LBYQKYieeeIPWheUWHIZcq6xcz2hd
	 g1l5mA52NnyNd2DlxVbaGXN6EHg1LoAczMtgeCSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJFXfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 19:35:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36488 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfJFXfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 19:35:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so11692746ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I541VyUsc39FvItvzf+6+a8hUNrsqYjkEIi3jp2fNe8=;
        b=dRuQMA2y2wlK980QrRzfH0xEaPdZmaKsiQQCv/qmq93BayrBgQjq03QgE6EdBHRoQT
         OZoizuluLCjMPp4szPv9UOuBbzVUypw+Zjz0wmmFn+xCOXWv842CfUdkcpf4pCVrIbHh
         frveB/6637/WgVUn6pMqJQpqOxNxMkXf3rQ+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I541VyUsc39FvItvzf+6+a8hUNrsqYjkEIi3jp2fNe8=;
        b=FrS7NYvq4K116sXVOUwcA1yeKX8sd/gKs4xos05fJAS9ZfvP33h6YtPXYiSOMPtOkv
         JO70oYKuNX/JQnIs8bARkcG51fALCmGjkVi8BKZocxnQgWSNXHtnHIkeGpZqYDjQf7r2
         cjGwsncaJEEPDK9oP6BvNXKLSjuRNO579N+rkuMUrMfhMowoRwRbXUx/WTBt14o15xtx
         PaFuQzB+JnWoCYLYGVtWQbxLFBLBixWbZUv8epFtg0sm3rxCnBPDWj4ZBpr5KHckKNhw
         ln96OyN/A68LWwGVC2RrLFlmE1tP4CGetnkheOtwxQM3/VnSvkQRFj1wvv77DNWdFcmc
         QZFA==
X-Gm-Message-State: APjAAAVJry6z0PbX3Y9J5SzkwcwmGQzLV5l59NyZBO5dKY3n3YXVdq+S
        WLzFmYejMPLPtBxOnfSfy3PE9x0WEsA=
X-Google-Smtp-Source: APXvYqy4NDPZYwBkDZbbzFYog6X0rRfDX8UCEmZBGUhbUz9yVRpBwHyB/Phbe0xNLlfv+FUj8IkAvg==
X-Received: by 2002:a2e:1b56:: with SMTP id b83mr16244093ljb.107.1570404933940;
        Sun, 06 Oct 2019 16:35:33 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id l3sm2355501lfc.31.2019.10.06.16.35.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 16:35:32 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id w67so7951736lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 16:35:32 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr15047822lfp.61.1570404932088;
 Sun, 06 Oct 2019 16:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
In-Reply-To: <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 16:35:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
Message-ID: <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000219e680594466412"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000219e680594466412
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 6, 2019 at 4:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ho humm. I've run variations of that patch over a few years on x86,
> but obviously not on alpha/sparc.

Oooh.

I wonder... This may be the name string copy loop. And it's special in
that the result may not be aligned.

Now, a "__put_user()" with an unaligned address _should_ work - it's
very easy to trigger that from user space by just giving an unaligned
address to any system call that then writes a single word.

But alpha does

  #define __put_user_32(x, addr)                                  \
  __asm__ __volatile__("1: stl %r2,%1\n"                          \
          "2:\n"                                                  \
          EXC(1b,2b,$31,%0)                                       \
                  : "=r"(__pu_err)                                \
                  : "m"(__m(addr)), "rJ"(x), "0"(__pu_err))

iow it implements that 32-bit __put_user() as a 'stl'.

Which will trap if it's not aligned.

And I wonder how much testing that has ever gotten. Nobody really does
unaigned accesses on alpha.

We need to do that memcpy unrolling on x86, because x86 actually uses
"user_access_begin()" and we have magic rules about what is inside
that region.

But on alpha (and sparc) it might be better to just do "__copy_to_user()".

Anyway, this does look like a possible latent bug where the alpha
unaligned trap doesn't then handle the case of exceptions. I know it
_tries_, but I doubt it's gotten a whole lot of testing.

Anyway, let me think about this, but just for testing, does the
attached patch make any difference? It's not the right thing in
general (and most definitely not on x86), but for testing whether this
is about unaligned accesses it might work.

It's entirely untested, and in fact on x86 it should cause objtool to
complain about a function call with AC set. But I think that on alpha
and sparc, using __copy_to_user() for the name copy should work, and
would work around the unaligned issue.

That said, if it *is* the unaligned issue, then that just means that
we have a serious bug elsewhere in the alpha port. Maybe nobody cares.

              Linus

--000000000000219e680594466412
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1fmjafm0>
X-Attachment-Id: f_k1fmjafm0

IGZzL3JlYWRkaXIuYyB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZnMvcmVhZGRpci5jIGIvZnMvcmVhZGRpci5jCmluZGV4IDE5YmVh
NTkxYzNmMS4uZDQ5YzRlMmM2NmE4IDEwMDY0NAotLS0gYS9mcy9yZWFkZGlyLmMKKysrIGIvZnMv
cmVhZGRpci5jCkBAIC03Niw2ICs3NiwxNSBAQAogCXVuc2FmZV9wdXRfdXNlcigwLCBkc3QsIGxh
YmVsKTsJCQkJXAogfSB3aGlsZSAoMCkKIAorLyogQWxwaGEgKGFuZCBzcGFyYz8pIHRlc3QgcGF0
Y2ghICovCisjdW5kZWYgdW5zYWZlX2NvcHlfZGlyZW50X25hbWUKKyNkZWZpbmUgdW5zYWZlX2Nv
cHlfZGlyZW50X25hbWUoX2RzdCwgX3NyYywgX2xlbiwgbGFiZWwpIGRvIHsJXAorCWNoYXIgX191
c2VyICpkc3QgPSAoX2RzdCk7CQkJCVwKKwljb25zdCBjaGFyICpzcmMgPSAoX3NyYyk7CQkJCVwK
KwlzaXplX3QgbGVuID0gKF9sZW4pOwkJCQkJXAorCWlmIChfX2NvcHlfdG9fdXNlcihkc3QsIHNy
YywgbGVuKSkgZ290byBsYWJlbDsJCVwKKwl1bnNhZmVfcHV0X3VzZXIoMCwgZHN0K2xlbiwgbGFi
ZWwpOwkJCVwKK30gd2hpbGUgKDApCiAKIGludCBpdGVyYXRlX2RpcihzdHJ1Y3QgZmlsZSAqZmls
ZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpCiB7Cg==
--000000000000219e680594466412--
