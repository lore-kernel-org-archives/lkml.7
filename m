Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901CBC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6342F20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO5rej+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgAIKXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:23:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40073 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgAIKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:23:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id u1so6621486ljk.7;
        Thu, 09 Jan 2020 02:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaANccIy4gA5baF7u0foL4cTjRF5faDrgsD1szRUw5E=;
        b=UO5rej+fgTEj4BzkweWqxr6L3b6qwha15PplzQPyrrBsMDip6EmUJnthyJBfGMiy1z
         2EbjLNjDWItj3igGmLr23dx+t1RNTHC2qDlQTsSqzLxkxDbvY0NFE9Vt2kXqc19a3Yj7
         v+5BTkYYRG3mc8/YuJVRs2AagJsLLhIMco3EOCntVOmHntAdVt/ka1jxq0utwtrcTQIA
         xTGWWLca7U+KMPfZcTIEloY57MCP0+Zpomk0nR+BeX6TuSZsUbyxXT+43mS1ACjM3hZw
         KUNlzmtG6OznoLTdlax16AqxaWT2kUGPtDkpm2SmGq7XKSWWAhwbkpm0uE6uPpBGbZ3W
         QWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaANccIy4gA5baF7u0foL4cTjRF5faDrgsD1szRUw5E=;
        b=jnuoDxslV4LL6qHTnYlSy211imIlUpG35MQ00oFDz2kQH0VlqzZK3UToebgbIf9ijY
         WqEGNoq9wN/msTFkacEi98mEMpf1VdVsLASAh7LPAwaLc0dBPwRPF+5mARB7WrGaP1Kz
         JPanzqHF2WweHn4I6yaaKP2XuANaam4IPynTYzA7dye6cEsmHcLZgEPFTlaqO9CbLHI7
         48EheTUndYC1OhHIyUns/uRRjAO5YRxoWKDkzL6aNjRorcQ30lCA7B8U6upScXN2YbiG
         HY6+VozoKHetppvaT4ukppnl27N4Z25815I+YRpEiJ8W7OaOiSwy32r9+iUiC2xk5FV7
         REGA==
X-Gm-Message-State: APjAAAXKYfZ8Swd9j4KzqttRyeRU76egQNpnISR/cedXzDT/yULropX3
        c8naMqzTcldRvO6M4uRw0/R7kdG8VczmcOP/vFQ=
X-Google-Smtp-Source: APXvYqwschtN+QMw6TDSpzE3jWTVQY0TbWx42jhGhs2ONEfm9f4uWmnz8gZ2X6CpDhrbkgbEDT4fKD4qTn+o/FJdvfk=
X-Received: by 2002:a2e:b5ac:: with SMTP id f12mr6292547ljn.0.1578565416928;
 Thu, 09 Jan 2020 02:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20200109095403.GA26453@Red>
In-Reply-To: <20200109095403.GA26453@Red>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 9 Jan 2020 07:23:25 -0300
Message-ID: <CAOMZO5DtOj8csUR+cWPy8D=78eGcC08H3vX4J4bcZ_O06h9ohA@mail.gmail.com>
Subject: Re: ata: sunxi: Regression due to 5253fe05bb47 ("phy: core: Add
 consumer device link support")
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>, mripard@kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On Thu, Jan 9, 2020 at 6:54 AM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> The problem was bisected to 5253fe05bb47a2402f471d76078b3dcc66442d6c ("phy: core: Add consumer device link support")
> Reverting this patch fix the problem

This problem has been fixed in linux-next 20200109.
