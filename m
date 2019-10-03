Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77555C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37087222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570061442;
	bh=fmE3R/unYqOD8Jb21mmni10VRvYjNlSBy0xhnkNHBb8=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=XXexwTzTd+2QNPaP9s9YD3zvp63+98I/6FbPuy+M4gAiJ9zK/qfnG9sfcuOUJxyRJ
	 FQWNNfFouuxzodgz6WtJjMpd26PfGUoRg3u6sj/rOVvY+o8oY3O8dELoDdORwgtqi3
	 fooRBvsONHZ1Fu3YCm5Ca/HvZSbJBZZkivCBQUds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfJCAKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfJCAKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:10:41 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F42222BE;
        Thu,  3 Oct 2019 00:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570061440;
        bh=fmE3R/unYqOD8Jb21mmni10VRvYjNlSBy0xhnkNHBb8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=wJMqOS7sYhwPKsQOa7bATY/6lIrGaEoXusZZJfI94MLCVMFxRLH+WGLIPX88acFSW
         hRNO/706HX1lqbPmFlbNoe1BraU7X8Hrlz4FeYETYir7OVKs9FB2XXPmjHkPKEdhj5
         mYEqNzdURjHlitcYcZzIQvxS5ORsvJhLH8Th36h4=
Date:   Wed, 2 Oct 2019 17:10:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/32] Memory-model updates
Message-ID: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains updates for the Linux-kernel memory model:

1.	Fix data race detection for unordered store and load,
	courtesy of Alan Stern.

2-4.	Documentation update for plain accesses.

5-32.	Work-in-progress test-script updates.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |  602 ++++++++++++++++++++++++++++++++++++++++--
 linux-kernel.cat              |    2 
 litmus-tests/.gitignore       |    4 
 scripts/README                |   16 -
 scripts/checkalllitmus.sh     |   29 --
 scripts/checkghlitmus.sh      |   11 
 scripts/checklitmus.sh        |  101 +++----
 scripts/checklitmushist.sh    |    2 
 scripts/checktheselitmus.sh   |   43 +++
 scripts/cmplitmushist.sh      |   53 +++
 scripts/hwfnseg.sh            |   20 +
 scripts/initlitmushist.sh     |    2 
 scripts/judgelitmus.sh        |  164 ++++++++---
 scripts/newlitmushist.sh      |    4 
 scripts/parseargs.sh          |   21 +
 scripts/runlitmus.sh          |  144 +++++++---
 scripts/runlitmushist.sh      |   29 +-
 scripts/simpletest.sh         |   35 ++
 18 files changed, 1071 insertions(+), 211 deletions(-)
