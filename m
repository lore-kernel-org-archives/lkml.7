Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67208FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4083B2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UkDzwlkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406575AbfJPRK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:10:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42578 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406453AbfJPRK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:10:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so9541404pgi.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0cNywFNADhUI1kRZtOJYpH0zXDmwDMxvQ8ELH46NO6Q=;
        b=UkDzwlkBo8OxWsWkSSsM66G5Tk3Xp4HPoJ0xHC3/biSsKCEmqEmYg79o6SAGQn5jzx
         CaG+uZzeEI5fkMpGY+A97dgs2n4KkNfXVbia3hkFrbv2fB74wdMJevcIQDqRgY8nqbTo
         62QB/n/vspsIOi9R5YHoK5hn1LtOoXoEiOr19iGFUXip1kNS+v9gh9BsMRic9lDOt8Ik
         ZRHgD6wnA2g2TV0XWgiQfJS2+R25imNWGL2PhGtBd3OXwPvGMNvq8KT9UJhLD/d0K0Ge
         F6GdEUtB819mcEcYFknS9xnVXzPqmKPBoO2YUCKgPLgxqgP9b8Fr0A9eZyiv5N+hPcKb
         2qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0cNywFNADhUI1kRZtOJYpH0zXDmwDMxvQ8ELH46NO6Q=;
        b=bZpENTzryq7zSEsg9W/MshqrQPoR7312dgj/YjP70K+2JkgunFXpa25GjH3Cw9fXQc
         QkB3n3zttF6U0Sy72VTsCAFlWJklzII5lgdXMNvsX18YWeC7tQuj72Wuwu8YFc2pTTyy
         IYGJeEZprTkY1dS18TWzKyuiI2L7KOzo8ZDAUP2/hvNZEl4ePzBhaORKDDSBPxVTTmrE
         bjSsJF0QCT2LvRh6TzpbtW3lUIofrY7EZAjlrN9QuaTOiYN9DGCBrhHDcrykuJy+N1fT
         lXWf0oN6MjJ5t5aZufir1j/+B26AUJgHdlL1Q1verg7nOXpk/wdwFY0R+PsdcTTBo3rP
         ZRng==
X-Gm-Message-State: APjAAAXYLngR49ys3l6vPF7h9URfoPYSRxDckFVBwoHITAMn9+Av1dQX
        VNMI2ER6VBuFPteJO2SKiqnuhQ==
X-Google-Smtp-Source: APXvYqwXqs75kRjkMDu/5UYr5Jh0qOBN1tP7nsttBOkJTt8DNE6wMwnjzWsX/ZtdJnAHzijyeYq9ng==
X-Received: by 2002:a63:9d49:: with SMTP id i70mr28109095pgd.120.1571245827703;
        Wed, 16 Oct 2019 10:10:27 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id w6sm30670953pfj.17.2019.10.16.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:10:27 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:10:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 08/12] net: hns3: introduce ring_to_netdev() in
 enet module
Message-ID: <20191016101023.21915feb@cakuba.netronome.com>
In-Reply-To: <1571210231-29154-9-git-send-email-tanhuazhong@huawei.com>
References: <1571210231-29154-1-git-send-email-tanhuazhong@huawei.com>
        <1571210231-29154-9-git-send-email-tanhuazhong@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 15:17:07 +0800, Huazhong Tan wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> 
> There are a few places that need to access the netdev of a ring
> through ring->tqp->handle->kinfo.netdev, and ring->tqp is a struct
> which both in enet and hclge modules, it is better to use the
> struct that is only used in enet module.
> 
> This patch adds the ring_to_netdev() to access the netdev of ring
> through ring->tqp_vector->napi.dev.
> 
> Also, struct hns3_enet_ring is a frequently used in critical data
> path, so make it cacheline aligned as struct hns3_enet_tqp_vector.

That part seems logically separate, should it be a separate patch?

> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
