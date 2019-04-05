Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B920C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D32217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfDEMjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:39:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDEMjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:39:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7AAA30027B5;
        Fri,  5 Apr 2019 12:39:12 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDAB55D71B;
        Fri,  5 Apr 2019 12:39:11 +0000 (UTC)
Date:   Fri, 5 Apr 2019 07:39:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Luis Ressel <aranea@aixah.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405123909.tupbgueie4czg2dd@treble>
References: <20190405110151.2461-1-aranea@aixah.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405110151.2461-1-aranea@aixah.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 05 Apr 2019 12:39:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 01:01:50PM +0200, Luis Ressel wrote:
> -Werror can be handy for development, but enabling it for production
> builds is a bad idea -- other compilers might produce unexpected
> warnings, or #included library headers might trigger warnings.
> 
> In my case, libelf's (not elfutil's!) headers trigger several -Wundef
> warnings. This wasn't a problem before 056d28d135bc, since gcc doesn't
> emit warnings for system headers, but now that there's a
> -I/usr/include/libelf/ in the gcc command line, those warnings appear
> and break the build.

Hi Luis,

What version of libelf are you using?  AFAIK, the non-elfutils version
of libelf is buggy and has been unmaintained for 10 years.

> CC'ing stable@ since 056d28d135bc has also been included in stable
> versions.
> 
> Fixes: 056d28d135bc ("objtool: Query pkg-config for libelf location")
> Signed-off-by: Luis Ressel <aranea@aixah.de>
> Cc: stable@vger.kernel.org
> ---
>  tools/objtool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 53f8be0f4a1f..ad2c11a881db 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -34,7 +34,7 @@ INCLUDES := -I$(srctree)/tools/include \
>  	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
>  	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
>  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
> -CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> +CFLAGS   += $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
>  LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
>  
>  # Allow old libelf to be used:
> -- 
> 2.21.0
> 

-- 
Josh
