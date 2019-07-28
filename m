Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98750C76186
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 00:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7204820856
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 00:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564274046;
	bh=J+sOCDsKNWNrzzwtP/DZIjFxr16L8xfSR+ePLcePezo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LI/eBfTiDSvSKghy5yvRNqLmK0P7yYXQx54oI+yd1qgZpUWD43NU1suqjUxeMQVUF
	 5GkZy6sdA0hkL7QfQgc8l49ggWgtcnz/zQObI26Y2LGnN283cxECNUeGdNKf7Qhe5B
	 oWxo+wvvPOBmspXdsz5/nRAQu7vDatZIyHY3CQFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfG1Ad7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 20:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfG1Ad6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 20:33:58 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2717B214C6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 00:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564274037;
        bh=J+sOCDsKNWNrzzwtP/DZIjFxr16L8xfSR+ePLcePezo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gRMLtbkKZ+oQeCaZ5YGW7WE9dBLE01ZHuANEphtxXiEfdwvW0ZJ6kUQu7NKN/2RWJ
         16pqpOP6r0kG+8ONQaxzKnnPDb+yR6joTa4dynIa00oW8BuX5cWJ17fvOOB70Xrobj
         B3+muxBKNlxgJsGA9bPxf6gGJmfnoPBIrzwObC7U=
Received: by mail-wm1-f47.google.com with SMTP id f17so50470657wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 17:33:57 -0700 (PDT)
X-Gm-Message-State: APjAAAXPqWSfD0vCDW4GFo5dRQBeWsjuI4IwyKiwEX0jU4b8krYdE9r7
        6QRNWt/ITQuyCwJTonro2cqXB2zvLiS6dWKg8BiJZQ==
X-Google-Smtp-Source: APXvYqz4oCsypBzUtEOjlGfN+9f1V85hwUhNa8au7cVcKcP0RTaxXMOqBrQj2KBAko4J+KTAAXe0pNqdpMBea1zhFgo=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr92031774wmk.79.1564274035582;
 Sat, 27 Jul 2019 17:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook> <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
 <201907231437.DB20BEBD3@keescook> <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de>
 <201907231636.AD3ED717D@keescook> <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
 <20190726180103.GE3188@linux.intel.com> <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com>
 <alpine.DEB.2.21.1907272042310.1791@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907272153090.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907272153090.1791@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 27 Jul 2019 17:33:44 -0700
X-Gmail-Original-Message-ID: <CALCETrVOb91w8SJwYKSXgtfs+MyzifpPoVSyiaOUKCVSXKwNSg@mail.gmail.com>
Message-ID: <CALCETrVOb91w8SJwYKSXgtfs+MyzifpPoVSyiaOUKCVSXKwNSg@mail.gmail.com>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on i386
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/mixed; boundary="000000000000392e55058eb2eeeb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000392e55058eb2eeeb
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 27, 2019 at 2:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 27 Jul 2019, Thomas Gleixner wrote:
> > On Sat, 27 Jul 2019, Andy Lutomirski wrote:
> > >
> > > I think it's getting quite late to start inventing new seccomp
> > > features to fix this.  I think the right solution for 5.3 is to change
> > > the 32-bit vdso fallback to use the old clock_gettime, i.e.
> > > clock_gettime32.  This is obviously not an acceptable long-term
> > > solution.
> >
> > Sigh. I'll have a look....
>
> Completely untested patch below.
>
> For the record: I have to say that I hate it.

Me too.

How about something more like the attached.  (The attachment obviously
won't compile, since it's incomplete.  I'm wondering if you think the
idea is okay.  The idea is to have the vdso calls fall back to the
corresponding syscalls rather than internally converting.)

--Andy

--000000000000392e55058eb2eeeb
Content-Type: text/x-patch; charset="US-ASCII"; name="vdso.patch"
Content-Disposition: attachment; filename="vdso.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jym8cu970>
X-Attachment-Id: f_jym8cu970

ZGlmZiAtLWdpdCBhL2xpYi92ZHNvL2dldHRpbWVvZmRheS5jIGIvbGliL3Zkc28vZ2V0dGltZW9m
ZGF5LmMKaW5kZXggMmQxYzFmMjQxZmQ5Li5iNzI4NDMzMDAxOGQgMTAwNjQ0Ci0tLSBhL2xpYi92
ZHNvL2dldHRpbWVvZmRheS5jCisrKyBiL2xpYi92ZHNvL2dldHRpbWVvZmRheS5jCkBAIC01MSw3
ICs1MSw3IEBAIHN0YXRpYyBpbnQgZG9faHJlcyhjb25zdCBzdHJ1Y3QgdmRzb19kYXRhICp2ZCwg
Y2xvY2tpZF90IGNsaywKIAkJbnMgPSB2ZHNvX3RzLT5uc2VjOwogCQlsYXN0ID0gdmQtPmN5Y2xl
X2xhc3Q7CiAJCWlmICh1bmxpa2VseSgoczY0KWN5Y2xlcyA8IDApKQotCQkJcmV0dXJuIGNsb2Nr
X2dldHRpbWVfZmFsbGJhY2soY2xrLCB0cyk7CisJCQlyZXR1cm4gLTE7CiAKIAkJbnMgKz0gdmRz
b19jYWxjX2RlbHRhKGN5Y2xlcywgbGFzdCwgdmQtPm1hc2ssIHZkLT5tdWx0KTsKIAkJbnMgPj49
IHZkLT5zaGlmdDsKQEAgLTg2LDYgKzg2LDcgQEAgX19jdmRzb19jbG9ja19nZXR0aW1lKGNsb2Nr
aWRfdCBjbG9jaywgc3RydWN0IF9fa2VybmVsX3RpbWVzcGVjICp0cykKIHsKIAljb25zdCBzdHJ1
Y3QgdmRzb19kYXRhICp2ZCA9IF9fYXJjaF9nZXRfdmRzb19kYXRhKCk7CiAJdTMyIG1zazsKKwlp
bnQgcmV0OwogCiAJLyogQ2hlY2sgZm9yIG5lZ2F0aXZlIHZhbHVlcyBvciBpbnZhbGlkIGNsb2Nr
cyAqLwogCWlmICh1bmxpa2VseSgodTMyKSBjbG9jayA+PSBNQVhfQ0xPQ0tTKSkKQEAgLTk3LDE0
ICs5OCwxNyBAQCBfX2N2ZHNvX2Nsb2NrX2dldHRpbWUoY2xvY2tpZF90IGNsb2NrLCBzdHJ1Y3Qg
X19rZXJuZWxfdGltZXNwZWMgKnRzKQogCSAqLwogCW1zayA9IDFVIDw8IGNsb2NrOwogCWlmIChs
aWtlbHkobXNrICYgVkRTT19IUkVTKSkgewotCQlyZXR1cm4gZG9faHJlcygmdmRbQ1NfSFJFU19D
T0FSU0VdLCBjbG9jaywgdHMpOworCQlyZXQgPSBkb19ocmVzKCZ2ZFtDU19IUkVTX0NPQVJTRV0s
IGNsb2NrLCB0cyk7CiAJfSBlbHNlIGlmIChtc2sgJiBWRFNPX0NPQVJTRSkgewogCQlkb19jb2Fy
c2UoJnZkW0NTX0hSRVNfQ09BUlNFXSwgY2xvY2ssIHRzKTsKIAkJcmV0dXJuIDA7CiAJfSBlbHNl
IGlmIChtc2sgJiBWRFNPX1JBVykgewotCQlyZXR1cm4gZG9faHJlcygmdmRbQ1NfUkFXXSwgY2xv
Y2ssIHRzKTsKKwkJcmV0ID0gZG9faHJlcygmdmRbQ1NfUkFXXSwgY2xvY2ssIHRzKTsKIAl9CiAK
KwlpZiAobGlrZWx5KHJldCA9PSAwKSkKKwkJcmV0dXJuIGNsb2NrX2dldHRpbWVfZmFsbGJhY2so
Y2xvY2ssIHRzKTsKKwogZmFsbGJhY2s6CiAJcmV0dXJuIGNsb2NrX2dldHRpbWVfZmFsbGJhY2so
Y2xvY2ssIHRzKTsKIH0KQEAgLTEyMCwxNSArMTI0LDE0IEBAIF9fY3Zkc29fY2xvY2tfZ2V0dGlt
ZTMyKGNsb2NraWRfdCBjbG9jaywgc3RydWN0IG9sZF90aW1lc3BlYzMyICpyZXMpCiAKIAlyZXQg
PSBfX2N2ZHNvX2Nsb2NrX2dldHRpbWUoY2xvY2ssICZ0cyk7CiAKLQlpZiAocmV0ID09IDApIHsK
KwlpZiAobGlrZWx5KHJldCA9PSAwKSkgewogCQlyZXMtPnR2X3NlYyA9IHRzLnR2X3NlYzsKIAkJ
cmVzLT50dl9uc2VjID0gdHMudHZfbnNlYzsKKwkJcmV0dXJuIHJldDsKIAl9CiAKLQlyZXR1cm4g
cmV0OwotCiBmYWxsYmFjazoKLQlyZXR1cm4gY2xvY2tfZ2V0dGltZV9mYWxsYmFjayhjbG9jaywg
KHN0cnVjdCBfX2tlcm5lbF90aW1lc3BlYyAqKXJlcyk7CisJcmV0dXJuIGNsb2NrX2dldHRpbWUz
Ml9mYWxsYmFjayhjbG9jaywgKHN0cnVjdCBfX2tlcm5lbF90aW1lc3BlYyAqKXJlcyk7CiB9CiAK
IHN0YXRpYyBfX21heWJlX3VudXNlZCBpbnQK
--000000000000392e55058eb2eeeb--
