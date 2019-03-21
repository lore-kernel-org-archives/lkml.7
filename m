Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71184C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CE221902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553192836;
	bh=bjnHFZAB/sfBbAGZmhPlq2iaYYdyFY2i4CiDXb2pBcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VQMoM/aTmFk7tQ0IQkKio/iYmHBsCl3PHoRX9H4bg0w04wROv6UXbn1piRzOJ9v7e
	 1Sx8SUxRtv0FMPDvdFv7jViHOjUEQ+A+jsVNe929hz//uX9uiRMisu60ZwKYcS6+up
	 V3Mpdgnb5N1eUiOwtUHG+VTvQ3jGa86qlE68uzRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfCUS1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUS1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:27:14 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99F92192B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553192833;
        bh=bjnHFZAB/sfBbAGZmhPlq2iaYYdyFY2i4CiDXb2pBcQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1vvSyHoSSXSq2Dc/2hzQwH0+4jKtri0ULzRvu4PjRdFTTNlSJNGjAsigD+b0uZgr
         8U6Cq04G0XQjINzuKFtz6n0kHswplu6fzBgv9JDb7ZEoY1FHzw0FNk2G2cnLUlHO4u
         LGwtBQZKzlcfFo12BnC+zW2/3zEI6rfNj6fvr9vE=
Received: by mail-wr1-f45.google.com with SMTP id g12so7747279wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:27:12 -0700 (PDT)
X-Gm-Message-State: APjAAAXmZCBbsGyO52QobT8csKeyTF/bhsGxOodk79e9Gudm5OBWnCKH
        rVDzmXXJGbEAKp1IqL4qgLYs7JRogO4VSGqqC+xZlA==
X-Google-Smtp-Source: APXvYqybATdBDY2IG9deLEad7ItrfxDCZQzd7pRSIWnROydI2iOeEDzkR0Q8VrFbxSSS2/c4K9YB4v3/63rY6CYkj74=
X-Received: by 2002:adf:f011:: with SMTP id j17mr465313wro.330.1553192831430;
 Thu, 21 Mar 2019 11:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com> <20190321141020.641e313f@gandalf.local.home>
In-Reply-To: <20190321141020.641e313f@gandalf.local.home>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 11:27:00 -0700
X-Gmail-Original-Message-ID: <CALCETrV1YRo8C6=VtFfrSDFAjQBs=Z6+uw-5hbus4frqAbUqGQ@mail.gmail.com>
Message-ID: <CALCETrV1YRo8C6=VtFfrSDFAjQBs=Z6+uw-5hbus4frqAbUqGQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Clark Williams <williams@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000fc9c8f05849ee24a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000fc9c8f05849ee24a
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 21, 2019 at 11:10 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 21 Mar 2019 11:05:06 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
> > In the long run, I think the right solution is to rewrite even more of
> > this mess in C.  We really ought to be able to put the IRQ flag
> > tracing and the context tracking into C code.
>
> And once we do that, we can work on getting the irq tracing
> incorporated into a jump_label type that we could possibly enable
> lockdep at start up, and then disable it later, even on production
> systems! That is, to be able to turn it off and bring the system back
> up to full speed.
>
> It would also allow for irq tracing too.
>
> Some inquiring minds have been asking about this ;-)
>

Well, here's pass zero at this.  Untested, because it obviously
doesn't work.  Here are just a few things that are almost certainly
wrong with it

 - The assertion that entries return with IRQs off will blow up,
because a bunch of the entries can return with IRQs on.  Needs fixing.

 - native_load_gs_index needs to be re-added as a static inline
somewhere or maybe even as a real function because of PV.  Sigh.

 - The IRQ tracing needs to be re-added.

 - Some real semantics need to be defined for precisely what code is
responsible for tracing.

 - We need some asm-callable assertions to check the following
conditions as appropriate:

 (a) that IRQ flags are currently traced as off.
 (b) that IRQ flags are currently traced to match the IRET frame.
 (c) that our context tracking is currently in good shape.  I'm not
100% sure how to define this.


 - We need to do some serious don't-instrument-me stuff to all the C
entries, since we're now in an awful context when calling them.

 - I haven't touched IRQs at all.

--000000000000fc9c8f05849ee24a
Content-Type: text/x-patch; charset="US-ASCII"; name="entry.patch"
Content-Disposition: attachment; filename="entry.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtiyrpw50>
X-Attachment-Id: f_jtiyrpw50

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMgYi9hcmNoL3g4Ni9lbnRyeS9l
bnRyeV82NC5TCmluZGV4IDFmMGVmZGI3YjYyOS4uMGFlMDU3MjRlYWZjIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TCisrKyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMK
QEAgLTE2NywxNSArMTY3LDExIEBAIEdMT0JBTChlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUpCiAKIAlQVVNIX0FORF9DTEVBUl9SRUdTIHJheD0kLUVOT1NZUwogCi0JVFJBQ0VfSVJRU19P
RkYKLQogCS8qIElSUXMgYXJlIG9mZi4gKi8KIAltb3ZxCSVyYXgsICVyZGkKIAltb3ZxCSVyc3As
ICVyc2kKIAljYWxsCWRvX3N5c2NhbGxfNjQJCS8qIHJldHVybnMgd2l0aCBJUlFzIGRpc2FibGVk
ICovCiAKLQlUUkFDRV9JUlFTX0lSRVRRCQkvKiB3ZSdyZSBhYm91dCB0byBjaGFuZ2UgSUYgKi8K
LQogCS8qCiAJICogVHJ5IHRvIHVzZSBTWVNSRVQgaW5zdGVhZCBvZiBJUkVUIGlmIHdlJ3JlIHJl
dHVybmluZyB0bwogCSAqIGEgY29tcGxldGVseSBjbGVhbiA2NC1iaXQgdXNlcnNwYWNlIGNvbnRl
eHQuICBJZiB3ZSdyZSBub3QsCkBAIC0zNDIsNyArMzM4LDYgQEAgRU5UUlkocmV0X2Zyb21fZm9y
aykKIAlVTldJTkRfSElOVF9SRUdTCiAJbW92cQklcnNwLCAlcmRpCiAJY2FsbAlzeXNjYWxsX3Jl
dHVybl9zbG93cGF0aAkvKiByZXR1cm5zIHdpdGggSVJRcyBkaXNhYmxlZCAqLwotCVRSQUNFX0lS
UVNfT04JCQkvKiB1c2VyIG1vZGUgaXMgdHJhY2VkIGFzIElSUVMgb24gKi8KIAlqbXAJc3dhcGdz
X3Jlc3RvcmVfcmVnc19hbmRfcmV0dXJuX3RvX3VzZXJtb2RlCiAKIDE6CkBAIC01OTUsNyArNTkw
LDYgQEAgcmV0X2Zyb21faW50cjoKIEdMT0JBTChyZXRpbnRfdXNlcikKIAltb3YJJXJzcCwlcmRp
CiAJY2FsbAlwcmVwYXJlX2V4aXRfdG9fdXNlcm1vZGUKLQlUUkFDRV9JUlFTX0lSRVRRCiAKIEdM
T0JBTChzd2FwZ3NfcmVzdG9yZV9yZWdzX2FuZF9yZXR1cm5fdG9fdXNlcm1vZGUpCiAjaWZkZWYg
Q09ORklHX0RFQlVHX0VOVFJZCkBAIC02NTEsMTAgKzY0NSw2IEBAIHJldGludF9rZXJuZWw6CiAJ
am1wCTBiCiAxOgogI2VuZGlmCi0JLyoKLQkgKiBUaGUgaXJldHEgY291bGQgcmUtZW5hYmxlIGlu
dGVycnVwdHM6Ci0JICovCi0JVFJBQ0VfSVJRU19JUkVUUQogCiBHTE9CQUwocmVzdG9yZV9yZWdz
X2FuZF9yZXR1cm5fdG9fa2VybmVsKQogI2lmZGVmIENPTkZJR19ERUJVR19FTlRSWQpAQCAtODc5
LDE1ICs4NjksMTAgQEAgYXBpY2ludGVycnVwdCBJUlFfV09SS19WRUNUT1IJCQlpcnFfd29ya19p
bnRlcnJ1cHQJCXNtcF9pcnFfd29ya19pbnRlcnJ1cHQKICAqIEBwYXJhbm9pZCA9PSAyIGlzIHNw
ZWNpYWw6IHRoZSBzdHViIHdpbGwgbmV2ZXIgc3dpdGNoIHN0YWNrcy4gIFRoaXMgaXMgZm9yCiAg
KiAjREY6IGlmIHRoZSB0aHJlYWQgc3RhY2sgaXMgc29tZWhvdyB1bnVzYWJsZSwgd2UnbGwgc3Rp
bGwgZ2V0IGEgdXNlZnVsIE9PUFMuCiAgKi8KLS5tYWNybyBpZHRlbnRyeSBzeW0gZG9fc3ltIGhh
c19lcnJvcl9jb2RlOnJlcSBwYXJhbm9pZD0wIHNoaWZ0X2lzdD0tMQorLm1hY3JvIGlkdGVudHJ5
IHN5bSBkb19zeW0gaGFzX2Vycm9yX2NvZGU6cmVxIHBhcmFub2lkPTAKIEVOVFJZKFxzeW0pCiAJ
VU5XSU5EX0hJTlRfSVJFVF9SRUdTIG9mZnNldD1caGFzX2Vycm9yX2NvZGUqOAogCi0JLyogU2Fu
aXR5IGNoZWNrICovCi0JLmlmIFxzaGlmdF9pc3QgIT0gLTEgJiYgXHBhcmFub2lkID09IDAKLQku
ZXJyb3IgInVzaW5nIHNoaWZ0X2lzdCByZXF1aXJlcyBwYXJhbm9pZD0xIgotCS5lbmRpZgotCiAJ
QVNNX0NMQUMKIAogCS5pZiBcaGFzX2Vycm9yX2NvZGUgPT0gMApAQCAtOTA3LDE0ICs4OTIsNiBA
QCBFTlRSWShcc3ltKQogCVVOV0lORF9ISU5UX1JFR1MKIAkvKiByZXR1cm5lZCBmbGFnOiBlYng9
MDogbmVlZCBzd2FwZ3Mgb24gZXhpdCwgZWJ4PTE6IGRvbid0IG5lZWQgaXQgKi8KIAotCS5pZiBc
cGFyYW5vaWQKLQkuaWYgXHNoaWZ0X2lzdCAhPSAtMQotCVRSQUNFX0lSUVNfT0ZGX0RFQlVHCQkJ
LyogcmVsb2FkIElEVCBpbiBjYXNlIG9mIHJlY3Vyc2lvbiAqLwotCS5lbHNlCi0JVFJBQ0VfSVJR
U19PRkYKLQkuZW5kaWYKLQkuZW5kaWYKLQogCW1vdnEJJXJzcCwgJXJkaQkJCS8qIHB0X3JlZ3Mg
cG9pbnRlciAqLwogCiAJLmlmIFxoYXNfZXJyb3JfY29kZQpAQCAtOTI0LDE3ICs5MDEsOSBAQCBF
TlRSWShcc3ltKQogCXhvcmwJJWVzaSwgJWVzaQkJCS8qIG5vIGVycm9yIGNvZGUgKi8KIAkuZW5k
aWYKIAotCS5pZiBcc2hpZnRfaXN0ICE9IC0xCi0Jc3VicQkkRVhDRVBUSU9OX1NUS1NaLCBDUFVf
VFNTX0lTVChcc2hpZnRfaXN0KQotCS5lbmRpZgotCiAJY2FsbAlcZG9fc3ltCiAKLQkuaWYgXHNo
aWZ0X2lzdCAhPSAtMQotCWFkZHEJJEVYQ0VQVElPTl9TVEtTWiwgQ1BVX1RTU19JU1QoXHNoaWZ0
X2lzdCkKLQkuZW5kaWYKLQotCS8qIHRoZXNlIHByb2NlZHVyZXMgZXhwZWN0ICJubyBzd2FwZ3Mi
IGZsYWcgaW4gZWJ4ICovCisJLyogcGFyYW5vaWRfZXhpdCBleHBlY3RzICJubyBzd2FwZ3MiIGZs
YWcgaW4gZWJ4ICovCiAJLmlmIFxwYXJhbm9pZAogCWptcAlwYXJhbm9pZF9leGl0CiAJLmVsc2UK
QEAgLTk4NiwxOCArOTU1LDE0IEBAIGlkdGVudHJ5IHNpbWRfY29wcm9jZXNzb3JfZXJyb3IJCWRv
X3NpbWRfY29wcm9jZXNzb3JfZXJyb3IJaGFzX2Vycm9yX2NvZGU9MAogCSAqIFJlbG9hZCBncyBz
ZWxlY3RvciB3aXRoIGV4Y2VwdGlvbiBoYW5kbGluZwogCSAqIGVkaTogIG5ldyBzZWxlY3Rvcgog
CSAqLwotRU5UUlkobmF0aXZlX2xvYWRfZ3NfaW5kZXgpCitFTlRSWShuYXRpdmVfbG9hZF9nc19p
bmRleF9pcnFzX29mZikKKwlERUJVR19FTlRSWV9BU1NFUlRfSVJRU19PRkYKIAlGUkFNRV9CRUdJ
TgotCXB1c2hmcQotCURJU0FCTEVfSU5URVJSVVBUUyhDTEJSX0FOWSAmIH5DTEJSX1JESSkKLQlU
UkFDRV9JUlFTX09GRgogCVNXQVBHUwogLkxnc19jaGFuZ2U6CiAJbW92bAklZWRpLCAlZ3MKIDI6
CUFMVEVSTkFUSVZFICIiLCAibWZlbmNlIiwgWDg2X0JVR19TV0FQR1NfRkVOQ0UKIAlTV0FQR1MK
LQlUUkFDRV9JUlFTX0ZMQUdTICglcnNwKQotCXBvcGZxCiAJRlJBTUVfRU5ECiAJcmV0CiBFTkRQ
Uk9DKG5hdGl2ZV9sb2FkX2dzX2luZGV4KQpAQCAtMTI0MywxNyArMTIwOCw3IEBAIEVOVFJZKGVy
cm9yX2VudHJ5KQogCUVOQ09ERV9GUkFNRV9QT0lOVEVSCiAJcHVzaHEJJXIxMgogCi0JLyoKLQkg
KiBXZSBuZWVkIHRvIHRlbGwgbG9ja2RlcCB0aGF0IElSUXMgYXJlIG9mZi4gIFdlIGNhbid0IGRv
IHRoaXMgdW50aWwKLQkgKiB3ZSBmaXggZ3NiYXNlLCBhbmQgd2Ugc2hvdWxkIGRvIGl0IGJlZm9y
ZSBlbnRlcl9mcm9tX3VzZXJfbW9kZQotCSAqICh3aGljaCBjYW4gdGFrZSBsb2NrcykuCi0JICov
Ci0JVFJBQ0VfSVJRU19PRkYKLQlDQUxMX2VudGVyX2Zyb21fdXNlcl9tb2RlCi0JcmV0Ci0KIC5M
ZXJyb3JfZW50cnlfZG9uZToKLQlUUkFDRV9JUlFTX09GRgogCXJldAogCiAJLyoKQEAgLTEzMDYs
OCArMTI2MSw3IEBAIEVORChlcnJvcl9lbnRyeSkKIAogRU5UUlkoZXJyb3JfZXhpdCkKIAlVTldJ
TkRfSElOVF9SRUdTCi0JRElTQUJMRV9JTlRFUlJVUFRTKENMQlJfQU5ZKQotCVRSQUNFX0lSUVNf
T0ZGCisJREVCVUdfRU5UUllfQVNTRVJUX0lSUVNfT0ZGCiAJdGVzdGIJJDMsIENTKCVyc3ApCiAJ
anoJcmV0aW50X2tlcm5lbAogCWptcAlyZXRpbnRfdXNlcgo=
--000000000000fc9c8f05849ee24a--
