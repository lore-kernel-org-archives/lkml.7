Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D34C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D9C2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCRTUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:20:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfCRTUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:20:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89C29356E9;
        Mon, 18 Mar 2019 19:20:40 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ED90601A4;
        Mon, 18 Mar 2019 19:20:39 +0000 (UTC)
Date:   Mon, 18 Mar 2019 15:20:37 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>
Cc:     live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.cz,
        jikos@suse.cz, nstange@suse.de, jpoimboe@redhat.com,
        khlebnikov@yandex-team.ru, jeyu@kernel.org, matz@suse.de,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, michal.lkml@markovi.net
Subject: Re: [PATCH v2 5/8] modpost: Integrate klp-convert
Message-ID: <20190318192037.GA23186@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-6-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301141313.15057-6-jmoreira@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 18 Mar 2019 19:20:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:13:10AM -0300, Joao Moreira wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Create cmd_klp_convert and hook it into scripts/Makefile.modpost.
> cmd_klp_convert invokes klp-convert with the right arguments for the
> conversion of unresolved symbols inside a livepatch.
> 
> [khlebnikov:
> * save cmd_ld_ko_o into .module.cmd, if_changed_rule doesn't do that
> * fix bashisms for debian where /bin/sh is a symlink to /bin/dash
> * rename rule_link_module to rule_ld_ko_o, otherwise arg-check inside
>   if_changed_rule compares cmd_link_module and cmd_ld_ko_o
> * check modinfo -F livepatch only if CONFIG_LIVEPATCH is true
> ]
> 
> [mbenes:
> * remove modinfo call. LIVEPATCH_ in Makefiled
> ]
> 
> [jmoreira:
> * split up: move the .livepatch file-based scheme for identifying
> livepatches to a previous patch, as it was required for correctly
> building Symbols.list there.
> ]
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> ---
>  scripts/Kbuild.include   |  4 +++-
>  scripts/Makefile.modpost | 16 +++++++++++++++-
>  scripts/mod/modpost.c    |  6 +++++-
>  scripts/mod/modpost.h    |  1 +
>  4 files changed, 24 insertions(+), 3 deletions(-)
> 
> [ ... snip ... ]
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 7d4af0d0accb..da779a185218 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -125,8 +125,22 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>                   -o $@ $(filter-out FORCE,$^) ;                         \
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  
> +SLIST = $(objtree)/Symbols.list
> +KLP_CONVERT = scripts/livepatch/klp-convert
> +quiet_cmd_klp_convert = KLP $@

Minor nit, but a little more whitespace after "KLP" will more neatly
align the build output:

  [squash] modpost: align KLP prefix 
  https://github.com/torvalds/linux/commit/543aa6bc390b778a2e5a6706960c1414404d409e

> [ ... snip ... ]
>  
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 26bf886bd168..1dfc34d8b668 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1979,6 +1979,10 @@ static void read_symbols(const char *modname)
>  		license = get_next_modinfo(&info, "license", license);
>  	}
>  
> +	/* Livepatch modules have unresolved symbols resolved by klp-convert */
> +	if (get_modinfo(info.modinfo, info.modinfo_len, "livepatch"))
> +		mod->livepatch = 1;
> +
> [ ... snip ... ]

To bisect/build post v5.0 merge, I needed to update the get_modinfo()
call.  h/t to the 0-day bot for flagging this:
  
  [squash] modpost: rebase for v5.0 
  https://github.com/torvalds/linux/commit/ab82f725dbc8d6366ca4912a4d05372e24e92e8b

-- Joe
