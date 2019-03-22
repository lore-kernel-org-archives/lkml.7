Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DACFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E12220830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256550;
	bh=WPBZUShpv/Qt1MsO26CfW2oZYcPGp1E4/CYdrzzSZrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cn/GH0QP540BgMkIqys5zk8GmyI/84i5j7odrAUnDdWo+G0+acXqW34EThvfyH57l
	 5+F1HeDkBgai4On5B4eeSqIoLpdG9hBAVh0FM28OQKRUdRxgn1vdQfop6rsBy6zAp9
	 MCko9bkBY7ACi8wkV1Be/ctmMifyPKeOy2JnvrrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbfCVMJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389252AbfCVMJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F369A20685;
        Fri, 22 Mar 2019 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256545;
        bh=WPBZUShpv/Qt1MsO26CfW2oZYcPGp1E4/CYdrzzSZrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZ4gNirsPoU2E/JwlEC5V8WpIAr7G6hpxqGVNHXfw6Ohji2Nz/tU4Z/p3tlpEBeBe
         Iykl4NA7tToaCSLjSEiPPaCSJn4n23kPsIn4lLs+h5yjo9QlXXFmAxN+FilM/wuCAk
         6gTJ01uFoNa0Q2l0kkP8iNfxpYsb/YulE/NeAxmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        Mike Snitzer <snitzer@redhat.com>,
        =?UTF-8?q?Guillaume=20Perr=C3=A9al?= <gperreal@free.fr>
Subject: [PATCH 4.19 236/280] dm: fix to_sector() for 32bit
Date:   Fri, 22 Mar 2019 12:16:29 +0100
Message-Id: <20190322111338.301754730@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit 0bdb50c531f7377a9da80d3ce2d61f389c84cb30 upstream.

A dm-raid array with devices larger than 4GB won't assemble on
a 32 bit host since _check_data_dev_sectors() was added in 4.16.
This is because to_sector() treats its argument as an "unsigned long"
which is 32bits (4GB) on a 32bit host.  Using "unsigned long long"
is more correct.

Kernels as early as 4.2 can have other problems due to to_sector()
being used on the size of a device.

Fixes: 0cf4503174c1 ("dm raid: add support for the MD RAID0 personality")
cc: stable@vger.kernel.org (v4.2+)
Reported-and-tested-by: Guillaume Perréal <gperreal@free.fr>
Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/device-mapper.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -601,7 +601,7 @@ do {									\
  */
 #define dm_target_offset(ti, sector) ((sector) - (ti)->begin)
 
-static inline sector_t to_sector(unsigned long n)
+static inline sector_t to_sector(unsigned long long n)
 {
 	return (n >> SECTOR_SHIFT);
 }


