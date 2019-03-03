Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A7C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EA420830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551652326;
	bh=owIPPZIVqiUuEyL/5/ZsvWfi9KD7RUFbCpzzDyG4kKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d35IDA+jGLgMD8Y93qiiIKTr1gK88+Ym7jElRm5QUp6KWuH41E6kGy2pHiOsXKcwO
	 ltMCCFZsywASJwBPDk3+HyoiMhxcHCMkjlQ6Gg/E5MEcPA7Tu5J7WEuE9SkfizQcmE
	 53/aSmdk0JCgiwPz0cEyEIKpsBZnfCLdNsmcdvc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfCCWbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:31:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36859 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 17:31:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id x206so2128077lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 14:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1X9ul5ErGmVL2MQ+STdM2MNKra3uw9gdOqsAoRqUVo=;
        b=Adw17k3G5eosGfOpmC9cx6r1I1b8LBMmByjpn0dIsi1a9o1GWAEm7hsxJgfPovjwAg
         mRZqn+29mDlH/0hameNwxJ+qug3i0KS2bqT2IjdnpS1AGZWuIC5E1DMsA4f4smvyuHMh
         9d9mcLKnueIKixyxG4JUTBTnOglnmEp0TErBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1X9ul5ErGmVL2MQ+STdM2MNKra3uw9gdOqsAoRqUVo=;
        b=QJhedfBavI4CaAFT2zP+/P/PBC7miEkI6BvTdMqpxsw9Jp+hdqifC2E2me/uDTjY2X
         qdcq6Xyce5UC6sPYR6yhRDcvNagzo8qVkON96m8PodChXJGqLk0vQQB6Clvzh8txsiXl
         Q+wYxcrbA98DDqFQTcIGVyE6DsuZcEPKyBmGA6pkqWkOkL0mt57rJmes2r3aEUO6I6Pi
         xCazMx2fspFEfQfAEZNm43WYXzmKdX5zgTEwseKihbLatYjWmDUOyKEjrm5dshEvN6ao
         vQXSvXV349oXwjegzkZn/t385FccWJKMOAj9KB61ejZWG1KvVesU6yLd+kcXgS954lIb
         IdZQ==
X-Gm-Message-State: APjAAAWFl+hA4ML8u23V0OkIP1hyNkmsFoiFZvFepMjoPaQYp5h2ZX7z
        j4iNT0Z6H8uHldmai3FVZXyXiKcpuX0=
X-Google-Smtp-Source: APXvYqy156A/8bMoa+ZZH3LSqssiE0b3TznU/4v17IwdbRv1LiIz9V9vMxbRs3qKar7AVhdBucOT5g==
X-Received: by 2002:ac2:4142:: with SMTP id c2mr328698lfi.84.1551652268019;
        Sun, 03 Mar 2019 14:31:08 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y15sm1169386lje.23.2019.03.03.14.31.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 14:31:07 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id d14so2625396ljl.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 14:31:07 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr9026443ljc.22.1551651829446;
 Sun, 03 Mar 2019 14:23:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f39c7b05832e0219@google.com> <20190303135502.GP2217@ZenIV.linux.org.uk>
 <20190303151846.GQ2217@ZenIV.linux.org.uk> <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
 <20190303203011.GR2217@ZenIV.linux.org.uk>
In-Reply-To: <20190303203011.GR2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 14:23:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=widuz9QBY-Xhpc1YHf=EV1uRGyOv-v-BNSa1zW-nCCC6Q@mail.gmail.com>
Message-ID: <CAHk-=widuz9QBY-Xhpc1YHf=EV1uRGyOv-v-BNSa1zW-nCCC6Q@mail.gmail.com>
Subject: Re: [PATCH] aio: prevent the final fput() in the middle of vfs_poll()
 (Re: KASAN: use-after-free Read in unix_dgram_poll)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary="0000000000001c2b9d0583381897"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001c2b9d0583381897
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 3, 2019 at 12:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Mar 03, 2019 at 11:44:33AM -0800, Linus Torvalds wrote:
> >
> > I'm assuming you're talking about the second vfs_poll() in
> > aio_poll_complete_work()? The one we call before we check for
> > "rew->cancelled" properly under the spinlock?
>
> No.  The first one, right in aio_poll().

Ok, they are both confusing. The lifetime of that filp is just not
clear, with the whole "it could have been completed asynchronously"
issue.

> I'll need to dig out the mail archive from last year, but IIRC this
> had been considered and there'd been non-trivial problems.  Give me
> an hour or so and I'll dig that out (there'd been many rounds of
> review, with long threads involved, some private, some on fsdevel).

Looking more at the patch, it still looks eminently sane to me.I fixed
the silly "ki_filp" thing you noticed (I thought we made fput() take
NULL, but you're right we don't), and simplified the patch to not do
the changes that aren't necessary.

I fixed the silly "filp can be NULL" issue you pointed out (I lazily
thought we allowed fput(NULL), but you're right, we definitely don't),
and simplified the patch to not do the unnecessary changes where we
can just access the file pointer multiple different ways.

And the resulting kernel boots fine, but I doubt I have anything that
actually uses io_submit(), so that doesn't mean much.

Slightly updated patch attached anyway, even smaller than before:

 2 files changed, 36 insertions(+), 44 deletions(-)

with several of the new lines being comments about that file pointer
placement in the union.

                Linus

--0000000000001c2b9d0583381897
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jsthex0j0>
X-Attachment-Id: f_jsthex0j0

IGZzL2Fpby5jICAgICAgICAgICB8IDcyICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9saW51eC9mcy5oIHwgIDggKysrKystCiAy
IGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDQ0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL2Fpby5jIGIvZnMvYWlvLmMKaW5kZXggYWFhYWY0ZDEyYzczLi44MmMwODQyMmIw
ZjQgMTAwNjQ0Ci0tLSBhL2ZzL2Fpby5jCisrKyBiL2ZzL2Fpby5jCkBAIC0xNjcsOSArMTY3LDEz
IEBAIHN0cnVjdCBraW9jdHggewogCXVuc2lnbmVkCQlpZDsKIH07CiAKKy8qCisgKiBGaXJzdCBm
aWVsZCBtdXN0IGJlIHRoZSBmaWxlIHBvaW50ZXIgaW4gYWxsIHRoZQorICogaW9jYiB1bmlvbnMh
IFNlZSBhbHNvICdzdHJ1Y3Qga2lvY2InIGluIDxsaW51eC9mcy5oPgorICovCiBzdHJ1Y3QgZnN5
bmNfaW9jYiB7Ci0Jc3RydWN0IHdvcmtfc3RydWN0CXdvcms7CiAJc3RydWN0IGZpbGUJCSpmaWxl
OworCXN0cnVjdCB3b3JrX3N0cnVjdAl3b3JrOwogCWJvb2wJCQlkYXRhc3luYzsKIH07CiAKQEAg
LTE4Myw4ICsxODcsMTUgQEAgc3RydWN0IHBvbGxfaW9jYiB7CiAJc3RydWN0IHdvcmtfc3RydWN0
CXdvcms7CiB9OwogCisvKgorICogTk9URSEgRWFjaCBvZiB0aGUgaW9jYiB1bmlvbiBtZW1iZXJz
IGhhcyB0aGUgZmlsZSBwb2ludGVyCisgKiBhcyB0aGUgZmlyc3QgZW50cnkgaW4gdGhlaXIgc3Ry
dWN0IGRlZmluaXRpb24uIFNvIHlvdSBjYW4KKyAqIGFjY2VzcyB0aGUgZmlsZSBwb2ludGVyIHRo
cm91Z2ggYW55IG9mIHRoZSBzdWItc3RydWN0cywKKyAqIG9yIGRpcmVjdGx5IGFzIGp1c3QgJ2tp
X2ZpbHAnIGluIHRoaXMgc3RydWN0LgorICovCiBzdHJ1Y3QgYWlvX2tpb2NiIHsKIAl1bmlvbiB7
CisJCXN0cnVjdCBmaWxlCQkqa2lfZmlscDsKIAkJc3RydWN0IGtpb2NiCQlydzsKIAkJc3RydWN0
IGZzeW5jX2lvY2IJZnN5bmM7CiAJCXN0cnVjdCBwb2xsX2lvY2IJcG9sbDsKQEAgLTEwNjAsNiAr
MTA3MSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpb2NiX3B1dChzdHJ1Y3QgYWlvX2tpb2NiICpp
b2NiKQogewogCWlmIChyZWZjb3VudF9yZWFkKCZpb2NiLT5raV9yZWZjbnQpID09IDAgfHwKIAkg
ICAgcmVmY291bnRfZGVjX2FuZF90ZXN0KCZpb2NiLT5raV9yZWZjbnQpKSB7CisJCWlmIChpb2Ni
LT5raV9maWxwKQorCQkJZnB1dChpb2NiLT5raV9maWxwKTsKIAkJcGVyY3B1X3JlZl9wdXQoJmlv
Y2ItPmtpX2N0eC0+cmVxcyk7CiAJCWttZW1fY2FjaGVfZnJlZShraW9jYl9jYWNoZXAsIGlvY2Ip
OwogCX0KQEAgLTE0MjQsNyArMTQzNyw2IEBAIHN0YXRpYyB2b2lkIGFpb19jb21wbGV0ZV9ydyhz
dHJ1Y3Qga2lvY2IgKmtpb2NiLCBsb25nIHJlcywgbG9uZyByZXMyKQogCQlmaWxlX2VuZF93cml0
ZShraW9jYi0+a2lfZmlscCk7CiAJfQogCi0JZnB1dChraW9jYi0+a2lfZmlscCk7CiAJYWlvX2Nv
bXBsZXRlKGlvY2IsIHJlcywgcmVzMik7CiB9CiAKQEAgLTE0MzIsOSArMTQ0NCw2IEBAIHN0YXRp
YyBpbnQgYWlvX3ByZXBfcncoc3RydWN0IGtpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBpb2NiICpp
b2NiKQogewogCWludCByZXQ7CiAKLQlyZXEtPmtpX2ZpbHAgPSBmZ2V0KGlvY2ItPmFpb19maWxk
ZXMpOwotCWlmICh1bmxpa2VseSghcmVxLT5raV9maWxwKSkKLQkJcmV0dXJuIC1FQkFERjsKIAly
ZXEtPmtpX2NvbXBsZXRlID0gYWlvX2NvbXBsZXRlX3J3OwogCXJlcS0+cHJpdmF0ZSA9IE5VTEw7
CiAJcmVxLT5raV9wb3MgPSBpb2NiLT5haW9fb2Zmc2V0OwpAQCAtMTQ1MSw3ICsxNDYwLDcgQEAg
c3RhdGljIGludCBhaW9fcHJlcF9ydyhzdHJ1Y3Qga2lvY2IgKnJlcSwgY29uc3Qgc3RydWN0IGlv
Y2IgKmlvY2IpCiAJCXJldCA9IGlvcHJpb19jaGVja19jYXAoaW9jYi0+YWlvX3JlcXByaW8pOwog
CQlpZiAocmV0KSB7CiAJCQlwcl9kZWJ1ZygiYWlvIGlvcHJpbyBjaGVjayBjYXAgZXJyb3I6ICVk
XG4iLCByZXQpOwotCQkJZ290byBvdXRfZnB1dDsKKwkJCXJldHVybiByZXQ7CiAJCX0KIAogCQly
ZXEtPmtpX2lvcHJpbyA9IGlvY2ItPmFpb19yZXFwcmlvOwpAQCAtMTQ2MCwxNCArMTQ2OSwxMCBA
QCBzdGF0aWMgaW50IGFpb19wcmVwX3J3KHN0cnVjdCBraW9jYiAqcmVxLCBjb25zdCBzdHJ1Y3Qg
aW9jYiAqaW9jYikKIAogCXJldCA9IGtpb2NiX3NldF9yd19mbGFncyhyZXEsIGlvY2ItPmFpb19y
d19mbGFncyk7CiAJaWYgKHVubGlrZWx5KHJldCkpCi0JCWdvdG8gb3V0X2ZwdXQ7CisJCXJldHVy
biByZXQ7CiAKIAlyZXEtPmtpX2ZsYWdzICY9IH5JT0NCX0hJUFJJOyAvKiBubyBvbmUgaXMgZ29p
bmcgdG8gcG9sbCBmb3IgdGhpcyBJL08gKi8KIAlyZXR1cm4gMDsKLQotb3V0X2ZwdXQ6Ci0JZnB1
dChyZXEtPmtpX2ZpbHApOwotCXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyBpbnQgYWlvX3NldHVw
X3J3KGludCBydywgY29uc3Qgc3RydWN0IGlvY2IgKmlvY2IsIHN0cnVjdCBpb3ZlYyAqKmlvdmVj
LApAQCAtMTUyMSwyNCArMTUyNiwxOSBAQCBzdGF0aWMgc3NpemVfdCBhaW9fcmVhZChzdHJ1Y3Qg
a2lvY2IgKnJlcSwgY29uc3Qgc3RydWN0IGlvY2IgKmlvY2IsCiAJaWYgKHJldCkKIAkJcmV0dXJu
IHJldDsKIAlmaWxlID0gcmVxLT5raV9maWxwOwotCi0JcmV0ID0gLUVCQURGOwogCWlmICh1bmxp
a2VseSghKGZpbGUtPmZfbW9kZSAmIEZNT0RFX1JFQUQpKSkKLQkJZ290byBvdXRfZnB1dDsKKwkJ
cmV0dXJuIC1FQkFERjsKIAlyZXQgPSAtRUlOVkFMOwogCWlmICh1bmxpa2VseSghZmlsZS0+Zl9v
cC0+cmVhZF9pdGVyKSkKLQkJZ290byBvdXRfZnB1dDsKKwkJcmV0dXJuIC1FSU5WQUw7CiAKIAly
ZXQgPSBhaW9fc2V0dXBfcncoUkVBRCwgaW9jYiwgJmlvdmVjLCB2ZWN0b3JlZCwgY29tcGF0LCAm
aXRlcik7CiAJaWYgKHJldCkKLQkJZ290byBvdXRfZnB1dDsKKwkJcmV0dXJuIHJldDsKIAlyZXQg
PSByd192ZXJpZnlfYXJlYShSRUFELCBmaWxlLCAmcmVxLT5raV9wb3MsIGlvdl9pdGVyX2NvdW50
KCZpdGVyKSk7CiAJaWYgKCFyZXQpCiAJCWFpb19yd19kb25lKHJlcSwgY2FsbF9yZWFkX2l0ZXIo
ZmlsZSwgcmVxLCAmaXRlcikpOwogCWtmcmVlKGlvdmVjKTsKLW91dF9mcHV0OgotCWlmICh1bmxp
a2VseShyZXQpKQotCQlmcHV0KGZpbGUpOwogCXJldHVybiByZXQ7CiB9CiAKQEAgLTE1NTUsMTYg
KzE1NTUsMTQgQEAgc3RhdGljIHNzaXplX3QgYWlvX3dyaXRlKHN0cnVjdCBraW9jYiAqcmVxLCBj
b25zdCBzdHJ1Y3QgaW9jYiAqaW9jYiwKIAkJcmV0dXJuIHJldDsKIAlmaWxlID0gcmVxLT5raV9m
aWxwOwogCi0JcmV0ID0gLUVCQURGOwogCWlmICh1bmxpa2VseSghKGZpbGUtPmZfbW9kZSAmIEZN
T0RFX1dSSVRFKSkpCi0JCWdvdG8gb3V0X2ZwdXQ7Ci0JcmV0ID0gLUVJTlZBTDsKKwkJcmV0dXJu
IC1FQkFERjsKIAlpZiAodW5saWtlbHkoIWZpbGUtPmZfb3AtPndyaXRlX2l0ZXIpKQotCQlnb3Rv
IG91dF9mcHV0OworCQlyZXR1cm4gLUVJTlZBTDsKIAogCXJldCA9IGFpb19zZXR1cF9ydyhXUklU
RSwgaW9jYiwgJmlvdmVjLCB2ZWN0b3JlZCwgY29tcGF0LCAmaXRlcik7CiAJaWYgKHJldCkKLQkJ
Z290byBvdXRfZnB1dDsKKwkJcmV0dXJuIHJldDsKIAlyZXQgPSByd192ZXJpZnlfYXJlYShXUklU
RSwgZmlsZSwgJnJlcS0+a2lfcG9zLCBpb3ZfaXRlcl9jb3VudCgmaXRlcikpOwogCWlmICghcmV0
KSB7CiAJCS8qCkBAIC0xNTgyLDkgKzE1ODAsNiBAQCBzdGF0aWMgc3NpemVfdCBhaW9fd3JpdGUo
c3RydWN0IGtpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBpb2NiICppb2NiLAogCQlhaW9fcndfZG9u
ZShyZXEsIGNhbGxfd3JpdGVfaXRlcihmaWxlLCByZXEsICZpdGVyKSk7CiAJfQogCWtmcmVlKGlv
dmVjKTsKLW91dF9mcHV0OgotCWlmICh1bmxpa2VseShyZXQpKQotCQlmcHV0KGZpbGUpOwogCXJl
dHVybiByZXQ7CiB9CiAKQEAgLTE1OTQsNyArMTU4OSw2IEBAIHN0YXRpYyB2b2lkIGFpb19mc3lu
Y193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAlpbnQgcmV0OwogCiAJcmV0ID0gdmZz
X2ZzeW5jKHJlcS0+ZmlsZSwgcmVxLT5kYXRhc3luYyk7Ci0JZnB1dChyZXEtPmZpbGUpOwogCWFp
b19jb21wbGV0ZShjb250YWluZXJfb2YocmVxLCBzdHJ1Y3QgYWlvX2tpb2NiLCBmc3luYyksIHJl
dCwgMCk7CiB9CiAKQEAgLTE2MDUsMTMgKzE1OTksOCBAQCBzdGF0aWMgaW50IGFpb19mc3luYyhz
dHJ1Y3QgZnN5bmNfaW9jYiAqcmVxLCBjb25zdCBzdHJ1Y3QgaW9jYiAqaW9jYiwKIAkJCWlvY2It
PmFpb19yd19mbGFncykpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JcmVxLT5maWxlID0gZmdldChp
b2NiLT5haW9fZmlsZGVzKTsKLQlpZiAodW5saWtlbHkoIXJlcS0+ZmlsZSkpCi0JCXJldHVybiAt
RUJBREY7Ci0JaWYgKHVubGlrZWx5KCFyZXEtPmZpbGUtPmZfb3AtPmZzeW5jKSkgewotCQlmcHV0
KHJlcS0+ZmlsZSk7CisJaWYgKHVubGlrZWx5KCFyZXEtPmZpbGUtPmZfb3AtPmZzeW5jKSkKIAkJ
cmV0dXJuIC1FSU5WQUw7Ci0JfQogCiAJcmVxLT5kYXRhc3luYyA9IGRhdGFzeW5jOwogCUlOSVRf
V09SSygmcmVxLT53b3JrLCBhaW9fZnN5bmNfd29yayk7CkBAIC0xNjIxLDEwICsxNjEwLDcgQEAg
c3RhdGljIGludCBhaW9fZnN5bmMoc3RydWN0IGZzeW5jX2lvY2IgKnJlcSwgY29uc3Qgc3RydWN0
IGlvY2IgKmlvY2IsCiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBhaW9fcG9sbF9jb21wbGV0ZShzdHJ1
Y3QgYWlvX2tpb2NiICppb2NiLCBfX3BvbGxfdCBtYXNrKQogewotCXN0cnVjdCBmaWxlICpmaWxl
ID0gaW9jYi0+cG9sbC5maWxlOwotCiAJYWlvX2NvbXBsZXRlKGlvY2IsIG1hbmdsZV9wb2xsKG1h
c2spLCAwKTsKLQlmcHV0KGZpbGUpOwogfQogCiBzdGF0aWMgdm9pZCBhaW9fcG9sbF9jb21wbGV0
ZV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKQEAgLTE3NDMsOSArMTcyOSw2IEBAIHN0
YXRpYyBzc2l6ZV90IGFpb19wb2xsKHN0cnVjdCBhaW9fa2lvY2IgKmFpb2NiLCBjb25zdCBzdHJ1
Y3QgaW9jYiAqaW9jYikKIAogCUlOSVRfV09SSygmcmVxLT53b3JrLCBhaW9fcG9sbF9jb21wbGV0
ZV93b3JrKTsKIAlyZXEtPmV2ZW50cyA9IGRlbWFuZ2xlX3BvbGwoaW9jYi0+YWlvX2J1ZikgfCBF
UE9MTEVSUiB8IEVQT0xMSFVQOwotCXJlcS0+ZmlsZSA9IGZnZXQoaW9jYi0+YWlvX2ZpbGRlcyk7
Ci0JaWYgKHVubGlrZWx5KCFyZXEtPmZpbGUpKQotCQlyZXR1cm4gLUVCQURGOwogCiAJcmVxLT5o
ZWFkID0gTlVMTDsKIAlyZXEtPndva2VuID0gZmFsc2U7CkBAIC0xNzg4LDEwICsxNzcxLDggQEAg
c3RhdGljIHNzaXplX3QgYWlvX3BvbGwoc3RydWN0IGFpb19raW9jYiAqYWlvY2IsIGNvbnN0IHN0
cnVjdCBpb2NiICppb2NiKQogCXNwaW5fdW5sb2NrX2lycSgmY3R4LT5jdHhfbG9jayk7CiAKIG91
dDoKLQlpZiAodW5saWtlbHkoYXB0LmVycm9yKSkgewotCQlmcHV0KHJlcS0+ZmlsZSk7CisJaWYg
KHVubGlrZWx5KGFwdC5lcnJvcikpCiAJCXJldHVybiBhcHQuZXJyb3I7Ci0JfQogCiAJaWYgKG1h
c2spCiAJCWFpb19wb2xsX2NvbXBsZXRlKGFpb2NiLCBtYXNrKTsKQEAgLTE4MjksNiArMTgxMCwx
MSBAQCBzdGF0aWMgaW50IF9faW9fc3VibWl0X29uZShzdHJ1Y3Qga2lvY3R4ICpjdHgsIGNvbnN0
IHN0cnVjdCBpb2NiICppb2NiLAogCWlmICh1bmxpa2VseSghcmVxKSkKIAkJZ290byBvdXRfcHV0
X3JlcXNfYXZhaWxhYmxlOwogCisJcmVxLT5raV9maWxwID0gZmdldChpb2NiLT5haW9fZmlsZGVz
KTsKKwlyZXQgPSAtRUJBREY7CisJaWYgKHVubGlrZWx5KCFyZXEtPmtpX2ZpbHApKQorCQlnb3Rv
IG91dF9wdXRfcmVxOworCiAJaWYgKGlvY2ItPmFpb19mbGFncyAmIElPQ0JfRkxBR19SRVNGRCkg
ewogCQkvKgogCQkgKiBJZiB0aGUgSU9DQl9GTEFHX1JFU0ZEIGZsYWcgb2YgYWlvX2ZsYWdzIGlz
IHNldCwgZ2V0IGFuCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xp
bnV4L2ZzLmgKaW5kZXggMjlkOGUyY2ZlZDBlLi5mZDQyM2ZlYzhkODMgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgKQEAgLTMwNCwxMyArMzA0
LDE5IEBAIGVudW0gcndfaGludCB7CiAKIHN0cnVjdCBraW9jYiB7CiAJc3RydWN0IGZpbGUJCSpr
aV9maWxwOworCisJLyogVGhlICdraV9maWxwJyBwb2ludGVyIGlzIHNoYXJlZCBpbiBhIHVuaW9u
IGZvciBhaW8gKi8KKwlyYW5kb21pemVkX3N0cnVjdF9maWVsZHNfc3RhcnQKKwogCWxvZmZfdAkJ
CWtpX3BvczsKIAl2b2lkICgqa2lfY29tcGxldGUpKHN0cnVjdCBraW9jYiAqaW9jYiwgbG9uZyBy
ZXQsIGxvbmcgcmV0Mik7CiAJdm9pZAkJCSpwcml2YXRlOwogCWludAkJCWtpX2ZsYWdzOwogCXUx
NgkJCWtpX2hpbnQ7CiAJdTE2CQkJa2lfaW9wcmlvOyAvKiBTZWUgbGludXgvaW9wcmlvLmggKi8K
LX0gX19yYW5kb21pemVfbGF5b3V0OworCisJcmFuZG9taXplZF9zdHJ1Y3RfZmllbGRzX2VuZAor
fTsKIAogc3RhdGljIGlubGluZSBib29sIGlzX3N5bmNfa2lvY2Ioc3RydWN0IGtpb2NiICpraW9j
YikKIHsK
--0000000000001c2b9d0583381897--
