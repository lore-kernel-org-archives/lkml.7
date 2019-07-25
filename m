Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B4C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E5821951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxsTZb5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfGYXjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:39:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44343 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:39:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so23489882pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 16:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HL3f1QKfq6e08jFTkT6R2/ZO1CAKghKslwWUsBfzlRE=;
        b=fxsTZb5+9JjG5L78sk/u6L1+2uCXJaQQndxS0n8FFFMYFQlGUpOvCDNt6WowVMszs+
         9Rsl+Txt4aPJPnLpB2Zzhyd7mKGBE8AxCUFnlo/ahAFDH9aDASN3JRwUNm4TQrYmMPd8
         kG1T+/drikeEIkkLiM5R3z+/reVUS50ZPPG2klTvYg8dvOFTRqxg4oeUXm1icEL8wqgQ
         2zCaMYFycC2/+0CyoSp50LAo24XS6VpktBsnBS2BGuyNhwDsjAayBWFG5qSl54OFgte0
         mZa/twt+3yvDxUdy91GQc/as394cvZsJM4HM0JZD4sw4m5qWbKJr2KNKqitkb8rCrT0s
         b6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HL3f1QKfq6e08jFTkT6R2/ZO1CAKghKslwWUsBfzlRE=;
        b=gdazu6J/MpmBzN9q1HTldmDm7wkx7Ug6rvxvQPvUA5gGyecFWWC16LVcxeo7cBS37O
         RdFs2yQxFFn0Tmu2d70U9DcYnYYn0n8bxbNrjpzZuAM42MXMNND21Ll+4jZUrGYB0FQz
         Epw4nMCvRp/LCK8G5i+xFYxU37xZWrdCnXxRjtOdgRIbkSWaAd+OraENO7SBKSz7Qf1Q
         RXyXJcsoKjBbYkZkRYLDK5SFxgYMMm9wLwtJeirVxX5ywuiSQBc/aVB6yoxtRWsZPcGv
         sQMhi0OcC+lXvcNtlojscVdBKXZnbpcMhVgharYYiHEsJISJ1rmIh/A8Iyf2AWtymTf0
         ZH4g==
X-Gm-Message-State: APjAAAUfAT0843HMVsIuJ6nrTMMCra8FIMu8g7E+hqG4Dl2noJMxldsg
        kKGwZPF455xRZHblMfmlrGw=
X-Google-Smtp-Source: APXvYqySg1O90lACAxj6zg8wg9D5yLpJeufx39qsSItUWsy1Uh2PwD3ZJMfh6e3dZqmI2hDs1eQYKw==
X-Received: by 2002:a63:490a:: with SMTP id w10mr87122603pga.6.1564097957836;
        Thu, 25 Jul 2019 16:39:17 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f72sm70888203pjg.10.2019.07.25.16.39.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 16:39:17 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     dafna.hirschfeld@collabora.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] dma-contiguous: two bug fixes for dma_{alloc,free}_contiguous()
Date:   Thu, 25 Jul 2019 16:39:57 -0700
Message-Id: <20190725233959.15129-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two obvious bugs in these two functions. So having
two patches to fix them.

Nicolin Chen (2):
  dma-contiguous: do not overwrite align in dma_alloc_contiguous()
  dma-contiguous: page-align the size in dma_free_contiguous()

 kernel/dma/contiguous.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.17.1

