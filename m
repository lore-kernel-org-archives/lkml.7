Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEECC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4239121743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yWuFBwvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbfGPWpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:45:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42807 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPWpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id s184so16925123oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CHc4daItHr047JAX6t6Ygj5bjbut9nVoR+XN5tnnFNU=;
        b=yWuFBwvCVvk0bqJ1fWzLXH2rBWx/FNnUSgVei/R5Ar5PeDVXdMfiBgNSwKyI2Ht2KZ
         LSrvS9RJI96GzWauHQwqt67UNiuc2qCaC5rLLu6VZcHDrxOGzslnCjT2e2qxZ0rFt5D4
         luQB1aPKdURv5/cdrcPuQsK1PnBOYpNB/+lfGAI9usbEIeg8N60a+THwW7+dR+yaHIDL
         ato8gF15L0hsZsqQcCS1O9DFzP76Yf4sNul3sgeiMgJbsOvPqk8MtpsdKqkkgbtDZvw8
         qR3YWl8qz/lq/e01gxS90t01/VluVPvoDRQc40zDNvxww8+mVVmAAURMrK3hbtUWN65F
         /Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CHc4daItHr047JAX6t6Ygj5bjbut9nVoR+XN5tnnFNU=;
        b=QEpqzosLTgz4ZX13fcM6aPwvy2+Nwgu7nvtweOZcnon0sYphW9qtlBLcM+W9j6cKYL
         TnoBRQYADv4h9duZyCyg69oqXi4Vza2DShfPp6nsvJLz/5rDDgb/6/7+aOKSdY+dFRxI
         T/Fmr9Y9Yj9wymQnFay5bS3WXpUcJzt+drXpj0/0W8JbVa+iNM2JFkpgl5HiEx6LpZt6
         DqfGe2qXU81UGZ5CstNc5OWr9Kt2EALffmomWCvNA7JhgAFLhG90O5pACUMTZjjg4cA8
         aEDH15v73i2NT//GNvr5z/E/MB7hwzecojDXFz/wNinN+nietavHuL/cKgL/3eDoQbRS
         w5uA==
X-Gm-Message-State: APjAAAXoianEMcf8CjCdWtMwd7+i2h/mOdRXDnNdWqp9hxtu+un79kUK
        xoc4+qlv/8cYV8Egdd9GCdrFzyJbX2ZI7+6O55pSu1vO
X-Google-Smtp-Source: APXvYqwATpjKwXHNrTFAzooQoGXlc0BH9RXXaDSu7AI1VaKpd0PA2MG4OY2F2Xuo3BJH3fT51VRssHd8KgiBQhs9XeY=
X-Received: by 2002:aca:1304:: with SMTP id e4mr17392219oii.149.1563317119863;
 Tue, 16 Jul 2019 15:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190613045903.4922-1-namit@vmware.com> <CAPcyv4hpWg5DWRhazS-ftyghiZP-J_M-7Vd5tiUd5UKONOib8g@mail.gmail.com>
 <9387A285-B768-4B58-B91B-61B70D964E6E@vmware.com> <CAPcyv4hstt+0teXPtAq2nwFQaNb9TujgetgWPVMOnYH8JwqGeA@mail.gmail.com>
 <19C3DCA0-823E-46CB-A758-D5F82C5FA3C8@vmware.com> <20190716150047.3c13945decc052c077e9ee1e@linux-foundation.org>
 <CAPcyv4iqNHBy-_WbH9XBg5hSqxa=qnkc88EW5=g=-5845jNzsg@mail.gmail.com>
 <D463DD43-C09F-4B6E-B1BC-7E1CA5C8A9C4@vmware.com> <CAPcyv4gGkgCsf4NtDPj7FNcTMO6o+fUYgfq8AP_pLkqDSbxjzA@mail.gmail.com>
 <39E58DBC-C13E-429C-A5FC-8FD80ABBBF55@vmware.com>
In-Reply-To: <39E58DBC-C13E-429C-A5FC-8FD80ABBBF55@vmware.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jul 2019 15:45:08 -0700
Message-ID: <CAPcyv4g4Qv-1eEcVxfr4gnTngprtn1DdwXBgRQ3T_-9Kr0vKDw@mail.gmail.com>
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

On Tue, Jul 16, 2019 at 3:29 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jul 16, 2019, at 3:20 PM, Dan Williams <dan.j.williams@intel.com> wr=
ote:
> >
> > On Tue, Jul 16, 2019 at 3:13 PM Nadav Amit <namit@vmware.com> wrote:
> >>> On Jul 16, 2019, at 3:07 PM, Dan Williams <dan.j.williams@intel.com> =
wrote:
> >>>
> >>> On Tue, Jul 16, 2019 at 3:01 PM Andrew Morton <akpm@linux-foundation.=
org> wrote:
> >>>> On Tue, 18 Jun 2019 21:56:43 +0000 Nadav Amit <namit@vmware.com> wro=
te:
> >>>>
> >>>>>> ...and is constant for the life of the device and all subsequent m=
appings.
> >>>>>>
> >>>>>>> Perhaps you want to cache the cachability-mode in vma->vm_page_pr=
ot (which I
> >>>>>>> see being done in quite a few cases), but I don=E2=80=99t know th=
e code well enough
> >>>>>>> to be certain that every vma should have a single protection and =
that it
> >>>>>>> should not change afterwards.
> >>>>>>
> >>>>>> No, I'm thinking this would naturally fit as a property hanging of=
f a
> >>>>>> 'struct dax_device', and then create a version of vmf_insert_mixed=
()
> >>>>>> and vmf_insert_pfn_pmd() that bypass track_pfn_insert() to insert =
that
> >>>>>> saved value.
> >>>>>
> >>>>> Thanks for the detailed explanation. I=E2=80=99ll give it a try (th=
e moment I find
> >>>>> some free time). I still think that patch 2/3 is beneficial, but ba=
sed on
> >>>>> your feedback, patch 3/3 should be dropped.
> >>>>
> >>>> It has been a while.  What should we do with
> >>>>
> >>>> resource-fix-locking-in-find_next_iomem_res.patch
> >>>
> >>> This one looks obviously correct to me, you can add:
> >>>
> >>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >>>
> >>>> resource-avoid-unnecessary-lookups-in-find_next_iomem_res.patch
> >>>
> >>> This one is a good bug report that we need to go fix pgprot lookups
> >>> for dax, but I don't think we need to increase the trickiness of the
> >>> core resource lookup code in the meantime.
> >>
> >> I think that traversing big parts of the tree that are known to be
> >> irrelevant is wasteful no matter what, and this code is used in other =
cases.
> >>
> >> I don=E2=80=99t think the new code is so tricky - can you point to the=
 part of the
> >> code that you find tricky?
> >
> > Given dax can be updated to avoid this abuse of find_next_iomem_res(),
> > it was a general observation that the patch adds more lines than it
> > removes and is not strictly necessary. I'm ambivalent as to whether it
> > is worth pushing upstream. If anything the changelog is going to be
> > invalidated by a change to dax to avoid find_next_iomem_res(). Can you
> > update the changelog to be relevant outside of the dax case?
>
> Well, 8 lines are comments, 4 are empty lines, so it adds 3 lines of code
> according to my calculations. :)
>
> Having said that, if you think I might have made a mistake, or you are
> concerned with some bug I might have caused, please let me know. I
> understand that this logic might have been lying around for some time.

Like I said, I'm ambivalent and not NAK'ing it. It looks ok, but at
the same time something is wrong if a hot path is constantly
re-looking up a resource. The fact that it shows up in profiles when
that happens could be considered useful.

> I can update the commit log, emphasizing the redundant search operations =
as
> motivation and then mentioning dax as an instance that induces overheads =
due
> to this overhead, and say it should be handled regardless to this patch-s=
et.
> Once I find time, I am going to deal with DAX, unless you beat me to it.

It turns out that the ability to ask the driver for pgprot bits is
useful above and beyond this performance optimization. For example I'm
looking to use it to support disabling speculation into pages with
known  media errors by letting the driver consult its 'badblock' list.
There are also usages for passing the key-id for persistent memory
encrypted by MKTME.
