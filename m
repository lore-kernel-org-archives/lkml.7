Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF7BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A05208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561126717;
	bh=utpNSfhfqDUGvBr9WSoyJ8v2U6SsAumLTAISUYtlQTY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tQyL5dZn54gTWysNWKX8E80F2pMTEIy8e1zJnqtMG/MsEu6mFDUHvnwv+LFx4PIu7
	 R/cktcTZ3ZuoAk8TeWrt0XKupla/32inIrrUxivq3ZvjqKt06sMGPUtlrfXODnO8nX
	 znhAqwZVVQuVUrKfEDwcfuVLYSDzvnJ7ieD7fjNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfFUOSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFUOSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:18:36 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0EBB20679;
        Fri, 21 Jun 2019 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561126715;
        bh=utpNSfhfqDUGvBr9WSoyJ8v2U6SsAumLTAISUYtlQTY=;
        h=From:To:Cc:Subject:Date:From;
        b=eRaYWm9YQG+vjmKWshHLBOcgeJpq63PTM/hsvBnkJzVYfsqhUV51SAFEgR+v+xBPj
         IiM5mHFJnjB/ZeuUpREW6v6K9uiwDFWK3VR2+E661IoaaJmZQK8rpYIJbEBXKmIdG7
         Bdz7S1xcCTEaaks8+NMyEWVgZ9aaeuLNZh1rA1OY=
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, zyan@redhat.com, sage@redhat.com,
        agruenba@redhat.com, joe@perches.com, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com
Subject: [PATCH v3 0/2] ceph: don't NULL terminate virtual xattr values
Date:   Fri, 21 Jun 2019 10:18:31 -0400
Message-Id: <20190621141833.17551-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: switch to using an intermediate buffer for snprintf destination
    add patch to fix ceph_vxattrcb_layout return value
v2: drop bogus EXPORT_SYMBOL of static function

This is the 3rd posting of this patchset. Instead of adding a new
snprintf variant that doesn't NULL terminate, this set instead has
the vxattr handlers use an intermediate buffer as the snprintf
destination and then memcpy's the result into the destination buffer.

Also, I added a patch to fix up the return of ceph_vxattrcb_layout. The
existing code actually worked, but relied on casting a signed negative
value to unsigned and back, which seemed a little sketchy.

Most of the rationale for this set is in the description of the first
patch of the series.

Jeff Layton (2):
  ceph: fix buffer length handling in virtual xattrs
  ceph: fix return of ceph_vxattrcb_layout

 fs/ceph/xattr.c | 113 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 32 deletions(-)

-- 
2.21.0

