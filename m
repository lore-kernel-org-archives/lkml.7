Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AF8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F01B20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfDJR3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:29:17 -0400
Received: from namei.org ([65.99.196.166]:33462 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbfDJR3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:29:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3AHT7nZ026352;
        Wed, 10 Apr 2019 17:29:07 GMT
Date:   Thu, 11 Apr 2019 03:29:07 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jann Horn <jannh@google.com>
cc:     David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: don't use RCU accessors for
 cred->session_keyring
In-Reply-To: <20190327153938.82007-1-jannh@google.com>
Message-ID: <alpine.LRH.2.21.1904110328490.25754@namei.org>
References: <20190327153938.82007-1-jannh@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019, Jann Horn wrote:

> sparse complains that a bunch of places in kernel/cred.c access
> cred->session_keyring without the RCU helpers required by the __rcu
> annotation.
> 
> cred->session_keyring is written in the following places:
> 
>  - prepare_kernel_cred() [in a new cred struct]
>  - keyctl_session_to_parent() [in a new cred struct]
>  - prepare_creds [in a new cred struct, via memcpy]
>  - install_session_keyring_to_cred()
>   - from install_session_keyring() on new creds
>   - from join_session_keyring() on new creds [twice]
>   - from umh_keys_init()
>    - from call_usermodehelper_exec_async() on new creds
> 
> All of these writes are before the creds are committed; therefore,
> cred->session_keyring doesn't need RCU protection.
> 
> Remove the __rcu annotation and fix up all existing users that use __rcu.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

