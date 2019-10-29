Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0EACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1862087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0ZK1Ea1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfJ2Kpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:45:51 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54759 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ2Kpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:45:50 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x9TAjllJ013769
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 19:45:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x9TAjllJ013769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572345948;
        bh=ABgtHQoYN+OnWaETIQoMwES94nPToZvZJ0rO3T4xCq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0ZK1Ea1HGyUC9VI9FxAlxXqejhflruqc+9jiOsRbQgXp+sQhJ3T+ASUvATJme46vY
         p/Ve40hriQiqA4MWw8Jk6Gpq40rvULPKwRVsqdAM28BcRPqDOeHbhhelKvmNlU86np
         2P1tFfd6pOgDsFrxqYcpWA3OABuy+7hrjuHy6KcHESDGFKsieFG0ZeSv9aXa9cUeVc
         gXqjvPzHnGs3XZiYqjwh7jRZkR9CUi+b021BFAkDowCvvyAf3XAf4QXacBpjVpJtLa
         Q/GJ8KX7a7L/3na01pFeWpufRGqxvY3iNztm+KelGQpw0/fIqYRjC2laD2W97fQdlw
         OV7lj05eD3A6A==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id q4so1493831uap.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 03:45:47 -0700 (PDT)
X-Gm-Message-State: APjAAAUoGKhuexGdF2D4QY1FE4H2DU07B+cC2C1Su1rLalWuGYxN48X7
        UKrUyQC8EvmNRnbBo4C8sIfT0IoVz0VXSCO4mGM=
X-Google-Smtp-Source: APXvYqxVtM76QDu1/i4gL4jgyGxUhoOrTzYpbZmzaM9HNLJVzBsNPznTio5GCyhsoaRKAP1ZdoZ4bSlnuwn4lHJjHe8=
X-Received: by 2002:a9f:2382:: with SMTP id 2mr10901980uao.95.1572345946290;
 Tue, 29 Oct 2019 03:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191028151427.31612-1-jeyu@kernel.org> <20191028151427.31612-3-jeyu@kernel.org>
In-Reply-To: <20191028151427.31612-3-jeyu@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 29 Oct 2019 19:45:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpb8nU8EqBnLRCpstnFuw3YJ5UENu7PRza=H2YvCav-Q@mail.gmail.com>
Message-ID: <CAK7LNARpb8nU8EqBnLRCpstnFuw3YJ5UENu7PRza=H2YvCav-Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] nsdeps: remove stale .ns_deps files before generating
 new ones
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:14 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> When adding or removing namespaces, calling `make` does not necessarily
> remove existing stale .ns_deps files. That is, one could remove a
> namespace, call make, and while modpost writes the correct, new .ns_deps
> files, stale ones are not removed from the source tree, thus producing
> incorrect results when running `make nsdeps`, i.e., inserting
> MODULE_IMPORT_NS() statements for namespaces that have been removed.
> Clean up old .ns_deps files before generating new ones with modpost.

Hmm, correct.

But, removing *.ns_deps every time is not an elegant solution.


I want to try a different approach.



>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index ffd7a912fc46..22f9894b346b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1685,6 +1685,8 @@ tags TAGS cscope gtags: FORCE
>  PHONY += nsdeps
>
>  nsdeps: modules
> +       @find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
> +               -name '*.ns_deps' -type f -print | xargs rm -f
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost nsdeps
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/$@
>
> --
> 2.16.4
>


--
Best Regards

Masahiro Yamada
