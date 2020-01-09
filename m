Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E4FC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504C6206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578595967;
	bh=iyhFb8CJpMhAQJCPvsTBfaummWzvOj+1/eyJdoHvFMk=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=f8NW8Ls+f80RO31BnBVqaSxmocQGgOoNGROyS8g7oaGmVwgb3FRKp/M7GgFTuMb2Q
	 2sndC+Mo9Z6oaqFwp8B3FknraSCXskUZBBJWFiPggMHnlJ+GWsn0ICdwzd9YkPcrRU
	 a7sDAKP5NMCAD/42Li+G5PBj9r5ng2YuVXkBYs3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbgAISwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:52:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45909 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgAISwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:52:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so2894214pls.12;
        Thu, 09 Jan 2020 10:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=YWCYqfZo+yiUkXEJo0FwY+2Q6KdpmhtF8II1qMD3w5k=;
        b=Jjec1r/CNMFUJJBCh/m+XRtesB//lnxJMAppyekeVHlqP15NEgMcWSfU6FW/5GKoq3
         XuxD4ZmWF05Ndpxedx/vI8crpQ7njgmTcGk5b6RiVxDXrKKoFcVqN/DSlo3lq7kKP0up
         MCXaXlHpIXcAD8z5w5HjMHIXSlCEysajan2+31yHBGLam7vCPmCJwD+vILqBSqmpDfUU
         xaaKMgTAD3TeJNAp9kTzxUQTRNAroRSRIkM78M4/URkqteEWLJ2DwH0ASH5IXkSesRkH
         INIHLUSOFeTa57+WCzXPFl7en6xlHRsY72FPwJ/YG9mi4uzIN9Psd+TEJZo8MxlUjKex
         qmmw==
X-Gm-Message-State: APjAAAVW0Tvt/pZUcq/MEgMPPjB4nMucjDgeYhJCrNEZ7K5KyPNtpYXu
        a3lF7hKlXNa2KDD9qaG2S2c=
X-Google-Smtp-Source: APXvYqz6kbCFqPQv6OI01HzXEx4Gr4e/6HdE7v2525bi/NrdaFFVZt+RBN40AxIDTK7riYxMzQlI+A==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr13212653plt.221.1578595965270;
        Thu, 09 Jan 2020 10:52:45 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id n26sm8757397pgd.46.2020.01.09.10.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 10:52:44 -0800 (PST)
Message-ID: <5e17767c.1c69fb81.a8827.4647@mx.google.com>
Date:   Thu, 09 Jan 2020 10:52:44 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     yu kuai <yukuai3@huawei.com>
CC:     <john@phrozen.org>, <ralf@linux-mips.org>, <paulburton@kernel.org>,
        <jhogan@kernel.org>
CC:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: add missing put_device in ill_acc_of_setup
References:  <20191225131520.2505-1-yukuai3@huawei.com>
In-Reply-To:  <20191225131520.2505-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

yu kuai wrote:
> If of_find_device_by_node return 0 and ill_acc_of_setup return error,
> pdev don't have a corresponding object release.
> 
> Fix it by adding put_device.

Applied to mips-next.

> commit defed0bbca2c
> https://git.kernel.org/mips/c/defed0bbca2c
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
