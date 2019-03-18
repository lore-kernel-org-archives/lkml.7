Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2767205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfCRTVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:21:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfCRTVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C694130832D8;
        Mon, 18 Mar 2019 19:21:16 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FD255D704;
        Mon, 18 Mar 2019 19:21:15 +0000 (UTC)
Date:   Mon, 18 Mar 2019 15:21:13 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>
Cc:     live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.cz,
        jikos@suse.cz, nstange@suse.de, jpoimboe@redhat.com,
        khlebnikov@yandex-team.ru, jeyu@kernel.org, matz@suse.de,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, michal.lkml@markovi.net
Subject: Re: [PATCH v2 7/8] livepatch: Add sample livepatch module
Message-ID: <20190318192113.GA23220@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-8-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301141313.15057-8-jmoreira@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 18 Mar 2019 19:21:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:13:12AM -0300, Joao Moreira wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Add a new livepatch sample in samples/livepatch/ to make use of
> symbols that must be post-processed to enable load-time relocation
> resolution. As the new sample is to be used as an example, it is
> annotated with KLP_MODULE_RELOC and with KLP_SYMPOS macros.
> 
> The livepatch sample updates the function cmdline_proc_show to
> print the string referenced by the symbol saved_command_line
> appended by the string "livepatch=1".
> 
> Update livepatch-sample.c to remove livepatch MODULE_INFO
> statement.
> 
> [jmoreira:
> * update module to use KLP_SYMPOS
> * Comments on symbol resolution scheme
> * Update Makefile
> * Remove MODULE_INFO statement
> * Changelog
> ]
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> ---
>  samples/livepatch/Makefile                     |   2 +
>  samples/livepatch/livepatch-annotated-sample.c | 113 +++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 samples/livepatch/livepatch-annotated-sample.c
> 
> [ ... snip ... ]
>
> diff --git a/samples/livepatch/livepatch-annotated-sample.c b/samples/livepatch/livepatch-annotated-sample.c
> new file mode 100644
> index 000000000000..44d9e9542db1
> --- /dev/null
> +++ b/samples/livepatch/livepatch-annotated-sample.c

Super small nit, but I shuffled the annotated-sample code around so it
better matched the original sample.  This minimized the diff when I
compared the two versions to see what was added for sympos annotation:

  [squash] livepatch: adjust annotated sample formatting 
  https://github.com/torvalds/linux/commit/ce49c70e85cf87e513de3bcf64953de191c3c6d7

> [ ... snip ... ]
>
> +static int livepatch_init(void)
> +{
> +	int ret;
> +
> +	ret = klp_register_patch(&patch);
> +	if (ret)
> +		return ret;
> +	ret = klp_enable_patch(&patch);
> +	if (ret) {
> +		WARN_ON(klp_unregister_patch(&patch));
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static void livepatch_exit(void)
> +{
> +	WARN_ON(klp_unregister_patch(&patch));
> +}

v5.0 deprecates klp_register_patch(), klp_unregister_patch(), and
klp_disable_patch(), so adjust the sample accordingly:

  [squash] livepatch: rebase the annotated sample 
  https://github.com/torvalds/linux/commit/fc04952376cfd8281eb663bd2ce18fec27eb42b2

-- Joe
