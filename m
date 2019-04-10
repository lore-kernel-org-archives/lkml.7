Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDAAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6AB20857
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554864484;
	bh=+RMywPEm68PFMzZ/6DUeakc2wa/FR5SDd7/I5XCbHgs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZuEmRHzY1oS9PSfWvgRNZIN274TV9xitgb5qI5aazCWOtN5tQ4/4b6FnHxgTievyw
	 bMvQ+4916nBtTrbQ1AhOzTjdlDU02juMICv6ynSYYhOOCvuT9CewfTdq5sDKDQ8Ec6
	 eDoYJuOuPiTPupJbmhlFGm9kFcth6k8HbfIq/EWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfDJCsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:48:02 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44155 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfDJCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:48:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 89AA411096;
        Tue,  9 Apr 2019 22:48:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 09 Apr 2019 22:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XlC3RnW+D3VAmOuoJ
        xxfAw5B6kl3S91FZ3Fvm+E8U4A=; b=lOxkk1daLOiUegnToXTPbXZstC7PhgN8v
        JNgQ4F00fMnTVZ9Snb0TFwk1DOJX1P61pbFmowgODP7h80N4aot4GVMGZz3fOYik
        AnUTSDJTvxaREOlbp5MXLBDdt6wCTpG98txUqu/KxZ2tNB3P8Dn/iPtOjjwKyohF
        e5GFJR9x6pYoyB2Fb99+TrdsSEfBr/9RfytcES7lAuuSP9/iyrqHOdZDjEzXqS1Z
        SImlly6TxIpyKk/7r83JOAj8p3/NXz5yhv5iSyY7rdmDeZdiIKmwn5x+MojV8IjW
        xx7oSwhoA/WUlWAT2wgAvT16zBbZ4qxnHGVm3CU/uAtW3XoAPds1Q==
X-ME-Sender: <xms:YFmtXMGFGIm-6am_5gDOgtnvVC7UyKzeFA4_cSGhoHZ_gw2hLatYSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeigdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudejuddrudelrdduleegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:YFmtXHOxTD7FOy3Uqw5GxJ2yaEeSWtc0WPUtjpjETR_PwYY0jg7hHQ>
    <xmx:YFmtXLQRd69luDnYzNCduhWMeanR3b0TETYgqZmLhuTNH6O11-7TlA>
    <xmx:YFmtXOSqW2Me1ghCuZXKUIfBx8Bmj7IHXCf1B3IWSU0oOIMKCMcEJw>
    <xmx:YVmtXFW9ie1klqfZaQJ-XkL6mOtkCMZwpXSIPUYTZofIoqXp1GVMzA>
Received: from eros.localdomain (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 746D610391;
        Tue,  9 Apr 2019 22:47:56 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] mm: Remove the SLAB allocator
Date:   Wed, 10 Apr 2019 12:47:13 +1000
Message-Id: <20190410024714.26607-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently a 2 year old bug was found in the SLAB allocator that crashes
the kernel.  This seems to imply that not that many people are using the
SLAB allocator.

Currently we have 3 slab allocators.  Two is company three is a crowd -
let's get rid of one. 

 - The SLUB allocator has been the default since 2.6.23
 - The SLOB allocator is kinda sexy.  Its only 664 LOC, the general
   design is outlined in KnR, and there is an optimisation taken from
   Knuth - say no more.

If you are using the SLAB allocator please speak now or forever hold your peace ...

Testing:

Build kernel with `make defconfig` (on x86_64 machine) followed by `make
kvmconfig`.  Then do the same and manually select SLOB.  Boot both
kernels in Qemu.


thanks,
Tobin.


Tobin C. Harding (1):
  mm: Remove SLAB allocator

 include/linux/slab.h |   26 -
 kernel/cpu.c         |    5 -
 mm/slab.c            | 4493 ------------------------------------------
 mm/slab.h            |   31 +-
 mm/slab_common.c     |   20 +-
 5 files changed, 5 insertions(+), 4570 deletions(-)
 delete mode 100644 mm/slab.c

-- 
2.21.0

