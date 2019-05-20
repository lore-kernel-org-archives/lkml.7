Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BADC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E0A20862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfETWs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 18:48:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58900 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfETWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 18:48:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2E3EF12DAD571;
        Mon, 20 May 2019 15:48:58 -0700 (PDT)
Date:   Mon, 20 May 2019 15:48:55 -0700 (PDT)
Message-Id: <20190520.154855.2207738976381931092.davem@davemloft.net>
To:     rick.p.edgecombe@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mroos@linux.ee, netdev@vger.kernel.org,
        sparclinux@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        mingo@redhat.com, namit@vmware.com, dave.hansen@intel.com
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c6020a01e81d08342e1a2b3ae7e03d55858480ba.camel@intel.com>
References: <20190520200703.15997-1-rick.p.edgecombe@intel.com>
        <90f8a4e1-aa71-0c10-1a91-495ba0cb329b@linux.ee>
        <c6020a01e81d08342e1a2b3ae7e03d55858480ba.camel@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 May 2019 15:48:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Mon, 20 May 2019 22:17:49 +0000

> Thanks for testing. So I guess that suggests it's the TLB flush causing
> the problem on sparc and not any lazy purge deadlock. I had sent Meelis
> another test patch that just flushed the entire 0 to ULONG_MAX range to
> try to always the get the "flush all" logic and apprently it didn't
> boot mostly either. It also showed that it's not getting stuck anywhere
> in the vm_remove_alias() function. Something just hangs later.

I wonder if an address is making it to the TLB flush routines which is
not page aligned.  Or a TLB flush is being done before the callsites
are patched properly for the given cpu type.
