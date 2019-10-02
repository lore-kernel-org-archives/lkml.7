Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D366C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB6D21D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570039626;
	bh=r/Ma9GOxLkElJodBCpox5WBBhm8RiRWqVvnaKg0xjCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JFJpZPP0SImXQLW6HMMBKJTnl+zEAOznHEnJKMsCTv1125vLNLJ0EJnNaS82qpzHy
	 AIlisGSUi6wcOdwIsQFSGfrngOvbyTvzFHAnkMQ19ZdHETh5InXgkBSCGeulKolOFN
	 s28MOT2EpXm1ManlcJwiXuXRhVAUXZTP6qG5SQBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfJBSHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:07:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46980 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:07:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so13380238lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LI8YD1l9wWpd4czC3TbcOWwWakrV1Iiw4AlgOzqD4sc=;
        b=Dh2G8GYr8EPvelOroqLSHC/KxuCKYDezy/8X2VOtg5D0e92mG2pHLP70TqaN2AfR9k
         0nLutEeynYTet4qiWK21uAUE+bdD6KLHao28LPAqwhOGZo7KVaP2s21u92x8UDfJvlon
         JS/hqGTaum4haQPegZco3tzb8IrjpJe1sLu54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LI8YD1l9wWpd4czC3TbcOWwWakrV1Iiw4AlgOzqD4sc=;
        b=jas+Q7bQhxIDEjXJlhT/g8KNboUar9d7UO/cbC3tL3AtYKuNE0uQ0qIcvG05R4oJKq
         OwJyAqBwfaTwHk3xWhGgkNHS3kYgW4CjUUA+l4tssm+3j4phua+EBwgk06Gy4U4x/6Gg
         /yZZcxG1ThupPBDhXRFbL/9SgEiYdiCmw2agdYLed5q3v3t63sIigB3rTXhqfZyzmAU+
         YKROWpNIDRg+Pba8F4oPp3qNtKMAlCSG9c+pK9Vsip1bN+UQrb12pv2Myn7vuWULfYdG
         7z6GmP1HkbXED3PuSxTXJF3Lnyj64DbE4teFtG7wSPCueY/eLsdlca8VzXXCSMmkF+Ji
         +/Lg==
X-Gm-Message-State: APjAAAX0Erngrt89WvCnjgYKyRmgnS0LhQhNP26PQtwuCZrMIb0mGkbq
        cojGAJR6bIO/duHZgxZLS8VYqpaPmk4=
X-Google-Smtp-Source: APXvYqyD4hx4SW71VsSsy3LNwQuowODNMKY16uTfHEuI3qaZI+Sby7Z1qSRy4ug5Vp9f5m3sw47Hwg==
X-Received: by 2002:a19:ee02:: with SMTP id g2mr3116243lfb.113.1570039622337;
        Wed, 02 Oct 2019 11:07:02 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id s6sm31991ljg.43.2019.10.02.11.06.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:06:59 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m7so18137865lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:06:59 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr3405968ljf.48.1570039619077;
 Wed, 02 Oct 2019 11:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191002134730.40985-1-thomas_os@shipmail.org> <20191002134730.40985-4-thomas_os@shipmail.org>
In-Reply-To: <20191002134730.40985-4-thomas_os@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Oct 2019 11:06:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
Message-ID: <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 6:48 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> Add two utilities to a) write-protect and b) clean all ptes pointing into
> a range of an address space.

This one I still don't exactly love.

I'm not entirely sure what rubs me the wrong way, but part of it is
naming. We don't use the name "as", because it reads as (sic) an
English word.

The name we use for address_space pointers is "mapping", both for
variables and for existing functions.

See for example "pte_same_as_swp()" which uses "as" as the _word_ 'as'.

Contrast that with "unmap_mapping_range()" or
"mapping_set_unevictable()" or "read_mapping_page()" or
"invalidate_mapping_pages()", that all work on address spaces.

So please don't use 'as' as shorthand for that - eithe rin the
function names or the filename.

I'm not sure if that's the _only_ thing that raises my heckles when I
read this patch, but I think it might be. So I'm not saying "ack with
naming change", but I suspect that if the naming was changed, it would
look much better to me.

Yes, it's a bit more typing. But I really think
"clean_mapping_dirty_pages()" is just not only more in line with the
mm naming, I think it's a lot more legible and understandable than
"as_dirty_clean()", which just makes me go "what the heck does that
function do?"

And I really think it needs more than just "as" -> "mapping".
"mapping_dirty_clean()" still makes me go "what?" in a way that
"clean_mapping_dirty_pages()" does not. One name reads as a series or
random words, the other reads as a "this is what the function does".

I know I sometimes get hung up about naming, but I do think naming
matters.  A descriptive name that just reads as what the function does
makes it much easier to read the logic of code, imnsho.

              Linus
