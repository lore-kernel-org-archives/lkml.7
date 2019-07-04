Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55ECC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 22:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778EF21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 22:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="hY0qIf3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfGDWNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 18:13:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43847 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 18:13:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so3596791plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=o5jK/lFAS+ONU/+opdeRt9/P3YNw9XJ8quHkOsC4h10=;
        b=hY0qIf3z6Ni/z4so7IV/FjBUGr0c8/glvUMwOm2RZJTLLBaV+yZiRYCr6U63l4gu8H
         8QOUaKoopVyo+MopFT9hBHjXUceCZvbyiPee97v3fiMqbVkvcQIdpgV9r7VysqQK0NCE
         uUdb7DOJcVYZbbg5DPL2ERoD7wXaZbYtDShQ9QBHP1yiIBvG4yYxbLkiDFwUHdyrUP4Z
         HtU+1XuvefrysiLbdF7P8065+4Smk29cK1fyalRGE0m6/MlosYH9KoMWygg/b+88EM9X
         byYqfHK6+AgTZP5jx7ZJz6fQwKPZhfQkEwNsQ7N73K1NIcsPSL5OtO0h3UO41NF9BQRm
         PKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=o5jK/lFAS+ONU/+opdeRt9/P3YNw9XJ8quHkOsC4h10=;
        b=XZOrUpuhngOL95CRv4/Wvx5WK3r6SR6Y4uJ/n1eNb1T9fcIWe+myQsRc/9ELpzQC3p
         j1haMRbNUiaVqGZsr3oVw77auGff8Jhy6mUZlcYJ+gLn7jekwtjNty2dg075MYMUeqpZ
         FfQQpLgsi3VuQJnpJUzcVHxAazbfr6sNvq/YrQWnr76IYU6jlKly0dQijtWQqNIFeYWo
         WFjazU7e5gdNqezbwKT1t7LTZ05UKK8BdBXtFPP8id51WbbTQ4Tq6ZJWm1sKYTXPsG0f
         pqzs+7PXfczxbU5O5n+Zk4jBxxo9Ag00IgM9g9/6OvfE21v819uJiDu1j4CW7RMNtelj
         HEAQ==
X-Gm-Message-State: APjAAAVvvmAtcANKdjuCZBM5yypMogYwGvCK20BcZbSYNrR5SetWSqRv
        cD585HzHR1QtjCwMfg/DhgxnRA==
X-Google-Smtp-Source: APXvYqxJjAHRCHXIsBiM2KCzNk8ZSgGLbZJho8RZHhx69atxriuGhqlS3aQPFTgXT0dBm6QEEKXWKw==
X-Received: by 2002:a17:902:654f:: with SMTP id d15mr475786pln.253.1562278395092;
        Thu, 04 Jul 2019 15:13:15 -0700 (PDT)
Received: from cakuba.netronome.com ([2601:646:8e00:e50::3])
        by smtp.gmail.com with ESMTPSA id p65sm6455400pfp.58.2019.07.04.15.13.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 15:13:14 -0700 (PDT)
Date:   Thu, 4 Jul 2019 15:13:11 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 0/9] net: hns3: some cleanups & bugfixes
Message-ID: <20190704151311.21025194@cakuba.netronome.com>
In-Reply-To: <1562249068-40176-1-git-send-email-tanhuazhong@huawei.com>
References: <1562249068-40176-1-git-send-email-tanhuazhong@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 22:04:19 +0800, Huazhong Tan wrote:
> This patch-set includes cleanups and bugfixes for
> the HNS3 ethernet controller driver.
> 
> [patch 1/9] fixes VF's broadcast promisc mode not enabled after
> initializing.
> 
> [patch 2/9] adds hints for fibre port not support flow control.
> 
> [patch 3/9] fixes a port capbility updating issue.
> 
> [patch 4/9 - 9/9] adds some cleanups for HNS3 driver.

For the unsigned "fixes" it seems it may have been easier to fix the
macroes than the users, but perhaps that's hard.  Series looks
unobjectionable :)
