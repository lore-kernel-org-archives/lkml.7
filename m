Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9047C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844682192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257093;
	bh=hU4XCE0T+csDNrAbczKLaLSUp3Wc69ICmnRt8kJCUJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7ekkt+sbrrxDD4jWoCH62RUKveyjVnj7LNx2G370Z2HMdB/d9EAuz85BMCPsOyde
	 Ergq/i1wMFwcleoSl1ooYoqOOgIt+Ob4/EqdzWPEPXFDt1eBgAD/Pz5Xc5Tqz1sBVG
	 vyP5N2SgWaWlss9b7ilaW+Zwk5wV48pPilVTX3oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390450AbfCVMSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390440AbfCVMSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E942083D;
        Fri, 22 Mar 2019 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257079;
        bh=hU4XCE0T+csDNrAbczKLaLSUp3Wc69ICmnRt8kJCUJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxR84wP9HlA9QvXiny8l2EwxDpoAHz3Cw/IKyOKv5H6zasq8XMZUNK6w2xWdoxvU3
         cDaAooeu5zJhcDOJW/wPw/Q8Levv/RBXUFpTTlaOCcwyijqUTUhPJuy3FmAJyTaTtP
         K/1Dp7PSIDHneBHH22Lki8e+6SO2myhooJniRn6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 094/238] btrfs: drop the lock on error in btrfs_dev_replace_cancel
Date:   Fri, 22 Mar 2019 12:15:13 +0100
Message-Id: <20190322111304.121747725@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 669e859b5ea7c6f4fce0149d3907c64e550c294b upstream.

We should drop the lock on this error path.  This has been found by a
static tool.

The lock needs to be released, it's there to protect access to the
dev_replace members and is not supposed to be left locked. The value of
state that's being switched would need to be artifically changed to an
invalid value so the default: branch is taken.

Fixes: d189dd70e255 ("btrfs: fix use-after-free due to race between replace start and cancel")
CC: stable@vger.kernel.org # 5.0+
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/dev-replace.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -862,6 +862,7 @@ int btrfs_dev_replace_cancel(struct btrf
 			btrfs_destroy_dev_replace_tgtdev(tgt_device);
 		break;
 	default:
+		up_write(&dev_replace->rwsem);
 		result = -EINVAL;
 	}
 


