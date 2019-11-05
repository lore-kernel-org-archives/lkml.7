Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EEFCA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B583F206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tg6feTvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfKEGPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:15:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfKEGPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:15:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so2155204plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aa3OA21J9JwZAlnC/lO7pQLgsSx0S9mISTEt24LrqMA=;
        b=tg6feTvsWhoUI6T3VhdPE7fPEDlz70rjIHNogtukLJgyq0FbR8IRr/wW7doMjp2B6f
         /6Rrj0kusQT2+oSBaXxAUTN/7XIksAKLaLCm4wlgxmHSurV1DUfXXcYkyx9oilShye0X
         T2KzM5WFY9461Ikl0Z9mHQkylCaLIGAlVKUAkeaMe4XDO8cfZu64IWTctqZEJLUahTZQ
         BAproY6ehLLKfo6XAcUaON3o4/meN3F6GmXYP8LjsRERo+sqnSUvwniIMRdZdMp6EuCb
         30JP/lV3quBsaUPs88fBAHMgsE0IgDFrMB/yoArneQUGvJ7/m2hyqdbKzt3nrwJuUjd6
         BI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aa3OA21J9JwZAlnC/lO7pQLgsSx0S9mISTEt24LrqMA=;
        b=LvSysvrwp0iBweJjWOz/SKgi17Yl1iGZRRGRtUBIj4iMYvhz8Z3XsoD14/6Hh9EMQH
         BGP4+tpcdgrYlgXtH50Ao4I//deuYG6ywbhrExYJ0TUcfvyOUQ4zVgh08PEOWXVy8B+L
         g1Uwuyd/BKdJ0+KEQ7wNBySGNU0W3thXi8E8p0kvoZ6hzOzCl+BERYzZMkeOCpO7pLMC
         R2sDa0V5ejQDqzNsApXeg36jzgKsmGnO7M/h/vwPdm5Oww0Z3D2yd2ADiHoFa0MiNkeB
         czZ/n0I410HVb1Nuv/N+Uf7PU2ZEwrKy6Lp3tZFG2/BMIhw3Uwtx0Nwcm5UmDmTHjwXE
         KC7w==
X-Gm-Message-State: APjAAAVHNABfj1avGeL90KxqhRJBiW9IpOSeIgOgsRWJHTN9EAJJs1XH
        wa4Rn4KqtkLK6LTFWRPfwKo=
X-Google-Smtp-Source: APXvYqycIJAQSd+NQR7rAmS9mG6bFN3PSXYm7zzBy9Xt8XqurYVXHrpgLG1q+jsvmUWwjpYS5q6+RA==
X-Received: by 2002:a17:902:d917:: with SMTP id c23mr23237443plz.199.1572934542419;
        Mon, 04 Nov 2019 22:15:42 -0800 (PST)
Received: from localhost.localdomain (c-73-48-141-28.hsd1.ca.comcast.net. [73.48.141.28])
        by smtp.googlemail.com with ESMTPSA id c12sm21419613pfp.67.2019.11.04.22.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 22:15:41 -0800 (PST)
From:   Charles Machalow <csm10495@gmail.com>
To:     linux-nvme@lists.infradead.org
Cc:     csm10495@gmail.com, marta.rybczynska@kalray.eu,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
Date:   Mon,  4 Nov 2019 22:15:10 -0800
Message-Id: <20191105061510.22233-1-csm10495@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing nvme_passthru_cmd64 to add a field: rsvd2. This field is an explicit
marker for the padding space added on certain platforms as a result of the
enlargement of the result field from 32 bit to 64 bits in size.
---
 include/uapi/linux/nvme_ioctl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index e168dc59e..d99b5a772 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -63,6 +63,7 @@ struct nvme_passthru_cmd64 {
 	__u32	cdw14;
 	__u32	cdw15;
 	__u32	timeout_ms;
+	__u32   rsvd2;
 	__u64	result;
 };
 
-- 
2.17.1

