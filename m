Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAADC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4944F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfDLHDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbfDLHDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:03:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F00F2ADAA;
        Fri, 12 Apr 2019 07:03:04 +0000 (UTC)
Date:   Fri, 12 Apr 2019 09:03:04 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Shuah Khan <shuah@kernel.org>
cc:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch use TEST_PROGS for test shell
 scripts
In-Reply-To: <20190412011823.26884-1-shuah@kernel.org>
Message-ID: <alpine.LSU.2.21.1904120901490.773@pobox.suse.cz>
References: <20190412011823.26884-1-shuah@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Shuah Khan wrote:

> TEST_PROGS variable is for test shell scripts and common clean target
> in lib.mk doesn't touch them. TEST_GEN_PROGS are removed by it.
> 
> Fix it to use TEST_PROGS for test shell scripts and TEST_PROGS_EXTENDED
> for common functions.sh.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  tools/testing/selftests/livepatch/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index af4aee79bebb..fd405402c3ff 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -TEST_GEN_PROGS := \
> +TEST_PROGS_EXTENDED := functions.sh
> +TEST_PROGS := \
>  	test-livepatch.sh \
>  	test-callbacks.sh \
>  	test-shadow-vars.sh

Hi Shuah,

thanks for the patch. We have already something similar queued in our git 
tree. See 
https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git/commit/?h=for-5.1/upstream-fixes&id=abfe3c4560684864f66641438fee3075de098e89

It is missing TEST_PROGS_EXTENDED though. Should we add it?

Miroslav
