Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B201EC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DE9217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565358369;
	bh=eLO/e/KA4TzDwacNEE2MlDgRix+GcyiN1TH0oGPTiMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZlckySuTD/1Uhvol3xUfco/8w9NllQ4J6I7Ivt3/J296cGqVQ+lpwnTVZ3MUOFpIv
	 e/qq6g083K9wv0K8WYpssexi+NkB35pq2Lr9KjVEuMw+azu8zfsF6FvwBZCZdrLcsC
	 68Ksyz5pOoOVLBLe75JXBLDDxyolfwAdTlRNyDh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406912AbfHINqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406518AbfHINqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:46:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DD8217D7;
        Fri,  9 Aug 2019 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565358366;
        bh=eLO/e/KA4TzDwacNEE2MlDgRix+GcyiN1TH0oGPTiMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZAup71aPhHloq96BLsiWIO3gr36c/hec21mq+uJNfAdm0yiOz0hTw6jfF/Ig7FEG
         fylFCbAdB56lfTcxrUL/ekm3zKGX/xSPbwKo95sPhqJtjDXBpJWUH9p0x7lUM7i7Po
         hJxvWbihicG6nlNKogM3IFHnuVm2C6n3Ed4qKfAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Turnbull <phil.turnbull@oracle.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 03/21] netfilter: nfnetlink_acct: validate NFACCT_QUOTA parameter
Date:   Fri,  9 Aug 2019 15:45:07 +0200
Message-Id: <20190809134241.707489370@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809134241.565496442@linuxfoundation.org>
References: <20190809134241.565496442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit eda3fc50daa93b08774a18d51883c5a5d8d85e15 ]

If a quota bit is set in NFACCT_FLAGS but the NFACCT_QUOTA parameter is
missing then a NULL pointer dereference is triggered. CAP_NET_ADMIN is
required to trigger the bug.

Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nfnetlink_acct.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -97,6 +97,8 @@ nfnl_acct_new(struct sock *nfnl, struct
 			return -EINVAL;
 		if (flags & NFACCT_F_OVERQUOTA)
 			return -EINVAL;
+		if ((flags & NFACCT_F_QUOTA) && !tb[NFACCT_QUOTA])
+			return -EINVAL;
 
 		size += sizeof(u64);
 	}


