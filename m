Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80549C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55845222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLSLUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:20:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfLSLUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:20:01 -0500
Received: from [79.140.121.60] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ihtqR-0003c3-2B; Thu, 19 Dec 2019 11:19:51 +0000
Date:   Thu, 19 Dec 2019 12:19:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] openat2: minor uapi cleanups
Message-ID: <20191219111949.auriw6biphxxvdng@wittgenstein>
References: <20191219105533.12508-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219105533.12508-1-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 09:55:28PM +1100, Aleksa Sarai wrote:
> While openat2(2) is still not yet in Linus's tree, we can take this
> opportunity to iron out some small warts that weren't noticed earlier:
> 
>   * A fix was suggested by Florian Weimer, to separate the openat2
>     definitions so glibc can use the header directly. I've put the
>     maintainership under VFS but let me know if you'd prefer it belong
>     ot the fcntl folks.
> 
>   * Having heterogenous field sizes in an extensible struct results in
>     "padding hole" problems when adding new fields (in addition the
>     correct error to use for non-zero padding isn't entirely clear ).
>     The simplest solution is to just copy clone(3)'s model -- always use
>     u64s. It will waste a little more space in the struct, but it
>     removes a possible future headache.

Am I imagining things or did I get the same patch series twice?

Christian
