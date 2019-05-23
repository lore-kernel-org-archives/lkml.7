Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0077C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FAF217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639632;
	bh=3ZhTXSwncieJow4pLP8cZK9G6BTxT9zbZnxIHYnH+bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xeW9In7HIjJc9w5XkaM7ycSRo3SPvjmB55E6+Nm7XImgiAzsoOkEBVpAYrFuImIwK
	 59QrlHgqtged29zgAisEVAQgFv0kVtNYr8Br7hJw9kF6kILHAO0AYZymdZuCCLW8Gt
	 NO8HC4FeeNAaQUxW+OhdU3yd355E9gi+UO2ep/34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbfEWT1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391536AbfEWT1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:27:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E8D206BA;
        Thu, 23 May 2019 19:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639629;
        bh=3ZhTXSwncieJow4pLP8cZK9G6BTxT9zbZnxIHYnH+bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2d7gNeQvZQmkUvONDfpeTf8p5gT3CeTIBs671zveMuZe14ivizAEQvliwzCrUvP76
         YMAsb1TGjBQ5MwcSC5Maj4F5vXFqKtzffjddYq3FPz6IXsxoQTGYXA/hH4y52j7YD0
         hFIsb7ti4jXAHDNp98j6ZcTJcLRRN9sEFeB4dOOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "chengjian (D)" <cj.chengjian@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <james.morris@microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH 5.1 036/122] proc: prevent changes to overridden credentials
Date:   Thu, 23 May 2019 21:05:58 +0200
Message-Id: <20190523181709.625861225@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

commit 35a196bef449b5824033865b963ed9a43fb8c730 upstream.

Prevent userspace from changing the the /proc/PID/attr values if the
task's credentials are currently overriden.  This not only makes sense
conceptually, it also prevents some really bizarre error cases caused
when trying to commit credentials to a task with overridden
credentials.

Cc: <stable@vger.kernel.org>
Reported-by: "chengjian (D)" <cj.chengjian@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Acked-by: James Morris <james.morris@microsoft.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/base.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2540,6 +2540,11 @@ static ssize_t proc_pid_attr_write(struc
 		rcu_read_unlock();
 		return -EACCES;
 	}
+	/* Prevent changes to overridden credentials. */
+	if (current_cred() != current_real_cred()) {
+		rcu_read_unlock();
+		return -EBUSY;
+	}
 	rcu_read_unlock();
 
 	if (count > PAGE_SIZE)


