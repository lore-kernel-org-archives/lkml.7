Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86D1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A796C20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeDh4e7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfC0E3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:29:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42307 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfC0E3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:29:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so9089174pfn.9;
        Tue, 26 Mar 2019 21:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrvJ3xMvsiZnf0Lfns893kkIojZF//oKOK67yhkS58g=;
        b=CeDh4e7X9wWgvFHKhUQPnHPsjXkVYLO6EpBA7apVIwpjEu+wWXkzUOyFs3dualgR9j
         4ogshP0pTMgNy9PDJTS5cRwa0BmGtGdl7Zs4fJTPW5Wu6R9Zd5zTmVXJsxbFj+2o9Txn
         eFKBhbmECcCLCOteTB9AiIqbqVXLEDsm+biZANua5hG/C6aA78FKfAKghHEotRDK6yw6
         Hz4g88IemZZu1Wk8vsRgX3Q5U+RKSyWy2lYjF5HyAcLdNIx5vmrcHIWCeOOu6b1AKpCd
         jw0DeSxE1tpTm2v30+XH9MCgYD1OamrFRAMH+pXqCKUZYio5k8CjiyRHsTYYKao4VtPh
         ayXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrvJ3xMvsiZnf0Lfns893kkIojZF//oKOK67yhkS58g=;
        b=aE09u+etAV2AYMljLqGAkyB3BXffIM9GfG7kMoljLaK74Jkbqvx+nNK/7+eQ4YIgvv
         VtoW9rmhmXCEs/+NVhoAJppZ6T/EhcPU2z35tN7xgeTrs+FtRXpRaujzA5XLxJ92d+bE
         U+lV6/hKQ8XZtrJWZvbkbCAtNoeCVt/vfifo2JgqBsL2ik4nJzPh3Hi5QYKZDhhvo7BV
         JfHRJeb+I5lAtxWEyOJ7/XSnnAiP/M64Wtaes7sorl/WTa+ksmeyohmFNQ/nYkHC5iuH
         Xi6fUzBUOh/Qvxcp9RwUJYV7caRXToa4rJ4K1hIN0mML5MQ/RtSxXAExdpPgPadF2UXj
         s8Og==
X-Gm-Message-State: APjAAAUdp2wbCEqJtP5thnQ7vB+4E0eBJo9735r9i1fmTfsQZjnJWThX
        so36Vkw6MmAtunNTkFwwSpjHMY5U
X-Google-Smtp-Source: APXvYqyttwiH2mX/wVe99xa/hmXqRhkAPrluoww62aEubiEQY7/r/ALKPUieDAoIuD++k5bkan652Q==
X-Received: by 2002:a62:4746:: with SMTP id u67mr33191357pfa.243.1553660984934;
        Tue, 26 Mar 2019 21:29:44 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id j13sm26353724pfh.32.2019.03.26.21.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 21:29:44 -0700 (PDT)
Date:   Tue, 26 Mar 2019 21:29:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     KT Liao <kt.liao@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: elan_i2c - Add many hardware ID for lenovo laptop
Message-ID: <20190327042942.GB40550@dtor-ws>
References: <1552479463-3686-1-git-send-email-kt.liao@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552479463-3686-1-git-send-email-kt.liao@emc.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 08:17:43PM +0800, KT Liao wrote:
> There are many Lenovo laptop which need elan_i2c support.
> Elan collects the list ands add to add to elan_acpi_id[]
> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>

Applied, thank you.

-- 
Dmitry
