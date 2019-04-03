Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC2C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D22B20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="RV90u1gU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnzHKVfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfDCEyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:54:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34689 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfDCEyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:54:50 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7605421EDB;
        Wed,  3 Apr 2019 00:54:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Apr 2019 00:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=dRD1L04hChZhTlTZdre1MhwWkHZ
        l8qy1+Gyjem9CXC0=; b=RV90u1gUiM8BnetFp56ONnHB6PkfQUeM6zA3ajYkOAu
        j7qPVKdAzKP361VnZqrHif1EO6QE9rDFnnqRG707YJIcHZPRqTu+Ynzkqx/OUUFs
        gvbFQsLHFCkOrEyY6dlcS79lix0+BuES34/mCu9XJcqtxN9b6b41+Da56359Kiid
        Wicp2A+hfkSQrllKtqhZ0yChA8uAJGc32xPfWlNgI8b7OsuiQN+/GUZmgLu7KODm
        VwgktTK9cnhYG86LQyTT4iUZlLYC0Ozk8oPSuV2UJ9gA5fBIEV91oTvJwqpLSqDJ
        u1lfubXw2Ov9NOx3mgLUM0z96xA+ubueiVC/w7HdWag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dRD1L0
        4hChZhTlTZdre1MhwWkHZl8qy1+Gyjem9CXC0=; b=UnzHKVfNQTDvpsPZJ8iE3B
        IkzERqxjl+PXhHXjFKKSxK9HlTAtsSPVgxZvEftuaCsvfx+r6gKzkAVWyu1pQBlU
        dd5ADMfbNYeoN120YEk4WaEe+ksgeQVuYW2q4pVHLaS5wcgQhIIth/iL0UeFq6f+
        LoRTycJaxeJecqX/0+UGwBYQgeeUxqH4r4hItaCfhmLi7lgHTzbE5NkwPwLDJVYh
        NaQi/gytoVYcoTgIGyFKpS+Bb9kbDTk+JCmpX9x/cG2LzftCf69aaY6XSQdjYPUm
        aNB6t6hFLqA63sMDDOGuVvsKhfXEVnORtpHdhkKHYooxmsaihhplOf3UagA1AERw
        ==
X-ME-Sender: <xms:mDykXEtKq0L0fk5G4sy3373KkIWr-5PflY72HG2MzKq7qLaUFnZviA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdekieculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhep
    fdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecuff
    homhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvgedrudeiledrvdejrddvtdek
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsth
    gvrhfuihiivgeptd
X-ME-Proxy: <xmx:mDykXHFtcfvr9iut-n4K0wvcsOZDBN3aJ7v8DAZeQwaF62awPeHCZQ>
    <xmx:mDykXH3Uog-QhGCuM58jlgVn458WTIkD8JkbQAh0jnulL1NQvmWEFQ>
    <xmx:mDykXP6hyIpL89iLVvUlCOjvGgOufnV-8N0QkoYZMOPaPVN9BFhIfQ>
    <xmx:mTykXF5jZp7JGKvJMuramSNW9ZARDoMq2WBsUViKUb5Pz4FAUhLmFg>
Received: from localhost (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5111E4841;
        Wed,  3 Apr 2019 00:54:47 -0400 (EDT)
Date:   Wed, 3 Apr 2019 15:54:17 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     kernel test robot <lkp@intel.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, LKP <lkp@01.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 15c8410c67 ("mm/slob.c: respect list_head abstraction layer"):
 WARNING: CPU: 0 PID: 1 at lib/list_debug.c:28 __list_add_valid
Message-ID: <20190403045417.GA19313@eros.localdomain>
References: <5ca413c6.9TM84kwWw8lLhnmK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca413c6.9TM84kwWw8lLhnmK%lkp@intel.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:00:38AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> commit 15c8410c67adefd26ea0df1f1b86e1836051784b
> Author:     Tobin C. Harding <tobin@kernel.org>
> AuthorDate: Fri Mar 29 10:01:23 2019 +1100
> Commit:     Stephen Rothwell <sfr@canb.auug.org.au>
> CommitDate: Sat Mar 30 16:09:41 2019 +1100
> 
>     mm/slob.c: respect list_head abstraction layer
>     
>     Currently we reach inside the list_head.  This is a violation of the layer
>     of abstraction provided by the list_head.  It makes the code fragile.
>     More importantly it makes the code wicked hard to understand.
>     
>     The code logic is based on the page in which an allocation was made, we
>     want to modify the slob_list we are working on to have this page at the
>     front.  We already have a function to check if an entry is at the front of
>     the list.  Recently a function was added to list.h to do the list
>     rotation.  We can use these two functions to reduce line count, reduce
>     code fragility, and reduce cognitive load required to read the code.
>     
>     Use list_head functions to interact with lists thereby maintaining the
>     abstraction provided by the list_head structure.
>     
>     Link: http://lkml.kernel.org/r/20190318000234.22049-3-tobin@kernel.org
>     Signed-off-by: Tobin C. Harding <tobin@kernel.org>
>     Cc: Christoph Lameter <cl@linux.com>
>     Cc: David Rientjes <rientjes@google.com>
>     Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>     Cc: Pekka Enberg <penberg@kernel.org>
>     Cc: Roman Gushchin <guro@fb.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> 2e1f88301e  include/linux/list.h: add list_rotate_to_front()
> 15c8410c67  mm/slob.c: respect list_head abstraction layer
> 05d08e2995  Add linux-next specific files for 20190402
> +-------------------------------------------------------+------------+------------+---------------+
> |                                                       | 2e1f88301e | 15c8410c67 | next-20190402 |
> +-------------------------------------------------------+------------+------------+---------------+
> | boot_successes                                        | 1009       | 198        | 299           |
> | boot_failures                                         | 0          | 2          | 44            |
> | WARNING:at_lib/list_debug.c:#__list_add_valid         | 0          | 2          | 44            |
> | RIP:__list_add_valid                                  | 0          | 2          | 44            |
> | WARNING:at_lib/list_debug.c:#__list_del_entry_valid   | 0          | 2          | 25            |
> | RIP:__list_del_entry_valid                            | 0          | 2          | 25            |
> | WARNING:possible_circular_locking_dependency_detected | 0          | 2          | 44            |
> | RIP:_raw_spin_unlock_irqrestore                       | 0          | 2          | 2             |
> | BUG:kernel_hang_in_test_stage                         | 0          | 0          | 6             |
> | BUG:unable_to_handle_kernel                           | 0          | 0          | 1             |
> | Oops:#[##]                                            | 0          | 0          | 1             |
> | RIP:slob_page_alloc                                   | 0          | 0          | 1             |
> | Kernel_panic-not_syncing:Fatal_exception              | 0          | 0          | 1             |
> | RIP:delay_tsc                                         | 0          | 0          | 2             |
> +-------------------------------------------------------+------------+------------+---------------+
> 
> [    2.618737] db_root: cannot open: /etc/target
> [    2.620114] mtdoops: mtd device (mtddev=name/number) must be supplied
> [    2.620967] slram: not enough parameters.
> [    2.621614] ------------[ cut here ]------------
> [    2.622254] list_add corruption. prev->next should be next (ffffffffaeeb71b0), but was ffffcee1406d3f70. (prev=ffffcee140422508).

Is this perhaps a false positive because we hackishly move the list_head
'head' and insert it back into the list.  Perhaps this is confusing the
validation functions?

	Tobin
