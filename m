Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8687C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2322183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCTQDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:03:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfCTQDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:03:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6020930BC66D;
        Wed, 20 Mar 2019 16:03:11 +0000 (UTC)
Received: from treble (ovpn-124-13.rdu2.redhat.com [10.10.124.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ACC35C260;
        Wed, 20 Mar 2019 16:03:10 +0000 (UTC)
Date:   Wed, 20 Mar 2019 11:03:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] objtool: query pkg-config for libelf location
Message-ID: <20190320160308.hdhd7ko4hquanmqc@treble>
References: <3381642.TeJ1gWjbju@devpool35>
 <20190320153701.7wym7btpjshdujpz@treble>
 <13279932.E8cnC9vheV@devpool35>
 <13510794.yptIvAPcpm@devpool35>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13510794.yptIvAPcpm@devpool35>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 20 Mar 2019 16:03:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 04:58:26PM +0100, Rolf Eike Beer wrote:
> If it is not in the default location compilation would fail at several points.
> 
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>

Looks fine to me.  If the kbuild folks don't have any comments, I'll
send it along to the -tip tree soonish.

> ---
> Changes in v2:
>   -also hide stderr when querying cflags
>   -use ":=" assignment as in other places in that file
> 
>  Makefile               | 4 +++-
>  tools/objtool/Makefile | 7 +++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 99c0530489ef..32caf30e0d79 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -950,9 +950,11 @@ mod_sign_cmd = true
>  endif
>  export mod_sign_cmd
>  
> +HOST_LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
> +
>  ifdef CONFIG_STACK_VALIDATION
>    has_libelf := $(call try-run,\
> -		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
> +		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
>    ifeq ($(has_libelf),1)
>      objtool_target := tools/objtool FORCE
>    else
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index c9d038f91af6..53f8be0f4a1f 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -25,14 +25,17 @@ LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
>  OBJTOOL    := $(OUTPUT)objtool
>  OBJTOOL_IN := $(OBJTOOL)-in.o
>  
> +LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
> +LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
> +
>  all: $(OBJTOOL)
>  
>  INCLUDES := -I$(srctree)/tools/include \
>  	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
>  	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
>  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
> -CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
> -LDFLAGS  += -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> +CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> +LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
>  
>  # Allow old libelf to be used:
>  elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> -- 
> 2.21.0
> 
> -- 
> Rolf Eike Beer, emlix GmbH, http://www.emlix.com
> Fon +49 551 30664-0, Fax +49 551 30664-11
> Gothaer Platz 3, 37083 Göttingen, Germany
> Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
> Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055
> 
> emlix - smart embedded open source



-- 
Josh
