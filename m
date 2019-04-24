Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08898C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD052064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127571;
	bh=bo2aulTAxicZiE39XAzO3FAOvczOP38m53ofMhCvz2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AknWhO7Hv4lVBm01poqJ4T8ihsZCvh82BaeEDrN/9jTaFG1WcjwF6yP8H6yGquWmm
	 LeHdYDODx4zpsTbyYbhz5ZERayL22kSNCMzuDVBRkfwqLRB4e0dcbNLvmIV3uG3x6y
	 kApZvvnDipjTVupPc+veKcHWoKXV2DnK+QmgY88c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392314AbfDXRiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392301AbfDXRh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:57 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4018620675;
        Wed, 24 Apr 2019 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127476;
        bh=bo2aulTAxicZiE39XAzO3FAOvczOP38m53ofMhCvz2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5mXhrhj9OUkR02S/t8bLMuIye+uuZ3XWtS6Lw5fP2sNknZEaCED5o860dHTiRlgK
         SkVYJBehoNBiAD8qACdx2ULRb6YhMHs/DWctPDyi9UY4A/mi39j6Qw2YGMyLzTxqq2
         waIhgHo+jele0BfmMVLHwQAoDnJBeakqghvUAUoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 105/115] tpm: Fix the type of the return value in calc_tpm2_event_size()
Date:   Wed, 24 Apr 2019 19:10:41 +0200
Message-Id: <20190424170930.845688134@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b9d0a85d6b2e76630cfd4c475ee3af4109bfd87a upstream

calc_tpm2_event_size() has an invalid signature because
it returns a 'size_t' where as its signature says that
it returns 'int'.

Cc: <stable@vger.kernel.org>
Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/eventlog/tpm2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 1b8fa9de2cac..41b9f6c92da7 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -37,8 +37,8 @@
  *
  * Returns size of the event. If it is an invalid event, returns 0.
  */
-static int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
-				struct tcg_pcr_event *event_header)
+static size_t calc_tpm2_event_size(struct tcg_pcr_event2 *event,
+				   struct tcg_pcr_event *event_header)
 {
 	struct tcg_efi_specid_event *efispecid;
 	struct tcg_event_field *event_field;
-- 
2.19.1



