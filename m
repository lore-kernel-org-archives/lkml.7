Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD797C4360D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ADC208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="n1s3qLO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfIVCn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:43:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38041 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfIVCn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 22:43:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so5962876pgi.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nOgWL+giO3OF7JU77tFkF1HZOgXSLjLGEM4YdmarUy0=;
        b=n1s3qLO1cyMpCgm3y+dJWEtTk9i10BruwIOR38foEcM2c95wXg9tMS7u1B9rlRcsJB
         8dhIKe2cgliEmywjeEC9jjFeRpoBGExwBM2BlkRux3QbpLDdt2ZezY05TB7veIUAEQvM
         jbqAS/oWyP3hjDnkLzt4Bk61PEAUOt4EHRJHDICFPvoNYu6BEgAgynpXJpCw64yjB6q4
         gF+Le2FuOthRrW3w0HD+vgXgbyWlbNmo23I3cdszqQAUY8vqkW6S/TezBd0Q/BhLcDMk
         /+DKOVz2ndxD0U5XE0lpNt6yfHWv+ryQuybzb0uu3JwEKY7CLdUyLVyWQ+dzRsOD8h6T
         CNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nOgWL+giO3OF7JU77tFkF1HZOgXSLjLGEM4YdmarUy0=;
        b=Kp6J6Glcz3HQ94UaT1AU062oaTkfqymryXPY8tvrwOIUlVUqis7WIxydbcIyTTqg2r
         t580usu0Gs0ZHmAPvIeyTEZWzd/UTntnpJxC8O3sM8qyquaEa7hxl3BNgiwh+6NlHjBW
         lN1ysC11CtwH5s7E8xQuFctcccewBUxFPivMC8z/kgEwqXZreU196BxqYdG8bjaejMtm
         kMQsro9b1x3EPwRw2MUfL2tZsG0OQPE2LPOLToUamsXqV1Rj1DolOdS9J5p0alGtNxPj
         o36Ty/VInOkOwRkm7GU2hG/V7dhVUeS0+HBlXUKJK5jSIrasxPVhoQQ0a49yQ14nBNvq
         kBtA==
X-Gm-Message-State: APjAAAX1AE4W1qX4TmVHRiyKBxWQLSr45+LtCF1rgRa+RxnWNXnNFkVM
        T5YwR94T/eysXulAi2IPniA5bw==
X-Google-Smtp-Source: APXvYqxY6qNtrBC/TZYXlUXV5rKkjJWUqQrurXGhF8XVryWr+VkYxBPxyZfndPMajJMLaHnevVeDYQ==
X-Received: by 2002:a17:90a:3450:: with SMTP id o74mr13667448pjb.5.1569120234901;
        Sat, 21 Sep 2019 19:43:54 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id h1sm6697407pfk.124.2019.09.21.19.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 19:43:54 -0700 (PDT)
Date:   Sat, 21 Sep 2019 19:43:52 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     <olteanv@gmail.com>, <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: sja1105: Add dependency for
 NET_DSA_SJA1105_TAS
Message-ID: <20190921194352.1500a70d@cakuba.netronome.com>
In-Reply-To: <20190919063819.164826-1-maowenan@huawei.com>
References: <20190919063819.164826-1-maowenan@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 14:38:19 +0800, Mao Wenan wrote:
> If CONFIG_NET_DSA_SJA1105_TAS=y and CONFIG_NET_SCH_TAPRIO=n,
> below error can be found:
> drivers/net/dsa/sja1105/sja1105_tas.o: In function `sja1105_setup_tc_taprio':
> sja1105_tas.c:(.text+0x318): undefined reference to `taprio_offload_free'
> sja1105_tas.c:(.text+0x590): undefined reference to `taprio_offload_get'
> drivers/net/dsa/sja1105/sja1105_tas.o: In function `sja1105_tas_teardown':
> sja1105_tas.c:(.text+0x610): undefined reference to `taprio_offload_free'
> make: *** [vmlinux] Error 1
> 
> sja1105_tas needs tc-taprio, so this patch add the dependency for it.
> 
> Fixes: 317ab5b86c8e ("net: dsa: sja1105: Configure the Time-Aware Scheduler via tc-taprio offload")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied, thank you!
