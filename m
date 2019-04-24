Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D0AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19BC21905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127177;
	bh=bo2aulTAxicZiE39XAzO3FAOvczOP38m53ofMhCvz2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZ+kJNn6lPFFXTKc97ZxRUBJTgv+2O5aUmV2+Xoh1wkU1i9xIdAAkm70Zbfyge/3O
	 fnPw57TcvrvTBIYz4o/UzHxGTPrAmrYWZ9meJQgIAgTmfoD1ExiebUmZ0/T9VDKDJo
	 WvTSbmQcwW8XIb631GYYcQj9e2/0r0rqXJ2xU/dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391197AbfDXRc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391173AbfDXRcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B1921939;
        Wed, 24 Apr 2019 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127171;
        bh=bo2aulTAxicZiE39XAzO3FAOvczOP38m53ofMhCvz2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulJ7vWhAt3CyVrwVVKFOiJYCdXJnTJ+5efCy4eyxFgeKGUp0vosvP02peIa79O8pI
         i09pbhk1eXd8uY9f9meM2jA2eAR065jEshGU0Al7Qh9aNSakOiM2satPGUTp2VeMOE
         oCSDruTmpI7VsNrfMtmiwBLV/9+z1zZ+PMJKoPIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 87/96] tpm: Fix the type of the return value in calc_tpm2_event_size()
Date:   Wed, 24 Apr 2019 19:10:32 +0200
Message-Id: <20190424170925.704176363@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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



