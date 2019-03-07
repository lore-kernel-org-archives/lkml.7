Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D250206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551925547;
	bh=2QU0MDrpwdun4/cHB8qGjVqbgDWBHSzhyPsv//TX8GI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VMY0j734noahLWEDXJe5L8Cfa88v/n2ZMUrJJ3v2ckKg2T/mBuZJRF05bYDjqY1C6
	 gSvLgwjDV1LvDeVpHwKvF3ZJRD2VUFwvBZmHy3zUJtShXb7X/BQO8FatGP6DJ4CWY4
	 TdODWToITBczqa3KBZ1XzEKmakTCZvGr7MxNy3+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfCGCZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:25:45 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37091 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfCGCZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:25:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E96A9220F9;
        Wed,  6 Mar 2019 21:25:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Mar 2019 21:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=oxKc3nC4ChsFsCBUy2NStnah7Bm/f
        rt0us14liNc9fY=; b=2VOwoyYGJmIUFKkoTAPuRvuP4r0aGFoeJjqvz6FP/FiZ0
        H74g3Lq+5AK6+58vRq9lupnXPA4o9+S9eJifShwqSCVUE520D/H1ljHzj85uEenY
        4PuKBhMTETnp0k9qfsbiSMFToPXScdV2YMbp79Stg6Exi5Mu9SaEPDMnrLyIORX2
        Vn705rgjZYdqD7sOcubLCccMnGI7cB//i1wWHwgY50SYztlYsBB3LfhCoHO7/67U
        02kxLQkAVq8ABOWvFoUMTNrvAxlQUPfbCksKxFM58YcdrTdz4NOD5fRLi45HIgQA
        PBzePX50jIrD2gVyrU+iaPxVXA0EG88k4dPXu7JDA==
X-ME-Sender: <xms:JoGAXM1hvk0IYr3CAsEyqh5gV6lmFOD79JF6jLMw1WPB9GYK00_WZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeejgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffoh
    hmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdegrdduieelrdehrdduheeknecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:JoGAXHzeMfp4FeQ0bKdZuCkR8QkhAvC1k4JOo0vYF5FUnXZQLt69qg>
    <xmx:JoGAXP-JZiaUKbEg3t7AdxFsHVXIuQ2fS20IDAqM0yKwiEuKuMP61Q>
    <xmx:JoGAXF2tiDU3ewXifsShOgsv6LpJw6tk4Vkb74W8M-2JHbXjFdLKcQ>
    <xmx:J4GAXCCmAeruDdzPCnzwQ_-9tfZE_mfFPNdRYdeCzKlmQc6nbzO_aw>
Received: from localhost (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id B88B3E469F;
        Wed,  6 Mar 2019 21:25:41 -0500 (EST)
Date:   Thu, 7 Mar 2019 13:25:22 +1100
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] leaking_addresses: changes for v5.1-rc1
Message-ID: <20190307022522.GA3942@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling changes to scripts/leaking_addresses.pl

I've started using my kernel.org email address.  I believe its the key
you care about not the email address this email is sent from, the tag is
signed as usual.

thanks,
Tobin.


The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git tags/leaks-5.1-rc1

for you to fetch changes up to 9ac060a708e054233265f8febfcef009ac3da826:

  leaking_addresses: Completely remove --version flag (2019-03-07 08:53:18 +1100)

----------------------------------------------------------------
leaking_addresses patches for 5.1-rc1

Here are two super trivial patches to the leaking addresses script for
the 5.1-rc1 merge window.  One fixes the debugging output which is
currently broken in a bunch of places, the other removes the --version
command line option.

Both patches have been tested and sitting in linux-next tree for a month
or so.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>

----------------------------------------------------------------
Tobin C. Harding (2):
      leaking_addresses: Fix calls to dprint
      leaking_addresses: Completely remove --version flag

 scripts/leaking_addresses.pl | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
