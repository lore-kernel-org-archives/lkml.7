Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E439C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE48A217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560962734;
	bh=kB3nUsz1fYNAiGj3UopgtiHKdqW2THI1cJKHLbgiGlM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=w8VE0ahCsoHcPZ9Ezu5M/cJl1+AmKMcWj1Ct6VsIgoMCEdCSXYZU3o60cgl0rQWWo
	 DsrkU3Rhpkkt/ZJ+e627jRu34PmiReOlm36u4DtC5FDoSfZyqadujqqDkiC7/vyWqU
	 46JcJokJWmJ1+IKcCVEOdegF5+Vya5ZkbaM6t+Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfFSQpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfFSQpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:45:32 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E99821537;
        Wed, 19 Jun 2019 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560962731;
        bh=kB3nUsz1fYNAiGj3UopgtiHKdqW2THI1cJKHLbgiGlM=;
        h=From:To:Cc:Subject:Date:From;
        b=Mmc/sVqNuRSnLHTiWp3VZctACHFcYtvcCuLLs4lHcT1O1/qRGA5QUClsLSP+309eV
         alR2SgfyP+IwKzf3jYyHL5vdnFVJim1k8k6E8ORqoA4O+GUA/QkqEIivZBodjKzEFd
         o4fTNxXbp+ZQIiXfN8SyfesoyamnAth7LRmeAsdA=
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, zyan@redhat.com, sage@redhat.com,
        agruenba@redhat.com, joe@perches.com, pmladek@suse.com,
        rostedt@goodmis.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com
Subject: [PATCH v2 0/3] ceph: don't NULL terminate virtual xattr values
Date:   Wed, 19 Jun 2019 12:45:25 -0400
Message-Id: <20190619164528.31958-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: drop bogus EXPORT_SYMBOL of static function

The only real difference between this set and the one I sent originally
is the removal of a spurious EXPORT_SYMBOL in the snprintf patch.

I'm mostly sending this with a wider cc list in an effort to get a
review from the maintainers of the printf code. Basically ceph needs a
snprintf variant that does not NULL terminate in order to handle its
virtual xattrs.

Joe Perches had expressed some concerns about stack usage in vsnprintf
with this, but I'm not sure I really understand the basis of that
concern. If it is problematic, then I could use suggestions as to how
best to fix that up.

----------------------------8<-----------------------------

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
 lib/vsprintf.c         | 144 ++++++++++++++++++++++++++++-------------
 3 files changed, 129 insertions(+), 66 deletions(-)

-- 
2.21.0

