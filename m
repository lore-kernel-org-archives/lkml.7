Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB62DECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC052064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfJOO2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:28:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40211 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfJOO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:28:50 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKNoe-0005gW-JJ; Tue, 15 Oct 2019 14:28:48 +0000
Date:   Tue, 15 Oct 2019 16:28:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christian Kellner <ckellner@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] pidfd: fix selftest compilation by removing linux/wait.h
Message-ID: <20191015142847.fa5ypv2qrocbuifd@wittgenstein>
References: <20191011163811.8607-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011163811.8607-1-ckellner@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 06:38:11PM +0200, Christian Kellner wrote:
> From: Christian Kellner <christian@kellner.me>
> 
> The pidfd_{open,poll}_test.c files both include `linux/wait.h` and
> later `sys/wait.h`. The former has `#define P_ALL 0`, but in the
> latter P_ALL is part of idtype_t enum, where it gets substituted
> due to the aforementioned define to be `0`, which then results in
> `typedef enum {0, ...`, which then results into a compiler error:
> "error: expected identifier before numeric constant".
> Since we need `sys/wait.h` for waitpid, drop `linux/wait.h`.
> 
> Signed-off-by: Christian Kellner <christian@kellner.me>

Sorry, I missed this patch.
This is problematic and your patch would only temporarily fix it.
If glibc adds a P_PIDFD to the enum we'll run into the same issue.
So please:
- remove the linux/wait.h header (as you've already done here)
- add a custom define for P_PIDFD under a different name, e.g.:
  #ifndef __P_PIDFD
  #define __P_PIDFD 3
  #endif
  and add a comment above it explaining the reason for this mess.


Thanks and (_ugh_)
Christian
