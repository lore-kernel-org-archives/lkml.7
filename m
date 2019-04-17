Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D59C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4608B206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL2qrRde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfDQSyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:54:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37005 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:54:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so12452714ply.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PX7mS7+UBf59qHB/nHuTZzULE7xDIIbAilGm8NaqjVo=;
        b=kL2qrRdeWDPx6JIfsrvWdMgH8TksMCy0D7xKP8taGoZDRRmlCf/ffXT6M5Jx4ciJMG
         hCLP8Sl7CSaNIaQdBmui5L862+OsUVGMALaL0PGP+GkI1L9PDl313GrPohijIXc7mebN
         vDezQoGVFn7R6tPiDycu7J4H7RyyfCayA0OVGijvM3KPTfmc0UcQC7kfBPoHh4vGsOFN
         gcR1QGwJsvmYzcQ0JEzupktAWgGH4EPrqgUCGMkgYRv2vI5lxlvZNH5TRPEJkyZCADv5
         cACOjO/cStadvy2zjT2U8YyKud9dykpOzpuW9jRbuHPOm9h0z/KOcVZdzUrfwltYrAPs
         qiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PX7mS7+UBf59qHB/nHuTZzULE7xDIIbAilGm8NaqjVo=;
        b=ee3embMFsJ46Ug5QZHRoRgIbd4JhEkRtF6ux4B7JkTbeiZ4j8OLDzFikHEIkS9rk3i
         BwlrJz3o2xaswWExmpRm/rLaRwti7CS+BrzMDmifnNcNHtF6/pU3kJDZ66OjwqM/1Zwy
         FOzNi4dawJARCUysiEX/VctzpSITVbAPiAu8qC7K6miJa3Mw69rieFxftjoE0p8OztZn
         OFusZ631PbmWySv+zmqNNtXbkjNnBuSEvauM13ZOo+ul8yqh+dTokupaLjPcAHmAnBt3
         BnQO8pYxUXvJOIgjjj+RFvU391JOPpZgjfOA4UPpb8QtjJBmPNjw56jchLexiR9405OU
         gD/A==
X-Gm-Message-State: APjAAAWrVtsQpxa6SZp/PfHwyhaVTEILEdFwxofLd7CSSfuDKXlRMqUZ
        Dl/PcuNZjrbwX9zkLJfkDUg=
X-Google-Smtp-Source: APXvYqwBXOYH6w0Xk5SOVwHBd7bc/8Bi3KAWJdHxHKFOJbD6fn5jYuCkf9maR83ouas8vkmeJmz1ww==
X-Received: by 2002:a17:902:9a0c:: with SMTP id v12mr63991196plp.184.1555527270706;
        Wed, 17 Apr 2019 11:54:30 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g10sm42380637pgq.54.2019.04.17.11.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:54:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] memory: brcmstb: dpfe: introduce DPFE API v3
Date:   Wed, 17 Apr 2019 11:54:28 -0700
Message-Id: <20190417185428.1352-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402230103.25491-7-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net> <20190402230103.25491-7-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 16:01:03 -0700, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Introduce code to handle DPFE API v3. We also change the driver to
> default to v3 by default and use API v2 only for select chips.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
