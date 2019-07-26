Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABCAC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E33C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfGZXWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:22:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47670 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfGZXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:22:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hr9XY-0000zv-Hh; Fri, 26 Jul 2019 23:22:20 +0000
Date:   Sat, 27 Jul 2019 00:22:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka
 user-namespace-mountable) filesystems
Message-ID: <20190726232220.GM1131@ZenIV.linux.org.uk>
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
 <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:47:02PM -0700, Linus Torvalds wrote:

> Of course, then later on, commit 20284ab7427f ("switch mount_capable()
> to fs_context") drops that argument entirely, and hardcodes the
> decision to look at fc->global.
> 
> But that fc->global decision wasn't there originally, and is incorrect
> since it breaks existing users.
> 
> What gets much more confusing about this is that the two different
> users then moved around. The sget_userns() case got moved to
> legacy_get_tree(), and then joined together in vfs_get_tree(), and
> then split and moved out to do_new_mount() and vfs_fsconfig_locked().
> 
> And that "joined together into vfs_get_tree()" must be wrong, because
> the two cases used two different namespace rules. The sget_userns()
> case *did* have that "global" flag check, while the sget_fc() did not.
> 
> Messy. Al?

Digging through that mess...  It's my fuckup, and we obviously need to
restore the old behaviour, but I really hope to manage that with
checks _not_ in superblock allocator ;-/
