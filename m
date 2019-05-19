Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9979CC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9E620449
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GMFr8l9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfESRuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:50:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13419 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfESRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:50:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce0f7df0000>; Sat, 18 May 2019 23:29:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 18 May 2019 23:29:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 18 May 2019 23:29:49 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 May
 2019 06:29:49 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 May
 2019 06:29:48 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 May 2019 06:29:48 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce0f7dc0001>; Sat, 18 May 2019 23:29:48 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/1] lockdep: fix warning: print_lock_trace defined but not used
Date:   Sat, 18 May 2019 23:29:45 -0700
Message-ID: <20190519062946.27040-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558247391; bh=ksr1pGeZiBQIqfKuyg0qGKN6OFXkV0WvzgMDp21VSw0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=GMFr8l9zwrT1Y7ZChMy/1xlma42OCTcqMV0zIArGQ94iNhpTq4QG61u25BygWcbDv
         uChBkUYCNq1mBXjS59BQZx7W8xdo/MeV3G9HusQzPOlCZT9sp5/KloFHboAogeT3gL
         61wkbYj4O3bED7BV85IOBFJp2vZH2OMEcz/Jm73toFi+kHC6oNzL/luqM6tZGiTgsP
         oXMKcjXav6J+5pAKcxvnz8GXMLhAz358P/TXYlgLO4plW8A+o0DlpXh+riQ1bvegjP
         XU21z7WBj6NQbJuNTEU8GU/EZuBHq87bfMcnEeRQdWklKoEfXVULQV2TbPdD3ubCwh
         lBRATSr15QFrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran across this minor warning while building against today's linux.git.

The proposed trivial fix leaves it a little fragile from a "what if someone
adds a new call to print_lock_trace()" point of view, but I believe that it
makes the current combination of ifdefs accurate, anyway.

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>

John Hubbard (1):
  lockdep: fix warning: print_lock_trace defined but not used

 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

--=20
2.21.0

