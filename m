Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF04C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFC4204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfFZISP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:18:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36399 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:18:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so1674960oti.3;
        Wed, 26 Jun 2019 01:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IVbKnkaSGCX3gm0GB9llTNW29e8KVqX77iAzmybS0U=;
        b=Q267OzRAYVpkoVfPQzItRmukN57ROVqBXVKUNPm90cgFLAmXm4DeH5Em4lrBChFL0h
         pfh91E/ybI6UvXtPPoOxY94bCcPd/aem9NkqzuyqF0mrAddbZvaNiSDNqxVps2fq31VL
         EUVz3Am0KuVmHi9m6o45jwulL3gOcEWkVgmAplNZmJ9Jd2J/KJaQvb4VovQwqmC3hGWu
         fUa6XFsmzTKi6O1ig+SvCEnkr7i+jAIZrNgT0lH7Aw5FSay4bSkDxnuXBKrv9SetCX6K
         J72AubuoYHrUtg5T1BAuzEecOWCGkaq9vOnjKbrwnlkLwdgHua05HBg2Twk6w4bc3Ix2
         /wig==
X-Gm-Message-State: APjAAAWLfFN8jgv7Nsiy8CfUVpr6vOG4gYwMaiEIjvj4+FrXNsyKkXfD
        CUrljCi0cNOatV8nxo4wxLgiu5DB9gBzHbKXWwVPaQ==
X-Google-Smtp-Source: APXvYqx21GlpsHmjxHQKZ88k/g5/4tos1Mt5NsOKYjmDkJoG9anxOCkcBrQN/NZvOzKudbfMCl4uzn2PncvBxlK+Lzw=
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr2314425oto.39.1561537093283;
 Wed, 26 Jun 2019 01:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190613070903.17214-1-hch@lst.de> <20190613070903.17214-9-hch@lst.de>
 <20190625222941.GA1343@ZenIV.linux.org.uk> <f8a61a8e-0469-a9d6-e0a1-01a4619d7363@linux-m68k.org>
In-Reply-To: <f8a61a8e-0469-a9d6-e0a1-01a4619d7363@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jun 2019 10:18:02 +0200
Message-ID: <CAMuHMdXkMh+pOqPNavmYAhKXTVT12nC5gKc10CJj_CXME+uhWQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] binfmt_flat: consolidate two version of flat_v2_reloc_t
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Michal Simek <monstr@monstr.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Jun 26, 2019 at 9:23 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 26/6/19 8:29 am, Al Viro wrote:
> > On Thu, Jun 13, 2019 at 09:08:54AM +0200, Christoph Hellwig wrote:
> >> Two branches of the ifdef maze actually have the same content, so merge
> >> them.
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >>   include/linux/flat.h | 6 ++----
> >>   1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/flat.h b/include/linux/flat.h
> >> index 2b7cda6e9c1b..19c586b74b99 100644
> >> --- a/include/linux/flat.h
> >> +++ b/include/linux/flat.h
> >> @@ -69,15 +69,13 @@ struct flat_hdr {
> >>   typedef union {
> >>      unsigned long   value;
> >>      struct {
> >> -# if defined(mc68000) && !defined(CONFIG_COLDFIRE)
> >> +#if defined(__LITTLE_ENDIAN_BITFIELD) || \
> >> +    (defined(mc68000) && !defined(CONFIG_COLDFIRE))
> >>              signed long offset : 30;
> >>              unsigned long type : 2;
> >>   # elif defined(__BIG_ENDIAN_BITFIELD)
> >>              unsigned long type : 2;
> >>              signed long offset : 30;
> >> -# elif defined(__LITTLE_ENDIAN_BITFIELD)
> >> -            signed long offset : 30;
> >> -            unsigned long type : 2;
> >>   # else
> >>   #          error "Unknown bitfield order for flat files."
> >>   # endif
> >> --
> >> 2.20.1
> >>
> >
> > FWIW, I wonder if keeping that type is worth bothering.
> > Something like
> > old_reloc(__be32 reloc)
> > {
> >       u32 v = be32_to_cpu(reloc);
> >       int offset, type;
> >
> > #if (defined(mc68000) && !defined(CONFIG_COLDFIRE))
> >       /* old m68k uses unusual format - type is in lower bits of octet 3 */
> >       type = v % 4;
> >       offset = (int)v / 4;
> > #else
> >       /* everything else (including coldfire) has it in upper bits of octet 0 */
> >       type = v >> 30;
> >       offset = (int)(v << 2) >> 2; /* or (v & 0x1fffffff) - (v & 0x20000000) * 4 */
> > #endif
> >       ...
> >
> > and to hell with bitfields, aliasing unions, etc.  Unless I'm misreading
> > the whole thing, that is...  Greg?
>
> I think you are right. This is much better.
> The old mc6800 is the odd one out, the rest have it in network order,
> and this makes that much clearer.

Is that correct for Microblaze, which can be big or little endian?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
