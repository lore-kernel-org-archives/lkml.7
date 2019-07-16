Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1C6C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD0D21743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="v+Nv91jW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbfGPWU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:20:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40794 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfGPWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:20:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id y20so6906643otk.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TNhwUv6Ky0s0w03ioY+550UObTT5jDR+657SS9hX3Ow=;
        b=v+Nv91jWpEWxB3/zZPcDf9TsGYnNUk2CxCYeiVF+WXu3e72lpqWE3E3zL1uP7kKM/I
         mWSC+EA9GPfECv8Dn/F4GCe6BsHuCw3YffdB81/ykh7RlRXTTw+lkwKY5db6NKrA0wiM
         vJIJM0ndSx7Z3vlHSM1Q3GD+OEhEsPak9HqQTmobk2mGCg2RSWBdQZF02DAKviNTolDt
         9SDDOnUdeKCBGe7Zb1ms0i6Eeqm5M8nPavXAQW+DCdbon412FKOVp1/ASfZ7Zm17UkmT
         5oS4kv9hgZ/bOnz/bdm2TKsksc6TCLtJ8qcCftpMyybO9L+LzRjA6LNjWj/T+Tz+Wkpf
         Gyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TNhwUv6Ky0s0w03ioY+550UObTT5jDR+657SS9hX3Ow=;
        b=dyVExymm3AETUe5uB80F83gzbEc/rEqfkbeENZNz4W8oFl8ripOP8yLT6iuh2pcwFz
         g6Nip+sdjV92t2/3pICYETUj04u00XVIH/H62uvBRdJaazcBRUihmTGs9Ce5KWbKYQSL
         VM9Nn3xASj/m55DmBCxDkvrAxHuZYHaxHgVApxlCvCCBxDAsbmQBB1b+QT11KXbhMJh9
         wDB0eYe/VxJ6cHJJz5hvYyond6jb3yelsphNViDrLDmqzvdOGNaKmFp84yxdd43axdcE
         5ivp+FiyCBxgAiCi+z4QM+DxP8pPj5jBscvw1hZfTt69TfknhTtcfuDDZTM/GHZ++PBl
         RtmQ==
X-Gm-Message-State: APjAAAVBv9Db4gYGOA83npjx2hhvixTiu7OLz1F8/wiZTS6A6F3q8AZB
        6EBZ/lmqX06wacC+mEnAVhPLLumaF1bOKDiA7sOzzg==
X-Google-Smtp-Source: APXvYqwEIU4jOVbAg9CR3IdZtyD05lbj5Yyf9evbtBtEsapl8Q2qFdqA8FewNacU01JSVqaAY5FbVjHEwxNT2ZHQ5YY=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr1338868oto.207.1563315656274;
 Tue, 16 Jul 2019 15:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190613045903.4922-1-namit@vmware.com> <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
 <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com> <CAPcyv4hstt+0teXPtAq2nwFQaNb9TujgetgWPVMOnYH8JwqGeA@mail.gmail.com>
 <19C3DCA0-823E-46CB-A758-D5F82C5FA3C8@vmware.com> <20190716150047.3c13945decc052c077e9ee1e@linux-foundation.org>
 <CAPcyv4iqNHBy-_WbH9XBg5hSqxa=qnkc88EW5=g=-5845jNzsg@mail.gmail.com> <D463DD43-C09F-4B6E-B1BC-7E1CA5C8A9C4@vmware.com>
In-Reply-To: <D463DD43-C09F-4B6E-B1BC-7E1CA5C8A9C4@vmware.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jul 2019 15:20:45 -0700
Message-ID: <CAPcyv4gGkgCsf4NtDPj7FNcTMO6o+fUYgfq8AP_pLkqDSbxjzA@mail.gmail.com>
Subject: Re: [PATCH 0/3] resource: find_next_iomem_res() improvements
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 3:13 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jul 16, 2019, at 3:07 PM, Dan Williams <dan.j.williams@intel.com> wr=
ote:
> >
> > On Tue, Jul 16, 2019 at 3:01 PM Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> >> On Tue, 18 Jun 2019 21:56:43 +0000 Nadav Amit <namit@vmware.com> wrote=
:
> >>
> >>>> ...and is constant for the life of the device and all subsequent map=
pings.
> >>>>
> >>>>> Perhaps you want to cache the cachability-mode in vma->vm_page_prot=
 (which I
> >>>>> see being done in quite a few cases), but I don=E2=80=99t know the =
code well enough
> >>>>> to be certain that every vma should have a single protection and th=
at it
> >>>>> should not change afterwards.
> >>>>
> >>>> No, I'm thinking this would naturally fit as a property hanging off =
a
> >>>> 'struct dax_device', and then create a version of vmf_insert_mixed()
> >>>> and vmf_insert_pfn_pmd() that bypass track_pfn_insert() to insert th=
at
> >>>> saved value.
> >>>
> >>> Thanks for the detailed explanation. I=E2=80=99ll give it a try (the =
moment I find
> >>> some free time). I still think that patch 2/3 is beneficial, but base=
d on
> >>> your feedback, patch 3/3 should be dropped.
> >>
> >> It has been a while.  What should we do with
> >>
> >> resource-fix-locking-in-find_next_iomem_res.patch
> >
> > This one looks obviously correct to me, you can add:
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> >> resource-avoid-unnecessary-lookups-in-find_next_iomem_res.patch
> >
> > This one is a good bug report that we need to go fix pgprot lookups
> > for dax, but I don't think we need to increase the trickiness of the
> > core resource lookup code in the meantime.
>
> I think that traversing big parts of the tree that are known to be
> irrelevant is wasteful no matter what, and this code is used in other cas=
es.
>
> I don=E2=80=99t think the new code is so tricky - can you point to the pa=
rt of the
> code that you find tricky?

Given dax can be updated to avoid this abuse of find_next_iomem_res(),
it was a general observation that the patch adds more lines than it
removes and is not strictly necessary. I'm ambivalent as to whether it
is worth pushing upstream. If anything the changelog is going to be
invalidated by a change to dax to avoid find_next_iomem_res(). Can you
update the changelog to be relevant outside of the dax case?
