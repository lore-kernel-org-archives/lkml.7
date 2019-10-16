Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FADFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0E22064B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="vV9fBMVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbfJPR1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:27:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35473 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfJPR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:27:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id c3so11592271plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1CYanzBAmlB3jQRtweRaRTG+rbpP/n7wTvScjVK1e/c=;
        b=vV9fBMVvWsO1gbT4kIxyv3aaSiKBwDc5Gwc83M5Nq5FWeYRavCF/CQJjTS1hAuZItM
         HMLD+r1XOa3lmN8TI9NIQJX/ZIdTc0sbvdry+PNBS1GM7hYm4EjmGpjdZTQLY03WS4+I
         LR74k+7efgX/xBkMxbgFQlk0XkqW1RAA+n7Gg+OIKm6XjwTXGsdymspr40ZdKET2Hz2E
         HNrX5KZsxgABEcBh4c+k3ZEgOMN+W23uh8vGUxcwGsGh8MIQAhl5gYoQLCCPqOad/EL8
         jFvlG9DSb9HxkkDVbE+gTVDbcRHUe8kKmio75nqmx3qVLCKv0xpIJuYgCWKGeKe5rZ+O
         kLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1CYanzBAmlB3jQRtweRaRTG+rbpP/n7wTvScjVK1e/c=;
        b=BcC5dIRqcoWGsJOjsIgFZdUyAKAp/XnXfvhakq908Y9hTiyUUCel7aVoGZ8QAM9wHG
         fcWgju9PYoJShPUZ7MIQyOln1LkyztiHVpU0zJ41wNFESkVDUayvSJ7mtzBBYzz4iEtT
         z1XIvi0uCldfpZuNwxISxv71G+gV9oBTRG0lAUGHxYozUH82vHKQR4VqVI02L8k5LDzP
         QmjvwmLTDyEZJzbKKASzLuMgxp0T4aEPgYov14o+ezAQTcGO75UcC6dYw2PD2/MBzHce
         /j2q48qZO+iF28zSdcYJ08c9ZzXBh42+SRjrsqZoDlnDqq0RKbjEIqXCGOzlgz0RjR/8
         bJqg==
X-Gm-Message-State: APjAAAWfGGQlQsdJ1clzhEeN3Ez/L/HB9sTDjgV9od0NTqlLc7I+IWio
        CyjsX040ph3kHOdYTxnJhSrx9g==
X-Google-Smtp-Source: APXvYqxddniC2KCF5w95AdZWbKYpc1M5yC6QhNRySlc/OkyxnaJ00PMtVud+qsCkv0FAbkYQlJkSOQ==
X-Received: by 2002:a17:902:246:: with SMTP id 64mr529341plc.257.1571246387191;
        Wed, 16 Oct 2019 10:19:47 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id z12sm25424325pfj.41.2019.10.16.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:19:47 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:19:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 00/12] net: hns3: add some bugfixes and
 optimizations
Message-ID: <20191016101943.415d73cf@cakuba.netronome.com>
In-Reply-To: <1571210231-29154-1-git-send-email-tanhuazhong@huawei.com>
References: <1571210231-29154-1-git-send-email-tanhuazhong@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 15:16:59 +0800, Huazhong Tan wrote:
> This patch-set includes some bugfixes and code optimizations
> for the HNS3 ethernet controller driver.

The code LGTM, mostly, but it certainly seems like patches 2, 3 and 4
should be a separate series targeting the net tree :(
