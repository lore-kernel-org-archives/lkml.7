Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870A520645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnu8P2jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfDJMO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:14:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40779 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfDJMO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:14:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id a28so1645106lfo.7;
        Wed, 10 Apr 2019 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ki6A3r9Nz0pMX8bgvM5FSU+hcyVOggm04GD+8XSOsls=;
        b=qnu8P2jD0kFBC+v/xK4beP1OqULlzLnnz3eRYxJ8T9v9zx2qYRR1Re+1C+Y+zncMfa
         4xzcds+R4s/ETFW907D6PddexmepgKMGr2euRiwgYBij+Wbm/oMw027LWeZhnJiLsJ06
         8Yq35pq2vIg59uUV8qJjAWMovzu9kpgrl+Xmk595Ir0T4s4KIRrnXymF9FYIfqHqm+f0
         cpudMcqfQ5RJVm9tbgkULZUhHsrjJqT99CA4idf9WEfjx2s2wLdxJ/ZcQsiRZbclVUXT
         MPGwI0AhOCJ/J6jKBtFZuqlTApPHTO/rHCe51Pf8VnXRjFRHkxoACc8Gk3Lmo861snNL
         t40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ki6A3r9Nz0pMX8bgvM5FSU+hcyVOggm04GD+8XSOsls=;
        b=WJ9rcYOiYLJrgO6qxPVFD+TmdUM1Gz4K3n3ScU2QKxZ7CyjJjS1/WewCqp2Ua2oUHL
         8Ri/lKdBIqkZu+wN4gNqNYjVGUijJPt3ZrEFk+xSsEMZbZws0NlTHAqDClURJY/3M/gK
         S9u3rEB9iRvrzstoezTTkkJIGXfxTrWx3nehoSaQm5NQhOnmyhm8hPeOf2oJw6dTwhRz
         YOYLP2jpfePENmxnon5Rl6UZ1EHioGOPlwK16lFgZ5kOFvSLLEO3M1KzGs50XHhnMJzc
         m7stcYeHuvP781egA0kw0hz4Pr0WO44zT0XjSga0J1gAHksXhJGgGXRbdiTrFs/uXs4R
         KGlg==
X-Gm-Message-State: APjAAAWcf9hQ0y5ZIl3Bjbz/Ws7fmjtQ7NAAscSfshLlDKPBSZZNGzVC
        q2VQnZFMwFvCC66+2PlcGiR/PvIc3FLk0sAv1hs=
X-Google-Smtp-Source: APXvYqxHzTQGftdYI9arntqzn4eBOFhZYy2jIcdsodOrTe4F1Agid7pNZzBX6ElrKXNbpXdpBCqNQ1ysnAhGON0OOdA=
X-Received: by 2002:a19:ca02:: with SMTP id a2mr23384074lfg.88.1554898466242;
 Wed, 10 Apr 2019 05:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <1554885748-51260-1-git-send-email-root@localhost.localdomain>
In-Reply-To: <1554885748-51260-1-git-send-email-root@localhost.localdomain>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 10 Apr 2019 09:14:20 -0300
Message-ID: <CAOMZO5AHTj+tGSs-1eO2D0-fqqWhh3t_UgeLm+4s==uQtw4QqA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6-solox: fix cpu hang BUG
To:     root <root@localhost.localdomain>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kay-Liu <liuk@cetca.net.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kay,

On Wed, Apr 10, 2019 at 5:43 AM root <root@localhost.localdomain> wrote:
>
> From: Kay-Liu <liuk@cetca.net.cn>
>
> The imx6-solox's enet clk config would cause CPU hang in a special
> environment.The BUG was accepted by yoctoproject, they will process
> platform related code,only submit dts part here.
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=13258
> Add support for it.

You did a very good job in describing the issue in the bugzilla report.

Please describe the issue and the proposed solution here in the commit log too.

It can be a summary of what you added in the bugzilla entry.

Thanks
