Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F92CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5581220869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbfKEINP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:13:15 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:38216 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387686AbfKEINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:13:15 -0500
Received: from [78.40.148.177] (helo=localhost)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iRtxh-00066H-Js; Tue, 05 Nov 2019 08:13:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Nov 2019 08:13:13 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org
Subject: de-reference of rcu pointers (sparse warnings)
Message-ID: <d0e13f6d93323acd3df7a6b92a56ab13@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few places in the kenrnel which directly de-reference
pointers marked as "noderef" such sa rcu or percpu. In the case
of rcu, one example is:

kernel/fork.c:2146:32: warning: incorrect type in assignment (different 
address spaces)
kernel/fork.c:2146:32:    expected struct task_struct [noderef] <asn:4> 
*real_parent
kernel/fork.c:2146:32:    got struct task_struct *task

this looks fairly non-trivial to fix given there's a mix of __rcu and 
non-__rcu
attributed variables.

Does anyone have an idea how to go about fixing these, if possible?

-- 
Ben
