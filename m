Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5770FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898D52168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393364AbfJPMvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:51:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42233 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405231AbfJPMuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:50:39 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKil0-0001Ie-TU; Wed, 16 Oct 2019 12:50:26 +0000
Date:   Wed, 16 Oct 2019 14:50:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     cyphar@cyphar.com, mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, christian@brauner.io, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usercopy: Avoid soft lockups in
 test_check_nonzero_user()
Message-ID: <20191016125025.ktxe55l4doirbxbe@wittgenstein>
References: <20191011022447.24249-1-mpe@ellerman.id.au>
 <20191016122732.13467-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016122732.13467-1-mpe@ellerman.id.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:27:32PM +1100, Michael Ellerman wrote:
> On a machine with a 64K PAGE_SIZE, the nested for loops in
> test_check_nonzero_user() can lead to soft lockups, eg:
> 
>   watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [modprobe:611]
>   Modules linked in: test_user_copy(+) vmx_crypto gf128mul crc32c_vpmsum virtio_balloon ip_tables x_tables autofs4
>   CPU: 4 PID: 611 Comm: modprobe Tainted: G             L    5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty #1151
>   ...
>   NIP __might_sleep+0x20/0xc0
>   LR  __might_fault+0x40/0x60
>   Call Trace:
>     check_zeroed_user+0x12c/0x200
>     test_user_copy_init+0x67c/0x1210 [test_user_copy]
>     do_one_initcall+0x60/0x340
>     do_init_module+0x7c/0x2f0
>     load_module+0x2d94/0x30e0
>     __do_sys_finit_module+0xc8/0x150
>     system_call+0x5c/0x68
> 
> Even with a 4K PAGE_SIZE the test takes multiple seconds. Instead
> tweak it to only scan a 1024 byte region, but make it cross the
> page boundary.
> 
> Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
> Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
