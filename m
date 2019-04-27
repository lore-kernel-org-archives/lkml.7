Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7549DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF48206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfD0P2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:28:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33018 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727315AbfD0PPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:20 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2s-00014G-2B; Sat, 27 Apr 2019 16:15:18 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2o-0004fS-DD; Sat, 27 Apr 2019 16:15:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jann Horn" <jannh@google.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.89499849@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 202/202] tty: mark Siemens R3964 line discipline as
 BROKEN
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit c7084edc3f6d67750f50d4183134c4fb5712a5c8 upstream.

The n_r3964 line discipline driver was written in a different time, when
SMP machines were rare, and users were trusted to do the right thing.
Since then, the world has moved on but not this code, it has stayed
rooted in the past with its lovely hand-crafted list structures and
loads of "interesting" race conditions all over the place.

After attempting to clean up most of the issues, I just gave up and am
now marking the driver as BROKEN so that hopefully someone who has this
hardware will show up out of the woodwork (I know you are out there!)
and will help with debugging a raft of changes that I had laying around
for the code, but was too afraid to commit as odds are they would break
things.

Many thanks to Jann and Linus for pointing out the initial problems in
this codebase, as well as many reviews of my attempts to fix the issues.
It was a case of whack-a-mole, and as you can see, the mole won.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/char/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -380,7 +380,7 @@ config XILINX_HWICAP
 
 config R3964
 	tristate "Siemens R3964 line discipline"
-	depends on TTY
+	depends on TTY && BROKEN
 	---help---
 	  This driver allows synchronous communication with devices using the
 	  Siemens R3964 packet protocol. Unless you are dealing with special

