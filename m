Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB88BC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22A923430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xQRCv0mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfH3XGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:06:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44848 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfH3XGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:06:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so4230518pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vQ0RQyeBGvlKMouk4X7nITJZVdjq0EWkMY4a5NZ/dZQ=;
        b=xQRCv0mi0eqGRYV/ApW2A3oDEZUa1JFHMJTj+zkFkf66OWCAFlrAkvdcmOExCKzJp/
         8d0lJBfUjEAhih8i9BG0EXJVvpJZWbBbaywySUXCV3N9UZcW4SBLFn2cxICiXyjzMdev
         ODyPR1MUXBohpro70eUuwg03iB5iVzUq84iTGwcTK1afHHJ82QZbgGCodDkdVbhMDlz+
         gnxzBHlYewWJrM1rEY7SuBEgSPQjN5ZmeCeXCzSgiErCGZiilfRAiR0MgcSv+b3q+jK9
         DYU+Pbpsxpz05Eqq8GODoDR98sC6ZaTakqg4XmHEfaJaRbYCYLevZFVCS60Yq5GaPWhN
         NQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vQ0RQyeBGvlKMouk4X7nITJZVdjq0EWkMY4a5NZ/dZQ=;
        b=pPJgoQmRFQvrZrPggVPf7SGJ/n5HulajnvDIehhlmMp6INoW8xF6KcK25mMblQYnN+
         /EsCXSd/C5OWXzt5pqcS6D/S7viGJf9wZFHRuAJaGM7r5GKNyORConE6NlGXBmg9OpVU
         ASRslQ3MgXSO7EmnkG46bT31GgnRE5fBmknUqhElnZs7IG4CaTyYp/li3BnCrmovwnaw
         Hj0AQxEC/1qYZw8M94by1Hq2sLw7VCqsBb6Ml7H6v3/TapJFF9nx8tqUF66ffDZAYhz3
         nNR+iY/5HyMkZvNBUIISUuAeG66+PyPBZ39ZKidpP/sw5QjNvUa7Zkeb7kRPcMaememo
         xpTg==
X-Gm-Message-State: APjAAAWgLv0Yf+7GfOQD0UZpF5xUg7KfjaPPONSUAAFpGW+DW0hjRMJ4
        uidFgTdLGPonja9ZJdcMWBNroA==
X-Google-Smtp-Source: APXvYqy4SP+CeDdQB323fXjcyLOvixFSIEIvkWq/VTDq2eiaZ/PI0TTeUDqlL1VjeoU5O8Dnut/1iQ==
X-Received: by 2002:a63:7d05:: with SMTP id y5mr14993115pgc.425.1567206359284;
        Fri, 30 Aug 2019 16:05:59 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 2sm7101550pjh.13.2019.08.30.16.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:05:59 -0700 (PDT)
Date:   Fri, 30 Aug 2019 16:05:36 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next, 1/2] hv_netvsc: Allow scatter-gather feature
 to be tunable
Message-ID: <20190830160536.0da5fdf2@cakuba.netronome.com>
In-Reply-To: <1567136656-49288-2-git-send-email-haiyangz@microsoft.com>
References: <1567136656-49288-1-git-send-email-haiyangz@microsoft.com>
        <1567136656-49288-2-git-send-email-haiyangz@microsoft.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 03:45:24 +0000, Haiyang Zhang wrote:
> In a previous patch, the NETIF_F_SG was missing after the code changes.
> That caused the SG feature to be "fixed". This patch includes it into
> hw_features, so it is tunable again.
> 
> Fixes: 	23312a3be999 ("netvsc: negotiate checksum and segmentation parameters")
         ^
Looks like a tab sneaked in there.

> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
