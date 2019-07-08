Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC2C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5142620844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfGHNsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:48:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728423AbfGHNsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:48:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFC7AB00E;
        Mon,  8 Jul 2019 13:48:06 +0000 (UTC)
Date:   Mon, 8 Jul 2019 15:48:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] kernel.h: Update comment about
 simple_strto<foo>() functions
Message-ID: <20190708134806.crpgmv3zzhd4nz3h@pathway.suse.cz>
References: <20190704115532.15679-1-andriy.shevchenko@linux.intel.com>
 <20190708130159.whefdhz4d65exdns@pathway.suse.cz>
 <CAMuHMdWLT-BKKv9X=7-0d_AbxR+gdbhZZhMxGhrvJ6A2TpeLbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWLT-BKKv9X=7-0d_AbxR+gdbhZZhMxGhrvJ6A2TpeLbg@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-08 15:13:50, Geert Uytterhoeven wrote:
> Hi Petr,
> 
> On Mon, Jul 8, 2019 at 3:02 PM Petr Mladek <pmladek@suse.com> wrote:
> > On Thu 2019-07-04 14:55:31, Andy Shevchenko wrote:
> > > There were discussions in the past about use cases for
> > > simple_strto<foo>() functions and, in some rare cases,
> > > they have a benefit over kstrto<foo>() ones.
> > >
> > > Update a comment to reduce confusion about special use cases.
> > >
> > > Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > - update comment based on Geert's input
> > >  include/linux/kernel.h | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > index 0c9bc231107f..63663c44933d 100644
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -332,8 +332,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
> > >   * @res: Where to write the result of the conversion on success.
> > >   *
> > >   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> > > - * Used as a replacement for the obsolete simple_strtoull. Return code must
> > > - * be checked.
> > > + * Used as a replacement for the simple_strtoull. Return code must be checked.
> > >  */
> > >  static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
> > >  {
> > > @@ -361,8 +360,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
> > >   * @res: Where to write the result of the conversion on success.
> > >   *
> > >   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> > > - * Used as a replacement for the obsolete simple_strtoull. Return code must
> > > - * be checked.
> > > + * Used as a replacement for the simple_strtoull. Return code must be checked.
> > >   */
> > >  static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
> > >  {
> > > @@ -438,7 +436,16 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
> > >       return kstrtoint_from_user(s, count, base, res);
> > >  }
> > >
> > > -/* Obsolete, do not use.  Use kstrto<foo> instead */
> > > +/*
> > > + * Use kstrto<foo> instead.
> > > + *
> > > + * NOTE: The simple_strto<foo> does not check for overflow and,
> > > + *    depending on the input, may give interesting results.
> >
> > I am a bit confused whether the interesting results are caused
> > by the buffer overflow or if there is another reason.
> 
> Which buffer overflow?
> > If it is because of the overflow, I would remove the 2nd line. I guess
> > that anyone knows what a buffer overflow might cause.
> 
> AFAIK, the overflow is a numerical overflow.
> 
> The "interesting result" is that the function keeps parsing until it finds
> a character that doesn't fit in the range of expected characters, according
> to the specified numerical base, but further ignoring character class.
> But that's really what you want, when you want to parse things like
> 10x50 or 10:50.

Thanks for the detailed explanation. It means that the new text is
still confusing. Please, make it more explicit, e.g.

NOTE: simple_strto<foo> does not check for the range overflow.

      The conversion ends on the first non-number character. It is
      needed only for parsing strings like 10;50; or 10:50 without
      the need to modify the original string.

      Be aware that the number base is being detected. Therefore, for
      example, "0x1a" returns 26 (base 16) and "019" returns 1 (base 8).

Best Regards,
Petr
