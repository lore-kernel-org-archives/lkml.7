Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39902C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAF52175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfCRTU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:20:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfCRTU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:20:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0471C3082E58;
        Mon, 18 Mar 2019 19:20:58 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3EC05D9C6;
        Mon, 18 Mar 2019 19:20:56 +0000 (UTC)
Date:   Mon, 18 Mar 2019 15:20:54 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>
Cc:     live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.cz,
        jikos@suse.cz, nstange@suse.de, jpoimboe@redhat.com,
        khlebnikov@yandex-team.ru, jeyu@kernel.org, matz@suse.de,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, michal.lkml@markovi.net
Subject: Re: [PATCH v2 6/8] modpost: Add modinfo flag to livepatch modules
Message-ID: <20190318192054.GA23203@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-7-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301141313.15057-7-jmoreira@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 18 Mar 2019 19:20:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:13:11AM -0300, Joao Moreira wrote:
> From: Miroslav Benes <mbenes@suse.cz>
> 
> Currently, livepatch infrastructure in the kernel relies on
> MODULE_INFO(livepatch, "Y") statement in a livepatch module. Then the
> kernel module loader knows a module is indeed livepatch module and can
> behave accordingly.
> 
> klp-convert, on the other hand relies on LIVEPATCH_* statement in the
> module's Makefile for exactly the same reason.
> 
> Remove dependency on modinfo and generate MODULE_INFO flag
> automatically in modpost when LIVEPATCH_* is defined in the module's
> Makefile. Generate a list of all built livepatch modules based on
> the .livepatch file and store it in (MODVERDIR)/livepatchmods. Give
> this list as an argument for modpost which will use it to identify
> livepatch modules.
> 
> As MODULE_INFO is no longer needed, remove it.
> 
> [jmoreira:
> * fix modpost.c (add_livepatch_flag) to update module structure with
> livepatch flag and prevent modpost from breaking due to unresolved
> symbols]
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> ---
>  samples/livepatch/livepatch-sample.c |  1 -
>  scripts/Makefile.modpost             |  8 +++-
>  scripts/mod/modpost.c                | 84 +++++++++++++++++++++++++++++++++---
>  3 files changed, 85 insertions(+), 8 deletions(-)
> 
> [ ... snip ... ]

While we're here, we can make the same changes to all the other in-tree
livepatch self-test and sample modules:

  [squash] modpost/livepatch: apply modinfo flag to all in-tree livepatch modules
  https://github.com/torvalds/linux/commit/22c59f05c9618903a946d5f8f79bfa345d31de3c

-- Joe
