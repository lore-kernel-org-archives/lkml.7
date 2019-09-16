Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7660C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A276E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfIPLYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:24:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:34788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfIPLYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:24:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB56DAF23;
        Mon, 16 Sep 2019 11:24:31 +0000 (UTC)
Date:   Mon, 16 Sep 2019 13:24:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.4
Message-ID: <20190916112431.jsts2owcco5pg4jg@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.4

========================

- Fix off-by-one error when calculating messages that might fit
  into kmsg buffer. It causes occasional omitting of the last message.

- Add missing pointer check in %pD format modifier handling.

- Some clean up.

----------------------------------------------------------------
Chuhong Yuan (1):
      printk: Replace strncmp() with str_has_prefix()

James Byrne (1):
      ABI: Update dev-kmsg documentation to match current kernel behaviour

Jia He (2):
      vsprintf: Prevent crash when dereferencing invalid pointers for %pD
      lib/test_printf: Add test of null/invalid pointer dereference for dentry

Petr Mladek (2):
      lib/test_printf: Remove obvious comments from %pd and %pD tests
      Merge branch 'for-5.4' into for-linus

Vincent Whitchurch (1):
      printk: Do not lose last line in kmsg buffer dump

 Documentation/ABI/testing/dev-kmsg | 15 +++++++--------
 kernel/printk/braille.c            | 15 +++++++++++----
 kernel/printk/printk.c             | 24 +++++++++++++++++-------
 lib/test_printf.c                  |  5 +++++
 lib/vsprintf.c                     | 13 ++++++++++---
 5 files changed, 50 insertions(+), 22 deletions(-)
