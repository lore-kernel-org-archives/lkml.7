Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A391FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C8D206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="J8r9Jszu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfJHUrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:47:04 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:11600 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbfJHUrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570567622; x=1602103622;
  h=from:to:cc:subject:date:message-id;
  bh=e2EpWxRth6aBZHE8ZXo1zKO2SslwXSb+q+bStpOzj7w=;
  b=J8r9JszuarkYbLe/WNGGN6JABPytcwIeY1Gcobw+mDVhYwQQXjDVoU36
   hljvoJeyRDIX6PrkI7VIe54cUz8aDKugtbN5gWprVESqhiRZPhJF4OX0F
   MRAZkcx4jl1s1dbRD8tKDuAQY+9ifrQiSiJ/tJOy04f2bueSxdjoY7Jgs
   TAULrYgj4Tpk7jZ5McfP+CmzyduOeuPUVMjEAP+P3mFuZzuVrM+3eiQaR
   wVZMuSuax3vOH8lVe5b1i9yJeFhCp3VAlBLmwHGVCKU2vz6PKNc93Mqka
   jdqXkqvZZqtc7pnx1SI4Eiirleo/OtYoXLRem8gMz3BYjd7vHMOx6NTWg
   g==;
IronPort-SDR: NLMqOct6CYY+eYP6dLgWL9wqD9fEn/6kplIpDoIucWHsaC81VFTS6yLa9BYlMScwiS+5rKjpXt
 N03keQa7fB6yqvzHLjrBZL3o6UtY8jIKwwfFn/tkhH/3zlMrHyuUKIeajWHNdxXIE+Fj2OzIvN
 zC1Ralg8rVUxtEiNuQk75B8jWoefvaK/MdIMUE7NcL2Ed8xaD0sGnT4y+w+sXqJF4vq4TGr2va
 00MxHWtoz4PW487QsQROqXF5M68O0PsxpOpnMl/WSgFuNvW75/qZDZh9+Gakyz51ho4dW6D2Pa
 g34=
IronPort-PHdr: =?us-ascii?q?9a23=3ATfG4BxcGJoANw9KmNy9MT04vlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcS4Zh7h7PlgxGXEQZ/co6odzbaP6Oa9CCdZvM3JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/Ru8QSjoduN6Y8xx?=
 =?us-ascii?q?XUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMAoa9b4sUFOoBPOBYr4bgrFUQtBW1GAesBOLxxT9Mm3D9wKk23u?=
 =?us-ascii?q?o9HQ3D2gEvGM4DvXrIoNnoLaseTf25x7TMwTneb/5a3DHw45XKfB88u/GBRb?=
 =?us-ascii?q?J+f9TMx0chFA3LiU6dpZD5Mz6PyugAqXSX4/ZmWOmyi2AnsQZxoj23y8gui4?=
 =?us-ascii?q?nIh4IVyk3D9S5kx4s0Jdy5SE5hbt6lDJdcqy+XOpBrQsw+WWFkojg1xaAbuZ?=
 =?us-ascii?q?OieiUB1ZcpxwbHZvCZb4SF5gjvWeWRLDtimn5pZb2yiwyv/UWkzuDwTtS43V?=
 =?us-ascii?q?dOoyZfjNXBuHAA2wbN5sWGUPdw/Eis1DCS3A7J8O5EO1o7la/DJp4kxb4/i4?=
 =?us-ascii?q?QcvFzYHi/zhEX2lKiWdlg4+uSw6+TofLHmppiEOo9xkA7+M6AultWnAeQ8Lw?=
 =?us-ascii?q?QCRmab9fm42bDn50H5T7JKjvo5kqndrp/WP9gUpqm8AwNN04Yj7QiwDyu+3d?=
 =?us-ascii?q?gGgXUKKEhJdRGHgoTzJV3CPf/1Ae2ij1molDpn3/XGMafgApXJIHjDirDhfb?=
 =?us-ascii?q?Nl5k9cyQszzcpQ55NIBr0dLv/+QVLxu8DCDhMjLQO73vvnBM1n1owCQWKPHr?=
 =?us-ascii?q?OZMKTKvF+M5+IvJfSMZYAMtDb+Nfcl/fjugmE9mVIGY6mp0oUYaGqiEvRlPU?=
 =?us-ascii?q?qZe3zsjckFEWsQuQo+VuPq2xWsSzlWMkezTaIh4XlvGZCmBIabHtuFnbebmi?=
 =?us-ascii?q?q3A8sFNSh9FlmQHCKwJM2/UPAWZXfXf5Js?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FAAABz9JxdgMfWVdFmHQEBAQkBEQU?=
 =?us-ascii?q?FAYFnCAELAYNdTBCMRWCGMgaLKRhxhXqINYF7AQgBAQEMAQEtAgEBhECCSCM?=
 =?us-ascii?q?0CQ4CAwkBAQUBAQEBAQUEAQECEAEBCQ0JCCeFQoI6KYM1CxYVUoEVAQUBNSI?=
 =?us-ascii?q?5gkcBgXYUoiSBAzyMJTOIZAEJDYFICQEIgSIBhzSEWYEQgQeDbnOHZoJEBIE?=
 =?us-ascii?q?5AQEBjXiHN5ZXAQYCghAUgXiTFSeEPIk/i0QBLac2AgoHBg8jgS+CEk0lgWw?=
 =?us-ascii?q?KgURQEBSQNSEzgQiQDAE?=
X-IPAS-Result: =?us-ascii?q?A2FAAABz9JxdgMfWVdFmHQEBAQkBEQUFAYFnCAELAYNdT?=
 =?us-ascii?q?BCMRWCGMgaLKRhxhXqINYF7AQgBAQEMAQEtAgEBhECCSCM0CQ4CAwkBAQUBA?=
 =?us-ascii?q?QEBAQUEAQECEAEBCQ0JCCeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBgXYUoiSBA?=
 =?us-ascii?q?zyMJTOIZAEJDYFICQEIgSIBhzSEWYEQgQeDbnOHZoJEBIE5AQEBjXiHN5ZXA?=
 =?us-ascii?q?QYCghAUgXiTFSeEPIk/i0QBLac2AgoHBg8jgS+CEk0lgWwKgURQEBSQNSEzg?=
 =?us-ascii?q?QiQDAE?=
X-IronPort-AV: E=Sophos;i="5.67,272,1566889200"; 
   d="scan'208";a="13722861"
Received: from mail-pl1-f199.google.com ([209.85.214.199])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2019 13:47:02 -0700
Received: by mail-pl1-f199.google.com with SMTP id v2so83738plp.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 13:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UcNGcrGPyVoPDcibS6kHRvKp5pfRC1J5GWh3MwSdG7g=;
        b=ok6WtEKppHXzMZyzyWqEIFsZ0EJCAEDYD5llsP6mX9bpnjvj5iFoUIx2MB12cOd06r
         /3m4/dg7vil7b2z0UoQiCo15low68yCBjxk16bLU53ha/PwXBPhg6m+e+O5/L1+U4i8S
         NSUK1FqU+ZuoYWJr29MR8Bcoz7ynZkIN0UFpigolaMt8x0VkQopOrH+glJqqCN1NUswb
         ng7GDxvB4UyD4uRrvgXuToTmGLvJipyU2btUTpWNZlfZCV9iMz9LiKzvKliWMaGsKh1x
         vRGe8hUhxFu8IBleFSQwQb27Kd5NWExOa4Vu3XHHcWMQ/0lud3bITA3mcs7JicUYIMYD
         P1Aw==
X-Gm-Message-State: APjAAAXI5XBAi3Ke8+qJNtHWDCWRq+IT67uavdJ4JW9RYI1Vw4tdE/FW
        UxMTkseBHBsynb32FxNYYh8FpgoK9mI4BIJXj4iUdw7XFQkTtFfAgQ+4IKBa55leuDGvi+MvjvZ
        JTKXm0iTCd8oK9V3LcoPdG4je/g==
X-Received: by 2002:a63:ba04:: with SMTP id k4mr364110pgf.162.1570567621804;
        Tue, 08 Oct 2019 13:47:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzS9am+3/0QB5lVI7nSgh41DWhbuBfe6Ou7GGIZLxUxzoHEQnS5f2k/m5C6amcRIGXt/o53kA==
X-Received: by 2002:a63:ba04:: with SMTP id k4mr364085pgf.162.1570567621409;
        Tue, 08 Oct 2019 13:47:01 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id f12sm78606pgo.85.2019.10.08.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 13:47:00 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/hpet: Fix uninitialized use in hpet_msi_resume()
Date:   Tue,  8 Oct 2019 13:47:44 -0700
Message-Id: <20191008204745.12040-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function hpet_msi_resume(), variable "msg" could be
uninitialized if irq_chip_compose_msi_msg() returns -ENOSYS.
However, it is directly used in hpet_msi_write(),  which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 arch/x86/kernel/hpet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c6f791bc481e..5bc76819dd32 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -501,6 +501,7 @@ static int hpet_clkevt_msi_resume(struct clock_event_device *evt)
 	struct irq_data *data = irq_get_irq_data(hc->irq);
 	struct msi_msg msg;
 
+	memset(&msg, 0, sizeof(struct msi_msg));
 	/* Restore the MSI msg and unmask the interrupt */
 	irq_chip_compose_msi_msg(data, &msg);
 	hpet_msi_write(hc, &msg);
-- 
2.17.1

