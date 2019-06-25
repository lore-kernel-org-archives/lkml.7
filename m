Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E19C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CCC213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRpoMSro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfFYLm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:42:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46837 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbfFYLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:42:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so12347203lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 04:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KC6UqMNqqkqf945o5TbzjnUd7iFuYFfkkwWAw6cVa+A=;
        b=dRpoMSrornZ5+U7nptq/uktaa04UFIo/QAPLaDjRnueu6KFQvvbSC6ea/xIkrZ1H+I
         Je7LPWkHilJBcantQI2hVUlxVqRs1rx96wT1pMz6dMOJHhnnGQlCkxVOepvxEeCOShTL
         Yk4beULHTY/vTur12Zdo9Cktt4Ag8Xlo1DSjye7uzhgOi6xbe0mMRHDoIUsYjhCT9JDP
         B6XZNeVqaYT95yRVDq8vrsv4Oi62dfsZacGbbZRDRztCjG8Ep7/SB33ub9e+WQ0Ep7vt
         6UyJgyu/fZjIQRTiLMN6bJdHGOJtcz9XOJutcYpEA+DsJl38eDuJcLtKImIBfeVyUsIX
         89pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KC6UqMNqqkqf945o5TbzjnUd7iFuYFfkkwWAw6cVa+A=;
        b=nAJACM43E+P2NSv4Nu3qMeEMIuxDofXF+b4BTHYn8GJTyYUJUCfBECGjqcks1Gutki
         H6O8pHbghsU+iiM2+rfay3GNzM/pfNwcpAkzosFvY/jzC2t0hP5YKAPOnaqG5JVV/WrF
         48uwOscbP2f3Mcy1fS3qdCMglP3ctOJheSDj7D7PtBFsz3n3q9g6RcMI7JzaJIwIcYs8
         YbWkePthA7bhUuyIf3TWBTn6nHusvIHZO+dIMYV1Fy2W4p846g4ivKO+TC8AAEhJr+kR
         xQlF+nkY3T3r1or7Ee/FMXaMnfDMdQhAHPKXlFH+Cw4MhA0r0sQ1otBKuXv3VWlTZm2F
         tXHA==
X-Gm-Message-State: APjAAAWNG7mirFkxNrx1Yu3T5+kKMTHN361205JRTcPD2rDurgH9pf0h
        Qemyb8POPOKKO032PKDqCLFyNxWEwCA=
X-Google-Smtp-Source: APXvYqxt2HqTpJfaSIXqLD+CeTVC95mRSNEVCNRSHi4rSCLqw8RN7sSne6onoOM39tgDEByte/9mFg==
X-Received: by 2002:a19:3804:: with SMTP id f4mr6841525lfa.69.1561462970776;
        Tue, 25 Jun 2019 04:42:50 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id r2sm1913675lfi.51.2019.06.25.04.42.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:42:50 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, hawk@kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [[PATCH net-next]] net: core: xdp: make __mem_id_disconnect to be static
Date:   Tue, 25 Jun 2019 14:42:46 +0300
Message-Id: <20190625114246.14726-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed static for local __mem_id_disconnect().

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index b29d7b513a18..829377cc83db 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -85,7 +85,7 @@ static void __xdp_mem_allocator_rcu_free(struct rcu_head *rcu)
 	kfree(xa);
 }
 
-bool __mem_id_disconnect(int id, bool force)
+static bool __mem_id_disconnect(int id, bool force)
 {
 	struct xdp_mem_allocator *xa;
 	bool safe_to_remove = true;
-- 
2.17.1

