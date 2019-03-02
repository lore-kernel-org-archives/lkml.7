Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D3C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39F320838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfCBDkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:40:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40064 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCBDkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:40:20 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1gzvVZ-0001fD-Eb; Sat, 02 Mar 2019 03:40:17 +0000
Date:   Sat, 2 Mar 2019 03:40:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs: use KERNEL_DS instead of get_ds()
Message-ID: <20190302034017.GM2217@ZenIV.linux.org.uk>
References: <20190301200835.18286-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301200835.18286-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 09:08:35PM +0100, Jann Horn wrote:
> get_ds() is a legacy name for KERNEL_DS; all architectures #define it to
> KERNEL_DS,

not quite - h8300 and m68k have it as (equivalent) static inline.

> and almost every user of set_fs() uses the name KERNEL_DS.
> 
> Let the VFS also use KERNEL_DS so that we can get rid of get_ds() at some
> point.

No objections, but that kind of stuff might be better done in a different
way: ask Linus to run this

git grep -n -w get_ds | tr ':' ' ' | while read file line junk; do
	case "$file" in
	*include*|tools*)
		;;
	*)
		ed $file <<EOF
${line}s/get_ds()/KERNEL_DS/
w
q
EOF
		;;
	esac
done

just before -rc1, then follow it up with "kill unused get_ds()" patch
right after -rc1.
