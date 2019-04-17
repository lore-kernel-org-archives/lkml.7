Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58F4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A291520663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRnHmouW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbfDQS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:56:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33601 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbfDQS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:56:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so12434996pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V8mHzhL8+k+I/acjoE0fKPjgB359nGNLS5xwb0yGhOI=;
        b=CRnHmouWX4tTJNVAtxP0DV1FrN7ddqqX9+bJCdtR/ABR9eL+flWy2KOGNMcRBrZF25
         tIYg2S8HtXMOfP2XfylxWEkcB8flrVBYTvlsWqAi/yN1RfvZVGCWAwk9iS9qcau0z1+b
         n4OwQaLcO//TLkEWMeUrCzJbx9gHjLMVkXTC+HklLuJW1nke9tFnRKbakAhSXoADo9MT
         q5gB6w6M9A1k+rPnAwq6TQ4YxbOKQhIoMSrrLHZ+3lUQe+Rpuyv0VEKWTGSQ+8yJ+N3c
         uLJFsspzcMb0kODGBkEm/wZnoDCQLIyzafQYQzWoZv3gKpYkymkWNgysBLs0kxpg3nZf
         TZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V8mHzhL8+k+I/acjoE0fKPjgB359nGNLS5xwb0yGhOI=;
        b=ODU7KhsXkrVVq8X+49YrSVbTztcauOlvjMrU7YkvALcCK3bDt+JEba1esIC8Ig7nUL
         CKcgCeRbEGjCgRpsvO5+HAgEmv7P+XKfIcLqe7kYxAlBDpv60JN4Oy1Adtm3c3uc1GB7
         xVZd0ql2AR+7ezPHx7qn8aZT7W6U53a/jWjZxsORPXDQjjj9x7+xZar3Hk81zZhx2lDH
         H2/pfzlFpqJR8+vJErpuzQF+4veBDG4ZnIpUsXpmY/SVRUprAwwIqTvyBWtRNOBjBOCX
         uq+8jlsSvesRQ37Y4b5lpyqKsfrIxq0dcMEX9D7W3uVvAok6cqdvluUylxL/ThTSDs3C
         DUkg==
X-Gm-Message-State: APjAAAV7lVcUfFiBIj+ApPxHhrTHBmFVDkM7OOcU0GVXkg/soWWJ4Iw1
        aKw8QjaX+u1PTeuj62A2Ad8=
X-Google-Smtp-Source: APXvYqzYsEAYtNe4WJMuFY46A4lTyk8zZCRqzXgCvT6/xBteLRySowyfAzmb8XOPzFmfAotbEC11eg==
X-Received: by 2002:a63:f44:: with SMTP id 4mr80074131pgp.324.1555527370066;
        Wed, 17 Apr 2019 11:56:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i3sm80072082pfa.90.2019.04.17.11.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:56:09 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: brcmstb: Fix error path for unsupported CPUs
Date:   Wed, 17 Apr 2019 11:56:08 -0700
Message-Id: <20190417185608.1774-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190407211910.8744-1-f.fainelli@gmail.com>
References: <20190407211910.8744-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Apr 2019 14:19:07 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> In case setup_hifcpubiuctrl_regs() returns an error, because of e.g:
> an unsupported CPU type, just catch that error and return instead of
> blindly continuing with the initialization. This fixes a NULL pointer
> de-reference with the code continuing without having a proper array of
> registers to use.
> 
> Fixes: 22f7a9116eba ("soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/fixes, thanks!
--
Florian
