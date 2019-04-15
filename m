Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97E8C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B793E218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354036;
	bh=xK4ZSRB7x1GWbG2XSi+acgbExSZTCnkbXS5Jvnb37ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JrK/Pk2ESG4vmIWQpoOYu+Rye7wH/tmh8d4VMr7w5DAwHC4S+gtKBd5vQ8Unc5rzZ
	 pcR8qhYH9mJwTTAOFE6XW7XHSEfNRhF8caUyLLnG6fHhZKlEZjJV/Yu++E0fLp829H
	 N8PxS6PY0bzoYpy0Aqzs56ZJKtd8eyQo1lBRR9e8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfDOSrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfDOSrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767F621916;
        Mon, 15 Apr 2019 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354030;
        bh=xK4ZSRB7x1GWbG2XSi+acgbExSZTCnkbXS5Jvnb37ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EA7WEckJZ1yUwuNrsATUSocTETTXulFVIHNGfRaK6Db9S+Ld+kHYr6NjJ+dDyWNM/
         GzWlZP7MTPehV6pj/TCH3fJF0GpAxpvxo0RHaeOK/uEm0ZSrpgrgmNHpt56MMx0w+E
         rZ7YBiPrBmDE7dp83qZtZ+6MuXT4LhUEshJHRtuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 46/76] tty: mark Siemens R3964 line discipline as BROKEN
Date:   Mon, 15 Apr 2019 20:44:10 +0200
Message-Id: <20190415183720.395096789@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

---
 drivers/char/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -377,7 +377,7 @@ config XILINX_HWICAP
 
 config R3964
 	tristate "Siemens R3964 line discipline"
-	depends on TTY
+	depends on TTY && BROKEN
 	---help---
 	  This driver allows synchronous communication with devices using the
 	  Siemens R3964 packet protocol. Unless you are dealing with special


