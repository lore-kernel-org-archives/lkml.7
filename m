Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F4C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B11A204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEHAmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:42:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHAmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:42:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zHkQ6mGQz9s00;
        Wed,  8 May 2019 10:42:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yury Norov <yury.norov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yury Norov <ynorov@marvell.com>
Subject: Re: [PATCH] powerpc: restore current_thread_info()
In-Reply-To: <20190507230746.GA19259@yury-thinkpad>
References: <20190507225121.18676-1-ynorov@marvell.com> <20190507225856.GP23075@ZenIV.linux.org.uk> <20190507230746.GA19259@yury-thinkpad>
Date:   Wed, 08 May 2019 10:42:37 +1000
Message-ID: <87h8a5wzcy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:
> On Tue, May 07, 2019 at 11:58:56PM +0100, Al Viro wrote:
>> On Tue, May 07, 2019 at 03:51:21PM -0700, Yury Norov wrote:
>> > Commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
>> > removes the function current_thread_info(). It's wrong because the
>> > function is used in non-arch code and is part of API.
>> 
>> In include/linux/thread_info.h:
>> 
>> #ifdef CONFIG_THREAD_INFO_IN_TASK
>> /*
>>  * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
>>  * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
>>  * including <asm/current.h> can cause a circular dependency on some platforms.
>>  */
>> #include <asm/current.h>
>> #define current_thread_info() ((struct thread_info *)current)
>> #endif
>
> Ah, sorry. Then it might be my rebase issue. I was confused because Christophe
> didn't remove the comment to current_thread_info(), so I decided he
> removed it erroneously.

Yeah you're right, that comment should have been removed too.

cheers
