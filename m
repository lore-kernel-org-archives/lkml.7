Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295A7C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EFE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520870;
	bh=GBpi+2jc9TM5PgxUcdAcZ9oSk3/lTAFmaEpX0O4ukaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HYwN4zn/GYetk7nLscxBZu5Xb3ZBRDlvsKQnZq25fpomszTmqIDxKFB1I1Fs2ebhR
	 zg3D5B57VT5e9Ea2EqKIz6RJ1AZtSIVX5PdXNkuzxYPhbWQX5LxAcmJOgAtR2HY+4S
	 rDkolBU4v5PwQ2z0XQ0ywbJUVIfIaQ+4V6xz3LrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfLPS1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731095AbfLPSPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:15:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983F6206E0;
        Mon, 16 Dec 2019 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520135;
        bh=GBpi+2jc9TM5PgxUcdAcZ9oSk3/lTAFmaEpX0O4ukaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JccahedrrOWP+wz+oOPkt3dmSA0ww0CT5mxly/9hMDoN2Ykg39sa+ctrc0Be5Kg7f
         xZGmQQxXUWjVjjkF338EbhvRTWx52TPOMkDVmGjE9aMQxxQKRS1c8z0Yli+uJQaLjP
         g5zn0RVYHEXK0NnQ2DQiuRrcOMDFPd2hV0McwblI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Brunberg <ingo_brunberg@web.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.4 003/177] nvme: Namepace identification descriptor list is optional
Date:   Mon, 16 Dec 2019 18:47:39 +0100
Message-Id: <20191216174811.740598147@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

commit 22802bf742c25b1e2473c70b3b99da98af65ef4d upstream.

Despite NVM Express specification 1.3 requires a controller claiming to
be 1.3 or higher implement Identify CNS 03h (Namespace Identification
Descriptor list), the driver doesn't really need this identification in
order to use a namespace. The code had already documented in comments
that we're not to consider an error to this command.

Return success if the controller provided any response to an
namespace identification descriptors command.

Fixes: 538af88ea7d9de24 ("nvme: make nvme_report_ns_ids propagate error back")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205679
Reported-by: Ingo Brunberg <ingo_brunberg@web.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org # 5.4+
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1727,6 +1727,8 @@ static int nvme_report_ns_ids(struct nvm
 		if (ret)
 			dev_warn(ctrl->device,
 				 "Identify Descriptors failed (%d)\n", ret);
+		if (ret > 0)
+			ret = 0;
 	}
 	return ret;
 }


