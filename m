Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A550C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AA020823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="AKd+nnnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCDQ6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:58:02 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:54687 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfCDQ6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:
        To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JuMGGRdJmDe3eywXLTeiyy8oXxx8XgsT/Lsw4bPmI5s=; b=AKd+nnnCvriPihM/oyrkBl6IVq
        csiqSnfZrTq43jFN0Xscrcw0d1hgIT5ZoG/rWNFcjBLzSeicZRqJPN4NZUVnmvuMuFJbG5yuPKGkZ
        5OKuydXrjTCIaebFu+C/kHT/m0BjQDguJCzHaxnLLY5FDJVKWAOUnTSug2ZPNlbS+6ywdc3WsaPYQ
        KnrBrjrReoMXPH6qX/dzQKtV+2jWg2mAX/aQaUqsGHUGqdIXSLKSidJ7qmw56nvi/dtsDd7lJuS1D
        6HZ7eMpEIp0dZoySUzWzunvV6+ocI0r8tnMlVXnDUOKghHyor6wV6IRpW6Q7+Wv7sU8Lm1zz+6KGv
        RDzO60uA==;
Received: from [10.7.4.141] (port=59860 helo=cello.cs.msu.ru)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h0quN-000JP0-Ng; Mon, 04 Mar 2019 19:57:44 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Date:   Mon,  4 Mar 2019 19:57:29 +0300
Message-Id: <20190304165732.24043-1-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 0/3] kbuild: More KCONFIG_CONFIG ignorance
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following a recent bug with `make *config' not supporting a redefined
kernel config file, I ran a `git grep -w -nE [.]config **/Makefile'
and discovered these:

Arseny Maslennikov (3):
  kconfig/Makefile: localmodconfig: use KCONFIG_CONFIG
  Makefile: kselftest: use KCONFIG_CONFIG
  arch/um/kernel/Makefile: use KCONFIG_CONFIG

 Makefile                 |  4 ++--
 arch/um/kernel/Makefile  |  2 +-
 scripts/kconfig/Makefile | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.20.1

