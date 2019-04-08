Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4683DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AA1213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDHNCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfDHNCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:02:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D17530BA340;
        Mon,  8 Apr 2019 13:02:42 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0544C60FC3;
        Mon,  8 Apr 2019 13:02:39 +0000 (UTC)
Date:   Mon, 8 Apr 2019 08:02:35 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Luis Ressel' <aranea@aixah.de>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190408130235.hmpmr6dtc2prywzu@treble>
References: <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
 <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
 <20190405162109.4hv6lqpd6manzjju@treble>
 <d3cb290b12974f1895ea235680f90ead@AcuMS.aculab.com>
 <20190405171207.jmi7zehu37ksg5a4@treble>
 <d24e8040cc8c47a48d1f85a5f06436a7@AcuMS.aculab.com>
 <20190405172235.pgsjnyb62hqkfwcl@treble>
 <4dcc5b4ce124408495a440511acfc4c4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dcc5b4ce124408495a440511acfc4c4@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 08 Apr 2019 13:02:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 09:20:50AM +0000, David Laight wrote:
> From: Josh Poimboeuf
> > Sent: 05 April 2019 18:23
> > On Fri, Apr 05, 2019 at 05:17:15PM +0000, David Laight wrote:
> > > > Hm, I don't see that in cmd_objtool, or any commits from you in
> > > > scripts/Makefile.build.
> > >
> > > Not sure I remember actually committing them.
> > > Maybe 'git diff' isn't doing what I expect :-)
> > > I hate git.
> > 
> > Do you see it here?
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.build
> 
> No, I must have had to tell git to apply the change locally.
> I can't see how to get git to diff against the 'real' head.
> Anyway a 'random' number of ^ after HEAD gave me:
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index e7889f4..a2f7abe 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -193,7 +193,9 @@ else
>  cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
> 
>  cmd_modversions_c =                                                            \
> -       if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then             \
> +       if ! obj_headers=$$($(OBJDUMP) -h $(@D)/.tmp_$(@F)); then               \
> +               false;                                                          \
> +       elif echo "$$obj_headers" | grep -q __ksymtab; then                     \
>                 $(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))  \
>                     > $(@D)/.tmp_$(@F:.o=.ver);                                 \
>                                                                                 \
> @@ -277,7 +279,14 @@ endif
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
>  cmd_objtool = $(if $(patsubst y%,, \
>         $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
> -       $(__objtool_obj) $(objtool_args) "$(objtool_o)";)
> +       $(__objtool_obj) $(objtool_args) "$(objtool_o)" && { \
> +               $(OBJDUMP) -h "$(objtool_o)" >/dev/null 2>&1 || { \
> +                       echo >&2 "******* objtool generated the invalid file $(objtool_o)"; \
> +                       echo >&2 "******* Update libelf.so or disable the ORC unwinder"; \
> +                       /bin/false; \
> +               }; \
> +       };)
> +
>  objtool_obj = $(if $(patsubst y%,, \
>         $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
>         $(__objtool_obj))
> 
> Do you want a formal patch?

Hm, I wonder if there's a way for objtool itself to detect it's
producing a bad file.  That would be a bit cleaner.

-- 
Josh
