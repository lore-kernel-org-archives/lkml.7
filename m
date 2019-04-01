Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F876C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E4820857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W10vcUCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfDAU4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:56:43 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:51747 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfDAU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:56:42 -0400
Received: by mail-it1-f169.google.com with SMTP id s3so1524745itk.1;
        Mon, 01 Apr 2019 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AT3+Y+13K2Cpfxn61ywWivlGpkV37QTXmmh6edUQOcE=;
        b=W10vcUCUuNW1SvLmkUv5TN0rM6YlxTZNQHJlOVFW6lFlV6+7A7UiFbLhHsCF3kunLF
         sGG53Tf/H/Ug1a3d4q44Ic7BoAgN1iw2sEeeMjNaB7QdSagIUpwzc/3Pc1o+X2/CuFBD
         migPFwxO+q0sQAUSL9GNPgyok5+pfEYxGPZq0AotXywWvFhm/25T6S10XepBLJHr7vcb
         wZBCW/RvB8GVAVVzQ4UehYd535fsDGlaKBv+JFU3wzBEQvA0wuccZZPpFAHFxmFsAYkJ
         wHkSkJ1K3WAZ3l3S40zRQV3EtZdwF/Uh9qBSXZHmpCgzpph9XbQ0CqKWsd48lqZrd/dW
         /z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT3+Y+13K2Cpfxn61ywWivlGpkV37QTXmmh6edUQOcE=;
        b=Ghly8ELXDru8GUpKtqHroNPnjF0AwdJWzrI7U4G/rjE1ITtuf7xxlHCSO5BHT7BTm1
         yas7pobEX0InlriR4NqprvuM41cHpYnG1R9S/zitAURE+aEB5uaUVFC89W0ePURF6Ne+
         EBmSo5KGE2MBYgAmss0ifLZNSTBdXUaKPUxuQQdRyUeaFMHPR1LV2rnhbqtGHrI85qks
         0nl1E8BameoM6bW4z+VU4hBylcZOVatrG7uptLBM6T7VEZ+4zEj8AjbpJs0O5y1x8WTz
         mEmL8zpmecKk9PXNqUZFdJ/UmpTD8pRil6mjaPSgolWx5SAjrlhQO/g3qFD31HmuMAyF
         0Ysw==
X-Gm-Message-State: APjAAAUV85wqgGRNCiN/6wGtuvgsvYPm5NbAnDiZ2R0eis2SOgsSWfo9
        o88Ys3JYrkbSLbTi/kGWgXO60eqdJmjqy5dcJmM=
X-Google-Smtp-Source: APXvYqxPdFADHjAK+0CFde23ZbwoLf1eXIIt4cdtDXo08VhKkesuIbGveqz+tqbUfBYlEaVHfcg+WTsTVB9Qcl5JDSk=
X-Received: by 2002:a24:7c52:: with SMTP id a79mr1507399itd.51.1554152201716;
 Mon, 01 Apr 2019 13:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190329084058-mutt-send-email-mst@kernel.org>
 <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com> <20190329104311-mutt-send-email-mst@kernel.org>
 <7a3baa90-5963-e6e2-c862-9cd9cc1b5f60@redhat.com> <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
 <20190329125034-mutt-send-email-mst@kernel.org> <fb23fd70-4f1b-26a8-5ecc-4c14014ef29d@redhat.com>
 <20190401073007-mutt-send-email-mst@kernel.org> <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
 <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com> <20190401104608-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190401104608-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 1 Apr 2019 13:56:30 -0700
Message-ID: <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com>
Subject: Re: On guest free page hinting and OOM
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 7:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Apr 01, 2019 at 04:11:42PM +0200, David Hildenbrand wrote:
> > > The interesting thing is most probably: Will the hinting size usually be
> > > reasonable small? At least I guess a guest with 4TB of RAM will not
> > > suddenly get a hinting size of hundreds of GB. Most probably also only
> > > something in the range of 1GB. But this is an interesting question to
> > > look into.
> > >
> > > Also, if the admin does not care about performance implications when
> > > already close to hinting, no need to add the additional 1Gb to the ram size.
> >
> > "close to OOM" is what I meant.
>
> Problem is, host admin is the one adding memory. Guest admin is
> the one that knows about performance.

The thing we have to keep in mind with this is that we are not dealing
with the same behavior as the balloon driver. We don't need to inflate
a massive hint and hand that off. Instead we can focus on performing
the hints on much smaller amounts and do it incrementally over time
with the idea being as the system sits idle it frees up more and more
of the inactive memory on the system.

With that said, I still don't like the idea of us even trying to
target 1GB of RAM for hinting. I think it would be much better if we
stuck to smaller sizes and kept things down to a single digit multiple
of THP or higher order pages. Maybe something like 64MB of total
memory out for hinting.

All we really would need to make it work would be to possibly look at
seeing if we can combine PageType values. Specifically what I would be
looking at is a transition that looks something like Buddy -> Offline
-> (Buddy | Offline). We would have to hold the zone lock at each
transition, but that shouldn't be too big of an issue. If we are okay
with possibly combining the Offline and Buddy types we would have a
way of tracking which pages have been hinted and which have not. Then
we would just have to have a thread running in the background on the
guest that is looking at the higher order pages and pulling 64MB at a
time offline, and when the hinting is done put them back in the "Buddy
| Offline" state.

I view this all as working not too dissimilar to how a standard Rx
ring in a network device works. Only we would want to allocate from
the pool of "Buddy" pages, flag the pages as "Offline", and then when
the hint has been processed we would place them back in the "Buddy"
list with the "Offline" value still set. The only real changes needed
to the buddy allocator would be to add some logic for clearing/merging
the "Offline" setting as necessary, and to provide an allocator that
only works with non-"Offline" pages.
