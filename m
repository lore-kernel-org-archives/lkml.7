Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC61C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C41620850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbVP/rNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCTQgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:36:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47045 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfCTQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:36:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so2531467edd.13;
        Wed, 20 Mar 2019 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJc1gpqbWVDmlmldQXsqqQpuToOQEsGY40p5KsQj9kw=;
        b=bbVP/rNakw/hrsudK3L/KMmW5OrgCZAh1GM35/uQY4lD8NZn/WGg7MfVAQTR6nsq9Y
         WmmZYKtH/hhS9i5TUSRBLUMUl6cscFYqF143Tx2pWlsNz3SxP4pEebZjYUMVkcH+hEp9
         NL7Mg0rzvkBc9FJIA6WH+qQQXUgqITxl4MRcLJE5UJ0PFV7Kh9Rz9pXYYSk1YEj68UES
         x1Z6InV2f5RZlz951l1EwkZKQYTpM3P6S2yl+lMEc7RgRT5LVr5U9cYSF2JyrjG7icV7
         O6W5K7fW/ENe8aGjBp6O7iOlmCw94tDmXvlDcIzNFnMd71rc0uRg3FmYd7sQg2Thlwyk
         V/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJc1gpqbWVDmlmldQXsqqQpuToOQEsGY40p5KsQj9kw=;
        b=ilZmEa5/GfKDRoVPuPJAbjz4AHowX9MDHUv4mi6VxHX3s/zFh3N3YarmmYvnGM36uZ
         8c6MuT5PH2nSZg2cW7hMfTHI+kLiZGM1XJCq5AovNJn7/RW7w27uRH/F3l1r3k2+48M0
         Ht3EB/cdRCeYqCeShch7+cFRNi9+cK+bAe+VNAsknCr0rs9RhpfN7W8asYcIZ97e2jLG
         QKzifWT4OS/LZdEFu9ihjhvbLt81LExS5RFFRxZ9QvXsGltA5QU2CeNmXmN8n77LO2rx
         4aE9btxS72kHrtz0CjRzyaF1C6hQB8VpRqTpfhfy1UYTF4Sw8xYkpaWcnHC7tP0SfhGp
         e8og==
X-Gm-Message-State: APjAAAXm/WcSVX5P4uWXyqWihpCxcncVBJQnPIwzQcCVrNLvt8nlZylB
        M1SBGiN6oVh6co5VMkQPfcs=
X-Google-Smtp-Source: APXvYqw4c70EOPAJn0fj75Pcoj0lLoL7TeqjdMThXbqkYjVTxsppYG+RXLK29CtKqwDWkbqsbyr/6A==
X-Received: by 2002:a50:b13b:: with SMTP id k56mr10811481edd.89.1553099799271;
        Wed, 20 Mar 2019 09:36:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s2sm498103eja.70.2019.03.20.09.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:36:38 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: qla2xxx: Simplify conditional check
Date:   Wed, 20 Mar 2019 09:33:16 -0700
Message-Id: <20190320163315.12740-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang generates a warning when it sees a logical not followed by a
conditional operator like ==, >, or < because it thinks that the logical
not should be applied to the whole statement:

drivers/scsi/qla2xxx/qla_nx.c:3702:7: warning: logical not is only
applied to the left hand side of this comparison
[-Wlogical-not-parentheses]
                if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
                    ^
drivers/scsi/qla2xxx/qla_nx.c:3702:7: note: add parentheses after the
'!' to evaluate the comparison first
                if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
                    ^
                     (
drivers/scsi/qla2xxx/qla_nx.c:3702:7: note: add parentheses around left
hand side expression to silence this warning
                if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
                    ^
                    (
1 warning generated.

It assumes the author might have made a mistake in their logic:

if (!a == b) -> if (!(a == b))

Sometimes that is the case; other times, it's just a super convoluted
way of saying 'if (a)' when b = 0:

if (!1 == 0) -> if (0 == 0) -> if (true)

Alternatively:

if (!1 == 0) -> if (!!1) -> if (1)

Simplify this comparison so that Clang doesn't complain.

Link: https://github.com/ClangBuiltLinux/linux/issues/80
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

This is commit 0bfe7d3cae58 ("scsi: qla2xxx: Simplify conditional check")
upstream but commit 3695310e37b4 ("scsi: qla2xxx: Update flash
read/write routine") in the 5.2/scsi-queue branch silently reverted it.
I don't care if it is squashed or not, I just want the warning to stay
fixed.

Thanks,
Nathan

 drivers/scsi/qla2xxx/qla_nx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index de2bc78449e7..121e18b3b9f8 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -3699,8 +3699,8 @@ qla82xx_chip_reset_cleanup(scsi_qla_host_t *vha)
 		spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 		/* Wait for pending cmds (physical and virtual) to complete */
-		if (!qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
-		    WAIT_HOST) == QLA_SUCCESS) {
+		if (qla2x00_eh_wait_for_pending_commands(vha, 0, 0,
+		    WAIT_HOST)) {
 			ql_dbg(ql_dbg_init, vha, 0x00b3,
 			    "Done wait for "
 			    "pending commands.\n");
-- 
2.21.0

