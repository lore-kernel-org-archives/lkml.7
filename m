Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E184C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED2F2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="LilBzVZs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B7wwLCg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfDDEk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 00:40:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50411 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbfDDEk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 00:40:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3945E22001;
        Thu,  4 Apr 2019 00:40:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2019 00:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=bUj9cbWyiESD0Bndu7rVRnpZO5R
        GiJ6UN/btqvOMQzs=; b=LilBzVZsyjXpmUeuJmZQ7Y+uZrJnTTp3BYXzPrZZ5lY
        T2M9C00bxrnlWdXN8RULcQnLug7v/Z8WgHE5T3e9+tsTA8s2nL/vKgfD1//NwQ6N
        fRoBpYpfJg0V37fdH72ptQh8/gXbXeryPKCleEKF2G7Ab7s1g3ZvpxXGxld+g4Gk
        4x4WPrnIILYaiyZAzuHrB09pi+8ommonzl1QtPztwVkTvRVaZWj6Qz9a93EWk1zd
        UK9cUAke4Urf02P4AoIMD+M1sFABWGyJqPRSUe/RfHgVuTOsVLfZ8Pt/N/cddG64
        AmwZVL+UH7tzZNfmTEXfFa9RGuX9KfMB5o4Nq+Fom3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bUj9cb
        WyiESD0Bndu7rVRnpZO5RGiJ6UN/btqvOMQzs=; b=B7wwLCg61dSqSMNqMB2jX/
        NZgBgRnxkTKygwqNS2Ty+qvnu7AKFu1l4GyCzY0jj5qdVeYMFIWyWET17/SEbrzj
        IU7vv/sJM+f9CWnzGn3+vOVkOV9uv8Q4g6jojiAUgcsyLMRRjcJDr+iiz7EXUBZO
        7LktPymVBPnmlVUEZUxlyMnqmyRvhxCXOssUd2f8E8G+hcU87x4gezRGWOIQV0A9
        wTTair7UEojVB76FWDf/6KxeG2lSKCiKqBvgyrpE4Uen7rBj66Dnk1uJA4xcTpAW
        m2xPcj39R8sulCRcgmdPCh4HYeHAr74OkMFMzBA7/iV+9TRzG5vm6u58g8fwxVoA
        ==
X-ME-Sender: <xms:u4qlXGTFrTZb_DWvALZx7_euM30AD_HrwUXvuhhgj9t3dicy95FhhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdekfeculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhep
    fdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecuff
    homhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvgedrudegledruddugedrkeei
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsth
    gvrhfuihiivgeptd
X-ME-Proxy: <xmx:u4qlXGfYZuxFbCPsWQQx6bcZBokcUeyGR3CXXH9woUnpfo_PzTgsTQ>
    <xmx:u4qlXH0w9YC9VYnG42RROq5pmJfxKbHD8VSQvoneEOcn_k9v0Ra7pg>
    <xmx:u4qlXCs_zoe62dctCp6DDOWxL3ja28G5IKYzpncaFfa-gsk8kXxbpg>
    <xmx:vIqlXPca26sTVtn2yzYtYifaq6OtxueTr3W6epUZNMna33Cfk0tgnA>
Received: from localhost (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id DD01510310;
        Thu,  4 Apr 2019 00:40:26 -0400 (EDT)
Date:   Thu, 4 Apr 2019 15:39:56 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     kernel test robot <lkp@intel.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, LKP <lkp@01.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 15c8410c67 ("mm/slob.c: respect list_head abstraction layer"):
 WARNING: CPU: 0 PID: 1 at lib/list_debug.c:28 __list_add_valid
Message-ID: <20190404043956.GA19471@eros.localdomain>
References: <5ca413c6.9TM84kwWw8lLhnmK%lkp@intel.com>
 <20190403045417.GA19313@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403045417.GA19313@eros.localdomain>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:54:17PM +1100, Tobin C. Harding wrote:
> On Wed, Apr 03, 2019 at 10:00:38AM +0800, kernel test robot wrote:
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > 
> > commit 15c8410c67adefd26ea0df1f1b86e1836051784b
> > Author:     Tobin C. Harding <tobin@kernel.org>
> > AuthorDate: Fri Mar 29 10:01:23 2019 +1100
> > Commit:     Stephen Rothwell <sfr@canb.auug.org.au>
> > CommitDate: Sat Mar 30 16:09:41 2019 +1100
> > 
> >     mm/slob.c: respect list_head abstraction layer
> >     
> >     Currently we reach inside the list_head.  This is a violation of the layer
> >     of abstraction provided by the list_head.  It makes the code fragile.
> >     More importantly it makes the code wicked hard to understand.
> >     
> >     The code logic is based on the page in which an allocation was made, we
> >     want to modify the slob_list we are working on to have this page at the
> >     front.  We already have a function to check if an entry is at the front of
> >     the list.  Recently a function was added to list.h to do the list
> >     rotation.  We can use these two functions to reduce line count, reduce
> >     code fragility, and reduce cognitive load required to read the code.
> >     
> >     Use list_head functions to interact with lists thereby maintaining the
> >     abstraction provided by the list_head structure.
> >     
> >     Link: http://lkml.kernel.org/r/20190318000234.22049-3-tobin@kernel.org
> >     Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> >     Cc: Christoph Lameter <cl@linux.com>
> >     Cc: David Rientjes <rientjes@google.com>
> >     Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >     Cc: Pekka Enberg <penberg@kernel.org>
> >     Cc: Roman Gushchin <guro@fb.com>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > 2e1f88301e  include/linux/list.h: add list_rotate_to_front()
> > 15c8410c67  mm/slob.c: respect list_head abstraction layer
> > 05d08e2995  Add linux-next specific files for 20190402
> > +-------------------------------------------------------+------------+------------+---------------+
> > |                                                       | 2e1f88301e | 15c8410c67 | next-20190402 |
> > +-------------------------------------------------------+------------+------------+---------------+
> > | boot_successes                                        | 1009       | 198        | 299           |
> > | boot_failures                                         | 0          | 2          | 44            |
> > | WARNING:at_lib/list_debug.c:#__list_add_valid         | 0          | 2          | 44            |
> > | RIP:__list_add_valid                                  | 0          | 2          | 44            |
> > | WARNING:at_lib/list_debug.c:#__list_del_entry_valid   | 0          | 2          | 25            |
> > | RIP:__list_del_entry_valid                            | 0          | 2          | 25            |
> > | WARNING:possible_circular_locking_dependency_detected | 0          | 2          | 44            |
> > | RIP:_raw_spin_unlock_irqrestore                       | 0          | 2          | 2             |
> > | BUG:kernel_hang_in_test_stage                         | 0          | 0          | 6             |
> > | BUG:unable_to_handle_kernel                           | 0          | 0          | 1             |
> > | Oops:#[##]                                            | 0          | 0          | 1             |
> > | RIP:slob_page_alloc                                   | 0          | 0          | 1             |
> > | Kernel_panic-not_syncing:Fatal_exception              | 0          | 0          | 1             |
> > | RIP:delay_tsc                                         | 0          | 0          | 2             |
> > +-------------------------------------------------------+------------+------------+---------------+
> > 
> > [    2.618737] db_root: cannot open: /etc/target
> > [    2.620114] mtdoops: mtd device (mtddev=name/number) must be supplied
> > [    2.620967] slram: not enough parameters.
> > [    2.621614] ------------[ cut here ]------------
> > [    2.622254] list_add corruption. prev->next should be next (ffffffffaeeb71b0), but was ffffcee1406d3f70. (prev=ffffcee140422508).
> 
> Is this perhaps a false positive because we hackishly move the list_head
> 'head' and insert it back into the list.  Perhaps this is confusing the
> validation functions?

This has got me stumped.  I cannot create a test case where manipulating
a list with list_rotate_to_front() causes the list validation functions
to emit an error.  Also I cannot come up with a way on paper that it can
happen either.

I don't really know how to go forwards from here.  I'll sleep on it and
see if something comes to me, any ideas to look into please?

thanks,
Tobin.
