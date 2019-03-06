Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9475120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfCFIUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:20:43 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42052 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfCFIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:20:43 -0500
Received: by mail-io1-f67.google.com with SMTP id p196so9463144iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 00:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puIPM2SEaE/SY4AAPfNoXvnDdkhGD4eur/O4uEB4sKc=;
        b=uOQCCSpCtXpG+ttv7LVkdW5lEgjXyvSFF5dNHSNw23FH253A66CMKZM7bmJqbIkaKG
         Wc7VTfvYVtSr5dxJqcRSkf9LT3CfI0HamYUoNcWEia0x/KlI9eR+hMI5P6nUfyIbBW8h
         jVdWs3RB5HUqDtlP5NKQmDPdS8+mNQjB9/UlWmV3DtA1HD3pXRjw3/QdA9r4xokTAauA
         +TVXmMeT2F3ZHB2VkDFTTK1Njnd7YZzJqGoPfQ1aRTCPr98jDz+xP7v/GNzQ95Vo7zfc
         5J2PEzP1f5tKXGUcTkooo/tt9P8vfSrHb6cH+zfNHNNcbJprCihvxNUZ5AP3enidgF2o
         laWw==
X-Gm-Message-State: APjAAAV8qoVKytgI3uXqq+S+z3G0bnK9L2oXbr46JtvtL/ilhWhxZ0WU
        Et0vn6li2VahLFGALTMK+9hQz1r5Gh/Vg3d5udh67w==
X-Google-Smtp-Source: APXvYqz3KgQ0aSqUQo9GwnLA+H6fxzWGkEppS2svuzfnmjmin95zRgq0zAAdjXmVWc1EhxODrqt31YSRONO0KvrsHdQ=
X-Received: by 2002:a6b:37d4:: with SMTP id e203mr2516264ioa.137.1551860442188;
 Wed, 06 Mar 2019 00:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20190213082800.4400-1-kasong@redhat.com> <20190228231202.3wvojgxscrodoalt@dwarf.suse.cz>
In-Reply-To: <20190228231202.3wvojgxscrodoalt@dwarf.suse.cz>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 6 Mar 2019 16:20:31 +0800
Message-ID: <CACPcB9fkho7n16Q9mDVddQF_8hyArP7ZyzS6q87e+b-R+wX1RQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/gart/kcore: Exclude GART aperture from kcore
To:     Jiri Bohac <jbohac@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 7:12 AM Jiri Bohac <jbohac@suse.cz> wrote:
>
> On Wed, Feb 13, 2019 at 04:28:00PM +0800, Kairui Song wrote:
> > @@ -465,6 +472,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> >                               goto out;
> >                       }
> >                       m = NULL;       /* skip the list anchor */
> > +             } else if (m->type == KCORE_NORAM) {
> > +                     /* for NORAM area just fill zero */
> > +                     if (clear_user(buffer, tsz)) {
> > +                             ret = -EFAULT;
> > +                             goto out;
> > +                     }
>
> I don't think this works reliably. The loop filling the buffer
> has this logic at the top:
>
>         while (buflen) {
>                 /*
>                  * If this is the first iteration or the address is not within
>                  * the previous entry, search for a matching entry.
>                  */
>                 if (!m || start < m->addr || start >= m->addr + m->size) {
>                         list_for_each_entry(m, &kclist_head, list) {
>                                 if (start >= m->addr &&
>                                     start < m->addr + m->size)
>                                         break;
>                         }
>                 }
>
> This sets m to the kclist entry that contains the memory being
> read. But if we do a large read that starts in valid KCORE_RAM
> memory below the GART overlap and extends into the overlap, m
> will not be set to the KCORE_NORAM entry. It will keep pointing
> to the KCORE_RAM entry and the patch will have no effect.
>
> But this seems already broken in existing cases as well, various
> KCORE_* types overlap with KCORE_RAM, don't they?  So maybe
> bf991c2231117d50a7645792b514354fc8d19dae ("proc/kcore: optimize
> multiple page reads") broke this and once fixed, this KCORE_NORAM
> approach will work. Omar?
>

Thanks for the review! You are right, although I hid the NORAM region
from the elf header, but didn't notice this potential risk of having
overlapped region.
I didn't see other kcore regions overlap for now, if so the
optimization should be totally good.
Better to keep using a hook just like what we did in vmcore or we will
have a performance drop for "fixing" this.
Will send V4 using the previous approach if there are no further comments.

-- 
Best Regards,
Kairui Song
