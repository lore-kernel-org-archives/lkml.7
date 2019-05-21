Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0D4C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9001B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfEUAdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 20:33:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59966 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfEUAdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:33:21 -0400
Received: from localhost (50-78-161-185-static.hfc.comcastbusiness.net [50.78.161.185])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B81BD1400F7CA;
        Mon, 20 May 2019 17:33:20 -0700 (PDT)
Date:   Mon, 20 May 2019 20:33:20 -0400 (EDT)
Message-Id: <20190520.203320.621504228022195532.davem@davemloft.net>
To:     rick.p.edgecombe@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, mroos@linux.ee, mingo@redhat.com,
        namit@vmware.com, luto@kernel.org, bp@alien8.de,
        netdev@vger.kernel.org, dave.hansen@intel.com,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
From:   David Miller <davem@davemloft.net>
In-Reply-To: <3e7e674c1fe094cd8dbe0c8933db18be1a37d76d.camel@intel.com>
References: <c6020a01e81d08342e1a2b3ae7e03d55858480ba.camel@intel.com>
        <20190520.154855.2207738976381931092.davem@davemloft.net>
        <3e7e674c1fe094cd8dbe0c8933db18be1a37d76d.camel@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 May 2019 17:33:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 00:20:13 +0000

> This behavior shouldn't happen until modules or BPF are being freed.

Then that would rule out my theory.

The only thing left is whether the permissions are actually set
properly.  If they aren't we'll take an exception when the BPF program
is run and I'm not %100 sure that kernel execute permission violations
are totally handled cleanly.
