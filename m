Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51C6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AAE208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbfIJMUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:20:35 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46586 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbfIJMUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:20:34 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4363B72CC6C;
        Tue, 10 Sep 2019 15:20:32 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id BD4867CCB47; Tue, 10 Sep 2019 15:20:31 +0300 (MSK)
Date:   Tue, 10 Sep 2019 15:20:31 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] fork: fail on non-zero higher 32 bits of args.exit_signal
Message-ID: <20190910122031.GA5311@altlinux.org>
References: <20190910115711.GA3755@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910115711.GA3755@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:57:11PM +0100, Eugene Syromiatnikov wrote:
> Previously, higher 32 bits of exit_signal fields were lost when
> copied to the kernel args structure (that uses int as a type for the
> respective field).  Fail with EINVAL if these are set as it looks like
> there's no sane reason to accept them.
> 
> * kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
> args.exit_signal converted to unsigned int is not equal to the original
> value.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>


-- 
ldv
