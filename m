Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3289E2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553810934;
	bh=Z3Bh15fiiyoRB9b/MgXof0a9yfpW1533uFz1TGPzN1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wG1WiDR139G1Yq4U0/7OPvoi9uF2gWmY/PU2BOuOWQuIgoRq9pphHQ2Z0q02cdwii
	 ygqw7aVn1DUQpXfwqadUjRHVyMJos5ReL3D8wPjMV23X4SZUeWs8YAbkYlVCt7Pe7b
	 ZqDonRl2W1ku9voPhgCCLhjPDWjDQKb2AwWPDWcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfC1WIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:08:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfC1WIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:08:52 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 30169D89;
        Thu, 28 Mar 2019 22:08:52 +0000 (UTC)
Date:   Thu, 28 Mar 2019 15:08:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RESEND PATCH v2 4/5] lib/list_sort: Simplify and remove
 MAX_LIST_LENGTH_BITS
Message-Id: <20190328150851.5d261d1a72e2ca86a1c141c0@linux-foundation.org>
In-Reply-To: <f63c410e0ff76009c9b58e01027e751ff7fdb749.1552704200.git.lkml@sdf.org>
References: <cover.1552704200.git.lkml@sdf.org>
        <f63c410e0ff76009c9b58e01027e751ff7fdb749.1552704200.git.lkml@sdf.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 08:16:00 +0000 George Spelvin <lkml@sdf.org> wrote:

> Rather than a fixed-size array of pending sorted runs, use the ->prev
> links to keep track of things.  This reduces stack usage, eliminates
> some ugly overflow handling, and reduces the code size.
> 
> Also:
> * merge() no longer needs to handle NULL inputs, so simplify.
> * The same applies to merge_and_restore_back_links(), which is renamed
>   to the less ponderous merge_final().  (It's a static helper function,
>   so we don't need a super-descriptive name; comments will do.)
> * Document the actual return value requirements on the (*cmp)()
>   function; some callers are already using this feature.
> 
> x86-64 code size 1086 -> 739 bytes (-347)
> 
> (Yes, I see checkpatch complaining about no space after comma in
> "__attribute__((nonnull(2,3,4,5)))".  Checkpatch is wrong.)

x86_64 allnoconfig with gcc-7.3.0:

lib/list_sort.c:17:36: warning: __pure__ attribute ignored [-Wattributes]
   struct list_head const *, struct list_head const *);

