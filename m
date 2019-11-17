Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B0EC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB2820730
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574018475;
	bh=w+dnIbu9oBYVUapr8nXPDvKyD1fApcFmkcoL+8BnDs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WE2h7NGUnCBvFfbHZ/9EH04XK9hIMZAipE1/SiQLWz8U9Ezh+nIG3i47yqpGyuNMC
	 mwV0RfPz6wG+ORfw9xnokm18/wJIGtJg+RjR9IZxN/J8KngLxzpFmgPjtuYAx6O9qK
	 BAW5recCPmPSglZehU8/o3WfDxc/+mj4+sGWRczU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfKQTVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 14:21:13 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35908 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfKQTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 14:21:13 -0500
Received: by mail-lj1-f171.google.com with SMTP id k15so16314546lja.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 11:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9o5Rr6p1RxZ72tpzaroFaDH4nHZbfJkcGWlbwHGYPZo=;
        b=ZiMIfR4AjFv/jhJFvFDre8SMJgUYCcl09+lxkMQQln87OoLJxqOTuFWC2+NlCK6IzF
         u6sYFWIKTKt15f/nAGiW7KCsuPofIkYwXcJZdnFE6CQDl4mFvmD4d7wAH5sfYedZulRS
         DaN+XYEks/6P7slQYw+1ukPouZeoxF412AFXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9o5Rr6p1RxZ72tpzaroFaDH4nHZbfJkcGWlbwHGYPZo=;
        b=UxDszn0voHPFCqfSMwrPQtlOAgsk+9tRu1xvo3KrIfsJnBy+ZhhtrlIiBwE6G6XnEV
         rht9SuQCt2uzzW9mynIuGEUJsX96Y/QFmYCj82i7tMqRZMbkQuRyval4E4vpO+Kmg6r9
         rCGlSxqQI2Yc6TxGRcE0hDZ/rr3HRa0zVDHr977ihG87BYQIOneDm6kS089pZQI180LJ
         O8hDC8xkQMGWWiXjo/YDfgmJxnGASFwD9R8ZNvrNziD0JMwgo/fAtjbStevWGe1Vm/aG
         plZMn66UzZ9wNJ45b0OekIv322ng5H7iaOrtScFD0i3zZ6TMbXgocREjP0B7y4718zZV
         SyOw==
X-Gm-Message-State: APjAAAU575Qx6xvcp/Z/y8+4mZtJPRT0/WW730ZomwML6VVFSofam7do
        4rgt9IOEM4X6+bQu3zbFBy4xt37NM1o=
X-Google-Smtp-Source: APXvYqwyhBZAlMcWm4VrIv6IEsXNclSsjEJhB6oEAP4b4yYyZh8xgtnW0xfomfnuJGI9KCa2oODIQg==
X-Received: by 2002:a2e:8e27:: with SMTP id r7mr18702520ljk.101.1574018468627;
        Sun, 17 Nov 2019 11:21:08 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q11sm7183596ljm.107.2019.11.17.11.21.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2019 11:21:06 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id n5so16300626ljc.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 11:21:05 -0800 (PST)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr18387414lji.97.1574018465184;
 Sun, 17 Nov 2019 11:21:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com>
 <20191112165033.GA7905@deco.navytux.spb.ru> <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
 <CAHk-=whPFjpOEfU5N4qz_gGC8_=NLh1VkBLm09K1S1Gcma5pzA@mail.gmail.com> <20191117185623.GA22280@deco.navytux.spb.ru>
In-Reply-To: <20191117185623.GA22280@deco.navytux.spb.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Nov 2019 11:20:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdm7qeqydbnC_EGDaiWcG-F-oe09o8T3ChORLnRZFE=w@mail.gmail.com>
Message-ID: <CAHk-=whdm7qeqydbnC_EGDaiWcG-F-oe09o8T3ChORLnRZFE=w@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007cedf905978fbbbb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007cedf905978fbbbb
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 17, 2019 at 10:56 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
>   I'd like to take a time break for now.
>   I will try to return to this topic after finishing my main work first.
>   I apologize for the inconvenience. )

Sure, no problem, appreciate that you're looking at it.

I *think* the pipe and socket case should be fixed by something like
this, but it is entirely and utterly untested.

              Linus

--0000000000007cedf905978fbbbb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k33dxwzp0>
X-Attachment-Id: f_k33dxwzp0

IGZzL3BpcGUuYyAgICB8IDYgKysrKy0tCiBuZXQvc29ja2V0LmMgfCAxICsKIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3Bp
cGUuYyBiL2ZzL3BpcGUuYwppbmRleCA4YTJhYjJmOTc0YmQuLmRlNmRlZTU1OWQ0MSAxMDA2NDQK
LS0tIGEvZnMvcGlwZS5jCisrKyBiL2ZzL3BpcGUuYwpAQCAtNzgzLDYgKzc4Myw3IEBAIGludCBj
cmVhdGVfcGlwZV9maWxlcyhzdHJ1Y3QgZmlsZSAqKnJlcywgaW50IGZsYWdzKQogCX0KIAogCWYt
PnByaXZhdGVfZGF0YSA9IGlub2RlLT5pX3BpcGU7CisJc3RyZWFtX29wZW4oaW5vZGUsIGYpOwog
CiAJcmVzWzBdID0gYWxsb2NfZmlsZV9jbG9uZShmLCBPX1JET05MWSB8IChmbGFncyAmIE9fTk9O
QkxPQ0spLAogCQkJCSAgJnBpcGVmaWZvX2ZvcHMpOwpAQCAtNzkxLDYgKzc5Miw3IEBAIGludCBj
cmVhdGVfcGlwZV9maWxlcyhzdHJ1Y3QgZmlsZSAqKnJlcywgaW50IGZsYWdzKQogCQlmcHV0KGYp
OwogCQlyZXR1cm4gUFRSX0VSUihyZXNbMF0pOwogCX0KKwlzdHJlYW1fb3Blbihpbm9kZSwgZik7
CiAJcmVzWzBdLT5wcml2YXRlX2RhdGEgPSBpbm9kZS0+aV9waXBlOwogCXJlc1sxXSA9IGY7CiAJ
cmV0dXJuIDA7CkBAIC05MzEsOSArOTMzLDkgQEAgc3RhdGljIGludCBmaWZvX29wZW4oc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApCiAJX19waXBlX2xvY2socGlwZSk7CiAK
IAkvKiBXZSBjYW4gb25seSBkbyByZWd1bGFyIHJlYWQvd3JpdGUgb24gZmlmb3MgKi8KLQlmaWxw
LT5mX21vZGUgJj0gKEZNT0RFX1JFQUQgfCBGTU9ERV9XUklURSk7CisJc3RyZWFtX29wZW4oaW5v
ZGUsIGZpbHApOwogCi0Jc3dpdGNoIChmaWxwLT5mX21vZGUpIHsKKwlzd2l0Y2ggKGZpbHAtPmZf
bW9kZSAmIChGTU9ERV9SRUFEIHwgRk1PREVfV1JJVEUpKSB7CiAJY2FzZSBGTU9ERV9SRUFEOgog
CS8qCiAJICogIE9fUkRPTkxZCmRpZmYgLS1naXQgYS9uZXQvc29ja2V0LmMgYi9uZXQvc29ja2V0
LmMKaW5kZXggNmE5YWI3YThiMWQyLi4zYzZkNjBlYWRmN2EgMTAwNjQ0Ci0tLSBhL25ldC9zb2Nr
ZXQuYworKysgYi9uZXQvc29ja2V0LmMKQEAgLTQwNCw2ICs0MDQsNyBAQCBzdHJ1Y3QgZmlsZSAq
c29ja19hbGxvY19maWxlKHN0cnVjdCBzb2NrZXQgKnNvY2ssIGludCBmbGFncywgY29uc3QgY2hh
ciAqZG5hbWUpCiAKIAlzb2NrLT5maWxlID0gZmlsZTsKIAlmaWxlLT5wcml2YXRlX2RhdGEgPSBz
b2NrOworCXN0cmVhbV9vcGVuKFNPQ0tfSU5PREUoc29jayksIGZpbGUpOwogCXJldHVybiBmaWxl
OwogfQogRVhQT1JUX1NZTUJPTChzb2NrX2FsbG9jX2ZpbGUpOwo=
--0000000000007cedf905978fbbbb--
