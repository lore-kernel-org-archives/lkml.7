Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FFFC5B578
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923FF20830
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562458152;
	bh=uDUMNRplJPOpoRlCOq9dBYqEWG5ukdpA2AerXefgfmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G3oe/MZHZSyS3oUiHGCKwsNF+RBWcZO2fm3JTA8KOdFZm+q6PjMu3TT7JbNY0Bdep
	 /dpst3LTA8jya+kw1vvFZCC1ZPblPQ5rITj4K9/Dye5mULEcnwcRE/E0mtcDVcYmvb
	 AFurDDaqT9gB+fXUgBoy0dK5X8c5+k10iBfGCjFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfGGAIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 20:08:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43475 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfGGAIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 20:08:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so12443762ljv.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scpPsW6mAUXoVLt8Kn4PeKq811oedw5fzrQlbMjJCpY=;
        b=G+oUd4wfJSoGtgNHa4aniQAymFR8ZTODrrpYDDWKvvAT1YrndCYcei6L3flSRZXgBd
         QUpo82vvG+iH5qmiH84iaRIHdc5FjR3ElleF4iXAMgN0mw4XLgeTReq+O0ocMMRwfHKX
         Ogar77eefZnUateWBw1DYgSIQsn/YXxYZzz9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scpPsW6mAUXoVLt8Kn4PeKq811oedw5fzrQlbMjJCpY=;
        b=edaEdhRHDc8QdixJxB39h5tXpI/9xJw9zpqRCCzyPbFz/7Vlsk+bmmSB9rBzsJK0Pz
         Lv09mkLgQweXhSl4LbBX8a7xas4xZ9N5N5eocVxwkp+/NrCQR0TAvkhF1YyqNEDFSwxt
         cCGwLAONGXDAB+j+ANw7eWZ8WjVfQFNHMZZCdO4VGTKak1Nr6iIaUVK3FiPZkHqJi3bi
         P9e3PDurV5GBt6bRP8hXIW19AnWcs3kistfJKlcDsjRRWbq/ZBQtLi7s4HJSMiIfb+qx
         0uAxP+IJJcnOryWAmVLehmsfGn9/Z9HzC2TrDjaBEuWSPIQ/V9dQxxJs1DO5Gklh9ofB
         uzqA==
X-Gm-Message-State: APjAAAV3MC3P8yZnvUpixyMdempQctzYJKNHqAwvDolvLcXCSt+fV0BY
        Ag05gjnh8z/9Yu1ALVP76Qp1bkFsZNI=
X-Google-Smtp-Source: APXvYqw2tJrZPIOqFWRRsAv4mx3ZDknodIy1ap5iH3A73H1JWOKTrA+us8GHbi5YNixiiJk1hL5iFA==
X-Received: by 2002:a2e:480a:: with SMTP id v10mr5795615lja.94.1562458120513;
        Sat, 06 Jul 2019 17:08:40 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a70sm2655096ljf.57.2019.07.06.17.08.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 17:08:37 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id p197so8522493lfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 17:08:37 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr5027021lfn.52.1562458116980;
 Sat, 06 Jul 2019 17:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
 <20190705134916.GU3402@hirez.programming.kicks-ass.net> <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com>
 <20190706182728.435a89ed@gandalf.local.home> <CAHk-=wj=vCn1c7O4rpjwnS1fZbEppkeUhAq=ob3+wox0FKNZwQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj=vCn1c7O4rpjwnS1fZbEppkeUhAq=ob3+wox0FKNZwQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Jul 2019 17:08:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOFXr83=A03ORuT5qq5yiQPwN9vMOrYvTMcqdC-wNn8w@mail.gmail.com>
Message-ID: <CAHk-=wjOFXr83=A03ORuT5qq5yiQPwN9vMOrYvTMcqdC-wNn8w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: multipart/mixed; boundary="0000000000000a3535058d0c21d7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000a3535058d0c21d7
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 6, 2019 at 3:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jul 6, 2019 at 3:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > We also have to deal with reading vmalloc'd data as that can fault too.
>
> Ahh, that may be a better reason for PeterZ's patches and reading cr2
> very early from asm code than the stack trace case.

Hmm. Another alternative might be to simply just make our vmalloc page
fault handling more robust.

Right now, if we take a vmalloc page fault in an inconvenient spot, it
is fatal because it corrupts the cr2 in the outer context.

However, it doesn't *need* to be fatal. Who cares if the outer context
cr2 gets corrupted? We probably *shouldn't* care - it's an odd and
unusual case, and the outer context could just handle the wrong
vmalloc-address cr2 fine (it's going to be a no-op, since the inner
page fault will have handled it already), return, and then re-fault.

The only reason it's fatal right now is that we care much too deeply about

 (a) the error code
 (b) the pt_regs state

when we handle vmalloc faults.

So one option is that we simply handle the vmalloc faults _without_
caring about the error code and the pt_regs state, because even if the
error code or the pt_regs implies that the fault comes from user
space, the cr2 value might be due to a vmalloc fault from the inner
kernel page fault that corrupted cr2.

Right now vmalloc faults are already special and need to be handled
without holding any locks etc. We'd just make them even more special,
and say that we might have a vmalloc area fault from any context.

IOW, somethinig like the attached patch would make nesting vmalloc
faults harmless. Sure, we'll do the "vmalloc fault" twice, and return
and re-do the original page fault, but this is a very unusual case, so
from a performance angle we don't really care.

But I guess the "read cr2 early" is fine too..

               Linus

--0000000000000a3535058d0c21d7
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jxs77kj10>
X-Attachment-Id: f_jxs77kj10

IGFyY2gveDg2L21tL2ZhdWx0LmMgfCAzMiArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvbW0vZmF1bHQuYyBiL2FyY2gveDg2L21tL2ZhdWx0LmMKaW5kZXgg
NDZkZjRjNmFhZTQ2Li4zYTAzNTA0YmM2MjQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L21tL2ZhdWx0
LmMKKysrIGIvYXJjaC94ODYvbW0vZmF1bHQuYwpAQCAtMTI0NSw2ICsxMjQ1LDE1IEBAIHN0YXRp
YyB2b2lkCiBkb19rZXJuX2FkZHJfZmF1bHQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVk
IGxvbmcgaHdfZXJyb3JfY29kZSwKIAkJICAgdW5zaWduZWQgbG9uZyBhZGRyZXNzKQogeworCS8q
CisJICogVGhlIGtlcm5lbCB2bWFsbG9jIGFyZWEgY2FuIGZhdWx0IGluIGF0IGFueSB0aW1lLCBh
bmQKKwkgKiB3ZSBzaG91bGQgbm90IGNoZWNrIHRoZSBodyBlcnJvciBjb2RlLCBzaW5jZSB0aGUg
Y3IyIHZhbHVlCisJICogY291bGQgYmUgYSBzdGFsZSBvbmUgZnJvbSBhIG5lc3RlZCB2bWFsbG9j
IGZhdWx0LCBidXQgdGhlCisJICogZXJyb3IgY29kZSBnb3QgcHVzaGVkIGJ5IGhhcmR3YXJlLgor
CSAqLworCWlmICh2bWFsbG9jX2ZhdWx0KGFkZHJlc3MpID49IDApCisJCXJldHVybjsKKwogCS8q
CiAJICogUHJvdGVjdGlvbiBrZXlzIGV4Y2VwdGlvbnMgb25seSBoYXBwZW4gb24gdXNlciBwYWdl
cy4gIFdlCiAJICogaGF2ZSBubyB1c2VyIHBhZ2VzIGluIHRoZSBrZXJuZWwgcG9ydGlvbiBvZiB0
aGUgYWRkcmVzcwpAQCAtMTI1MiwyOSArMTI2MSw2IEBAIGRvX2tlcm5fYWRkcl9mYXVsdChzdHJ1
Y3QgcHRfcmVncyAqcmVncywgdW5zaWduZWQgbG9uZyBod19lcnJvcl9jb2RlLAogCSAqLwogCVdB
Uk5fT05fT05DRShod19lcnJvcl9jb2RlICYgWDg2X1BGX1BLKTsKIAotCS8qCi0JICogV2UgY2Fu
IGZhdWx0LWluIGtlcm5lbC1zcGFjZSB2aXJ0dWFsIG1lbW9yeSBvbi1kZW1hbmQuIFRoZQotCSAq
ICdyZWZlcmVuY2UnIHBhZ2UgdGFibGUgaXMgaW5pdF9tbS5wZ2QuCi0JICoKLQkgKiBOT1RFISBX
ZSBNVVNUIE5PVCB0YWtlIGFueSBsb2NrcyBmb3IgdGhpcyBjYXNlLiBXZSBtYXkKLQkgKiBiZSBp
biBhbiBpbnRlcnJ1cHQgb3IgYSBjcml0aWNhbCByZWdpb24sIGFuZCBzaG91bGQKLQkgKiBvbmx5
IGNvcHkgdGhlIGluZm9ybWF0aW9uIGZyb20gdGhlIG1hc3RlciBwYWdlIHRhYmxlLAotCSAqIG5v
dGhpbmcgbW9yZS4KLQkgKgotCSAqIEJlZm9yZSBkb2luZyB0aGlzIG9uLWRlbWFuZCBmYXVsdGlu
ZywgZW5zdXJlIHRoYXQgdGhlCi0JICogZmF1bHQgaXMgbm90IGFueSBvZiB0aGUgZm9sbG93aW5n
OgotCSAqIDEuIEEgZmF1bHQgb24gYSBQVEUgd2l0aCBhIHJlc2VydmVkIGJpdCBzZXQuCi0JICog
Mi4gQSBmYXVsdCBjYXVzZWQgYnkgYSB1c2VyLW1vZGUgYWNjZXNzLiAgKERvIG5vdCBkZW1hbmQt
Ci0JICogICAgZmF1bHQga2VybmVsIG1lbW9yeSBkdWUgdG8gdXNlci1tb2RlIGFjY2Vzc2VzKS4K
LQkgKiAzLiBBIGZhdWx0IGNhdXNlZCBieSBhIHBhZ2UtbGV2ZWwgcHJvdGVjdGlvbiB2aW9sYXRp
b24uCi0JICogICAgKEEgZGVtYW5kIGZhdWx0IHdvdWxkIGJlIG9uIGEgbm9uLXByZXNlbnQgcGFn
ZSB3aGljaAotCSAqICAgICB3b3VsZCBoYXZlIFg4Nl9QRl9QUk9UPT0wKS4KLQkgKi8KLQlpZiAo
IShod19lcnJvcl9jb2RlICYgKFg4Nl9QRl9SU1ZEIHwgWDg2X1BGX1VTRVIgfCBYODZfUEZfUFJP
VCkpKSB7Ci0JCWlmICh2bWFsbG9jX2ZhdWx0KGFkZHJlc3MpID49IDApCi0JCQlyZXR1cm47Ci0J
fQotCiAJLyogV2FzIHRoZSBmYXVsdCBzcHVyaW91cywgY2F1c2VkIGJ5IGxhenkgVExCIGludmFs
aWRhdGlvbj8gKi8KIAlpZiAoc3B1cmlvdXNfa2VybmVsX2ZhdWx0KGh3X2Vycm9yX2NvZGUsIGFk
ZHJlc3MpKQogCQlyZXR1cm47Cg==
--0000000000000a3535058d0c21d7--
