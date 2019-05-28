Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20290206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfE1OzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:55:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfE1OzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:55:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3EBB2E95AF;
        Tue, 28 May 2019 14:55:01 +0000 (UTC)
Received: from treble (ovpn-122-72.rdu2.redhat.com [10.10.122.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15CA378551;
        Tue, 28 May 2019 14:55:00 +0000 (UTC)
Date:   Tue, 28 May 2019 09:54:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 10/13] objtool: Make recordmcount into an objtool
 subcmd
Message-ID: <20190528145458.2xmlkzucuekj2km4@treble>
References: <cover.1558569448.git.mhelsley@vmware.com>
 <10da56db6206a99d1b909e56ee48cb4ceb374ef8.1558569448.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10da56db6206a99d1b909e56ee48cb4ceb374ef8.1558569448.git.mhelsley@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 28 May 2019 14:55:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 05:03:33PM -0700, Matt Helsley wrote:
> Rather than a standalone executable merge recordmcount as a sub
> command of objtool. This is a small step towards cleaning up
> recordmcount and eventually saving ELF code with objtool.
> 
> For the initial step all that's required is a bit of Makefile
> changes and invoking the former main() function from recordmcount.c
> because the subcommand code uses similar function arguments as
> main when dispatching.
> 
> Subsequent patches will gradually convert recordmcount to use
> more and more of libelf/objtool's ELF accessor code. This will both
> clean up recordmcount to be more easily readable and remove
> recordmcount's crude accessor wrapping code.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>  scripts/Makefile.build         | 15 +++++--
>  tools/objtool/Build            |  3 +-
>  tools/objtool/Makefile         | 18 +++------
>  tools/objtool/builtin-mcount.c | 72 ++++++++++++++++++++++++++++++++++
>  tools/objtool/builtin-mcount.h | 23 +++++++++++
>  tools/objtool/builtin.h        |  6 +++
>  tools/objtool/objtool.c        |  6 +++
>  tools/objtool/recordmcount.c   | 29 +++++---------
>  8 files changed, 134 insertions(+), 38 deletions(-)
>  create mode 100644 tools/objtool/builtin-mcount.c
>  create mode 100644 tools/objtool/builtin-mcount.h
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index f32cfe63bb0e..6a3a5a477cbd 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -173,10 +173,13 @@ cmd_modversions_c =								\
>  	fi
>  endif
>  
> +objtool_dep =
> +
>  ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  ifndef CC_USING_RECORD_MCOUNT
> -# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
> +# compiler will not generate __mcount_loc use objtool mcount record or recordmcount.pl
>  ifdef BUILD_C_RECORDMCOUNT
> +objtool_dep += $(objtree)/tools/objtool/objtool
>  ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
>    RECORDMCOUNT_FLAGS = -w
>  endif
> @@ -186,10 +189,12 @@ endif
>  # files, including recordmcount.
>  sub_cmd_record_mcount =					\
>  	if [ $(@) != "scripts/mod/empty.o" ]; then	\
> -		$(objtree)/tools/objtool/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
> +		$(objtree)/tools/objtool/objtool mcount record $(RECORDMCOUNT_FLAGS) "$(@)";	\
>  	fi;
>  
> -recordmcount_source := $(srctree)/tools/objtool/recordmcount.c \
> +recordmcount_source := $(srctree)/tools/objtool/builtin-mcount.c \
> +		    $(srctree)/tools/objtool/builtin-mcount.h \
> +		    $(srctree)/tools/objtool/recordmcount.c \
>  		    $(srctree)/tools/objtool/recordmcount.h

Is this needed? if any of these files change, then objtool will change,
and which is already covered by the objtool_dep assignment above.

>  else
>  sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)" \
> @@ -203,6 +208,8 @@ endif # BUILD_C_RECORDMCOUNT
>  cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
>  	$(sub_cmd_record_mcount))
>  endif # CC_USING_RECORD_MCOUNT
> +
> +objtool_dep += $(recordmcount_source)

I don't think this is needed because recordmcount_source is already
listed as a dependency for .o files.

>  endif # CONFIG_FTRACE_MCOUNT_RECORD
>  
>  ifdef CONFIG_STACK_VALIDATION
> @@ -241,7 +248,7 @@ endif # SKIP_STACK_VALIDATION
>  endif # CONFIG_STACK_VALIDATION
>  
>  # Rebuild all objects when objtool changes, or is enabled/disabled.
> -objtool_dep = $(objtool_obj)					\
> +objtool_dep += $(objtool_obj)		\

The backslash should be aligned with the following ones.

>  	      $(wildcard include/config/orc/unwinder.h		\
>  			 include/config/stack/validation.h)

Should we also add an ftrace config dependency here?
Like include/config/ftrace/mcount/record.h?

>  
> diff --git a/tools/objtool/Build b/tools/objtool/Build
> index 78c4a8a2f9e7..7b71534767bd 100644
> --- a/tools/objtool/Build
> +++ b/tools/objtool/Build
> @@ -1,6 +1,7 @@
>  objtool-y += arch/$(SRCARCH)/
>  objtool-y += builtin-check.o
>  objtool-y += builtin-orc.o
> +objtool-$(BUILD_C_RECORDMCOUNT) += builtin-mcount.o recordmcount.o

Can we just build these files unconditionally, even if they're not used?
Thus far, objtool doesn't have any kernel config dependencies like this.
It helps keep things simple and keeps objtool more separate from the
kernel.

So if you build record mcount unconditionally then I think you can also
get rid of the BUILD_C_RECORDMCOUNT export, the CMD_MCOUNT define, and
cmd_nop().

-- 
Josh
