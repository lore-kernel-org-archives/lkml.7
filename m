Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01213C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9752082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qL5z0D6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLRRhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:37:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35974 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfLRRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:37:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so1645186pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7gdzcydNB65VYFctQBYHPEUqxDfTBuUZfIDGPSDNGq8=;
        b=qL5z0D6hD+W8MhQurl7WrbFLJjn48e2QS0a3n/2e9UPTmw9TuhFUd6BwEkzNik49WL
         DEdSHuWOs/7HqLTJ95oDz+XuKOvVFVjZ8oGQ0YtRgSjYv3iR436wUSJWge7FtMvwnbNL
         xQMHIGKEBdEV9TqPl7zTX+vXOG21X+RJIS6Pk9pth2fA2i7ZZvT7lwIkNA2nZHLwAxkL
         nrnp0CaYDrdQfasgCRhtJRiplvdzkem5+erSCx4RnGd9bt4W92ZS18xTJRMCgFDG4WQz
         njXY7eQLmXXv2M8tlhQkvSQiWd9SG8LhJW8794NYGmKCNQPncLu5mg4RP+LXiiAKXNaS
         5+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7gdzcydNB65VYFctQBYHPEUqxDfTBuUZfIDGPSDNGq8=;
        b=dJfWo3w8YX98EOYRHv1lBipQgtpFvauRyerVeDNWL0OjmRL8abUs+qykHzZobRTXXQ
         Y+qQWCSPj4WuLDBiIHXreSlbtuAIUwzuAunvybYXSc7HPrXDueY1iOy/b1krHzhgIhfT
         2gvR0ydYUTrRGLbLVhDDO4EeQgIbgw5zmqOhB2rPy3HM0l1tjfaoM8/SDwrJKA/k8sVn
         Y+rRel8AcFcLq1OReBBrvO14Odre3dLiFpqR5lJLXbi1eHSLu6OfZUzujJGOmDbXZnNN
         Fa1CdVZMd6qyKlT0Oyu81C+54XkmE9eHWyVmJgz5Xc8ze64Eodzr+mv3xUab+G1TQllV
         1+cg==
X-Gm-Message-State: APjAAAUQ/C2e92kQjXtEE7QeDLSrHqbcbrnLSWqcpI+jnKIzdY/PsY/J
        BTcJaddDsjOQaAjVvPsh1K3vbg==
X-Google-Smtp-Source: APXvYqwiiQTgFhV2FNc/1YXxsDh666XwSCO1QqqmlVwGJMzysZdJo+Xg72a91JerRuhflwPXQQk0Uw==
X-Received: by 2002:a63:b005:: with SMTP id h5mr4195873pgf.67.1576690673864;
        Wed, 18 Dec 2019 09:37:53 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::5])
        by smtp.gmail.com with ESMTPSA id x21sm4011976pfn.164.2019.12.18.09.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:37:53 -0800 (PST)
Date:   Wed, 18 Dec 2019 09:37:50 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <zhangfei.gao@linaro.org>,
        <arnd@arndb.de>, <dingtianhong@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leeyou.li@huawei.com>, <nixiaoming@huawei.com>
Subject: Re: [PATCH v3] net: hisilicon: Fix a BUG trigered by wrong
 bytes_compl
Message-ID: <20191218093750.2c9f1aa1@cakuba.netronome.com>
In-Reply-To: <1576635093-60466-1-git-send-email-xiaojiangfeng@huawei.com>
References: <1576635093-60466-1-git-send-email-xiaojiangfeng@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 10:11:33 +0800, Jiangfeng Xiao wrote:
> Fixes: a41ea46a9 ("net: hisilicon: new hip04 ethernet driver")

Thanks for providing the fixes tag, for quoting commits please always
use 12 characters of the hash.
