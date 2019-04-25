Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F9EC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2338212F5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="ANu5KapW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfDYNcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:32:10 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25527 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDYNcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:32:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556199109; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=FHNT+PW3isxtkSc3QTfqnJv2GLM10ZzQDMrc8YUwgnShXd0cZB7IbC05qTC4N1Wje0eV6CmsqE3a1vSK04zVijTbAoxJ8YcSP4MB+VFh4jz66K88cqODAxf9LVqDZZpzLXUKtpeT3mIqcRjbRdkSd8N8CVDQK8qjIG7RtINqTGk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1556199109; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=Tm4MFOZ+beMe8coc6MHTjfEHDn7ofBjG8iFAxVj0NL0=; 
        b=Z/q7XPSVJxR6jiRMnXFmqCfIY2Wv37g056+7HH1i4BB0KrLxqtK7jhTgDKdxRWwenDFhGQolngT+BF+2oeIMQIwqnzUSvZb9eH98h1gbM/rDwI9+BmU8kg0MtHYfjA9yV+rfMYRpaklbY1kE6CwW7agyFPejkeTMhubcQaSct6k=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=OqBr1qmHiD9MoWyVNOUWJ8c4z6cKXWkLfS51QV+z2lFCfBE59XMtzdzKYaCtLQU4IKY7SuC72Y0m
    +l63sG6IO3b2JSArZoc8j+2cGISbB8qJYM9Q23uFeV4E17mwimSa  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1556199109;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=722;
        bh=Tm4MFOZ+beMe8coc6MHTjfEHDn7ofBjG8iFAxVj0NL0=;
        b=ANu5KapWiNNBOx/WcEVSla8abajNuFWq5Uk0CPzMa3aLZq3eVxYtNYm+dDMxcyYY
        fM4GnuWL+LYvsBOUfkfe/Cugvi4zvO/1/DckpsIQSpVVYHfnB8lc67Ket3TbmlbeGVj
        w26VtWy1/k/Fz0JAh+EnhN1H7ZCsBh1ZC+tPfymk=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.108.196 [123.120.108.196]) by mx.zohomail.com
        with SMTPS id 1556199106011184.3682483421203; Thu, 25 Apr 2019 06:31:46 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 0/4] Misc dm writecache patches
Date:   Thu, 25 Apr 2019 21:31:16 +0800
Message-Id: <20190425133120.13088-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

This patch set is a collection about some patches for dm-writecache.

Patches 0001-0003 have got Acked-by or Signed-off-by from the author and
dm maintainer.

Patches 0004 is still under review. Any comments and suggestion are welcome.

Huaisheng Ye (4):
  dm writecache: remove needless dereferences in
    __writecache_writeback_pmem()
  dm writecache: add unlikely for returned value of rb_next/prev
  dm writecache: remove unused member page_offset in writeback_struct
  dm writecache: avoid unnecessary lookups in writecache_find_entry

 drivers/md/dm-writecache.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
1.8.3.1


