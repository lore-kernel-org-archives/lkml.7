Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E9DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43DC2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560519990;
	bh=Pk73/xkfvswS3oDbkwy/KBqHTKF7UicnSaCndmc/Fec=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WaPGSW3nsJc2p2ILC/RAYBu1sgXyVR5lJ7JIgnosN+1Rg9o2ts4W8oHwgf/2Y1Kox
	 gYroQ/PiaWhwP/skazB5YzXmLG3w0a9ViyHxHe2963wL8IH27X1cut9N2J2H0fpj+z
	 rTzyp8gFkTLENiFwsjYYXx7DLcgJJMhRSuzwZCYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfFNNq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbfFNNq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:46:27 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750E32168B;
        Fri, 14 Jun 2019 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560519987;
        bh=Pk73/xkfvswS3oDbkwy/KBqHTKF7UicnSaCndmc/Fec=;
        h=From:To:Cc:Subject:Date:From;
        b=l2H8kA6nwkejbUj+mU7hs6Dczy+qaqNHwHugz/3YKhwgdT/6JhNh/7cZbLuTLd5HY
         XD06qWG0sMdQEo0UH4fVvDY5Sd/Lm74XGIzOFrJua3OY7t010vwpAyS+axTDhMWnrm
         6rLTT7kIMrdh5FkjounPmS4VcLHxfsArvArssdDg=
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc:     akpm@linux-foundation.org, idryomov@gmail.com, zyan@redhat.com,
        sage@redhat.com, agruenba@redhat.com
Subject: [PATCH 0/3] ceph: don't NULL terminate virtual xattr values
Date:   Fri, 14 Jun 2019 09:46:22 -0400
Message-Id: <20190614134625.6870-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kcephfs has several "virtual" xattrs that return strings that are
currently populated using snprintf(), which always NULL terminates the
string.

This leads to the string being truncated when we use a buffer length
acquired by calling getxattr with a 0 size first. The last character
of the string ends up being clobbered by the termination.

The convention with xattrs is to not store the termination with string
data, given that we have the length. This is how setfattr/getfattr
operate.

This patch makes ceph's virtual xattrs not include NULL termination
when formatting their values. In order to handle this, a new
snprintf_noterm function is added, and ceph is changed over to use
this to populate the xattr value buffer. Finally, we fix ceph to
return -ERANGE properly when the string didn't fit in the buffer.

Jeff Layton (3):
  lib/vsprintf: add snprintf_noterm
  ceph: don't NULL terminate virtual xattr strings
  ceph: return -ERANGE if virtual xattr value didn't fit in buffer

 fs/ceph/xattr.c        |  49 +++++++-------
 include/linux/kernel.h |   2 +
 lib/vsprintf.c         | 145 ++++++++++++++++++++++++++++-------------
 3 files changed, 130 insertions(+), 66 deletions(-)

-- 
2.21.0

