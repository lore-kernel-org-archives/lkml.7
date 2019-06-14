Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21902C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D6221744
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 01:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfFNBId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 21:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfFNBIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 21:08:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34CD23082DDD;
        Fri, 14 Jun 2019 01:08:29 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-232.rdu2.redhat.com [10.10.121.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC8B5429D;
        Fri, 14 Jun 2019 01:08:24 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/3] module: Livepatch/ftrace fixes
Date:   Thu, 13 Jun 2019 20:07:21 -0500
Message-Id: <cover.1560474114.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 14 Jun 2019 01:08:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 fixes a module loading race between livepatch and ftrace.

Patch 2 adds lockdep assertions assocated with patch 1.

Patch 3 fixes a theoretical bug in the module __ro_after_init section
handling.

Josh Poimboeuf (3):
  module: Fix livepatch/ftrace module text permissions race
  module: Add text_mutex lockdep assertions for page attribute changes
  module: Improve module __ro_after_init handling

 arch/arm64/kernel/ftrace.c |  2 +-
 include/linux/module.h     |  4 ++--
 kernel/livepatch/core.c    | 10 ++++++++--
 kernel/module.c            | 29 ++++++++++++++++++++++-------
 kernel/trace/ftrace.c      | 10 +++++++++-
 5 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.20.1

