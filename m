Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592EF2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8wqETeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfCDSeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:34:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41218 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfCDSeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:34:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id k11so2690539pgb.8;
        Mon, 04 Mar 2019 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i1Bx3t0yCJuhrr4DUHHFMKZ984/ZfD3OSNjGkyzCTrM=;
        b=A8wqETeTBhoprte2boTrgrLGOyJGvxxWU+KOUh8BZ/oiXxTbXpubp0860kjZVpWT6K
         UB3hhorFV0n+g7j6mncbbOUE/UqP6BdfFuKEfSnLm/D/Ht5SW5F4r16EqY7XnWYmFLiF
         2g+X9L+Po9lyFolVi5Gge+sUbx2PVHuk1/H7HktBcsy2nUQMYsVJqiFZAm3gU6r9KVHw
         ERfSLH/bMsBzH+gyOMfUqRlSiPxMV26VAMNgbeUoFzRl7KM+GVMoIR2ngMK3CLtmNlc3
         vaebc1Ag6owgLtWuQRmpxpRhVfgzB6Xx9JCXMay0ts1Koit5fjqW/DsWXYTlg3qpDImn
         z72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i1Bx3t0yCJuhrr4DUHHFMKZ984/ZfD3OSNjGkyzCTrM=;
        b=fGCF/Bpj/hgIgYB4ampL3NTYgn3VmyP8JGzdkONQfPdzWCmvZZNzO+eulzV+j2bFij
         gmWfXWywFXaoQZnEM/Qyr10GwwIHBofNY55f8jAN7FEe12hDdhE026NB65yi5If65+kj
         6XWo5hm0UHoTPEb/oTy7+iPTPWD8uh0pVQy27SyVW1N9ZW1oLZ3hITyReHku5MOag5gq
         TkJZvN/U5OeLjDAEWFNwPd44oQ9gyQg44SfVSBrJS8cgokfzx5B+MLfIHyzxCOqdhfd4
         7LCTF6aMYV8lykRr19nVkFOUpXxKhfpHyv4dXCIReSwO0ZiRDYKJW53Wx47EwWlOAdup
         NqUg==
X-Gm-Message-State: APjAAAU3NIh0gOlneQHbXs8JOGismkQwctFEp1zdmPE0FGF3lASMQrNj
        9Wz6S0SZZO6ZUUvPKJbDvkx8tUcx
X-Google-Smtp-Source: APXvYqw2KSA/6nmuFq7U8Xy2qBNjk3vWaK6ImtdfT2UUipPZpeYlFhi8zEAQlZGknvTv41cmTIM26Q==
X-Received: by 2002:a65:6483:: with SMTP id e3mr19527725pgv.273.1551724439544;
        Mon, 04 Mar 2019 10:33:59 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.146])
        by smtp.gmail.com with ESMTPSA id 1sm15173520pfy.68.2019.03.04.10.33.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 10:33:58 -0800 (PST)
Date:   Tue, 5 Mar 2019 00:08:27 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@linux.ibm.com, boqun.feng@gmail.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftest/rseq: Remove duplicate header
Message-ID: <20190304183827.GA6809@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/testing/selftests/rseq/rseq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index c72eb70..6c1126e7 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sched.h>
 #include <linux/rseq.h>
 
 /*
-- 
1.9.1

