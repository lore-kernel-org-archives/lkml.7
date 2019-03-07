Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEAAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1525E2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551993146;
	bh=WkrzSdGEHhzydBz8SLNammOMrmiXJpBlgacOOUWj+Ns=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aGojehXtLo8iKHWWvtB1tdEmYApGfYOIaqqE4pKcahtlUM2anZAge/sH/kGSBblL2
	 3YoPimRbArSs+yTWKjtIhFbC/Is914stv0YsoMi9Jyqt0w6raM6H7KXApOx5+z1QHH
	 JkNC/WzFYkc9ZlWy8lbRXtCUOTey8NPgsGlj1oMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCGVMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:12:24 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41611 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbfCGVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:12:24 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 15DF43026;
        Thu,  7 Mar 2019 16:12:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 16:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/tHVp1gtEeRLSAoer
        mLBJfxzsdFUrHewWYgWmWrrgbI=; b=1cvKLABHN1eTIWzvMQBdkQXYiib6cn0rQ
        EAtoXXctgUhikAa4HbwBvRr+o9rZl1O4HyZjy26SBIe+N844bAEBdmBLOf2q9QC+
        N8ktX12wJxTzfKt0902ZiL0Zc8+dTcyFLatKZjxEkp65RNWyTbmf2RhlBIRAT1GG
        pw/7Tu1bMUeOppENXxHFbNbCmZ2/vMGfpJUpH/fYmiVMm8mM+zcv7mfcyMcBtuPY
        W8BCNr768gDCwLHHy1QRtNqN60tjFtwUqjW51CO73aiXJ92GuYAw0jrJtzcBf2A5
        mUza4JM5jnyz38CNjx9jIQjBMkIMpa9umeKn5eujkzoQJCnibNvJg==
X-ME-Sender: <xms:NYmBXEW8Wf4vdNqqcXvlGRBypP6ThUxWxBQShUqbl_omOwaKBmJ2Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcu
    vedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppe
    duvdegrdduieelrdehrdduheeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NYmBXOOQln3BGQuKl91Ls9IaX1Y7DBb0IBT-36GJRZq_mxQeY1nXog>
    <xmx:NYmBXAdYY2D2f2MWwknKmQLSnAXn2UBlH3zyUePNOjOrS7hhIbk2Aw>
    <xmx:NYmBXMCfJtIq3TWCgRIhrp2yLFtAkKOieeKyify5e7rv7qLVAa1BUw>
    <xmx:NomBXOSz827_33fUKdgTwrA9aqXS-wNLiRFGLMouP74V1Datl22Z5w>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFE6510341;
        Thu,  7 Mar 2019 16:12:19 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] docs: Fix various build warnings/errors
Date:   Fri,  8 Mar 2019 08:11:44 +1100
Message-Id: <20190307211153.28400-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had a few hours to spare so I thought I'd clear some Sphinx build
warnings/errors.  There isn't anything too controversial here.  The only
interesting thing I hit was in patch 7 (docs: Remove unknown 'hint'
directive), I couldn't work out if this was a serious directive, a joke,
or a typo.  Please review that patch more carefully than the others.

Patch 4 adds :ref: and raises an issue I've come across a few times now,
could I have your opinion on it please (if you have the time/inclination
to share it)

:ref:`/Documentation/path/to/file.rst <label>`

vs

:ref:`label`

Undeniably the second is better in HTML.  The first is, on one hand,
arguable better to parse when reading the textual file (since you can
see which file it refers to) but on the other hand kinda looks ugly
since it often line wraps poorly and is a bit cluttered if all you want to
see is the path.  Having only the label doesn't _really_ make it worse
in text because often you already know (or don't care) what the path is
(e.g. when there are multiple refs to the same label) and if you do care
you can just grep the docs for the label.

Do you have an opinion on this?

Oh also, do you have a script by any chance that does a clean build of
the docs, saves stderr output, applies a patch, cleanly re-builds the
docs and then diffs the two outputs?  Then rinse-and-repeat for a whole
patch series. Thought I'd ask before I write one.

thanks,
Tobin.

Tobin C. Harding (9):
  docs: Fix spelling mistake
  docs: Add colon clearing sphinx warning
  docs: Remove unnecessary reference link title
  docs: Use reference to link to rst file
  docs: Replace backtick with apostrophe.
  docs: Use correct list markup character
  docs: Remove unknown 'hint' directive
  docs: Fix Title underline too short warning
  docs: Add blank line after SPDX licence identifier

 .../admin-guide/mm/numa_memory_policy.rst     |  9 ++-
 .../driver-api/dmaengine/dmatest.rst          |  4 +-
 Documentation/driver-api/gpio/board.rst       |  5 +-
 Documentation/filesystems/path-lookup.rst     | 24 ++++----
 Documentation/laptops/lg-laptop.rst           | 13 +++--
 Documentation/misc-devices/ibmvmc.rst         |  1 +
 Documentation/networking/snmp_counter.rst     | 58 +++++++++----------
 Documentation/process/howto.rst               |  2 +-
 Documentation/vm/numa.rst                     |  4 +-
 Documentation/vm/slub.rst                     |  2 +-
 include/linux/kernel.h                        |  2 +-
 include/linux/wait.h                          |  2 +-
 12 files changed, 64 insertions(+), 62 deletions(-)

-- 
2.21.0

