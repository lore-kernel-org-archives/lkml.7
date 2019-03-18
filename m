Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45891C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFC3205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfCRTVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:21:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfCRTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:21:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B81E030821A3;
        Mon, 18 Mar 2019 19:21:30 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A0E76063B;
        Mon, 18 Mar 2019 19:21:29 +0000 (UTC)
Date:   Mon, 18 Mar 2019 15:21:27 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>
Cc:     live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.cz,
        jikos@suse.cz, nstange@suse.de, jpoimboe@redhat.com,
        khlebnikov@yandex-team.ru, jeyu@kernel.org, matz@suse.de,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, michal.lkml@markovi.net
Subject: Re: [PATCH v2 8/8] documentation: Update on livepatch elf format
Message-ID: <20190318192127.GA23238@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-9-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301141313.15057-9-jmoreira@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 19:21:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:13:13AM -0300, Joao Moreira wrote:
> Add a section to Documentation/livepatch/module-elf-format.txt
> describing how klp-convert works for fixing relocations.
> 
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> ---
>  Documentation/livepatch/module-elf-format.txt | 47 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/livepatch/module-elf-format.txt b/Documentation/livepatch/module-elf-format.txt
> index f21a5289a09c..6b0259dfab49 100644
> --- a/Documentation/livepatch/module-elf-format.txt
> +++ b/Documentation/livepatch/module-elf-format.txt
> @@ -2,7 +2,8 @@
>  Livepatch module Elf format
>  ===========================
>  
> [ ... snip ... ]
>
> +--------------------------------------------------
> +4.  Automatic conversion of unresolved relocations
> +--------------------------------------------------
> +Sometimes livepatches may operate on symbols which are not self-contained nor
> +exported. When this happens, these symbols remain unresolved in the elf object
> +and will trigger an error during the livepatch instantiation.
> +
> +Whenever possible, the kernel building infrastructure solves this problem
> +automatically. First, a symbol database containing information on all compiled
> +objects is built. Second, this database - a file named Symbols.list, placed in
> +the kernel source root directory - is used to identify targets for unresolved
> +relocations, converting them in the livepatch elf accordingly to the
> +specifications above-described. While the first staged is fully handled by the
                                                   ^^^^^^
nit: s/staged/stage

> +building system, the second is done by a tool called klp-convert, which can be
> +found in "scripts/livepatch".
> +
> +When an unresolved relocation has as target a symbol whose name is also used by
> +different symbols throughout the kernel, the relocation cannot be resolved
> +automatically. In these cases, the livepatch developer must add annotations to
> +the livepatch, making it possible for the system to identify which is the
> +correct target amongst multiple homonymous symbols. Such annotations must be
> +done through a data structure as follows:
> +
> +struct KLP_MODULE_RELOC(object) data_structure_name[] = {
> +	KLP_SYMPOS(symbol, pos)
> +};
> +
> +In the above example, object refers to the object file which contains the
> +symbol, being vmlinux or a module; symbol refers to the symbol name that will
> +be relocated and pos is its position in the object.
> [ ... snip ... ]

Should we be explicit about how position is counted?  First = 1, second
= 2, etc?  See the off-by-one bug I pointed out in the "livepatch: Add
klp-convert tool" patch earlier.

-- Joe
