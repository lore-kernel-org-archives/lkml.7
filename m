Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631B1205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yeN126dH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404628AbfFMRKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:10:32 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43842 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbfFLWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 18:46:42 -0400
Received: by mail-qt1-f172.google.com with SMTP id z24so7153866qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=AvEz80RndZML7i5e7xLWFJaU/oBcGksUZL3ZVAZz/vc=;
        b=yeN126dH080F5WJlpPkx/gVbgWfPMDnzZs19djMIpFWkQAaC6GGGjs3s9hsd6JKraY
         +QJ4pGRl91F1byjRjEOILr+u2loTuriMZty4iV0M0L7Q7Xav0PB3xkp+8EpcypvWWcMP
         zzJUwEPKDtJgWrWxR/R1ZDG5tzqLYY/cPoOn6XlPU1ROe48CiMkre6f09aEIh3/jOW44
         yPgRQnWmNglH8zGM58ZL7Fq3YKJmE48oQCimuABrRuIIyufEav+Bjt8k+p7wzQrZBEVk
         cYzjSSpm3gM5RpipcK0Wzggy58E2yU21E4WcKWjdmDAg1R4VtJEEe6cyPxp6rxNWy4Sn
         IDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AvEz80RndZML7i5e7xLWFJaU/oBcGksUZL3ZVAZz/vc=;
        b=knyUuso6PJRyXz5HKHXOlUOHB1PgcRViq0xlQPSkt7mJsEfpcSBoMrlPlg9AAiVPAd
         JUoh0+Wtd3j1tjwWBNAevhaIkybpfbjXcwadySHcsC9dmKV/yTys2OTHOjDzQXQfryXs
         bZOpvmuvGpIDVrMA5l85btOkVgsTvbT2REeAZ33Awc67VShnFSRU1qjU0yCmWFb/oBlD
         2EJQx+LgmIbBr3Ei5LZKom9oKnyBTClrwIr6Aq9s6ix9DEclgJu0ktxV/x4Z9Wo7iCtk
         k7IZj4Sy7loxQZ0gwGeKqYkoCPHqhx5thwafodygGIdR5HlVC31LUxDqa5sVRV378avG
         uHMg==
X-Gm-Message-State: APjAAAUDHcJbR9XCBjdV/qD5wbqNuE7eXnbvxIhETdfgEsu9FPA0tYiA
        7TVdvLyCHR1/3H8AFZO7DgNmcg==
X-Google-Smtp-Source: APXvYqw2t3mcxgOlSDwDLTX5e/42JMuOR5iBZr++4VWJwoI79YpIf7fWltBgwDZgdOieGa/+ml1jQA==
X-Received: by 2002:a0c:8927:: with SMTP id 36mr823821qvp.131.1560379601808;
        Wed, 12 Jun 2019 15:46:41 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 34sm691604qtq.59.2019.06.12.15.46.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 15:46:41 -0700 (PDT)
Date:   Wed, 12 Jun 2019 15:46:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Xue Chaojing <xuechaojing@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoshaokai@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>,
        <wulike1@huawei.com>
Subject: Re: [PATCH net-next v2 1/2] hinic: add rss support
Message-ID: <20190612154637.2ad4d882@cakuba.netronome.com>
In-Reply-To: <20190611181234.4843-2-xuechaojing@huawei.com>
References: <20190611181234.4843-1-xuechaojing@huawei.com>
        <20190611181234.4843-2-xuechaojing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 18:12:33 +0000, Xue Chaojing wrote:
> +	for (i = 0; i < HINIC_RSS_INDIR_SIZE; i++)
> +		indir_tbl[i] = (i / HINIC_RSS_INDIR_SIZE) * nic_dev->num_rss +
> +				i % nic_dev->num_rss;

This looks suspicious:

	i is in range [0, HINIC_RSS_INDIR_SIZE)
	so i / HINIC_RSS_INDIR_SIZE is always 0

For the rest please use ethtool_rxfh_indir_default()
