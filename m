Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2742184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="C9Fx4+03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfCTRCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:02:55 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:41964 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCTRCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:02:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id DEF7DB40
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 17:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dK6YBLQCeFtx for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 12:02:53 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id B5337BE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:02:53 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id z6so2610231ioh.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/5fgvFNuiwFQaXpG8wTqV/SjFj07kFd/Tf8QJk9MXPg=;
        b=C9Fx4+03vXwwL4X8VdqknAqQKoOD4aUjJgZto9K17FQJfmcav0LLCMrM6hOfULllwk
         mnOmEdsrQV9ReObNVVmgu3QtqNiCmhk/Z8Lox/RB5mrPaYBwEeCBR6FzndLXiykCCB4k
         s0bin/mzPDYW0i8SnYFX1OWgE/ZpPBpSeQPImB7irpV38k+7jpXViGho/nj0Buuha4bh
         P+xq+YZqDS+V1qSeBUyWL1cyE9yklELko0+FJWUlJx+RGzk792wbAY7funtjrNtJCR0W
         fb4cApKF0CR63SBmYvxK/bhoiyHIm7ms5bYjbckE34rPAWauolCWvhCxAjgVHlkgj7Vm
         8DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/5fgvFNuiwFQaXpG8wTqV/SjFj07kFd/Tf8QJk9MXPg=;
        b=IIJr91m9Gr5MG7YHKi3oxo8x8o+Mw+IqhUMWxUVVsQ7B2sXIr/VIDdhOWR9wC3aTXn
         pjRgIA51q6B3yN3C1QQ+hzG5iSQ+OU8hrjwf3fCxcI/n74ZRltQDpj5XUkZ3h+UwW4zq
         xo4TPyRCRxTJuNvqhSyL0SdaXeEm/kOnl3AGe+roTKrrZuSqBHbR2SZv99UVkCWrNbgZ
         Xip9NN+hDsLwi9BD8UqJD53ZEk2b5jOtCMdgkc8eO7Pbz/nblSnTPpfRi1rkYxI/XTXM
         AW3dV2EAZo7cIy2iPKlQffkV1+rvV9bo5IvuVgGpyMN8QZk5NKD4801oCHNx3Q3e6qwh
         8wDA==
X-Gm-Message-State: APjAAAVEdySXjRXMYqT3J2Spl4dsR7J3UNeLL3P+D8SStKOeskI+dFHe
        6Jt8ygV/hujz1Gz00zD7PQHcYTVKmHDFtzDm90LLCaaru16SX3QoMRB1w+cQZd4al7j2D4rOGc0
        PaGcjrZe0NlOqnbvCIqFasDMFJWF0
X-Received: by 2002:a24:e86:: with SMTP id 128mr5689080ite.113.1553101373417;
        Wed, 20 Mar 2019 10:02:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylLeN83pRYTpgJgTFGxIlhJkex28Wg/dBzS9D3APzJoZMymyxGtbN3vkDRP6pUKpWPDVI1fQ==
X-Received: by 2002:a24:e86:: with SMTP id 128mr5689061ite.113.1553101373193;
        Wed, 20 Mar 2019 10:02:53 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id m79sm1308564itm.25.2019.03.20.10.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:02:52 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtlwifi: rtl8822b: fix to avoid NULL pointer dereference
Date:   Wed, 20 Mar 2019 12:02:49 -0500
Message-Id: <20190320170251.31838-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb allocated via dev_alloc_skb can fail and return a NULL pointer.
This patch avoids such a scenario and returns, consistent with other
invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Move signed off above the version change log
v1: Patch collision with rtl_phydm.c, fix as per Greg
---
 drivers/staging/rtlwifi/rtl8822be/fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
index f061dd1382aa..cf6b7a80b753 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -743,6 +743,8 @@ void rtl8822be_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		      u1_rsvd_page_loc, 3);
 
 	skb = dev_alloc_skb(totalpacketlen);
+	if (!skb)
+		return;
 	memcpy((u8 *)skb_put(skb, totalpacketlen), &reserved_page_packet,
 	       totalpacketlen);
 
-- 
2.17.1

