Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1F1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B249220867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570507776;
	bh=s3dFg/jjHiqQe5rPAcgBciihZZEaL0Ms9c+sbhKXc3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rgV7zLFRJEnA2hB3/DAVi6vvCzpx9NxcFq/iLQpHQvp9E37F9v7aWNiHgWP0xM2AR
	 cCy4fBXB/zu1wR8iB3hKWX8RXRZLyH4X/c4a7BYOFHuvRmTfvgf5HcLvhHWFWy+aJj
	 Cen7mdoav7BUjSaO4DTx+E+W5T2GmtezoCgZyGeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfJHEJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:09:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46717 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfJHEJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:09:35 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so10785125lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnKFcjxBKN6Qpqxh5XkObDMG8fH2wT4HUjifdtCIY7U=;
        b=LCTCldBdoohmi8kv7PcXweH6uWk7dC5wCVDPU9bVrAuYhDOtJV9+8ZUI3ZUecmGXb8
         63QN/52Kf/NOj4RH1TMXblY6soPXq/L0PBd6sRBHAJAl8T1SAHO0vB0b1ljtolfq8auX
         ZtLweTHsVLVOlJLg/B4F8wbqExDFYmMKBwmPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnKFcjxBKN6Qpqxh5XkObDMG8fH2wT4HUjifdtCIY7U=;
        b=pK0yLNVoWDlxm1SzIMK7h8J+O2mOW+Md7y6nwU0McgXgoukbiv0kydfU7Cbjff8awn
         /zsuzpk+elPzl7Ong7WchOGLTmw7Fk+HhPEhkz3SvvXHcNeIJ9IsFf+gLvxKX4i/5KPw
         rHeTVHZiT6bwYrKdxbLm6sAQMWM1aSdfuNeie6eTBIRW66OGbi8HjNUmKcK1uF6cfRI2
         S0Qt3YcaIVaFaubqYiv1Ycu/L6dW+oooLr0R6t0oqaNbAjX3vkFUl3pTI+dvDCVDyO6j
         Lha0bI4CB9egHpDsX5VpthABE75EzFZjdGb9rOF8FYWkJtt70skQxUi171AzzXEpNSip
         DKnA==
X-Gm-Message-State: APjAAAX9zyQjyGXc3q0F8n/PQDXsY0mRyCrvyVUNUmpNRd/jzFuGnc64
        9T/Gh0ExBJOW9FBVCJXGyHqZVXaCITE=
X-Google-Smtp-Source: APXvYqwmgHwpMk3d3rggRGZm3LYMpkD+32dMTKoqSZgz7kTZKUsQZcEF/tu9tkeMK+pQyvZm2Ork3A==
X-Received: by 2002:ac2:5983:: with SMTP id w3mr18328788lfn.121.1570507772379;
        Mon, 07 Oct 2019 21:09:32 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s1sm3200115lfd.14.2019.10.07.21.09.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 21:09:31 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id l21so15960609lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 21:09:31 -0700 (PDT)
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr20643986ljj.1.1570507770530;
 Mon, 07 Oct 2019 21:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com> <20191008032912.GQ26530@ZenIV.linux.org.uk>
In-Reply-To: <20191008032912.GQ26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 21:09:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
Message-ID: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c7beeb05945e55b8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c7beeb05945e55b8
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 7, 2019 at 8:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> For x86?  Sure, why not...  Note, BTW, that for short constant-sized
> copies we *do* STAC/CLAC at the call site - see those
>                 __uaccess_begin_nospec();
> in raw_copy_{from,to}_user() in the switches...

Yeah, an that code almost never actually triggers in practice. The
code is pointless and dead.

The thing is, it's only ever used for the double undescore versions,
and the ones that do have have it are almost never constant sizes in
the first place.

And yes, there's like a couple of cases in the whole kernel.

Just remove those constant size cases. They are pointless and just
complicate our headers and slow down the compile for no good reason.

Try the attached patch, and then count the number of "rorx"
instructions in the kernel. Hint: not many. On my personal config,
this triggers 15 times in the whole kernel build (not counting
modules).

It's not worth it. The "speedup" from using __copy_{to,from}_user()
with the fancy inlining is negligible. All the cost is in the
STAC/CLAC anyway, the code might as well be deleted.

> 1) cross-architecture user_access_begin_dont_use(): on everything
> except x86 it's empty, on x86 - __uaccess_begin_nospec().

No, just do a proper range check, and use user_access_begin()

Stop trying to optimize that range check away. It's a couple of fast
instructions.

The only ones who don't want the range check are the actual kernel
copy ones, but they don't want the user_access_begin() either.

> void *copy_mount_options(const void __user * data)
> {
>         unsigned offs, size;
>         char *copy;
>
>         if (!data)
>                 return NULL;
>
>         copy = kmalloc(PAGE_SIZE, GFP_KERNEL);
>         if (!copy)
>                 return ERR_PTR(-ENOMEM);
>
>         offs = (unsigned long)untagged_addr(data) & (PAGE_SIZE - 1);
>
>         if (copy_from_user(copy, data, PAGE_SIZE - offs)) {
>                 kfree(copy);
>                 return ERR_PTR(-EFAULT);
>         }
>         if (offs) {
>                 if (copy_from_user(copy, data + PAGE_SIZE - offs, offs))
>                         memset(copy + PAGE_SIZE - offs, 0, offs);
>         }
>         return copy;
> }
>
> on the theory that any fault halfway through a page means a race with
> munmap/mprotect/etc. and we can just pretend we'd lost the race entirely.
> And to hell with exact_copy_from_user(), byte-by-byte copying, etc.

Looks reasonable.

              Linus

--000000000000c7beeb05945e55b8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1hbrkuh0>
X-Attachment-Id: f_k1hbrkuh0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaCBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaAppbmRleCA1Y2QxY2FhOGJjNjUuLmRiNThjNDQzNmNl
MyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzc182NC5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaApAQCAtNjIsNiArNjIsOCBAQCBjb3B5X3Rv
X3VzZXJfbWNzYWZlKHZvaWQgKnRvLCBjb25zdCB2b2lkICpmcm9tLCB1bnNpZ25lZCBsZW4pCiAJ
cmV0dXJuIHJldDsKIH0KIAorI2RlZmluZSBtYXJrZXIoeCkgYXNtIHZvbGF0aWxlKCJyb3J4ICQi
ICN4ICIsJXJheCwlcmR4IikKKwogc3RhdGljIF9fYWx3YXlzX2lubGluZSBfX211c3RfY2hlY2sg
dW5zaWduZWQgbG9uZwogcmF3X2NvcHlfZnJvbV91c2VyKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCBf
X3VzZXIgKnNyYywgdW5zaWduZWQgbG9uZyBzaXplKQogewpAQCAtNzIsMzAgKzc0LDM1IEBAIHJh
d19jb3B5X2Zyb21fdXNlcih2b2lkICpkc3QsIGNvbnN0IHZvaWQgX191c2VyICpzcmMsIHVuc2ln
bmVkIGxvbmcgc2l6ZSkKIAlzd2l0Y2ggKHNpemUpIHsKIAljYXNlIDE6CiAJCV9fdWFjY2Vzc19i
ZWdpbl9ub3NwZWMoKTsKKwkJbWFya2VyKDEpOwogCQlfX2dldF91c2VyX2FzbV9ub3plcm8oKih1
OCAqKWRzdCwgKHU4IF9fdXNlciAqKXNyYywKIAkJCSAgICAgIHJldCwgImIiLCAiYiIsICI9cSIs
IDEpOwogCQlfX3VhY2Nlc3NfZW5kKCk7CiAJCXJldHVybiByZXQ7CiAJY2FzZSAyOgogCQlfX3Vh
Y2Nlc3NfYmVnaW5fbm9zcGVjKCk7CisJCW1hcmtlcigyKTsKIAkJX19nZXRfdXNlcl9hc21fbm96
ZXJvKCoodTE2ICopZHN0LCAodTE2IF9fdXNlciAqKXNyYywKIAkJCSAgICAgIHJldCwgInciLCAi
dyIsICI9ciIsIDIpOwogCQlfX3VhY2Nlc3NfZW5kKCk7CiAJCXJldHVybiByZXQ7CiAJY2FzZSA0
OgogCQlfX3VhY2Nlc3NfYmVnaW5fbm9zcGVjKCk7CisJCW1hcmtlcig0KTsKIAkJX19nZXRfdXNl
cl9hc21fbm96ZXJvKCoodTMyICopZHN0LCAodTMyIF9fdXNlciAqKXNyYywKIAkJCSAgICAgIHJl
dCwgImwiLCAiayIsICI9ciIsIDQpOwogCQlfX3VhY2Nlc3NfZW5kKCk7CiAJCXJldHVybiByZXQ7
CiAJY2FzZSA4OgogCQlfX3VhY2Nlc3NfYmVnaW5fbm9zcGVjKCk7CisJCW1hcmtlcig4KTsKIAkJ
X19nZXRfdXNlcl9hc21fbm96ZXJvKCoodTY0ICopZHN0LCAodTY0IF9fdXNlciAqKXNyYywKIAkJ
CSAgICAgIHJldCwgInEiLCAiIiwgIj1yIiwgOCk7CiAJCV9fdWFjY2Vzc19lbmQoKTsKIAkJcmV0
dXJuIHJldDsKIAljYXNlIDEwOgogCQlfX3VhY2Nlc3NfYmVnaW5fbm9zcGVjKCk7CisJCW1hcmtl
cigxMCk7CiAJCV9fZ2V0X3VzZXJfYXNtX25vemVybygqKHU2NCAqKWRzdCwgKHU2NCBfX3VzZXIg
KilzcmMsCiAJCQkgICAgICAgcmV0LCAicSIsICIiLCAiPXIiLCAxMCk7CiAJCWlmIChsaWtlbHko
IXJldCkpCkBAIC0xMDYsNiArMTEzLDcgQEAgcmF3X2NvcHlfZnJvbV91c2VyKHZvaWQgKmRzdCwg
Y29uc3Qgdm9pZCBfX3VzZXIgKnNyYywgdW5zaWduZWQgbG9uZyBzaXplKQogCQlyZXR1cm4gcmV0
OwogCWNhc2UgMTY6CiAJCV9fdWFjY2Vzc19iZWdpbl9ub3NwZWMoKTsKKwkJbWFya2VyKDE2KTsK
IAkJX19nZXRfdXNlcl9hc21fbm96ZXJvKCoodTY0ICopZHN0LCAodTY0IF9fdXNlciAqKXNyYywK
IAkJCSAgICAgICByZXQsICJxIiwgIiIsICI9ciIsIDE2KTsKIAkJaWYgKGxpa2VseSghcmV0KSkK
QEAgLTEyOSwzMCArMTM3LDM1IEBAIHJhd19jb3B5X3RvX3VzZXIodm9pZCBfX3VzZXIgKmRzdCwg
Y29uc3Qgdm9pZCAqc3JjLCB1bnNpZ25lZCBsb25nIHNpemUpCiAJc3dpdGNoIChzaXplKSB7CiAJ
Y2FzZSAxOgogCQlfX3VhY2Nlc3NfYmVnaW4oKTsKKwkJbWFya2VyKDUxKTsKIAkJX19wdXRfdXNl
cl9hc20oKih1OCAqKXNyYywgKHU4IF9fdXNlciAqKWRzdCwKIAkJCSAgICAgIHJldCwgImIiLCAi
YiIsICJpcSIsIDEpOwogCQlfX3VhY2Nlc3NfZW5kKCk7CiAJCXJldHVybiByZXQ7CiAJY2FzZSAy
OgogCQlfX3VhY2Nlc3NfYmVnaW4oKTsKKwkJbWFya2VyKDUyKTsKIAkJX19wdXRfdXNlcl9hc20o
Kih1MTYgKilzcmMsICh1MTYgX191c2VyICopZHN0LAogCQkJICAgICAgcmV0LCAidyIsICJ3Iiwg
ImlyIiwgMik7CiAJCV9fdWFjY2Vzc19lbmQoKTsKIAkJcmV0dXJuIHJldDsKIAljYXNlIDQ6CiAJ
CV9fdWFjY2Vzc19iZWdpbigpOworCQltYXJrZXIoNTQpOwogCQlfX3B1dF91c2VyX2FzbSgqKHUz
MiAqKXNyYywgKHUzMiBfX3VzZXIgKilkc3QsCiAJCQkgICAgICByZXQsICJsIiwgImsiLCAiaXIi
LCA0KTsKIAkJX191YWNjZXNzX2VuZCgpOwogCQlyZXR1cm4gcmV0OwogCWNhc2UgODoKIAkJX191
YWNjZXNzX2JlZ2luKCk7CisJCW1hcmtlcig1OCk7CiAJCV9fcHV0X3VzZXJfYXNtKCoodTY0ICop
c3JjLCAodTY0IF9fdXNlciAqKWRzdCwKIAkJCSAgICAgIHJldCwgInEiLCAiIiwgImVyIiwgOCk7
CiAJCV9fdWFjY2Vzc19lbmQoKTsKIAkJcmV0dXJuIHJldDsKIAljYXNlIDEwOgogCQlfX3VhY2Nl
c3NfYmVnaW4oKTsKKwkJbWFya2VyKDYwKTsKIAkJX19wdXRfdXNlcl9hc20oKih1NjQgKilzcmMs
ICh1NjQgX191c2VyICopZHN0LAogCQkJICAgICAgIHJldCwgInEiLCAiIiwgImVyIiwgMTApOwog
CQlpZiAobGlrZWx5KCFyZXQpKSB7CkBAIC0xNjQsNiArMTc3LDcgQEAgcmF3X2NvcHlfdG9fdXNl
cih2b2lkIF9fdXNlciAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHVuc2lnbmVkIGxvbmcgc2l6ZSkK
IAkJcmV0dXJuIHJldDsKIAljYXNlIDE2OgogCQlfX3VhY2Nlc3NfYmVnaW4oKTsKKwkJbWFya2Vy
KDY2KTsKIAkJX19wdXRfdXNlcl9hc20oKih1NjQgKilzcmMsICh1NjQgX191c2VyICopZHN0LAog
CQkJICAgICAgIHJldCwgInEiLCAiIiwgImVyIiwgMTYpOwogCQlpZiAobGlrZWx5KCFyZXQpKSB7
Cg==
--000000000000c7beeb05945e55b8--
