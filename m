Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602E020657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254012;
	bh=IHjFbVGS/uo9iMqCymCWQY/UG08xlc+YdXwK2kHPVPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hZ+FrtOgllCi7z1fq+SHLdPTh3gejAQYrSEYW0XpeX+jhND2Ns5Zz7I6g06GrkNO6
	 oHOooxaceUc+1XrQNPWsBXj2INTv571XuMqrOhV0JYrFNULFJozsU/DORcw72yKM7r
	 BTXKsE0H94dp56s2DrGxit9VGBx7nwJTi4krEP4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfCVL0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbfCVL0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:26:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C6B320657;
        Fri, 22 Mar 2019 11:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254008;
        bh=IHjFbVGS/uo9iMqCymCWQY/UG08xlc+YdXwK2kHPVPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqy3m02+ijR3oRN5R8VnBW+2L9W2p9G2EtHPwiktN148sPX3TYn06llptPbl6tppF
         dY769T4UzbLNOY7vGRV3cTpKr8BEyF291Cx/PSf12Zi371nTmeBVO4ngtrFUxxixWn
         U00djEJ9DuKeC1w4dyIGGttcI9VwMfvmTc9ubsMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yihao Wu <wuyihao@linux.alibaba.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3.18 130/134] nfsd: fix wrong check in write_v4_end_grace()
Date:   Fri, 22 Mar 2019 12:15:43 +0100
Message-Id: <20190322111219.939225536@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yihao Wu <wuyihao@linux.alibaba.com>

commit dd838821f0a29781b185cd8fb8e48d5c177bd838 upstream.

Commit 62a063b8e7d1 "nfsd4: fix crash on writing v4_end_grace before
nfsd startup" is trying to fix a NULL dereference issue, but it
mistakenly checks if the nfsd server is started. So fix it.

Fixes: 62a063b8e7d1 "nfsd4: fix crash on writing v4_end_grace before nfsd startup"
Cc: stable@vger.kernel.org
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfsctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1110,7 +1110,7 @@ static ssize_t write_v4_end_grace(struct
 		case 'Y':
 		case 'y':
 		case '1':
-			if (nn->nfsd_serv)
+			if (!nn->nfsd_serv)
 				return -EBUSY;
 			nfsd4_end_grace(nn);
 			break;


