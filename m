Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E708AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9802077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfDJSSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfDJSSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:18:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02D9A308624B;
        Wed, 10 Apr 2019 18:18:41 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B7E019C6F;
        Wed, 10 Apr 2019 18:18:39 +0000 (UTC)
Date:   Wed, 10 Apr 2019 14:18:37 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 4/9] livepatch: Add klp-convert annotation helpers
Message-ID: <20190410181837.GA13083@redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190410155058.9437-5-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410155058.9437-5-joe.lawrence@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 10 Apr 2019 18:18:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:50:53AM -0400, Joe Lawrence wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Define macros KLP_MODULE_RELOC and KLP_SYMPOS in
> include/linux/livepatch.h to improve user-friendliness of the
> livepatch annotation process.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  include/linux/livepatch.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 16b48e8b29a2..947cfc2d1980 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -236,6 +236,18 @@ void *klp_shadow_get_or_alloc(void *obj, unsigned long id,
>  void klp_shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor);
>  void klp_shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor);
>  
> +/* Used to annotate symbol relocations in livepatches */
> +#define KLP_MODULE_RELOC(obj)						\
> +	struct klp_module_reloc						\
> +	__attribute__((__section__(".klp.module_relocs." #obj)))	\
> +	__attribute__((aligned (4)))
> +
> +#define KLP_SYMPOS(symbol, pos)						\
> +	{								\
> +		.sym = &symbol,						\
> +		.sympos = pos,						\
> +	},
        ^^
nit: if we dropped the trailing array comma delimiter from KLP_SYMPOS
macro, the invocations would look more intuitively like an array.  For
example:

  KLP_MODULE_RELOC(test_klp_convert_mod) test_klp_convert_mod_relocs_a[] = {
  	KLP_SYMPOS(driver_name, 0),
  	KLP_SYMPOS(homonym_string, 2),
  	KLP_SYMPOS(get_homonym_string, 2),
  };

But I could not figure out a good regex to reference if other such
kernel preprocessor macros include or exclude the delimiter.  Are there
reasons to include it?

-- Joe
