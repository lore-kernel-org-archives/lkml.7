Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A3AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528EC206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570508114;
	bh=dQx4U6E2wnPGfqmhCZjJLQqOM/Yc5IVoKON+Lk4cbBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q/iBUvHsHqCL8MdbvMnnFn/d0jDf5HybGfuJGMMT6vyefJ0uX3XAcTs/WHjhXmfv/
	 wLSBY/tmq6xdBfZCygzbcAPl7lDA2OLmF5KiCWXaFMTU1xJEmLebZAL7sceLJ4ON/7
	 9rUXjmD52L/LpHIHWof77wL1RQwdG06VVQJkN2t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfJHEPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:15:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37953 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfJHEPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:15:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so15961854ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIsG/nCdDkK1ngfVEDi6AHQN0IOnMDNLhzPEh74gezA=;
        b=Q59g2wJg3H2RXUV5xJAzGwMmIOuLCzelcYtfS3ZKTuBdWq7FQusnrMuEBfttf7P/rn
         7cZ3I69o5e2WqLIYq2QphG+J2FDw+B4Auv5XA95QGpFeXOCCZzbXHldaCs/m6Nhfcy9Y
         VJn0c1EL0Tm2kKTwVp/fvfq+g0y0vXdeYbjdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIsG/nCdDkK1ngfVEDi6AHQN0IOnMDNLhzPEh74gezA=;
        b=F+qrt6UrNCqd5Gy3BsY4/VeBcn58DNkKbxCD1mKksl0FR5k3xXE+9ypEtLm4wS39Oy
         Qt99TVLaU30WrGTfENQ7DfHPcCSnjlEVAAj9WV4Ad64vuxNEbVTj90YxwzUxtxeRvISM
         benqZDuWGL7ziuqcr/4bfls0uYhA8zIhoqR8Id98SiqwGqTnP/JmNiyg4mRVMN+8HE7g
         RW5DZHrqSc0XQ2sE33+D0oI1euB+uC6rHG26v1PfVFe7PdyG7N5JuzMXrInNjljPbnFD
         ezYzvNsI1e/+t0cwGC8w0ruKMAnl5kAkeqoFWFEJL2ZfscYEbwLyl6k1iVvNaKRjU03e
         808w==
X-Gm-Message-State: APjAAAU9HqDzDiPUnSYVuRgnbKZN4UnN/jL0dNS9ScBF5zkk4PeJcGiP
        63r49aG+HYWazEgD8C0uUaVsy3sOWZc=
X-Google-Smtp-Source: APXvYqzKtQgFrXr4KHx1X07humQdnPcrMI/X/VI5HqMI1SOvUXj9jNhGGP3wug6BjHQikv++Z5JNXA==
X-Received: by 2002:a2e:8147:: with SMTP id t7mr1847795ljg.75.1570508110159;
        Mon, 07 Oct 2019 21:15:10 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id r5sm3269127lfc.85.2019.10.07.21.15.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 21:15:09 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 72so10823752lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 21:15:09 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr18951601lfe.79.1570508108744;
 Mon, 07 Oct 2019 21:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
In-Reply-To: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 21:14:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjE_9x02o=6Kgu9XWD7RTaRMKOXXYc0CPwAx87i-FZ70w@mail.gmail.com>
Message-ID: <CAHk-=wjE_9x02o=6Kgu9XWD7RTaRMKOXXYc0CPwAx87i-FZ70w@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f0773b05945e696f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f0773b05945e696f
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 7, 2019 at 9:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Try the attached patch, and then count the number of "rorx"
> instructions in the kernel. Hint: not many. On my personal config,
> this triggers 15 times in the whole kernel build (not counting
> modules).

So here's a serious patch that doesn't just mark things for counting -
it just removes the cases entirely.

Doesn't this look nice:

  2 files changed, 2 insertions(+), 133 deletions(-)

and it is one less thing to worry about when doing further cleanup.

Seriously, if any of those __copy_{to,from}_user() constant cases were
a big deal, we can turn them into get_user/put_user calls. But only
after they show up as an actual performance issue.

            Linus

--000000000000f0773b05945e696f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1hbytc60>
X-Attachment-Id: f_k1hbytc60

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfMzIuaCB8ICAyNyAtLS0tLS0tLS0tCiBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNzXzY0LmggfCAxMDggKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxMzMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzc18z
Mi5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzc18zMi5oCmluZGV4IGJhMmRjMTkzMDYz
MC4uMzg4YTQwNjYwYzdiIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNz
XzMyLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzc18zMi5oCkBAIC0yMywzMyAr
MjMsNiBAQCByYXdfY29weV90b191c2VyKHZvaWQgX191c2VyICp0bywgY29uc3Qgdm9pZCAqZnJv
bSwgdW5zaWduZWQgbG9uZyBuKQogc3RhdGljIF9fYWx3YXlzX2lubGluZSB1bnNpZ25lZCBsb25n
CiByYXdfY29weV9mcm9tX3VzZXIodm9pZCAqdG8sIGNvbnN0IHZvaWQgX191c2VyICpmcm9tLCB1
bnNpZ25lZCBsb25nIG4pCiB7Ci0JaWYgKF9fYnVpbHRpbl9jb25zdGFudF9wKG4pKSB7Ci0JCXVu
c2lnbmVkIGxvbmcgcmV0OwotCi0JCXN3aXRjaCAobikgewotCQljYXNlIDE6Ci0JCQlyZXQgPSAw
OwotCQkJX191YWNjZXNzX2JlZ2luX25vc3BlYygpOwotCQkJX19nZXRfdXNlcl9hc21fbm96ZXJv
KCoodTggKil0bywgZnJvbSwgcmV0LAotCQkJCQkgICAgICAiYiIsICJiIiwgIj1xIiwgMSk7Ci0J
CQlfX3VhY2Nlc3NfZW5kKCk7Ci0JCQlyZXR1cm4gcmV0OwotCQljYXNlIDI6Ci0JCQlyZXQgPSAw
OwotCQkJX191YWNjZXNzX2JlZ2luX25vc3BlYygpOwotCQkJX19nZXRfdXNlcl9hc21fbm96ZXJv
KCoodTE2ICopdG8sIGZyb20sIHJldCwKLQkJCQkJICAgICAgInciLCAidyIsICI9ciIsIDIpOwot
CQkJX191YWNjZXNzX2VuZCgpOwotCQkJcmV0dXJuIHJldDsKLQkJY2FzZSA0OgotCQkJcmV0ID0g
MDsKLQkJCV9fdWFjY2Vzc19iZWdpbl9ub3NwZWMoKTsKLQkJCV9fZ2V0X3VzZXJfYXNtX25vemVy
bygqKHUzMiAqKXRvLCBmcm9tLCByZXQsCi0JCQkJCSAgICAgICJsIiwgImsiLCAiPXIiLCA0KTsK
LQkJCV9fdWFjY2Vzc19lbmQoKTsKLQkJCXJldHVybiByZXQ7Ci0JCX0KLQl9CiAJcmV0dXJuIF9f
Y29weV91c2VyX2xsKHRvLCAoX19mb3JjZSBjb25zdCB2b2lkICopZnJvbSwgbik7CiB9CiAKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaAppbmRleCA1Y2QxY2FhOGJjNjUuLmJjMTBlM2RjNjRmZSAx
MDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzc182NC5oCisrKyBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaApAQCAtNjUsMTE3ICs2NSwxMyBAQCBjb3B5X3Rv
X3VzZXJfbWNzYWZlKHZvaWQgKnRvLCBjb25zdCB2b2lkICpmcm9tLCB1bnNpZ25lZCBsZW4pCiBz
dGF0aWMgX19hbHdheXNfaW5saW5lIF9fbXVzdF9jaGVjayB1bnNpZ25lZCBsb25nCiByYXdfY29w
eV9mcm9tX3VzZXIodm9pZCAqZHN0LCBjb25zdCB2b2lkIF9fdXNlciAqc3JjLCB1bnNpZ25lZCBs
b25nIHNpemUpCiB7Ci0JaW50IHJldCA9IDA7Ci0KLQlpZiAoIV9fYnVpbHRpbl9jb25zdGFudF9w
KHNpemUpKQotCQlyZXR1cm4gY29weV91c2VyX2dlbmVyaWMoZHN0LCAoX19mb3JjZSB2b2lkICop
c3JjLCBzaXplKTsKLQlzd2l0Y2ggKHNpemUpIHsKLQljYXNlIDE6Ci0JCV9fdWFjY2Vzc19iZWdp
bl9ub3NwZWMoKTsKLQkJX19nZXRfdXNlcl9hc21fbm96ZXJvKCoodTggKilkc3QsICh1OCBfX3Vz
ZXIgKilzcmMsCi0JCQkgICAgICByZXQsICJiIiwgImIiLCAiPXEiLCAxKTsKLQkJX191YWNjZXNz
X2VuZCgpOwotCQlyZXR1cm4gcmV0OwotCWNhc2UgMjoKLQkJX191YWNjZXNzX2JlZ2luX25vc3Bl
YygpOwotCQlfX2dldF91c2VyX2FzbV9ub3plcm8oKih1MTYgKilkc3QsICh1MTYgX191c2VyICop
c3JjLAotCQkJICAgICAgcmV0LCAidyIsICJ3IiwgIj1yIiwgMik7Ci0JCV9fdWFjY2Vzc19lbmQo
KTsKLQkJcmV0dXJuIHJldDsKLQljYXNlIDQ6Ci0JCV9fdWFjY2Vzc19iZWdpbl9ub3NwZWMoKTsK
LQkJX19nZXRfdXNlcl9hc21fbm96ZXJvKCoodTMyICopZHN0LCAodTMyIF9fdXNlciAqKXNyYywK
LQkJCSAgICAgIHJldCwgImwiLCAiayIsICI9ciIsIDQpOwotCQlfX3VhY2Nlc3NfZW5kKCk7Ci0J
CXJldHVybiByZXQ7Ci0JY2FzZSA4OgotCQlfX3VhY2Nlc3NfYmVnaW5fbm9zcGVjKCk7Ci0JCV9f
Z2V0X3VzZXJfYXNtX25vemVybygqKHU2NCAqKWRzdCwgKHU2NCBfX3VzZXIgKilzcmMsCi0JCQkg
ICAgICByZXQsICJxIiwgIiIsICI9ciIsIDgpOwotCQlfX3VhY2Nlc3NfZW5kKCk7Ci0JCXJldHVy
biByZXQ7Ci0JY2FzZSAxMDoKLQkJX191YWNjZXNzX2JlZ2luX25vc3BlYygpOwotCQlfX2dldF91
c2VyX2FzbV9ub3plcm8oKih1NjQgKilkc3QsICh1NjQgX191c2VyICopc3JjLAotCQkJICAgICAg
IHJldCwgInEiLCAiIiwgIj1yIiwgMTApOwotCQlpZiAobGlrZWx5KCFyZXQpKQotCQkJX19nZXRf
dXNlcl9hc21fbm96ZXJvKCoodTE2ICopKDggKyAoY2hhciAqKWRzdCksCi0JCQkJICAgICAgICh1
MTYgX191c2VyICopKDggKyAoY2hhciBfX3VzZXIgKilzcmMpLAotCQkJCSAgICAgICByZXQsICJ3
IiwgInciLCAiPXIiLCAyKTsKLQkJX191YWNjZXNzX2VuZCgpOwotCQlyZXR1cm4gcmV0OwotCWNh
c2UgMTY6Ci0JCV9fdWFjY2Vzc19iZWdpbl9ub3NwZWMoKTsKLQkJX19nZXRfdXNlcl9hc21fbm96
ZXJvKCoodTY0ICopZHN0LCAodTY0IF9fdXNlciAqKXNyYywKLQkJCSAgICAgICByZXQsICJxIiwg
IiIsICI9ciIsIDE2KTsKLQkJaWYgKGxpa2VseSghcmV0KSkKLQkJCV9fZ2V0X3VzZXJfYXNtX25v
emVybygqKHU2NCAqKSg4ICsgKGNoYXIgKilkc3QpLAotCQkJCSAgICAgICAodTY0IF9fdXNlciAq
KSg4ICsgKGNoYXIgX191c2VyICopc3JjKSwKLQkJCQkgICAgICAgcmV0LCAicSIsICIiLCAiPXIi
LCA4KTsKLQkJX191YWNjZXNzX2VuZCgpOwotCQlyZXR1cm4gcmV0OwotCWRlZmF1bHQ6Ci0JCXJl
dHVybiBjb3B5X3VzZXJfZ2VuZXJpYyhkc3QsIChfX2ZvcmNlIHZvaWQgKilzcmMsIHNpemUpOwot
CX0KKwlyZXR1cm4gY29weV91c2VyX2dlbmVyaWMoZHN0LCAoX19mb3JjZSB2b2lkICopc3JjLCBz
aXplKTsKIH0KIAogc3RhdGljIF9fYWx3YXlzX2lubGluZSBfX211c3RfY2hlY2sgdW5zaWduZWQg
bG9uZwogcmF3X2NvcHlfdG9fdXNlcih2b2lkIF9fdXNlciAqZHN0LCBjb25zdCB2b2lkICpzcmMs
IHVuc2lnbmVkIGxvbmcgc2l6ZSkKIHsKLQlpbnQgcmV0ID0gMDsKLQotCWlmICghX19idWlsdGlu
X2NvbnN0YW50X3Aoc2l6ZSkpCi0JCXJldHVybiBjb3B5X3VzZXJfZ2VuZXJpYygoX19mb3JjZSB2
b2lkICopZHN0LCBzcmMsIHNpemUpOwotCXN3aXRjaCAoc2l6ZSkgewotCWNhc2UgMToKLQkJX191
YWNjZXNzX2JlZ2luKCk7Ci0JCV9fcHV0X3VzZXJfYXNtKCoodTggKilzcmMsICh1OCBfX3VzZXIg
Kilkc3QsCi0JCQkgICAgICByZXQsICJiIiwgImIiLCAiaXEiLCAxKTsKLQkJX191YWNjZXNzX2Vu
ZCgpOwotCQlyZXR1cm4gcmV0OwotCWNhc2UgMjoKLQkJX191YWNjZXNzX2JlZ2luKCk7Ci0JCV9f
cHV0X3VzZXJfYXNtKCoodTE2ICopc3JjLCAodTE2IF9fdXNlciAqKWRzdCwKLQkJCSAgICAgIHJl
dCwgInciLCAidyIsICJpciIsIDIpOwotCQlfX3VhY2Nlc3NfZW5kKCk7Ci0JCXJldHVybiByZXQ7
Ci0JY2FzZSA0OgotCQlfX3VhY2Nlc3NfYmVnaW4oKTsKLQkJX19wdXRfdXNlcl9hc20oKih1MzIg
KilzcmMsICh1MzIgX191c2VyICopZHN0LAotCQkJICAgICAgcmV0LCAibCIsICJrIiwgImlyIiwg
NCk7Ci0JCV9fdWFjY2Vzc19lbmQoKTsKLQkJcmV0dXJuIHJldDsKLQljYXNlIDg6Ci0JCV9fdWFj
Y2Vzc19iZWdpbigpOwotCQlfX3B1dF91c2VyX2FzbSgqKHU2NCAqKXNyYywgKHU2NCBfX3VzZXIg
Kilkc3QsCi0JCQkgICAgICByZXQsICJxIiwgIiIsICJlciIsIDgpOwotCQlfX3VhY2Nlc3NfZW5k
KCk7Ci0JCXJldHVybiByZXQ7Ci0JY2FzZSAxMDoKLQkJX191YWNjZXNzX2JlZ2luKCk7Ci0JCV9f
cHV0X3VzZXJfYXNtKCoodTY0ICopc3JjLCAodTY0IF9fdXNlciAqKWRzdCwKLQkJCSAgICAgICBy
ZXQsICJxIiwgIiIsICJlciIsIDEwKTsKLQkJaWYgKGxpa2VseSghcmV0KSkgewotCQkJYXNtKCIi
Ojo6Im1lbW9yeSIpOwotCQkJX19wdXRfdXNlcl9hc20oNFsodTE2ICopc3JjXSwgNCArICh1MTYg
X191c2VyICopZHN0LAotCQkJCSAgICAgICByZXQsICJ3IiwgInciLCAiaXIiLCAyKTsKLQkJfQot
CQlfX3VhY2Nlc3NfZW5kKCk7Ci0JCXJldHVybiByZXQ7Ci0JY2FzZSAxNjoKLQkJX191YWNjZXNz
X2JlZ2luKCk7Ci0JCV9fcHV0X3VzZXJfYXNtKCoodTY0ICopc3JjLCAodTY0IF9fdXNlciAqKWRz
dCwKLQkJCSAgICAgICByZXQsICJxIiwgIiIsICJlciIsIDE2KTsKLQkJaWYgKGxpa2VseSghcmV0
KSkgewotCQkJYXNtKCIiOjo6Im1lbW9yeSIpOwotCQkJX19wdXRfdXNlcl9hc20oMVsodTY0ICop
c3JjXSwgMSArICh1NjQgX191c2VyICopZHN0LAotCQkJCSAgICAgICByZXQsICJxIiwgIiIsICJl
ciIsIDgpOwotCQl9Ci0JCV9fdWFjY2Vzc19lbmQoKTsKLQkJcmV0dXJuIHJldDsKLQlkZWZhdWx0
OgotCQlyZXR1cm4gY29weV91c2VyX2dlbmVyaWMoKF9fZm9yY2Ugdm9pZCAqKWRzdCwgc3JjLCBz
aXplKTsKLQl9CisJcmV0dXJuIGNvcHlfdXNlcl9nZW5lcmljKChfX2ZvcmNlIHZvaWQgKilkc3Qs
IHNyYywgc2l6ZSk7CiB9CiAKIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgX19tdXN0X2NoZWNrCg==
--000000000000f0773b05945e696f--
