Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E0CECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27C42086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570666730;
	bh=gt0rGR97Xme0CwycwIAopWrIZcx9Vdl7Vq84sBueo1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CfSpDJDDKdqV2Yzp3noz3D1/Mq2HOJ7mgFNAGVMhM5KYpieIV4Di548DgCw9vatop
	 kPSekvynYiZP+rtRLLMHevB0+0fRLiR01/WxQoVie3osTmAYMfNglEBB9GF6sxornq
	 jezqsVM09wIXntTSJNCNK87jJl/mFVXcpLrqI+PI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfJJASa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:18:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34348 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfJJAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:18:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so4345439lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Do77P50v1iqzLRFJrcaqrujRx6icNyR1SPhQlluhlo8=;
        b=ErC9fvmS1HrPg1zFSfjCcWymQCihOoMHXfDfVxRpG2osTRkV+UY897Qb6hAbHieCGh
         ovDlnXsYSazZqq9YSeU20f9vPeJTZZLRwdzFJK3NKeRe7Z4Zz/xleu9LP+Oi+8+Wi4Vr
         h/kj1J01eVTlDwnz1hlkJFD+i5COsGwWPh0Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Do77P50v1iqzLRFJrcaqrujRx6icNyR1SPhQlluhlo8=;
        b=WvgtaWyXuiC/nptrlQfGv1hGHek/e9CVKBT3EQP1kPmTqOEGUC60tW9NCbdp+fxUNl
         suhUWH73w68HFJLVvndN2ujlJ4GALvx5pHhCmS7ncmxffNbevWODqwVOQro5emBL9CqP
         RMp1nuoifbiZw1ioJRDriFRExd1tjTHV9KfDUOhhY9hwRvXH64NZTRq0YcDb2KmSFFTd
         vkaaAfBFlqtTj7pl63cSuy0//424lAq3NXy7dherxxkCzitMjkUWVigySQXmq/Wr81Tc
         5UNxei+ZGgrc5qy+15ZIO2MC/C3aQ0OGisqCe13q424RkSzoR0CmT0YccasYY059OJP1
         bUtg==
X-Gm-Message-State: APjAAAUs1UHwC43aObYODSJ/7TD1GA60raPS1OwEi++5/xG9z8DJV1TE
        qW9KAwhi3pLxeTQbl/hWRAzE1pLgenc=
X-Google-Smtp-Source: APXvYqxaT3W6mYNs56kvdIuZqnzJgovQZSTk22sHyrK2jB1xBZ6lghTE+62myt4E3iwvGjYgm38Xmg==
X-Received: by 2002:a2e:3919:: with SMTP id g25mr4023741lja.242.1570666705918;
        Wed, 09 Oct 2019 17:18:25 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id w30sm814572lfn.82.2019.10.09.17.18.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 17:18:23 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f5so4287596ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:18:22 -0700 (PDT)
X-Received: by 2002:a2e:9848:: with SMTP id e8mr3988315ljj.148.1570666702440;
 Wed, 09 Oct 2019 17:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box> <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org> <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
 <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
 <CAHk-=wgy-ULe8UmEDn9gCCmTtw65chS0h309WrTaQhK3RAXM-A@mail.gmail.com>
 <c054849e-1e24-6b27-6a54-740ea9d17054@shipmail.org> <CAHk-=wgmr-BPMTnSuKrAMoHL_A0COV_sZkdcNB9aosYfouA_fw@mail.gmail.com>
 <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org> <CAHk-=wg6n_nGRtJd4MeXZrA5QrrVViJeO4x2w37KDbcDmTh3dg@mail.gmail.com>
In-Reply-To: <CAHk-=wg6n_nGRtJd4MeXZrA5QrrVViJeO4x2w37KDbcDmTh3dg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 17:18:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgR3zs=zPsOe4eV-yJi=LLo7bTyrB+6o-FiJz1P0nkCWg@mail.gmail.com>
Message-ID: <CAHk-=wgR3zs=zPsOe4eV-yJi=LLo7bTyrB+6o-FiJz1P0nkCWg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000dc39e8059483566e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000dc39e8059483566e
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 9, 2019 at 4:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (a) right now nobody wants the "skip" behavior. You think you'll
> eventually want it
>
>  (b) right now, the "return positive value" is actually a horribly
> ugly pointless hack, which could be made to be an error value and
> cleaned up in the process
>
>  (c) to me that really argues that we should just make the rule be
>
>      - negative error means break out with error
>
>      - 0 means continue down the next level
>
>      - positive could be trivially be made to just mean "ok, I did it,
> you can just continue".
>
> and I think that would make a lot of sense.

So here's an ENTIRELY untested patch, but the return value of
pmd_entry() now makes conceptual sense to me. The whole "I hit an
error, I did nothing, I already did it myself" to me is the intuitive
meaning of {neg,0,pos} handling.

I think we probably should do this same thing for the upper levels too
to be consistent, but I think this at least makes sense, and is
simple, and avoids any hacky PAGE_WALK_CALLER_MAX magic.

I also wonder if some caller might want to get a count of "how many X
handled", and we'd just sum up all the positive return values as we're
traversing things, but that falls under "nobody seems to want it right
now", so I'm not adding extra code for something that might not be
useful.

And it is possible that I missed some other pmd_entry() callback that
returns a positive value. I did check them all, but mistakes happen
and I might have missed some case...

Again: entirely and utterly untested. It compiles. That's all I'm
going to guarantee, and even that might be a fluke.

                 Linus

--000000000000dc39e8059483566e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1jye0i60>
X-Attachment-Id: f_k1jye0i60

IG1tL21lbXBvbGljeS5jIHwgMTAgKysrKystLS0tLQogbW0vcGFnZXdhbGsuYyAgfCAxMSArKysr
KysrKy0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL21tL21lbXBvbGljeS5jIGIvbW0vbWVtcG9saWN5LmMKaW5kZXggNGFl
OTY3YmNmOTU0Li5mOGM5OTU5MTU5MmIgMTAwNjQ0Ci0tLSBhL21tL21lbXBvbGljeS5jCisrKyBi
L21tL21lbXBvbGljeS5jCkBAIC00ODIsNyArNDgyLDcgQEAgc3RhdGljIGludCBxdWV1ZV9wYWdl
c19wbWQocG1kX3QgKnBtZCwgc3BpbmxvY2tfdCAqcHRsLCB1bnNpZ25lZCBsb25nIGFkZHIsCiAg
KgogICogcXVldWVfcGFnZXNfcHRlX3JhbmdlKCkgaGFzIHRocmVlIHBvc3NpYmxlIHJldHVybiB2
YWx1ZXM6CiAgKiAwIC0gcGFnZXMgYXJlIHBsYWNlZCBvbiB0aGUgcmlnaHQgbm9kZSBvciBxdWV1
ZWQgc3VjY2Vzc2Z1bGx5LgotICogMSAtIHRoZXJlIGlzIHVubW92YWJsZSBwYWdlLCBhbmQgTVBP
TF9NRl9NT1ZFKiAmIE1QT0xfTUZfU1RSSUNUIHdlcmUKKyAqIC1FQlVTWSAtIHRoZXJlIGlzIHVu
bW92YWJsZSBwYWdlLCBhbmQgTVBPTF9NRl9NT1ZFKiAmIE1QT0xfTUZfU1RSSUNUIHdlcmUKICAq
ICAgICBzcGVjaWZpZWQuCiAgKiAtRUlPIC0gb25seSBNUE9MX01GX1NUUklDVCB3YXMgc3BlY2lm
aWVkIGFuZCBhbiBleGlzdGluZyBwYWdlIHdhcyBhbHJlYWR5CiAgKiAgICAgICAgb24gYSBub2Rl
IHRoYXQgZG9lcyBub3QgZm9sbG93IHRoZSBwb2xpY3kuCkBAIC02NjksNyArNjY5LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtbV93YWxrX29wcyBxdWV1ZV9wYWdlc193YWxrX29wcyA9IHsKICAq
IHBhc3NlZCB2aWEgQHByaXZhdGUuCiAgKgogICogcXVldWVfcGFnZXNfcmFuZ2UoKSBoYXMgdGhy
ZWUgcG9zc2libGUgcmV0dXJuIHZhbHVlczoKLSAqIDEgLSB0aGVyZSBpcyB1bm1vdmFibGUgcGFn
ZSwgYnV0IE1QT0xfTUZfTU9WRSogJiBNUE9MX01GX1NUUklDVCB3ZXJlCisgKiAtRUJVU1kgLSB0
aGVyZSBpcyB1bm1vdmFibGUgcGFnZSwgYnV0IE1QT0xfTUZfTU9WRSogJiBNUE9MX01GX1NUUklD
VCB3ZXJlCiAgKiAgICAgc3BlY2lmaWVkLgogICogMCAtIHF1ZXVlIHBhZ2VzIHN1Y2Nlc3NmdWxs
eSBvciBubyBtaXNwbGFjZWQgcGFnZS4KICAqIC1FSU8gLSB0aGVyZSBpcyBtaXNwbGFjZWQgcGFn
ZSBhbmQgb25seSBNUE9MX01GX1NUUklDVCB3YXMgc3BlY2lmaWVkLgpAQCAtMTI4NSw4ICsxMjg1
LDggQEAgc3RhdGljIGxvbmcgZG9fbWJpbmQodW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQg
bG9uZyBsZW4sCiAJcmV0ID0gcXVldWVfcGFnZXNfcmFuZ2UobW0sIHN0YXJ0LCBlbmQsIG5tYXNr
LAogCQkJICBmbGFncyB8IE1QT0xfTUZfSU5WRVJULCAmcGFnZWxpc3QpOwogCi0JaWYgKHJldCA8
IDApIHsKLQkJZXJyID0gLUVJTzsKKwlpZiAocmV0IDwgMCAmJiByZXQgIT0gLUVCVVNZKSB7CisJ
CWVyciA9IHJldDsKIAkJZ290byB1cF9vdXQ7CiAJfQogCkBAIC0xMzAzLDcgKzEzMDMsNyBAQCBz
dGF0aWMgbG9uZyBkb19tYmluZCh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGxl
biwKIAkJCQlwdXRiYWNrX21vdmFibGVfcGFnZXMoJnBhZ2VsaXN0KTsKIAkJfQogCi0JCWlmICgo
cmV0ID4gMCkgfHwgKG5yX2ZhaWxlZCAmJiAoZmxhZ3MgJiBNUE9MX01GX1NUUklDVCkpKQorCQlp
ZiAoKHJldCA8IDApIHx8IChucl9mYWlsZWQgJiYgKGZsYWdzICYgTVBPTF9NRl9TVFJJQ1QpKSkK
IAkJCWVyciA9IC1FSU87CiAJfSBlbHNlCiAJCXB1dGJhY2tfbW92YWJsZV9wYWdlcygmcGFnZWxp
c3QpOwpkaWZmIC0tZ2l0IGEvbW0vcGFnZXdhbGsuYyBiL21tL3BhZ2V3YWxrLmMKaW5kZXggZDQ4
YzJhOTg2ZWEzLi5lYjlkMjkyNTg4YTIgMTAwNjQ0Ci0tLSBhL21tL3BhZ2V3YWxrLmMKKysrIGIv
bW0vcGFnZXdhbGsuYwpAQCAtNDksMTAgKzQ5LDE1IEBAIHN0YXRpYyBpbnQgd2Fsa19wbWRfcmFu
Z2UocHVkX3QgKnB1ZCwgdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKIAkJ
ICogVGhpcyBpbXBsaWVzIHRoYXQgZWFjaCAtPnBtZF9lbnRyeSgpIGhhbmRsZXIKIAkJICogbmVl
ZHMgdG8ga25vdyBhYm91dCBwbWRfdHJhbnNfaHVnZSgpIHBtZHMKIAkJICovCi0JCWlmIChvcHMt
PnBtZF9lbnRyeSkKKwkJaWYgKG9wcy0+cG1kX2VudHJ5KSB7CiAJCQllcnIgPSBvcHMtPnBtZF9l
bnRyeShwbWQsIGFkZHIsIG5leHQsIHdhbGspOwotCQlpZiAoZXJyKQotCQkJYnJlYWs7CisJCQlp
ZiAoZXJyIDwgMCkKKwkJCQlicmVhazsKKwkJCWlmIChlcnIgPiAwKSB7CisJCQkJZXJyID0gMDsK
KwkJCQljb250aW51ZTsKKwkJCX0KKwkJfQogCiAJCS8qCiAJCSAqIENoZWNrIHRoaXMgaGVyZSBz
byB3ZSBvbmx5IGJyZWFrIGRvd24gdHJhbnNfaHVnZQo=
--000000000000dc39e8059483566e--
