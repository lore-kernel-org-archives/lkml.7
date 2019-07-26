Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD085C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BA120657
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564181245;
	bh=aDfFwQVufuI38BmvzBlKeAWC7n6zGui5AMaLxaymMr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fEAymjK5Jl7tIyKzSjAClYemIFPgs/TkqqZE8y+w0SLu7iK5KyAd2wHQVtPCAhoHd
	 HjrF1rrV2f+g3sZCqwslcaNIIIlvyTTiAb0FJimGtYsBUVib241l3fl5xbIBN6bdXF
	 1FaA2MmAHAMkPKbmLRQCcyU/gxG//xPPzuoSKLuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbfGZWrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:47:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41957 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfGZWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:47:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so52918203ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvhl+E3GJ0wX7WnV445XNNKydMDFA46thWrGIj1mIFA=;
        b=GOxLXfdpuhlLftPoWnZrvMRblqxWbQ3er1hFgs/arKDDsdl194FVlQdatc/si9hxFr
         kVxHfT4tQQ31sJ21+3oANtmv33rMWfwJ2ONRNADmAJDyNwWi3M7uM/4KN6bZUIr7BHkT
         1PE4jlh7jdUrQ17riWCjMBVCrRw1oLxWmBTCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvhl+E3GJ0wX7WnV445XNNKydMDFA46thWrGIj1mIFA=;
        b=SIO14fXaM/6xRWs7MNeeasmXi3xmu/GKl+U01CPXA3+cmh8cDFAminZbJceekdvGeD
         aT356prXXV/vUMvJHhC32Sof5XP02f/Ub1Ka7YrjgwOTvzu/YoU/Z8ZBDJ7xJXYX1pfs
         iOktP0sNyjFxpCyKCQ9y3/Bwj2eQOVSgB5iWUi3d2XLSuOhk+s3eiGV4MWZHAIlD/S5I
         57KGnZt5Wz3vA0jAtnHpAxaZtnKKeU9PiQ6OWeD15+kJXvf3TVtDBJaEwJD1/PYcEtF1
         DOQfLU3Xyk+CWEyA9zDp1K6PZHVerC8Sd6AbZorZwd1SdjWGgDgkNizJpsKXFxIYUbiC
         IRsQ==
X-Gm-Message-State: APjAAAX33lkEcifhPvLyQ12bpPn/DkHrnj9TLoB6CwattZm1mRA1WODE
        p44gIsgv5K4fofpdOz4VHSkgTSQAsIg=
X-Google-Smtp-Source: APXvYqyttprpZykoWUrT//Gh0ChXk2NCggIpauWr4Uhkk0uFA95otGUrR9WJxYRjdfZ95qWkTz0LQw==
X-Received: by 2002:a2e:9857:: with SMTP id e23mr50199281ljj.217.1564181240446;
        Fri, 26 Jul 2019 15:47:20 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x18sm8792275lfe.42.2019.07.26.15.47.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 15:47:18 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id p17so52948437ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 15:47:18 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr52379784ljj.156.1564181238239;
 Fri, 26 Jul 2019 15:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
In-Reply-To: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Jul 2019 15:47:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
Message-ID: <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka
 user-namespace-mountable) filesystems
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 5:00 AM Christian Brauner <christian@brauner.io> wrote:
>
> The commit that introduced the regression is:
>
> commit 0ce0cf12fc4c6a089717ff613d76457052cf4303
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sun May 12 15:42:48 2019 -0400
>
>     consolidate the capability checks in sget_{fc,userns}()
>
>     ... into a common helper - mount_capable(type, userns)

The commit message there tries to imply that it's just consolidating
existing checks, but you're right - that's not at all the case.

In sget_fc(), the tests are all the exact same tests, but it uses a
different 'user_ns' after the commit. It *used* to use fc->user_ns,
now it uses 'user_ns' which depends on that 'global' bit.

And in sget_userns(), the userns is the same, but the tests are
different. Before that commit, it *always* checked for capability in
user_ns, and then (for non-FS_USERNS_MOUNT) it checked for capability
in the init namespace.

I guess the semantic change in sget_userns() is immaterial - if you
have CAP_SYS_ADMIN in the init namespace, you will have it in user_ns
too.

But the sget_fc() semantic change is a more serious change. Maybe that
was just unintentional, and Al _meant_ to pass in "fc->user_ns", but
didn't?

Of course, then later on, commit 20284ab7427f ("switch mount_capable()
to fs_context") drops that argument entirely, and hardcodes the
decision to look at fc->global.

But that fc->global decision wasn't there originally, and is incorrect
since it breaks existing users.

What gets much more confusing about this is that the two different
users then moved around. The sget_userns() case got moved to
legacy_get_tree(), and then joined together in vfs_get_tree(), and
then split and moved out to do_new_mount() and vfs_fsconfig_locked().

And that "joined together into vfs_get_tree()" must be wrong, because
the two cases used two different namespace rules. The sget_userns()
case *did* have that "global" flag check, while the sget_fc() did not.

Messy. Al?

               Linus
