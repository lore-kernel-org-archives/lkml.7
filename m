Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8397C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED9421897
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfIQW2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:28:39 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:54611 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbfIQW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:28:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D6F1818038B43;
        Tue, 17 Sep 2019 22:28:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: doll51_2dc9165fbe829
X-Filterd-Recvd-Size: 2939
Received: from XPS-9350 (unknown [14.161.9.139])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Sep 2019 22:28:34 +0000 (UTC)
Message-ID: <d6d30d81aa73404cbb5479b373bce2b14850577b.camel@perches.com>
Subject: Re: [rfc patch script] treewide conversion of __section(foo) to
 section("foo");
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 17 Sep 2019 15:28:31 -0700
In-Reply-To: <CAKwvOd=uzQJ_098ua5VuUuDaWqGQHncED4WWjNwNS0-CdE5mfw@mail.gmail.com>
References: <7ef58eb00bc46b4ea3fe49a8c45cd2ff06292247.camel@perches.com>
         <CAKwvOdn6bMGZFAwH8iS5xD+Ce7oV8U6Fgi_SrFpCjo2-1hEUrw@mail.gmail.com>
         <a8290101e2720cac8b06613ec4cb91ffbfd69f05.camel@perches.com>
         <CAKwvOd=uzQJ_098ua5VuUuDaWqGQHncED4WWjNwNS0-CdE5mfw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 12:45 -0700, Nick Desaulniers wrote:
> On Thu, Sep 12, 2019 at 4:50 PM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2019-09-12 at 15:45 -0700, Nick Desaulniers wrote:
> > > If you want to email me just the patch file (so I don't have to
> > > copy+pasta from an email),
> > 
> > Lazy... ;)
> Says the Perl programmer...http://threevirtues.com/ ;)

Everyone here has most of those.  You too.

> > > I'd be happy to apply it and compile+boot test a few more arch's
> > > than x86.
> 
> Looks like arm defconfig has an error:

Thanks.

> arch/arm/mach-omap2/omap-wakeupgen.c:634:1: error: expected ';' after
> top level declarator
> ./include/linux/irqchip.h:27:43: note: expanded from macro 'IRQCHIP_DECLARE'
> #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name,
> compat, fn)
>                                           ^
> ./include/linux/of.h:1304:3: note: expanded from macro 'OF_DECLARE_2'
>                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
>                 ^
> ./include/linux/of.h:1284:10: note: expanded from macro '_OF_DECLARE'
>                 __used __section("__" ## table ## "_of_table")          \

Thanks, I stuffed up the # concatenation.  I'll fix and send the
script again.
> 
> and modpost is broken:
> drivers/cpufreq/cpufreq_conservative.mod.c:12:11: error: expected expression
> __section(.gnu.linkonce.this_module) = {
>           ^
> 1 error generated.

This one is because:

scripts/mod/modpost.c:  buf_printf(b, "__section(.gnu.linkonce.this_module) = {\n");

Easy to add quotes here,  I'll add it to the script.

> Same problem (token pasting then concatenation of strings).

right...


