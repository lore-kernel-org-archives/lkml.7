Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EA5C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A75B206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbfHAQTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:19:15 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:51359 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727024AbfHAQTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:19:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AA946801BDBC;
        Thu,  1 Aug 2019 16:19:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: songs99_32ffe7e5c531c
X-Filterd-Recvd-Size: 2560
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 16:19:09 +0000 (UTC)
Message-ID: <917395fc42633b66abe3f713a9eef8edfdf7ee44.camel@perches.com>
Subject: Re: [PATCH 08/12] printk: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 09:19:04 -0700
In-Reply-To: <CANhBUQ2RD065Dn8eGkbzSQxfie5XrR_kgaFQ1QgOS4cKNhAfPA@mail.gmail.com>
References: <20190729151505.9660-1-hslester96@gmail.com>
         <5dee05d6cb8498b3e636f5e8a62da673334cb5a9.camel@perches.com>
         <CANhBUQ2RD065Dn8eGkbzSQxfie5XrR_kgaFQ1QgOS4cKNhAfPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 23:23 +0800, Chuhong Yuan wrote:
> Joe Perches <joe@perches.com> 于2019年7月30日周二 上午8:16写道：
> > On Mon, 2019-07-29 at 23:15 +0800, Chuhong Yuan wrote:
> > > strncmp(str, const, len) is error-prone.
> > > We had better use newly introduced
> > > str_has_prefix() instead of it.
> > []
> > > diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
> > []
> > > @@ -11,10 +11,10 @@
> > > 
> > >  int _braille_console_setup(char **str, char **brl_options)
> > >  {
> > > -     if (!strncmp(*str, "brl,", 4)) {
> > > +     if (str_has_prefix(*str, "brl,")) {
> > >               *brl_options = "";
> > >               *str += 4;
> > > -     } else if (!strncmp(*str, "brl=", 4)) {
> > > +     } else if (str_has_prefix(*str, "brl=")) {
> > >               *brl_options = *str + 4;
> > 
> > Better to get rid of the += 4 uses too by storing the result
> > of str_has_prefix and using that as the addend.
> > 
> > Perhaps
> >         size_t len;
> > 
> >         if ((len = str_has_prefix(*str, "brl,"))) {
> >                 *brl_options = "";
> >                 *str += len;
> >         } else if ((len = str_has_prefix(*str, "brl="))) {
> >                 etc...
> > 
> 
> I find that checkpatch.pl forbids assignment in if condition.
> So this seems to be infeasible...

checkpatch is a stupid script and doesn't forbid
anything.  It's just a suggestion guide.

Ignore checkpatch when you know better.


