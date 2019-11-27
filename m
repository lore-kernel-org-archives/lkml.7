Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEEEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A966921903
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887985;
	bh=vl4WYn3Y1mvDXZ3LcSvCXAm7WocIWQiBt4NUiXNqQYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2Rn2Ja0lMRHJlIjc/7SuHk/UKOaNKchc/ln6WDVpZwnDTgmwH6jDt36mv2oYMI9Y
	 KKyx5r+HvFrdaoqsViS5pq7LAAiglKTApVXsZmZsLuMOWAhZD+WcRSoq9dgM73z2Ue
	 16o45OZqYsBTHCrctgLbd0GAOivgsCPUq0RgKgSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfK0UxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:53:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbfK0UxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:53:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1651221903;
        Wed, 27 Nov 2019 20:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887980;
        bh=vl4WYn3Y1mvDXZ3LcSvCXAm7WocIWQiBt4NUiXNqQYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvyU09aO335xOKFqssVftO0TCbvcPbUw2Adh8stuKEwxvWOiwiL0xZEFxVa2nqX+h
         +Q/9Bw7R0NLAOb0rfKVj3gd+bZCykDEj7ckSLPDJfBuio0nmBFDySXqU1klaL7y9Ot
         plEMBxpPHWLU0UD+9Z4latAFXxa3yH9PrbJcJBMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Pittman <jpittman@redhat.com>,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.14 168/211] md/raid10: prevent access of uninitialized resync_pages offset
Date:   Wed, 27 Nov 2019 21:31:41 +0100
Message-Id: <20191127203109.745603101@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Pittman <jpittman@redhat.com>

commit 45422b704db392a6d79d07ee3e3670b11048bd53 upstream.

Due to unneeded multiplication in the out_free_pages portion of
r10buf_pool_alloc(), when using a 3-copy raid10 layout, it is
possible to access a resync_pages offset that has not been
initialized.  This access translates into a crash of the system
within resync_free_pages() while passing a bad pointer to
put_page().  Remove the multiplication, preventing access to the
uninitialized area.

Fixes: f0250618361db ("md: raid10: don't use bio's vec table to manage resync pages")
Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: John Pittman <jpittman@redhat.com>
Suggested-by: David Jeffery <djeffery@redhat.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -226,7 +226,7 @@ static void * r10buf_pool_alloc(gfp_t gf
 
 out_free_pages:
 	while (--j >= 0)
-		resync_free_pages(&rps[j * 2]);
+		resync_free_pages(&rps[j]);
 
 	j = 0;
 out_free_bio:


