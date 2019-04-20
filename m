Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FCCC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC8A21736
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfDTDfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:35:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44215 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726082AbfDTDfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:35:54 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3K3Zkf7025552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Apr 2019 23:35:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 164E1420497; Fri, 19 Apr 2019 23:35:46 -0400 (EDT)
Date:   Fri, 19 Apr 2019 23:35:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jon DeVree <nuxi@vault24.org>
Cc:     linux-kernel@vger.kernel.org, Jason@zx2c4.com
Subject: Re: [PATCH] random: fix CRNG initialization when random.trust_cpu=1
Message-ID: <20190420033546.GA5539@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Jon DeVree <nuxi@vault24.org>, linux-kernel@vger.kernel.org,
        Jason@zx2c4.com
References: <20190319172846.30741-1-nuxi@vault24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319172846.30741-1-nuxi@vault24.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:28:47PM -0400, Jon DeVree wrote:
> When the system boots with random.trust_cpu=1 it doesn't initialize the
> per-NUMA CRNGs because it skips the rest of the CRNG startup code. This
> means that the code from 1e7f583af67b ("random: make /dev/urandom scalable
> for silly userspace programs") is not used when random.trust_cpu=1.
> 
> crash> dmesg | grep random:
> [    0.000000] random: get_random_bytes called from start_kernel+0x94/0x530 with crng_init=0
> [    0.314029] random: crng done (trusting CPU's manufacturer)
> crash> print crng_node_pool
> $6 = (struct crng_state **) 0x0
> 
> After adding the missing call to numa_crng_init() the per-NUMA CRNGs are
> initialized again:
> 
> crash> dmesg | grep random:
> [    0.000000] random: get_random_bytes called from start_kernel+0x94/0x530 with crng_init=0
> [    0.314031] random: crng done (trusting CPU's manufacturer)
> crash> print crng_node_pool
> $1 = (struct crng_state **) 0xffff9a915f4014a0
> 
> The call to invalidate_batched_entropy() was also missing. This is
> important for architectures like PPC and S390 which only have the
> arch_get_random_seed_* functions.
> 
> Fixes: 39a8883a2b98 ("random: add a config option to trust the CPU's hwrng")
> Signed-off-by: Jon DeVree <nuxi@vault24.org>

Thanks, applied.

					- Ted
