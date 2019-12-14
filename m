Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09960C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C093920866
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="lWZ8zbtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLNU2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:28:07 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.87]:31929 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfLNU2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 15:28:07 -0500
X-Greylist: delayed 1330 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Dec 2019 15:28:06 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 1E8FA60EC62
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 14:05:56 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id gDfoiOs5xiJ43gDfoioC1z; Sat, 14 Dec 2019 14:05:56 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fuWZgfc/nOwr/7Hm0CFqLup50VNZxiYld5Lu20kW2H0=; b=lWZ8zbtphioj26kyBkxXWX+zoW
        A0L2B3ikK4xhPE73/B5bwoM5ZyLysrLSKeMT/NECuU5mqtrHZXWu0lGtdTzTzxu+n8irduxR/IteD
        mUzwP0crn27n84aDRu9rIjEQGNQPDEviDjdOhN9n99vfrZp2Q+12482FJY9IeN4NIVHJfEFkAXhCs
        ly3lsPcyOtgTX1PtEHY2PGrelLYNoLphpZXwfvUZqFeZSW14Eyie9v9S5tIq+V2ZLu+ff41IsLjWe
        SdI2EVSoaO4AkUE4iU1LHJI/GruJpBgVx7bULjevqzVAvo0jElqHFS8LJYJHN5SPNIALrAsbf05Ot
        Emn7YcjA==;
Received: from [187.192.35.14] (port=45108 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1igDfm-002mfX-Kj; Sat, 14 Dec 2019 14:05:54 -0600
Date:   Sat, 14 Dec 2019 14:07:09 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.5-rc2
Message-ID: <20191214200709.GA20124@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.35.14
X-Source-L: No
X-Exim-ID: 1igDfm-002mfX-Kj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.35.14]:45108
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.5-rc2

for you to fetch changes up to 3d519d6d388ba4f9a75d0e0b6f60d890987bc096:

  sh: kgdb: Mark expected switch fall-throughs (2019-12-10 16:11:42 -0600)

----------------------------------------------------------------
Wimplicit-fallthrough patches for 5.5-rc2

Hi Linus,

Please, pull the following patches that mark switch cases where we are
expecting to fall through.

 - Fix compile error on sh by marking expected switch fall-through

Thanks

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

----------------------------------------------------------------
Kuninori Morimoto (1):
      sh: kgdb: Mark expected switch fall-throughs

 arch/sh/kernel/kgdb.c | 1 +
 1 file changed, 1 insertion(+)
