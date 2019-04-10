Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B10420830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfDJRbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:31:05 -0400
Received: from namei.org ([65.99.196.166]:33476 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbfDJRbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:31:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3AHV1Qh026449;
        Wed, 10 Apr 2019 17:31:01 GMT
Date:   Thu, 11 Apr 2019 03:31:01 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jann Horn <jannh@google.com>
cc:     David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] keys: safe concurrent user->{session,uid}_keyring
 access
In-Reply-To: <20190327155508.144730-1-jannh@google.com>
Message-ID: <alpine.LRH.2.21.1904110330420.25754@namei.org>
References: <20190327155508.144730-1-jannh@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019, Jann Horn wrote:

> The current code can perform concurrent updates and reads on
> user->session_keyring and user->uid_keyring. Add a comment to
> struct user_struct to document the nontrivial locking semantics, and use
> READ_ONCE() for unlocked readers and smp_store_release() for writers to
> prevent memory ordering issues.
> 
> Fixes: 69664cf16af4 ("keys: don't generate user and user session keyrings unless they're accessed")
> Signed-off-by: Jann Horn <jannh@google.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

