Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E9C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4642146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmY6BiMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfHRTj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 15:39:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42627 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRTj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:39:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so5832809pfk.9;
        Sun, 18 Aug 2019 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJjwWl4XQTgcmRcDEc+l30pX8XFo75tSFumPFai+auM=;
        b=UmY6BiMKjLfJtTbMPr2YL48+gSi6VOnzYOGmB49byG2y+gNWR+LHccMEOjU3uV6rzU
         vs47bj1Wda0bHM3M+0tVfVnkUn5JeYWMuWoPyJiWhssB5oqJi3lvuowfQ5qRiqzyKByF
         037PGyd0fWngnsSpBjBk4owPIqAYkSIl8DR9T1VCkYVvWLNNd/4SLogCYlENV5fXi/GI
         qnVGwINwsEAhgY5m/Vu9VC+dsD3inyTVFkMorxi2MckhRHGG3v9Saij0nBgVh07rb5wE
         OqTFjDg2ifQD/yQ8Uj40xNeOboRbiBcdRommtkDta5yDTw5vCbifx/WTDfU1ckZxVYSw
         PlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJjwWl4XQTgcmRcDEc+l30pX8XFo75tSFumPFai+auM=;
        b=iGL9NwcGvYKpir+yGE1w4233WgrHiRVSMi9TiLM7a+1xOZijbGZL43r++M9tayzvwr
         J1GYlhxibZkjOimWjPg5LvgGDoveRBr4tz5x7rCRpyQPl0sj2z9qxANpdRjLHm4MGl0V
         VG7ow3fc3ivtGsyDFVuFHwkESp4jbEboyFmVgDcUC3hLuGRHscsfbwc122xzmZ0YbnoR
         RNhotDco8Pcue1VHxry3V7IoYioXfxj0AI71vzVjOpQnPNqB8X6sHxg3dgZCsP3H1JNE
         G7PdbMtwBif2lPpvuRQ7W/tZGI1RFfqjcSzMxPWXARtrUPR+8FKujwbQjTbb8UgWCPhu
         PsBA==
X-Gm-Message-State: APjAAAUSij76NlyRhQ0F3CZ97Pa6fk5fVPE39X9kpmED20HYXS5A8pgF
        +LMF99bPtbxBAR7m5soSshPTPD1i
X-Google-Smtp-Source: APXvYqx7tVVfV+B2SMb5KcGTV0Iw93mnZu+rvdEXioARTktPChwDBCq20S1nC96AwKkuvChntzXpWw==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr16328693pgb.82.1566157166340;
        Sun, 18 Aug 2019 12:39:26 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.36])
        by smtp.gmail.com with ESMTPSA id k5sm11318890pgo.45.2019.08.18.12.39.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 12:39:25 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, jhubbard@nvidia.com
Cc:     jglisse@redhat.com, ira.weiny@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        william.kucharski@oracle.com, hch@lst.de,
        inux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bharath Vedartham <linux.bhar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees][PATCH v6 1/2] sgi-gru: Convert put_page() to put_user_page*()
Date:   Mon, 19 Aug 2019 01:08:54 +0530
Message-Id: <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/misc/sgi-gru/grufault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 4b713a8..61b3447 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
 		return -EFAULT;
 	*paddr = page_to_phys(page);
-	put_page(page);
+	put_user_page(page);
 	return 0;
 }
 
-- 
2.7.4

