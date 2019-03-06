Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CBCC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C420684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGOE7mlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfCFQMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:12:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40366 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfCFQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:12:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so8977093pfo.7;
        Wed, 06 Mar 2019 08:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9ad23BboDTynOD0KkNNhjbcGR2AlZ8Ie+e2SzuZdvyk=;
        b=VGOE7mlT/KfBLbSwzLSExkyr0QuzO2CL32qlLDHiaLlvnKW7sfHC+U3j5zVbatMU6c
         9fBSsS0DtFQqsVvHP1mzCjuVbboTAPZX1sCoJ9+eyoOw0eznhHE0nbZ/J/BRGGUuSQZc
         ypsR7JCKbnj1BpDtvjM0CmPlJa9xzBM94mhg2sRR2+XQDv1d3dSAWYf8fv9R/Zn8ru+z
         MvOGbBh+FtPMV+Onu83bzSvSxdTewFizOaBqv0N3bEhVagWn50ZgCns1o3vBxYCEbEyH
         QGT2Op8vNV4wNfCYiypZlskGUNWV5XqpdZx9+Dbl7pRqK61uQt7ZCVCae9dzQV9jZdav
         h5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9ad23BboDTynOD0KkNNhjbcGR2AlZ8Ie+e2SzuZdvyk=;
        b=nFCwsvOhJV6BvxvcD6UH++uHhlRi0CrV5KpfZ6FDqPyiMULx6DFyApI1AlgI/RVNwp
         3n/EViBhUN0sirnhV3ItggP3+8DYrI9DoRm+Ui7jhRdGsxI5RO9pi0laNPFa7uWbC1gu
         JJVUy1ZxkRsmzraIIp/X+b1dQF7JdquZ3gnRP0LnnB3Zr1vwYPhhrzGxESq79XgdL3MQ
         qrq8cDl6JytEY6Xc3WEk41c15Vq8LKmG1dUX4MKZuZ1+ZoyrX8JKv8XpU7y5nicw81WN
         9bA7Ms7u9Q+Z8Rst8LOCLl2a2CvORBroGK5i6IX4DSeHBG7br2R+LyTl1T26bCRCXDCm
         iQ0w==
X-Gm-Message-State: APjAAAXiEUTZfNPJ4ddFRgSUZGMFlrFgcvpXJOyxJTJERFoq5ey1ynMJ
        JjpVfaamCMAriqB+jhQnNgzIsynM
X-Google-Smtp-Source: APXvYqwpZprnM88EJV33G3vQu6/n3mBmBImeQuBnsNxyCj086Hbyuuvye7hQ+U6cwl0hD6yu8bamAg==
X-Received: by 2002:a63:f558:: with SMTP id e24mr6836620pgk.373.1551888742881;
        Wed, 06 Mar 2019 08:12:22 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.50.195])
        by smtp.gmail.com with ESMTPSA id y14sm5466351pgs.47.2019.03.06.08.12.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Mar 2019 08:12:21 -0800 (PST)
Date:   Wed, 6 Mar 2019 21:46:51 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@linux.ibm.com, boqun.feng@gmail.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftest/rseq: Remove duplicate header
Message-ID: <20190306161650.GA3155@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Remove duplicate header which is included twice

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
v2: Corrected format.

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

