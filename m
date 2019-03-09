Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37274C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0036C207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpQj26Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfCIWDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:03:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41635 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCIWDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 17:03:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id d25so787697pfn.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 14:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SlDMbagQcGDNc2igxBfQt50QWoGD2RbgPl1lrtEBvtE=;
        b=OpQj26NkOwQBRi+aqBpsK/L3dySu6SUOXji4oeC2g7QCZvjvEdz6xc/8lwQbjMoxQV
         ExqwX2zJ18hjG1eBpFelvMzx6PgJYeWXGutaCuv/QFxKlec41Xye7LCefLxD9s4RbbAj
         RWk/IVrsKoLdqlk9TT/fDIega559H9mvJKM9Q+dP+p8O8m9hpZtxbR0Zpo0eLcRsQWnp
         EBctzu3tpTlOXs0/Pn/bzGVA94HN6/Ie/aIOPxuBVd/KbLoFV5JGS9et+8yaBnjbsNNZ
         uzK51MuZEQpCfgKqxzGiUaS/r+Qr63qPBhyYrdr86gz+pxk4/cmXg4jG10yIKB5iasZX
         ok4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SlDMbagQcGDNc2igxBfQt50QWoGD2RbgPl1lrtEBvtE=;
        b=LJCirAgoGqD6WJqbWryKa1tm5IzZYBSVY/4vE6UYivL3jOnAsdkvEALSlPu0Rs6/r8
         ukSW4J6+ON4jLdRkyZTdPNda1TRHjZZ11ylq2ot+VMxA0brpQkbLIfobEg8HMre6mIhz
         Bo7MsxMfAdsJf5tRBZV+gLjScBcOnQAx3zZFMPC4LyUtyla8XnNymyqBFK9Y8F3qdXHi
         0iRQxjVKRIBNHyPs8nggawkEneiWcVqG2Uk32g0RxiekqHSVQf7CuoMQyPuq5GEJOjPc
         vXSrP+QSmvokz/0CFEqE/Q6ly7WcEzsr50SyXtnoNguKntxMeqDDspvPakknjqMsbCKP
         BYPg==
X-Gm-Message-State: APjAAAUXmaAH8tL9tmXhMzYI63hLdwze1nhEJ7JN5dtsd9R7j1opgJmL
        5wZ0WyPtexS1UhbC+onkmwVgsX1l
X-Google-Smtp-Source: APXvYqyaM9GMo3h0yZDd2NhazNzD1p8H9bNv2TxYkkD7MMubTQru0K+pcsj24DYc13gM0Nrv0hXDvA==
X-Received: by 2002:a63:6e8d:: with SMTP id j135mr23161539pgc.160.1552169014119;
        Sat, 09 Mar 2019 14:03:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e5sm2134255pfd.73.2019.03.09.14.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 14:03:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] soc: brcmstb: dpfe: use byte 3 of registers MR4-MR8
Date:   Sat,  9 Mar 2019 14:03:32 -0800
Message-Id: <20190309220332.26100-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212012443.21819-4-code@mmayer.net>
References: <20190212012443.21819-1-code@mmayer.net> <20190212012443.21819-4-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 17:24:43 -0800, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> For dual-rank LPDDR4, result data for any command is placed in byte 0
> and byte 3 of the corresponding MR register by the firmware.
> Single-rank RAM was supposed to work the same way. However, due to a
> firmware bug, result values are only placed in byte 3 of the
> corresponding MR register.
> 
> Since byte 3 works for single-rank and dual-rank setups, we change the
> Linux driver to always use byte 3, thus returning the correct value in
> either case.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
