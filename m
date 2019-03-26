Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9398920866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfCZRdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732431AbfCZRdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:33:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83DFE8666B;
        Tue, 26 Mar 2019 17:33:12 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F2465C28D;
        Tue, 26 Mar 2019 17:33:10 +0000 (UTC)
Date:   Tue, 26 Mar 2019 13:33:08 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] kbuild: strip whitespace in cmd_record_mcount findstring
Message-ID: <20190326173308.GA26546@redhat.com>
References: <20190325160438.8982-1-joe.lawrence@redhat.com>
 <CAK7LNARyD=tG0JhwN_mjdyDRSPAF8UoZKvqAT3Ah_v7GfymCPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARyD=tG0JhwN_mjdyDRSPAF8UoZKvqAT3Ah_v7GfymCPg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 26 Mar 2019 17:33:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:29:47PM +0900, Masahiro Yamada wrote:
> On Tue, Mar 26, 2019 at 1:05 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> >
> > CC_FLAGS_FTRACE may contain trailing whitespace that interferes with
> > findstring.
> >
> > For example, commit 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on
> > GCC 4.9 and newer") introduced a change such that on my ppc64le box,
> > CC_FLAGS_FTRACE="-pg -mprofile-kernel ".  (Note the trailing space.)
> > When cmd_record_mcount is now invoked, findstring fails as the ftrace
> > flags were found at very end of _c_flags, without the trailing space.
> >
> >   _c_flags=" ... -pg -mprofile-kernel"
> >   CC_FLAGS_FTRACE="-pg -mprofile-kernel "
> >                                        ^
> >     findstring is looking for this extra space
> >
> > Remove the redundant whitespaces from CC_FLAGS_FTRACE in
> > cmd_record_mcount to avoid this problem.
> >
> > Fixes: 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer").
> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > ---
> >
> > Standard disclaimer: I'm not a kbuild expert, but this works around the
> > problem I reported where ftrace and livepatch self-tests were failing as
> > specified object files were not run through the recordmcount.pl script:
> >
> > ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-March/187298.html
> >
> >  scripts/Makefile.build | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 2554a15ecf2b..74d402b5aa3c 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -199,10 +199,10 @@ sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
> >         "$(if $(part-of-module),1,0)" "$(@)";
> >  recordmcount_source := $(srctree)/scripts/recordmcount.pl
> >  endif # BUILD_C_RECORDMCOUNT
> > -cmd_record_mcount =                                            \
> > -       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =   \
> > -            "$(CC_FLAGS_FTRACE)" ]; then                       \
> > -               $(sub_cmd_record_mcount)                        \
> > +cmd_record_mcount =                                                    \
> > +       if [ "$(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags))" =  \
> > +            "$(strip $(CC_FLAGS_FTRACE))" ]; then                      \
> > +               $(sub_cmd_record_mcount)                                \
> >         fi
> >  endif # CC_USING_RECORD_MCOUNT
> >  endif # CONFIG_FTRACE_MCOUNT_RECORD
> > --
> > 2.20.1
> >
> 
> 
> 
> I do not see a point in using the shell command here
> in the first place.
> 
> Instead of adding crappy workarounds,
> I guess the following simple code should work:
> 
> 
> index 2554a15..5f13021 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -199,11 +199,8 @@ sub_cmd_record_mcount = perl
> $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
>         "$(if $(part-of-module),1,0)" "$(@)";
>  recordmcount_source := $(srctree)/scripts/recordmcount.pl
>  endif # BUILD_C_RECORDMCOUNT
> -cmd_record_mcount =                                            \
> -       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =   \
> -            "$(CC_FLAGS_FTRACE)" ]; then                       \
> -               $(sub_cmd_record_mcount)                        \
> -       fi
> +cmd_record_mcount = $(if $(findstring $(CC_FLAGS_FTRACE),$(_c_flags)),\
> +                 $(sub_cmd_record_mcount))
>  endif # CC_USING_RECORD_MCOUNT
>  endif # CONFIG_FTRACE_MCOUNT_RECORD
> 

Hi Masahiro,

Agreed on the shell command ugliness, however I still think we need to
strip the search pattern here.  With your suggestion:

% rm -f kernel/trace/trace_selftest_dynamic.o 
% make kernel/trace/trace_selftest_dynamic.o
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  CC      kernel/trace/trace_selftest_dynamic.o

% eu-readelf --sections kernel/trace/trace_selftest_dynamic.o | grep mcount
(nothing)

Adding it back as, as below, restores those sections and the self tests
work again.

Regards,

-- Joe

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

From 6a85e8ecf4179b3e80601a327ec43d8d49f0e3cd Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@redhat.com>
Date: Tue, 26 Mar 2019 10:50:28 -0400
Subject: [PATCH v2] kbuild: strip whitespace in cmd_record_mcount findstring

CC_FLAGS_FTRACE may contain trailing whitespace that interferes with
findstring.

For example, commit 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on
GCC 4.9 and newer") introduced a change such that on my ppc64le box,
CC_FLAGS_FTRACE="-pg -mprofile-kernel ".  (Note the trailing space.)
When cmd_record_mcount is now invoked, findstring fails as the ftrace
flags were found at very end of _c_flags, without the trailing space.

  _c_flags=" ... -pg -mprofile-kernel"
  CC_FLAGS_FTRACE="-pg -mprofile-kernel "
                                       ^
    findstring is looking for this extra space

Remove the redundant whitespaces from CC_FLAGS_FTRACE in
cmd_record_mcount to avoid this problem.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com> (refactoring)
Fixes: 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer").
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/Makefile.build | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2554a15ecf2b..76ca30cc4791 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -199,11 +199,8 @@ sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
-cmd_record_mcount =						\
-	if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =	\
-	     "$(CC_FLAGS_FTRACE)" ]; then			\
-		$(sub_cmd_record_mcount)			\
-	fi
+cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
+	$(sub_cmd_record_mcount))
 endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
-- 
2.20.1

