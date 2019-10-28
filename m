Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8EACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8401F2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfJ1W20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:28:26 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:44446 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfJ1W20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:28:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 914C78384360;
        Mon, 28 Oct 2019 22:28:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crown52_665b347525d29
X-Filterd-Recvd-Size: 4204
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 22:28:23 +0000 (UTC)
Message-ID: <00c5ef125a4e62f538de7ddddc9d8fe7085794a3.camel@perches.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
From:   Joe Perches <joe@perches.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-sparse@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 28 Oct 2019 15:28:17 -0700
In-Reply-To: <20191028221523.vlzdk6dkcglxei6v@desk.local>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
         <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
         <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
         <20191028221523.vlzdk6dkcglxei6v@desk.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 23:15 +0100, Luc Van Oostenryck wrote:
> On Mon, Oct 28, 2019 at 10:59:47AM -0700, Joe Perches wrote:
> > On Mon, 2019-10-28 at 18:37 +0100, Miguel Ojeda wrote:
> > > Just in case: for these ones (i.e. __CHECKER__), did you check if
> > > sparse handles this syntax? (I don't recall myself if it does).
> > > 
> > > Other than that, thanks for the cleanup too! I can pick it up in the
> > > the compiler-attributes tree and put it in -next.
> > 
> > Thanks for asking and no, I did  not until just now.
> > Turns out sparse does _not_ handle these changes and
> > the checking fails for these __<changes>__.
> > 
> > sparse would have to update parse.c or the __CHECKER__
> > changes would need to be reverted.
> > 
> > Perhaps update parse.c like:
> 
> ...
> 
> Yes, this was missing. Thanks.
> Can I have your SoB for this?

I'm not sure this actually works as there's
some possible sparse parsing changes in the
use of __context__.

There is a difference in linux compilation of
a defconfig output with sparse output of init/
with the new parse.c 

old:

$ make clean ; make C=1 init > old 2>&1

(recompile sparse with changes above)

new:

$ make clean ; make C=1 init > new 2>&1

$ diff -urN old new
--- old	2019-10-28 15:20:00.524678375 -0700
+++ new	2019-10-28 15:21:14.004674721 -0700
@@ -55,7 +55,25 @@
   CHK     include/generated/compile.h
   CHECK   init/main.c
 init/main.c:173:12: warning: symbol 'envp_init' was not declared. Should it be static?
+./include/linux/rcupdate.h:598:9: error: undefined identifier '__context__'
+./include/linux/rcupdate.h:651:9: error: undefined identifier '__context__'
+./include/linux/rcupdate.h:598:9: error: not a function <noident>
+./include/linux/rcupdate.h:598:9: error: undefined identifier 'RCU'
+./include/linux/rcupdate.h:651:9: error: not a function <noident>
+./include/linux/rcupdate.h:651:9: error: undefined identifier 'RCU'
 init/main.c:506:20: warning: symbol 'mem_encrypt_init' was not declared. Should it be static?
+./include/linux/rcupdate.h:716:9: error: undefined identifier '__context__'
+./include/linux/rcupdate.h:736:9: error: undefined identifier '__context__'
+./include/linux/rcupdate.h:716:9: error: not a function <noident>
+./include/linux/rcupdate.h:716:9: error: undefined identifier 'RCU_SCHED'
+./include/linux/rcupdate.h:736:9: error: not a function <noident>
+./include/linux/rcupdate.h:736:9: error: undefined identifier 'RCU_SCHED'
+./include/linux/rcupdate.h:716:9: error: not a function <noident>
+./include/linux/rcupdate.h:736:9: error: not a function <noident>
+./include/linux/rcupdate.h:716:9: error: not a function <noident>
+./include/linux/rcupdate.h:736:9: error: not a function <noident>
+./include/linux/spinlock.h:211:9: error: undefined identifier '__context__'
+init/main.c:1222:9: warning: context imbalance in 'kernel_init_freeable' - wrong count at exit
   CC      init/main.o
   CHECK   init/version.c
   CC      init/version.o

