Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDBEC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21662075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfG1RtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:49:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfG1RtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:49:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13B6085363;
        Sun, 28 Jul 2019 17:49:02 +0000 (UTC)
Received: from treble (ovpn-120-102.rdu2.redhat.com [10.10.120.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61E2E60600;
        Sun, 28 Jul 2019 17:49:01 +0000 (UTC)
Date:   Sun, 28 Jul 2019 12:48:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 10/13] objtool: Make recordmcount into an objtool
 subcmd
Message-ID: <20190728174859.v767keld5x3zylq7@treble>
References: <cover.1563992889.git.mhelsley@vmware.com>
 <13ef7e93410f99579fa9b8a44bdd313e8300b706.1563992889.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13ef7e93410f99579fa9b8a44bdd313e8300b706.1563992889.git.mhelsley@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 28 Jul 2019 17:49:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 02:05:04PM -0700, Matt Helsley wrote:
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 08b70ee9614a..43707491317c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -170,22 +170,21 @@ endif
>  
>  ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  ifndef CC_USING_RECORD_MCOUNT
> -# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
> -ifdef BUILD_C_RECORDMCOUNT
> +# compiler will not generate __mcount_loc use objtool mcount record or recordmcount.pl

This comment could use some English-ification, something like:

# The compiler doesn't support generation of the __mcount_loc section.
# Generate it manually with "objtool mcount record" or recordmcount.pl.

> @@ -236,9 +235,10 @@ endif # SKIP_STACK_VALIDATION
>  endif # CONFIG_STACK_VALIDATION
>  
>  # Rebuild all objects when objtool changes, or is enabled/disabled.
> -objtool_dep = $(objtool_obj)					\
> +objtool_dep += $(objtool_obj)					\
>  	      $(wildcard include/config/orc/unwinder.h		\
> -			 include/config/stack/validation.h)
> +			 include/config/stack/validation.h	\
> +			 include/config/ftrace/mcount/record.h)

I think the '+=' isn't needed as this is the only place objtool_dep gets
set?

-- 
Josh
