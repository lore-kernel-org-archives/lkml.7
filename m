Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA6AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72C820717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ynfiagkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfHFDGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:06:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38685 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfHFDGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:06:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so40676335pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 20:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FlvubqIedgeUlDz/PPiAaJ/H2Njn7iS17Qlm1S+ibcs=;
        b=ynfiagkhgmGZERUei2yzw6PnvDoOnOGKaEU+BMUJIRoWffXtOXvM7JmpSEltHxNXMA
         oYyljM/tmGwXdC30QlWHHWbcRrYE9qBwLWv7umSLx8+B/ECw6vRLRLIHMOgbn3pi46mt
         4A3L0A+DOhRb2pQbdkqq3jFUo0M2J6N8Rn5GpoEo7cWttiHS18T3tj0og3hmA6lPjzMr
         1H5xB2mVcdaFWSbiEBswqQ5jiRkhy1nkaEyR5ccR3jTCnjHxI4JKgfSa15Gn6ncXadnj
         trmN9tyDkV9ItvX2nZJGnL59ViA4Sqj8UWgo6MZ7JXNTK5w2kx2RIoBKs7hBnfU4I30G
         /Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FlvubqIedgeUlDz/PPiAaJ/H2Njn7iS17Qlm1S+ibcs=;
        b=Bo3xYRgDo8LfGtpHS7LMiw/kPfD5s5dYEJjDD+Gyf2iRLY8LUZozYl5rRTD0iV1esv
         d4tY7MJ5YK6Mqx9s3J+8u43R/Q2EWcBEzijTdENjG45nwGq72VgcuhxgMpRiqnAM28TM
         uuSWtq5LZ3RBdrQwTMByq7wIFio5yeCk/RrEgdJvIma7FPzfZeLh0f5Z9bQAvb7mTCtW
         RV4+G+eXWZ+veNUqRzVrcm24BRpEBsEnj5cBlHwkeh+/nSImLRM6zyVczwT0JxQfQsG2
         4DTILajqo8MDp3O6Of/c0WCW/SnyWZ6yhAuLTukHbA6wNNkruDdw8J/2QXPLuMlyM3JO
         nHBw==
X-Gm-Message-State: APjAAAUW9vhlx36HQAryE5YyT6azxwAd0vGvzCRdUW/LCcny0F6meTci
        St+EfdBC2WvWZc4EYCrmPgzoyg==
X-Google-Smtp-Source: APXvYqyC0NiG+dH81MgzylsXKTEOMaOlrWGlwxH0Q+mcPaNttiuDNofMxMSQSM8JshjuU5dIMYQZPA==
X-Received: by 2002:a17:90a:b312:: with SMTP id d18mr822646pjr.35.1565060780443;
        Mon, 05 Aug 2019 20:06:20 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id v14sm91912574pfm.164.2019.08.05.20.06.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 20:06:20 -0700 (PDT)
Date:   Mon, 5 Aug 2019 20:05:55 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <leeyou.li@huawei.com>,
        <xiaowei774@huawei.com>, <nixiaoming@huawei.com>
Subject: Re: [PATCH v1 1/3] net: hisilicon: make hip04_tx_reclaim
 non-reentrant
Message-ID: <20190805200555.5a171567@cakuba.netronome.com>
In-Reply-To: <c150d41b-6f0e-ad49-e8c2-00896fc9cbe4@huawei.com>
References: <1564835501-90257-1-git-send-email-xiaojiangfeng@huawei.com>
        <1564835501-90257-2-git-send-email-xiaojiangfeng@huawei.com>
        <20190805174618.2b3b551a@cakuba.netronome.com>
        <c150d41b-6f0e-ad49-e8c2-00896fc9cbe4@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 10:00:52 +0800, Jiangfeng Xiao wrote:
> If hip04_tx_reclaim is interrupted while it is running, and then
> __irq_svc->gic_handle_irq->hip04_mac_interrupt->__napi_schedule->hip04_rx_poll->hip04_tx_reclaim

Ah right, obviously you can't do stuff after napi_complete_done(), 
that makes sense.

Series looks reasonable.
