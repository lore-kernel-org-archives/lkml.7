Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6501DC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC0320842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551642304;
	bh=RHCrnyYQ+/uGHKC7kS2nc2rKWItWCmsUY/Vo/lZvOkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OTSIcAYLRcZwIOOT796dvxjRjH8l2kZv3Y2gSjA1sVcTmMY7fE9or1yqX2y8zCzM0
	 yFryi2Bm9kfWfzGiEhrL2KPJXmbeb/aFyRFQcfsTzmEC65dViz3DefUqLtTlNcSl2q
	 TqqQkIsY4vWeF5GCWCQAD5AnPPAnEftXhLbxMyT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCCTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 14:44:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34921 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfCCToz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 14:44:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id t13so2448603lji.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emLBRT+ePEbJqGEmTcgW7jivCqu7pM8mOi3WlpQY2C0=;
        b=Ag3xMzs24KITHNppQe/HMUfmo695AYEwkT2nWpk2UlQYfutvKGrDpImbCeG05mf4Ep
         ucbTfKuLfNQ+uFBfwt77MFo6wux2gwFWeOTQfDaMkV9stX0xBZi60NPbRWr6J9ngnBIl
         0CBHY2/ON9JuTwPmB47pQYraqi4Fj6gm/vuUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emLBRT+ePEbJqGEmTcgW7jivCqu7pM8mOi3WlpQY2C0=;
        b=XqmNf0rrCJWYIDQ2YFoHFukXL6EquP2d91AKXElzEHTatnse9tOMr0docesEvJKMwA
         Z/oOWVWnFjuhbLCcR7HVvy1bUefvHwWAgHiVMWr6CD24/9PA2mYjX5m5rof31nvFj7g8
         PtmgkGIIp2kitnsoovMHmBkbI+z5ChJrYeZsAgn1G6iEgQdiJChbtPdJUYFOTeyHMObY
         xzNGN1U1wGbDkf0IcMSUx01Nz1RojPfxMRm7+xnbxvwDvH6VtyfG7tJwDvOm2XMaXLwX
         j/0RKVRgtA9OU6bkZialSkgC6P5UnDUlYgkzXpwbl3zusMt5ry+a+lTqk47sk+db+DAJ
         8UwA==
X-Gm-Message-State: APjAAAXLoTqGa1FFdYs8U/EuqB3zHuTSs241C4fy77HbrzCHwf7nT72l
        xBy+WPVUR4mns5i+aW4FY+6GcfqPa5I=
X-Google-Smtp-Source: APXvYqw9cSQx3W6w0CQeVDt5oCi8Cv/oQd1NH9qdgjF+84vgrD9ZoEnQH4dGjdFths1e5C5ITQbqBQ==
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr8809994ljc.22.1551642291904;
        Sun, 03 Mar 2019 11:44:51 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id p27sm1193850lfh.0.2019.03.03.11.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 11:44:50 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id f16so1955434lfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 11:44:50 -0800 (PST)
X-Received: by 2002:ac2:5088:: with SMTP id f8mr6855485lfm.11.1551642289908;
 Sun, 03 Mar 2019 11:44:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f39c7b05832e0219@google.com> <20190303135502.GP2217@ZenIV.linux.org.uk>
 <20190303151846.GQ2217@ZenIV.linux.org.uk>
In-Reply-To: <20190303151846.GQ2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 11:44:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
Message-ID: <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
Subject: Re: [PATCH] aio: prevent the final fput() in the middle of vfs_poll()
 (Re: KASAN: use-after-free Read in unix_dgram_poll)
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary="0000000000008261ee058335df7d"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008261ee058335df7d
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 3, 2019 at 7:18 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > Maybe unrelated to this bug, but...  What's to prevent a wakeup
> > that happens just after we'd been added to a waitqueue by ->poll()
> > triggering aio_poll_wake(), which gets to aio_poll_complete()
> > with its fput() *before* we'd reached the end of ->poll() instance?

I'm assuming you're talking about the second vfs_poll() in
aio_poll_complete_work()? The one we call before we check for
"rew->cancelled" properly under the spinlock?

> 1) io_submit(2) allocates aio_kiocb instance and passes it to aio_poll()
> 2) aio_poll() resolves the descriptor to struct file by
>         req->file = fget(iocb->aio_fildes)
[...]

So honestly, the whole filp handling in aio looks overly complicated to me.

All the different operations do that silly fget/fput() dance, although
aio_read/write at least tried to make a common helper function for
handling it.

But as far as I can tell, they *all* could do:

 - look up file in aio_submit() when allocating and creating the aio_kiocb

 - drop the filp in 'iocb_put()' (which happens whether things
complete successfully or not).

and we'd have avoided a lot of complexity, and we'd have avoided this bug.

Your patch fixes the poll() case, but it does so by just letting the
existing complexity remain, and adding a second fget/fput pair in the
poll logic.

It would seem like it would be much better to rip all the complexity
out entirely, and replace it with sane, simple and obviously correct
code.

Hmm?

In other words, why wouldn't something like the attached work instead?

TOTALLY UNTESTED! It builds, and it looks sane, but maybe I'm
overlooking some obvious problem with it. But doesn't it look nice to
see

 2 files changed, 41 insertions(+), 50 deletions(-)

with actual code reduction, and a fundamental simplification in
handling of the file pointer?

                 Linus

--0000000000008261ee058335df7d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jstbqupx0>
X-Attachment-Id: f_jstbqupx0

IGZzL2Fpby5jICAgICAgICAgICB8IDgzICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9saW51eC9mcy5oIHwgIDggKysrKystCiAy
IGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDUwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL2Fpby5jIGIvZnMvYWlvLmMKaW5kZXggYWFhYWY0ZDEyYzczLi45ZWNjZDJlYTZj
YTkgMTAwNjQ0Ci0tLSBhL2ZzL2Fpby5jCisrKyBiL2ZzL2Fpby5jCkBAIC0xNjcsMTQgKzE2Nywx
OCBAQCBzdHJ1Y3Qga2lvY3R4IHsKIAl1bnNpZ25lZAkJaWQ7CiB9OwogCisvKgorICogRmlyc3Qg
ZmllbGQgbXVzdCBiZSAna2lfZmlscCcgaW4gYWxsIHRoZQorICogaW9jYiB1bmlvbnMhCisgKi8K
IHN0cnVjdCBmc3luY19pb2NiIHsKKwlzdHJ1Y3QgZmlsZQkJKmtpX2ZpbHA7CiAJc3RydWN0IHdv
cmtfc3RydWN0CXdvcms7Ci0Jc3RydWN0IGZpbGUJCSpmaWxlOwogCWJvb2wJCQlkYXRhc3luYzsK
IH07CiAKIHN0cnVjdCBwb2xsX2lvY2IgewotCXN0cnVjdCBmaWxlCQkqZmlsZTsKKwlzdHJ1Y3Qg
ZmlsZQkJKmtpX2ZpbHA7CiAJc3RydWN0IHdhaXRfcXVldWVfaGVhZAkqaGVhZDsKIAlfX3BvbGxf
dAkJZXZlbnRzOwogCWJvb2wJCQl3b2tlbjsKQEAgLTE4Myw4ICsxODcsMTUgQEAgc3RydWN0IHBv
bGxfaW9jYiB7CiAJc3RydWN0IHdvcmtfc3RydWN0CXdvcms7CiB9OwogCisvKgorICogTk9URSEg
RWFjaCBvZiB0aGUgaW9jYiB1bmlvbiBtZW1iZXJzIGhhcyAia2lfZmlscCIgYXMKKyAqIHRoZSBm
aXJzdCBlbnRyeSBpbiB0aGVpciBzdHJ1Y3QgZGVmaW5pdGlvbi4gU28geW91IGNhbgorICogYWNj
ZXNzIHRoZSBmaWxlIHBvaW50ZXIgZWl0aGVyIGRpcmVjdGx5IHRocm91Z2ggdGhpcworICogYW5v
bnltb3VzIHVuaW9uLCBvciB0aHJvdWdoIGFueSBvZiB0aGUgc3ViLXN0cnVjdHMuCisgKi8KIHN0
cnVjdCBhaW9fa2lvY2IgewogCXVuaW9uIHsKKwkJc3RydWN0IGZpbGUJCSpraV9maWxwOwogCQlz
dHJ1Y3Qga2lvY2IJCXJ3OwogCQlzdHJ1Y3QgZnN5bmNfaW9jYglmc3luYzsKIAkJc3RydWN0IHBv
bGxfaW9jYglwb2xsOwpAQCAtMTA2MCw2ICsxMDcxLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGlv
Y2JfcHV0KHN0cnVjdCBhaW9fa2lvY2IgKmlvY2IpCiB7CiAJaWYgKHJlZmNvdW50X3JlYWQoJmlv
Y2ItPmtpX3JlZmNudCkgPT0gMCB8fAogCSAgICByZWZjb3VudF9kZWNfYW5kX3Rlc3QoJmlvY2It
PmtpX3JlZmNudCkpIHsKKwkJZnB1dChpb2NiLT5raV9maWxwKTsKIAkJcGVyY3B1X3JlZl9wdXQo
JmlvY2ItPmtpX2N0eC0+cmVxcyk7CiAJCWttZW1fY2FjaGVfZnJlZShraW9jYl9jYWNoZXAsIGlv
Y2IpOwogCX0KQEAgLTE0MTMsNyArMTQyNSw3IEBAIHN0YXRpYyB2b2lkIGFpb19jb21wbGV0ZV9y
dyhzdHJ1Y3Qga2lvY2IgKmtpb2NiLCBsb25nIHJlcywgbG9uZyByZXMyKQogCQlhaW9fcmVtb3Zl
X2lvY2IoaW9jYik7CiAKIAlpZiAoa2lvY2ItPmtpX2ZsYWdzICYgSU9DQl9XUklURSkgewotCQlz
dHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShraW9jYi0+a2lfZmlscCk7CisJCXN0cnVj
dCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGlvY2ItPmtpX2ZpbHApOwogCiAJCS8qCiAJCSAq
IFRlbGwgbG9ja2RlcCB3ZSBpbmhlcml0ZWQgZnJlZXplIHByb3RlY3Rpb24gZnJvbSBzdWJtaXNz
aW9uCkBAIC0xNDIxLDEwICsxNDMzLDkgQEAgc3RhdGljIHZvaWQgYWlvX2NvbXBsZXRlX3J3KHN0
cnVjdCBraW9jYiAqa2lvY2IsIGxvbmcgcmVzLCBsb25nIHJlczIpCiAJCSAqLwogCQlpZiAoU19J
U1JFRyhpbm9kZS0+aV9tb2RlKSkKIAkJCV9fc2Jfd3JpdGVyc19hY3F1aXJlZChpbm9kZS0+aV9z
YiwgU0JfRlJFRVpFX1dSSVRFKTsKLQkJZmlsZV9lbmRfd3JpdGUoa2lvY2ItPmtpX2ZpbHApOwor
CQlmaWxlX2VuZF93cml0ZShpb2NiLT5raV9maWxwKTsKIAl9CiAKLQlmcHV0KGtpb2NiLT5raV9m
aWxwKTsKIAlhaW9fY29tcGxldGUoaW9jYiwgcmVzLCByZXMyKTsKIH0KIApAQCAtMTQzMiw5ICsx
NDQzLDYgQEAgc3RhdGljIGludCBhaW9fcHJlcF9ydyhzdHJ1Y3Qga2lvY2IgKnJlcSwgY29uc3Qg
c3RydWN0IGlvY2IgKmlvY2IpCiB7CiAJaW50IHJldDsKIAotCXJlcS0+a2lfZmlscCA9IGZnZXQo
aW9jYi0+YWlvX2ZpbGRlcyk7Ci0JaWYgKHVubGlrZWx5KCFyZXEtPmtpX2ZpbHApKQotCQlyZXR1
cm4gLUVCQURGOwogCXJlcS0+a2lfY29tcGxldGUgPSBhaW9fY29tcGxldGVfcnc7CiAJcmVxLT5w
cml2YXRlID0gTlVMTDsKIAlyZXEtPmtpX3BvcyA9IGlvY2ItPmFpb19vZmZzZXQ7CkBAIC0xNDUx
LDcgKzE0NTksNyBAQCBzdGF0aWMgaW50IGFpb19wcmVwX3J3KHN0cnVjdCBraW9jYiAqcmVxLCBj
b25zdCBzdHJ1Y3QgaW9jYiAqaW9jYikKIAkJcmV0ID0gaW9wcmlvX2NoZWNrX2NhcChpb2NiLT5h
aW9fcmVxcHJpbyk7CiAJCWlmIChyZXQpIHsKIAkJCXByX2RlYnVnKCJhaW8gaW9wcmlvIGNoZWNr
IGNhcCBlcnJvcjogJWRcbiIsIHJldCk7Ci0JCQlnb3RvIG91dF9mcHV0OworCQkJcmV0dXJuIHJl
dDsKIAkJfQogCiAJCXJlcS0+a2lfaW9wcmlvID0gaW9jYi0+YWlvX3JlcXByaW87CkBAIC0xNDYw
LDE0ICsxNDY4LDEwIEBAIHN0YXRpYyBpbnQgYWlvX3ByZXBfcncoc3RydWN0IGtpb2NiICpyZXEs
IGNvbnN0IHN0cnVjdCBpb2NiICppb2NiKQogCiAJcmV0ID0ga2lvY2Jfc2V0X3J3X2ZsYWdzKHJl
cSwgaW9jYi0+YWlvX3J3X2ZsYWdzKTsKIAlpZiAodW5saWtlbHkocmV0KSkKLQkJZ290byBvdXRf
ZnB1dDsKKwkJcmV0dXJuIHJldDsKIAogCXJlcS0+a2lfZmxhZ3MgJj0gfklPQ0JfSElQUkk7IC8q
IG5vIG9uZSBpcyBnb2luZyB0byBwb2xsIGZvciB0aGlzIEkvTyAqLwogCXJldHVybiAwOwotCi1v
dXRfZnB1dDoKLQlmcHV0KHJlcS0+a2lfZmlscCk7Ci0JcmV0dXJuIHJldDsKIH0KIAogc3RhdGlj
IGludCBhaW9fc2V0dXBfcncoaW50IHJ3LCBjb25zdCBzdHJ1Y3QgaW9jYiAqaW9jYiwgc3RydWN0
IGlvdmVjICoqaW92ZWMsCkBAIC0xNTIxLDI0ICsxNTI1LDE5IEBAIHN0YXRpYyBzc2l6ZV90IGFp
b19yZWFkKHN0cnVjdCBraW9jYiAqcmVxLCBjb25zdCBzdHJ1Y3QgaW9jYiAqaW9jYiwKIAlpZiAo
cmV0KQogCQlyZXR1cm4gcmV0OwogCWZpbGUgPSByZXEtPmtpX2ZpbHA7Ci0KLQlyZXQgPSAtRUJB
REY7CiAJaWYgKHVubGlrZWx5KCEoZmlsZS0+Zl9tb2RlICYgRk1PREVfUkVBRCkpKQotCQlnb3Rv
IG91dF9mcHV0OworCQlyZXR1cm4gLUVCQURGOwogCXJldCA9IC1FSU5WQUw7CiAJaWYgKHVubGlr
ZWx5KCFmaWxlLT5mX29wLT5yZWFkX2l0ZXIpKQotCQlnb3RvIG91dF9mcHV0OworCQlyZXR1cm4g
LUVJTlZBTDsKIAogCXJldCA9IGFpb19zZXR1cF9ydyhSRUFELCBpb2NiLCAmaW92ZWMsIHZlY3Rv
cmVkLCBjb21wYXQsICZpdGVyKTsKIAlpZiAocmV0KQotCQlnb3RvIG91dF9mcHV0OworCQlyZXR1
cm4gcmV0OwogCXJldCA9IHJ3X3ZlcmlmeV9hcmVhKFJFQUQsIGZpbGUsICZyZXEtPmtpX3Bvcywg
aW92X2l0ZXJfY291bnQoJml0ZXIpKTsKIAlpZiAoIXJldCkKIAkJYWlvX3J3X2RvbmUocmVxLCBj
YWxsX3JlYWRfaXRlcihmaWxlLCByZXEsICZpdGVyKSk7CiAJa2ZyZWUoaW92ZWMpOwotb3V0X2Zw
dXQ6Ci0JaWYgKHVubGlrZWx5KHJldCkpCi0JCWZwdXQoZmlsZSk7CiAJcmV0dXJuIHJldDsKIH0K
IApAQCAtMTU1NSwxNiArMTU1NCwxNCBAQCBzdGF0aWMgc3NpemVfdCBhaW9fd3JpdGUoc3RydWN0
IGtpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBpb2NiICppb2NiLAogCQlyZXR1cm4gcmV0OwogCWZp
bGUgPSByZXEtPmtpX2ZpbHA7CiAKLQlyZXQgPSAtRUJBREY7CiAJaWYgKHVubGlrZWx5KCEoZmls
ZS0+Zl9tb2RlICYgRk1PREVfV1JJVEUpKSkKLQkJZ290byBvdXRfZnB1dDsKLQlyZXQgPSAtRUlO
VkFMOworCQlyZXR1cm4gLUVCQURGOwogCWlmICh1bmxpa2VseSghZmlsZS0+Zl9vcC0+d3JpdGVf
aXRlcikpCi0JCWdvdG8gb3V0X2ZwdXQ7CisJCXJldHVybiAtRUlOVkFMOwogCiAJcmV0ID0gYWlv
X3NldHVwX3J3KFdSSVRFLCBpb2NiLCAmaW92ZWMsIHZlY3RvcmVkLCBjb21wYXQsICZpdGVyKTsK
IAlpZiAocmV0KQotCQlnb3RvIG91dF9mcHV0OworCQlyZXR1cm4gcmV0OwogCXJldCA9IHJ3X3Zl
cmlmeV9hcmVhKFdSSVRFLCBmaWxlLCAmcmVxLT5raV9wb3MsIGlvdl9pdGVyX2NvdW50KCZpdGVy
KSk7CiAJaWYgKCFyZXQpIHsKIAkJLyoKQEAgLTE1ODIsOSArMTU3OSw2IEBAIHN0YXRpYyBzc2l6
ZV90IGFpb193cml0ZShzdHJ1Y3Qga2lvY2IgKnJlcSwgY29uc3Qgc3RydWN0IGlvY2IgKmlvY2Is
CiAJCWFpb19yd19kb25lKHJlcSwgY2FsbF93cml0ZV9pdGVyKGZpbGUsIHJlcSwgJml0ZXIpKTsK
IAl9CiAJa2ZyZWUoaW92ZWMpOwotb3V0X2ZwdXQ6Ci0JaWYgKHVubGlrZWx5KHJldCkpCi0JCWZw
dXQoZmlsZSk7CiAJcmV0dXJuIHJldDsKIH0KIApAQCAtMTU5Myw4ICsxNTg3LDcgQEAgc3RhdGlj
IHZvaWQgYWlvX2ZzeW5jX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCXN0cnVjdCBm
c3luY19pb2NiICpyZXEgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGZzeW5jX2lvY2IsIHdv
cmspOwogCWludCByZXQ7CiAKLQlyZXQgPSB2ZnNfZnN5bmMocmVxLT5maWxlLCByZXEtPmRhdGFz
eW5jKTsKLQlmcHV0KHJlcS0+ZmlsZSk7CisJcmV0ID0gdmZzX2ZzeW5jKHJlcS0+a2lfZmlscCwg
cmVxLT5kYXRhc3luYyk7CiAJYWlvX2NvbXBsZXRlKGNvbnRhaW5lcl9vZihyZXEsIHN0cnVjdCBh
aW9fa2lvY2IsIGZzeW5jKSwgcmV0LCAwKTsKIH0KIApAQCAtMTYwNSwxMyArMTU5OCw4IEBAIHN0
YXRpYyBpbnQgYWlvX2ZzeW5jKHN0cnVjdCBmc3luY19pb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBp
b2NiICppb2NiLAogCQkJaW9jYi0+YWlvX3J3X2ZsYWdzKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAK
LQlyZXEtPmZpbGUgPSBmZ2V0KGlvY2ItPmFpb19maWxkZXMpOwotCWlmICh1bmxpa2VseSghcmVx
LT5maWxlKSkKLQkJcmV0dXJuIC1FQkFERjsKLQlpZiAodW5saWtlbHkoIXJlcS0+ZmlsZS0+Zl9v
cC0+ZnN5bmMpKSB7Ci0JCWZwdXQocmVxLT5maWxlKTsKKwlpZiAodW5saWtlbHkoIXJlcS0+a2lf
ZmlscC0+Zl9vcC0+ZnN5bmMpKQogCQlyZXR1cm4gLUVJTlZBTDsKLQl9CiAKIAlyZXEtPmRhdGFz
eW5jID0gZGF0YXN5bmM7CiAJSU5JVF9XT1JLKCZyZXEtPndvcmssIGFpb19mc3luY193b3JrKTsK
QEAgLTE2MjEsMTAgKzE2MDksNyBAQCBzdGF0aWMgaW50IGFpb19mc3luYyhzdHJ1Y3QgZnN5bmNf
aW9jYiAqcmVxLCBjb25zdCBzdHJ1Y3QgaW9jYiAqaW9jYiwKIAogc3RhdGljIGlubGluZSB2b2lk
IGFpb19wb2xsX2NvbXBsZXRlKHN0cnVjdCBhaW9fa2lvY2IgKmlvY2IsIF9fcG9sbF90IG1hc2sp
CiB7Ci0Jc3RydWN0IGZpbGUgKmZpbGUgPSBpb2NiLT5wb2xsLmZpbGU7Ci0KIAlhaW9fY29tcGxl
dGUoaW9jYiwgbWFuZ2xlX3BvbGwobWFzayksIDApOwotCWZwdXQoZmlsZSk7CiB9CiAKIHN0YXRp
YyB2b2lkIGFpb19wb2xsX2NvbXBsZXRlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQpA
QCAtMTYzNiw3ICsxNjIxLDcgQEAgc3RhdGljIHZvaWQgYWlvX3BvbGxfY29tcGxldGVfd29yayhz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJX19wb2xsX3QgbWFzayA9IDA7CiAKIAlpZiAoIVJF
QURfT05DRShyZXEtPmNhbmNlbGxlZCkpCi0JCW1hc2sgPSB2ZnNfcG9sbChyZXEtPmZpbGUsICZw
dCkgJiByZXEtPmV2ZW50czsKKwkJbWFzayA9IHZmc19wb2xsKGlvY2ItPmtpX2ZpbHAsICZwdCkg
JiByZXEtPmV2ZW50czsKIAogCS8qCiAJICogTm90ZSB0aGF0IC0+a2lfY2FuY2VsIGNhbGxlcnMg
YWxzbyBkZWxldGUgaW9jYiBmcm9tIGFjdGl2ZV9yZXFzIGFmdGVyCkBAIC0xNzQzLDkgKzE3Mjgs
NiBAQCBzdGF0aWMgc3NpemVfdCBhaW9fcG9sbChzdHJ1Y3QgYWlvX2tpb2NiICphaW9jYiwgY29u
c3Qgc3RydWN0IGlvY2IgKmlvY2IpCiAKIAlJTklUX1dPUksoJnJlcS0+d29yaywgYWlvX3BvbGxf
Y29tcGxldGVfd29yayk7CiAJcmVxLT5ldmVudHMgPSBkZW1hbmdsZV9wb2xsKGlvY2ItPmFpb19i
dWYpIHwgRVBPTExFUlIgfCBFUE9MTEhVUDsKLQlyZXEtPmZpbGUgPSBmZ2V0KGlvY2ItPmFpb19m
aWxkZXMpOwotCWlmICh1bmxpa2VseSghcmVxLT5maWxlKSkKLQkJcmV0dXJuIC1FQkFERjsKIAog
CXJlcS0+aGVhZCA9IE5VTEw7CiAJcmVxLT53b2tlbiA9IGZhbHNlOwpAQCAtMTc2Myw3ICsxNzQ1
LDcgQEAgc3RhdGljIHNzaXplX3QgYWlvX3BvbGwoc3RydWN0IGFpb19raW9jYiAqYWlvY2IsIGNv
bnN0IHN0cnVjdCBpb2NiICppb2NiKQogCS8qIG9uZSBmb3IgcmVtb3ZhbCBmcm9tIHdhaXRxdWV1
ZSwgb25lIGZvciB0aGlzIGZ1bmN0aW9uICovCiAJcmVmY291bnRfc2V0KCZhaW9jYi0+a2lfcmVm
Y250LCAyKTsKIAotCW1hc2sgPSB2ZnNfcG9sbChyZXEtPmZpbGUsICZhcHQucHQpICYgcmVxLT5l
dmVudHM7CisJbWFzayA9IHZmc19wb2xsKGFpb2NiLT5raV9maWxwLCAmYXB0LnB0KSAmIHJlcS0+
ZXZlbnRzOwogCWlmICh1bmxpa2VseSghcmVxLT5oZWFkKSkgewogCQkvKiB3ZSBkaWQgbm90IG1h
bmFnZSB0byBzZXQgdXAgYSB3YWl0cXVldWUsIGRvbmUgKi8KIAkJZ290byBvdXQ7CkBAIC0xNzg4
LDEwICsxNzcwLDggQEAgc3RhdGljIHNzaXplX3QgYWlvX3BvbGwoc3RydWN0IGFpb19raW9jYiAq
YWlvY2IsIGNvbnN0IHN0cnVjdCBpb2NiICppb2NiKQogCXNwaW5fdW5sb2NrX2lycSgmY3R4LT5j
dHhfbG9jayk7CiAKIG91dDoKLQlpZiAodW5saWtlbHkoYXB0LmVycm9yKSkgewotCQlmcHV0KHJl
cS0+ZmlsZSk7CisJaWYgKHVubGlrZWx5KGFwdC5lcnJvcikpCiAJCXJldHVybiBhcHQuZXJyb3I7
Ci0JfQogCiAJaWYgKG1hc2spCiAJCWFpb19wb2xsX2NvbXBsZXRlKGFpb2NiLCBtYXNrKTsKQEAg
LTE4MjksNiArMTgwOSwxMSBAQCBzdGF0aWMgaW50IF9faW9fc3VibWl0X29uZShzdHJ1Y3Qga2lv
Y3R4ICpjdHgsIGNvbnN0IHN0cnVjdCBpb2NiICppb2NiLAogCWlmICh1bmxpa2VseSghcmVxKSkK
IAkJZ290byBvdXRfcHV0X3JlcXNfYXZhaWxhYmxlOwogCisJcmVxLT5raV9maWxwID0gZmdldChp
b2NiLT5haW9fZmlsZGVzKTsKKwlyZXQgPSAtRUJBREY7CisJaWYgKHVubGlrZWx5KCFyZXEtPmtp
X2ZpbHApKQorCQlnb3RvIG91dF9wdXRfcmVxOworCiAJaWYgKGlvY2ItPmFpb19mbGFncyAmIElP
Q0JfRkxBR19SRVNGRCkgewogCQkvKgogCQkgKiBJZiB0aGUgSU9DQl9GTEFHX1JFU0ZEIGZsYWcg
b2YgYWlvX2ZsYWdzIGlzIHNldCwgZ2V0IGFuCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zz
LmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgKaW5kZXggMjlkOGUyY2ZlZDBlLi5mZDQyM2ZlYzhkODMg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgK
QEAgLTMwNCwxMyArMzA0LDE5IEBAIGVudW0gcndfaGludCB7CiAKIHN0cnVjdCBraW9jYiB7CiAJ
c3RydWN0IGZpbGUJCSpraV9maWxwOworCisJLyogVGhlICdraV9maWxwJyBwb2ludGVyIGlzIHNo
YXJlZCBpbiBhIHVuaW9uIGZvciBhaW8gKi8KKwlyYW5kb21pemVkX3N0cnVjdF9maWVsZHNfc3Rh
cnQKKwogCWxvZmZfdAkJCWtpX3BvczsKIAl2b2lkICgqa2lfY29tcGxldGUpKHN0cnVjdCBraW9j
YiAqaW9jYiwgbG9uZyByZXQsIGxvbmcgcmV0Mik7CiAJdm9pZAkJCSpwcml2YXRlOwogCWludAkJ
CWtpX2ZsYWdzOwogCXUxNgkJCWtpX2hpbnQ7CiAJdTE2CQkJa2lfaW9wcmlvOyAvKiBTZWUgbGlu
dXgvaW9wcmlvLmggKi8KLX0gX19yYW5kb21pemVfbGF5b3V0OworCisJcmFuZG9taXplZF9zdHJ1
Y3RfZmllbGRzX2VuZAorfTsKIAogc3RhdGljIGlubGluZSBib29sIGlzX3N5bmNfa2lvY2Ioc3Ry
dWN0IGtpb2NiICpraW9jYikKIHsK
--0000000000008261ee058335df7d--
