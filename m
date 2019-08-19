Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C21AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CF222CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566252830;
	bh=4OL6nVB0qLhHMLV1A+Hg935diBRpXnS4haw7ngoM9j4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QLtrrMH2A4pUyo5H7WVDg7+brw5emr/YySE2PAqP2hkTUZLEimRfcElhok+yrpAzT
	 jiylwZ3QqauUrjleh8gd7VmFfF244Re7C/ehPR1Nj/wAQ2xmsTw7jZEfrz18nnKqvX
	 AyoUsqYacTZTS1mu5bRccMYSUteaoVsiM+/U9BTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfHSWNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbfHSWNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:13:48 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF79C214DA;
        Mon, 19 Aug 2019 22:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566252827;
        bh=4OL6nVB0qLhHMLV1A+Hg935diBRpXnS4haw7ngoM9j4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kI9kp010sbLvA9Ywre7pB5dBfmLhakbFcsuorxWOsdV6NmA+5vidwNG0D1bwcxfD5
         EJ/hFdkoCAooP46shHMKoYGA4ahBsfgPgTI244f/fzMjmQ5//XKRM3TegfNa+TLMJ2
         sdG4xBNmgNek2PkqFsbwyptx/+1k3hlw6wZ10qXE=
Date:   Mon, 19 Aug 2019 15:13:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: tmpfs: fixups to use of the new mount API
Message-Id: <20190819151347.ecbd915060278a70ddeebc91@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.1908191503290.1253@eggly.anvils>
References: <alpine.LSU.2.11.1908191503290.1253@eggly.anvils>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 15:09:14 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> Several fixups to shmem_parse_param() and tmpfs use of new mount API:
> 
> mm/shmem.c manages filesystem named "tmpfs": revert "shmem" to "tmpfs"
> in its mount error messages.
> 
> /sys/kernel/mm/transparent_hugepage/shmem_enabled has valid options
> "deny" and "force", but they are not valid as tmpfs "huge" options.
> 
> The "size" param is an alternative to "nr_blocks", and needs to be
> recognized as changing max_blocks.  And where there's ambiguity, it's
> better to mention "size" than "nr_blocks" in messages, since "size" is
> the variant shown in /proc/mounts.
> 
> shmem_apply_options() left ctx->mpol as the new mpol, so then it was
> freed in shmem_free_fc(), and the filesystem went on to use-after-free.
> 
> shmem_parse_param() issue "tmpfs: Bad value for '%s'" messages just
> like fs_parse() would, instead of a different wording.  Where config
> disables "mpol" or "huge", say "tmpfs: Unsupported parameter '%s'".

Is this

Fixes: 144df3b288c41 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")?

and a Cc:stable is appropriate?
