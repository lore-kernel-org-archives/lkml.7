Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7B921773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411677;
	bh=taqv78Bjch7H13m0evgRBtxRHT+7jbq2JnLj37tX/p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U5A5pkReB3JKTRa4ac6vomcSqqLvsNf3Q10uzSIRannhHaM4P4JjMz3AVzLAysIBy
	 +eetWZmu4w2SdNsmpn+YH0d/UBLXxqlMNfxsLBf2tprdQr2JhkokC1XNbspB+A0pmf
	 oIKUhXjFOClsp/nVP8JAZzcR4fdzOsnCc8d8M27U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfCLRRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbfCLRQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:37 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6249D217F5;
        Tue, 12 Mar 2019 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410996;
        bh=taqv78Bjch7H13m0evgRBtxRHT+7jbq2JnLj37tX/p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCNcBqmYiGLg+zac+Jw6vjkVFCuXjPtTfJcKaHbUxV/TvXOi4DcT3gFeprC4qVcGD
         jNgEuzRBgvBq9IDXHJxIM88i7rahtWjNYO0cDPJn8JGVX1vF0HzP/pky+A7PZuVES5
         EILTC+HrSLjfYPj6Zps7xVkSzt1Kmt0wgQFy+nNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 078/135] apparmor: Fix aa_label_build() error handling for failed merges
Date:   Tue, 12 Mar 2019 10:08:45 -0700
Message-Id: <20190312170348.370879561@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d6d478aee003e19ef90321176552a8ad2929a47f ]

aa_label_merge() can return NULL for memory allocations failures
make sure to handle and set the correct error in this case.

Reported-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/domain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index dd754b7850a8..67bf8b7ee8a2 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1260,7 +1260,10 @@ int aa_change_profile(const char *fqname, int flags)
 					aa_get_label(&profile->label));
 		if (IS_ERR_OR_NULL(new)) {
 			info = "failed to build target label";
-			error = PTR_ERR(new);
+			if (!new)
+				error = -ENOMEM;
+			else
+				error = PTR_ERR(new);
 			new = NULL;
 			perms.allow = 0;
 			goto audit;
-- 
2.19.1



