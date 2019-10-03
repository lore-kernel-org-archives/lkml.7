Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6700FC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2FB2054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121741;
	bh=ljeLKOSfshAmD2JJkObm5RrE/BqXkmV9xjJUCMLWlcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tlMPF17q0s5y/ViYOdVfRpjN2DPxFkAChhHNluweqFxDfAUNjXaYSgCUXcwkqXGIg
	 SkOg+dOHSJ7OhIc7mdBemJcXf/4lUxenF0TT4Ea7L03/IEjW5fSStW/QYkb8+7gegS
	 V5rw3mZ6Oow5PKIGYzsJGuRdbEJZgRudVNR9tmg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393241AbfJCQzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:55:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36549 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391665AbfJCQzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:55:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so3578142ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fCPYvMiyrHbhtjPVCqhOP9e/Y2hvO3REb3XJchre7k=;
        b=Y9GR64nrbeaiaZcBLMQtFKUReDn0GpFCXOUX8CTGwDjwQAQLsBMrq29nU78RLTf9GA
         mey/GNYOY2uM9Nw357QjHb3Z9c5AeZtZm8sIYaxM5nYLSWVi/DYQG8GLbnVLwGMKE8tn
         FcenIAYbAYguUBzZNbX4KkwtWTnWMGs0VHx9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fCPYvMiyrHbhtjPVCqhOP9e/Y2hvO3REb3XJchre7k=;
        b=RHm4EUBcsiuBjiOHreVh9aRl++KwVkRN4mEQUM+MINwrCZcKCayCQefP8sY6TaA/Az
         ZzQEohpVLuHOkszQaHsVlbp3cZbRNmqzH1ehzfIyXdeJfG7qLIBUKedsssfqH6U1WZM2
         XpnlyQihZAeuxDDiy4+4vrj5n1n6W9ztyBX7KFhW5Z9zVE+V5xF6Nmpcodxj58YpIMKy
         5h9vWVd4TXW8qU9EMterl5xVkv4D+/teT0+QugDPyBsBIElFbtLWimY9s92BUmRlyCUx
         YejaYWiiizNLsHBqWgKnVLDgb5kLB4qPqm5paLb1yYcWHoWguHn5fNj3R7mKl10DEMa+
         sdgA==
X-Gm-Message-State: APjAAAW9yyBu+p+reFAYNTPwwU9kkrEmnW+eSdOD/3c/UVu8A779FDxo
        1XnQYnZzVVJiEen886RdK0xFnjukYXQ=
X-Google-Smtp-Source: APXvYqxKuQCf1DbZj8kkj06Uj72Uqujh+wCIquOTD3+ntFjJL4caItKOrIftTKkNkYfJC9rW+ticxA==
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr6771314lji.204.1570121735246;
        Thu, 03 Oct 2019 09:55:35 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x15sm722414lff.54.2019.10.03.09.55.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 09:55:34 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id j19so3592886lja.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:55:33 -0700 (PDT)
X-Received: by 2002:a2e:7611:: with SMTP id r17mr1979719ljc.133.1570121733316;
 Thu, 03 Oct 2019 09:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-4-thomas_os@shipmail.org> <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
 <516814a5-a616-b15e-ac87-26ede681da85@shipmail.org> <CAHk-=wgH=T5mcDxTaC6QbBN=iJD3d_amzcb2+GxbcV7XuEYL2A@mail.gmail.com>
 <MN2PR05MB61412DB4F703A5EE4F961593A19F0@MN2PR05MB6141.namprd05.prod.outlook.com>
In-Reply-To: <MN2PR05MB61412DB4F703A5EE4F961593A19F0@MN2PR05MB6141.namprd05.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 09:55:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5NiFPouYd6zUgY4K7VovOAxQT-xhDRjD6j5hifBWi_g@mail.gmail.com>
Message-ID: <CAHk-=wj5NiFPouYd6zUgY4K7VovOAxQT-xhDRjD6j5hifBWi_g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: multipart/mixed; boundary="0000000000002b4d560594047424"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002b4d560594047424
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 3, 2019 at 12:56 AM Thomas Hellstrom <thellstrom@vmware.com> wrote:
>
> Both the cleaning operation and the wp operation operate on shared
> writable mappings, and since they are also both restricted to entries
> that may take part in dirty-tracking (they're ignoring pmds and puds),
> so perhaps a "dirty" may make sense anyway, and to point out the similarity:
>
> clean_mapping_dirty_range() and wp_mapping_dirty_range()"?

Hmm. Yeah, either that, or "shared", as in "clean_shared_mapping_range()"?

I don't know. Maybe this isn't a huge deal, and the "don't care about
private dirty/write" is kind of implied by the fact that it's about
the backing mapping rather than the vma.

But on the other hand we do have things like "unmap_mapping_range()"
which will unmap all the private mappings too, so maybe it's a good
idea to clarify that this is about shared mappings.

I suspect it's a bit of a bike shed, and I could go either way.

> >  And I'd rather see
> > separate 'struct mm_walk_ops' than shared ones that then have a flag
> > in a differfent structure to change behavior.
> >
> > Yes, yes, some of the levels share the same logic, but that just means
> > that you can use the same function pointer for that level in the
> > different "clean" vs "wp" mm_walk_op.
>
> I think that this comment and this last one:
>
> > Also, why do you loop inside the pmd_entry function, instead of just
> > having a pte_entry function?"
>
> are tied together. The pagewalk code is kind of awkward since if you
> provide a pte_entry function, then huge pmds are unconditionally split,

So I think that we could handle differently.

But even if you don't want to do the pte_entry function, the "use two
different set of walker op structures" stands. Instead of havign a
test for "am I walking for wp or not", just make it implicit.

Also, I do think that you're seeing what is a weakness in the pte
walkers wrt splitting. I do think we shouldn't split unconditionally.

I suspect we should instead change the logic to split only if we
didn't have a pmd_entry. Because looking at the existing cases, if you
have a pmd_entry, you currently never have a pte_entry, so it wouldn't
change semantics for current cases.

> even if handled in pmd_entry,
> forcing pmd-aware users to handle also ptes in pmd_entry(). I'm not
> entirely sure why, but it looks like it's to avoid a race where huge
> pmds could otherwise be unintentionally split if appearing *after* the
> pmd_entry() call.

See above: we never have both pmd_entry and pte_entry walkers as it is
right now. So you can't have that race.

> Other pagewalk users do the same here,  see for
> example clear_refs_pte_range();
>
> https://elixir.bootlin.com/linux/latest/source/fs/proc/task_mmu.c#L1040
>
> Also the pagewalk walk_pte_range() for some reason doesn't take the page
> table lock, which means that a pte may well be cleared under us while we
> have it cached for modification.

Ho humm. That looks really sketchy to me. We actually have very few
pte_entry cases, perhaps exactly because it's all kinds of broken.

There's a couple of odd architectures, and then there is
prot_none_walk_ops. And that one purely looks at the pte's, and does a
special "can we do this" phase before doing the real modification.
It's limited to special PFNMAP/MIXEDMAP things.

So it does look like the pte walking code is accidentally (or
intentionally) ok in that case, but looking at the architecture users
(s390, at least), I do get the feeling that the lack of locking is an
actual and real bug.

It's probably impossible to hit in practice because it's limited to
special ops and you'd have to race with swapout anbd even then it
might not much matter. But it looks _wrong_.

And honestly, it looks like the clear_refs_pte_range() example you
point at comes from this for _exactly_ the same reason your code does
this: the pte walker is buggy, and the pmd case doesn't want to split.

The pte walker code in question has been there since 2008. This is not
a new thing. The clear_refs_pte_range() code partly goes all the way
back to that, although it's been changed some since. But the actual
pte_offset_map_lock() call in there predates the generic walker, so
what I think happened is that the generic walker was done only
partially, and intentionally didn't go all the way to the pte level
exactly because the walker was made to split things up unconditionally
if you did the pte case.

> For these reasons we can't use the pte_entry, even internally and this
> means we have three choices:
>
> a) Selecting the pte function using a bool. Saves code and avoids extra
> indirect function call.
> b) Duplicating the pmd_entry with a different pte function, also
> duplicating the ops. Avoids extra indirect function call but some extra
> code.
> c) Instead of the bool, use another function pointer in yet another ops
> pointed to by the private structure. Saves some code.

So considering that

 - there is one current user of the pte code that doesn't care about
the proper pte lock, because what it does is a racy pre-check anyway

 - that one user is also documented to not care too much about
performance (it's a crazy special case)

 - the other users _do_ look like they are currently buggy and want a
stable pte with proper locking

 - there are currently no cases of "I have a pmd walker _and_ a pte
walker" because that case was always broken due to splitting

I would say that the current walker code is simply buggy in this
respect, and people have worked around it for over a decade.

End result: since you have an actual test-case that wants this, I'd
like to at least try

 d) Fix the pte walker to do the right thing, then just use separate
pte walkers in your code

The fix would be those two conceptual changes:

 1) don't split if the walker asks for a pmd_entry (the walker itself
can then decide to split, of course, but right now no walkers want it
since there are no pmd _and_ pte walkers, because people who want that
do the pte walk themselves)

 2) get the proper page table lock if you do walk the pte, since
otherwise it's racy

Then there won't be any code duplication, because all the duplication
you now have at the pmd level is literally just workarounds for the
fact that our current walker has this bug.

That "fix the pte walker" would be one preliminary patch that would
look something like the attached TOTALLY UNTESTED garbage.

I call it "garbage" because I really hope people take it just as what
it is: "something like this". It compiles for me, and I did try to
think it through, but I might have missed some big piece of the
picture when writing that patch.

And yes, this is a much bigger conceptual change for the VM layer, but
I really think our pagewalk code is actively buggy right now, and is
forcing users to do bad things because they work around the existing
limitations.

Hmm? Could some of the core mm people look over that patch?

And yes, I was tempted to move the proper pmd locking into the walker
too, and do

        ptl = pmd_trans_huge_lock(pmd, vma);
        if (ptl) {
                err = ops->pmd_entry(pmd, addr, next, walk);
                spin_unlock(ptl);
                ...

but while I think that's the correct thing to do in the long run, that
would have to be done together with changing all the existing
pmd_entry users. It would make the pmd_entry _solely_ handle the
hugepage case, and then you'd have to remove the locking in the
pmd_entry, and have to make the pte walking be a walker entry. But
that would _really_ clean things up, and would make things like
smaps_pte_range() much easier to read, and much more obvious (it would
be split into a smaps_pmd_range and smaps_pte_range, and the callbacks
wouldn't need to know about the complex locking).

So I think this is the right direction to move into, but I do want
people to think about this, and think about that next phase of doing
the pmd_trans_huge_lock too.

Comments?

                Linus

--0000000000002b4d560594047424
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1axocej0>
X-Attachment-Id: f_k1axocej0

IG1tL3BhZ2V3YWxrLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvbW0vcGFnZXdhbGsuYyBiL21tL3BhZ2V3YWxrLmMKaW5kZXggZDQ4YzJhOTg2ZWEz
Li42YWU5NTkzMmU3OTkgMTAwNjQ0Ci0tLSBhL21tL3BhZ2V3YWxrLmMKKysrIGIvbW0vcGFnZXdh
bGsuYwpAQCAtNywxMSArNywxMyBAQAogc3RhdGljIGludCB3YWxrX3B0ZV9yYW5nZShwbWRfdCAq
cG1kLCB1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAogCQkJICBzdHJ1Y3Qg
bW1fd2FsayAqd2FsaykKIHsKLQlwdGVfdCAqcHRlOworCXB0ZV90ICpwdGUsICpzdGFydF9wdGU7
CiAJaW50IGVyciA9IDA7CiAJY29uc3Qgc3RydWN0IG1tX3dhbGtfb3BzICpvcHMgPSB3YWxrLT5v
cHM7CisJc3BpbmxvY2tfdCAqcHRsOwogCi0JcHRlID0gcHRlX29mZnNldF9tYXAocG1kLCBhZGRy
KTsKKwlwdGUgPSBwdGVfb2Zmc2V0X21hcF9sb2NrKHdhbGstPm1tLCBwbWQsIGFkZHIsICZwdGwp
OworCXN0YXJ0X3B0ZSA9IHB0ZTsKIAlmb3IgKDs7KSB7CiAJCWVyciA9IG9wcy0+cHRlX2VudHJ5
KHB0ZSwgYWRkciwgYWRkciArIFBBR0VfU0laRSwgd2Fsayk7CiAJCWlmIChlcnIpCkBAIC0yMiw3
ICsyNCw3IEBAIHN0YXRpYyBpbnQgd2Fsa19wdGVfcmFuZ2UocG1kX3QgKnBtZCwgdW5zaWduZWQg
bG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKIAkJcHRlKys7CiAJfQogCi0JcHRlX3VubWFw
KHB0ZSk7CisJcHRlX3VubWFwX3VubG9jayhzdGFydF9wdGUsIHB0bCk7CiAJcmV0dXJuIGVycjsK
IH0KIApAQCAtNDksMjEgKzUxLDI0IEBAIHN0YXRpYyBpbnQgd2Fsa19wbWRfcmFuZ2UocHVkX3Qg
KnB1ZCwgdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKIAkJICogVGhpcyBp
bXBsaWVzIHRoYXQgZWFjaCAtPnBtZF9lbnRyeSgpIGhhbmRsZXIKIAkJICogbmVlZHMgdG8ga25v
dyBhYm91dCBwbWRfdHJhbnNfaHVnZSgpIHBtZHMKIAkJICovCi0JCWlmIChvcHMtPnBtZF9lbnRy
eSkKKwkJaWYgKG9wcy0+cG1kX2VudHJ5KSB7CiAJCQllcnIgPSBvcHMtPnBtZF9lbnRyeShwbWQs
IGFkZHIsIG5leHQsIHdhbGspOwotCQlpZiAoZXJyKQotCQkJYnJlYWs7Ci0KLQkJLyoKLQkJICog
Q2hlY2sgdGhpcyBoZXJlIHNvIHdlIG9ubHkgYnJlYWsgZG93biB0cmFuc19odWdlCi0JCSAqIHBh
Z2VzIHdoZW4gd2UgX25lZWRfIHRvCi0JCSAqLwotCQlpZiAoIW9wcy0+cHRlX2VudHJ5KQotCQkJ
Y29udGludWU7CisJCQlpZiAoZXJyKQorCQkJCWJyZWFrOworCQkJLyogTm8gcHRlIGxldmVsIHdh
bGtpbmc/ICovCisJCQlpZiAoIW9wcy0+cHRlX2VudHJ5KQorCQkJCWNvbnRpbnVlOworCQkJLyog
Tm8gcHRlIGxldmVsIGF0IGFsbD8gKi8KKwkJCWlmIChpc19zd2FwX3BtZCgqcG1kKSB8fCBwbWRf
dHJhbnNfaHVnZSgqcG1kKSB8fCBwbWRfZGV2bWFwKCpwbWQpKQorCQkJCWNvbnRpbnVlOworCQl9
IGVsc2UgeworCQkJaWYgKCFvcHMtPnB0ZV9lbnRyeSkKKwkJCQljb250aW51ZTsKIAotCQlzcGxp
dF9odWdlX3BtZCh3YWxrLT52bWEsIHBtZCwgYWRkcik7Ci0JCWlmIChwbWRfdHJhbnNfdW5zdGFi
bGUocG1kKSkKLQkJCWdvdG8gYWdhaW47CisJCQlzcGxpdF9odWdlX3BtZCh3YWxrLT52bWEsIHBt
ZCwgYWRkcik7CisJCQlpZiAocG1kX3RyYW5zX3Vuc3RhYmxlKHBtZCkpCisJCQkJZ290byBhZ2Fp
bjsKKwkJfQogCQllcnIgPSB3YWxrX3B0ZV9yYW5nZShwbWQsIGFkZHIsIG5leHQsIHdhbGspOwog
CQlpZiAoZXJyKQogCQkJYnJlYWs7Cg==
--0000000000002b4d560594047424--
