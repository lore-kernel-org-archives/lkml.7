Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D391FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C9C218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbfB1ShP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:37:15 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36612 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387399AbfB1ShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:37:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 268FB14BA6D35;
        Thu, 28 Feb 2019 10:37:14 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:37:13 -0800 (PST)
Message-Id: <20190228.103713.745079321072396223.davem@davemloft.net>
To:     igor.druzhinin@citrix.com
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.liu2@citrix.com,
        paul.durrant@citrix.com
Subject: Re: [PATCH v2] xen-netback: fix occasional leak of grant ref
 mappings under memory pressure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551358083-14227-1-git-send-email-igor.druzhinin@citrix.com>
References: <1551358083-14227-1-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Feb 2019 10:37:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Thu, 28 Feb 2019 12:48:03 +0000

> Zero-copy callback flag is not yet set on frag list skb at the moment
> xenvif_handle_frag_list() returns -ENOMEM. This eventually results in
> leaking grant ref mappings since xenvif_zerocopy_callback() is never
> called for these fragments. Those eventually build up and cause Xen
> to kill Dom0 as the slots get reused for new mappings:
> 
> "d0v0 Attempt to implicitly unmap a granted PTE c010000329fce005"
> 
> That behavior is observed under certain workloads where sudden spikes
> of page cache writes coexist with active atomic skb allocations from
> network traffic. Additionally, rework the logic to deal with frag_list
> deallocation in a single place.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Applied and queued up for -stable, thanks.
