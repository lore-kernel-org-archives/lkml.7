Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58A7C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7872133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcnVgWDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfHNOuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:50:40 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:54377 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfHNOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:50:38 -0400
Received: by mail-wm1-f41.google.com with SMTP id p74so4844972wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/DXlUZnAnppcVmvRaCvG45NAF6K209fxQvIeSZzOmy4=;
        b=pcnVgWDPpVIKvEGcoQm5OxaoBVqYZbMOQiqkZ3wTAZr8Y6ocDyeakMLA8Im1Y+g99D
         POTgttsWlFnHPGAOzmL9x63nQingz9nYI4tmdXIrqRiCxn+kPG3T16a2nvIYG8GQ2Vzs
         Wce7Jnayh7CiIlLHBB2wEP03uzF21zbs288aBwspAfbTH7jE/zAGLwIiABldEZ0t2MFl
         7g+sqkueLUfkGGO7etvOXVSscsbkaSLTKp6TuYRkN4eneuKFf/g2q7u1xTmiXRL4QSi9
         08axMg8aBPXjCpcOkD6x6gdVVXu3E7WHEH7t0kz1SSsDjvHpa4CY59KwF9g2UEt0zSR3
         HS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/DXlUZnAnppcVmvRaCvG45NAF6K209fxQvIeSZzOmy4=;
        b=jXQgzVaklX99sfpBCAqhOWSZkiSwBFnQKMvcw7zOPAdUeuqsG1rWq8XxSVyMppK9gD
         C/tK8EvwegHNK7NiQvgyHuElcFHmB/b64X+xgzjGZvae/vnGytdsTUbYlWidIe7IwSq/
         qyHVxRkeaAH4hdHWf9RkhowtWJezQjSJcSz8yINF6vgCshnyOzjmn+NY0r7nJF0meTBH
         2yXKnkJP0Uwnp4PmTIDWjtOzUo6q0g5gAk1bVKTj65Yt7Y7s78fJJmeLTYy1VOKVmBP9
         o/X6KeLUtltxT3Pt+5sIQ051ztzuxP+c/PtkXwiyai/YsUHXN5xpMn1uGVcOQ6eBChfQ
         1Zxg==
X-Gm-Message-State: APjAAAVMdHodDvUf8378Fnwr67zdFyKY3xpsYj0cDiIZtWepLp0RjueU
        SzcYtmkotOq0pQy8GbSkL0k=
X-Google-Smtp-Source: APXvYqzoe9W3VA/sAzPxBxLK/CY1XdtfCqCC8uiIxtC44+YlxqrDtNJOaniUqy9vvtFN3+P4u+PPwA==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr9053044wmi.48.1565794236524;
        Wed, 14 Aug 2019 07:50:36 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id t198sm7911434wmt.39.2019.08.14.07.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 07:50:35 -0700 (PDT)
Date:   Wed, 14 Aug 2019 16:50:33 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
 nouveau ?
Message-ID: <20190814145033.GA11190@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Since lot of release (at least since 4.19), I hit the following error message:
DMA-API: cacheline tracking ENOMEM, dma-debug disabled

After hitting that, I try to check who is creating so many DMA mapping and see:
cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
      6 ahci
    257 e1000e
      6 ehci-pci
   5891 nouveau
     24 uhci_hcd

Does nouveau having this high number of DMA mapping is normal ?

Regards
