Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EA8C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBEB21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucPR/0qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfGENS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:18:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42461 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbfGENS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:18:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so9010400otn.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzoXo3/htFR31LA8s3Fj/XgdNRyw0c3OLiqfSUlNP70=;
        b=ucPR/0quxKGLxIUb9Fysde/5/WskQOU1F7/mjtGZ3gpanKQW8COcu7UBrVGoJr1jPa
         IO41prY3nvOiDU2Y9rIHe2xtUipl4sR2OfvQNFp7V3xnRT4WBsFfFKQyv1rjmgDLiT9d
         IdHgdL0EhF+0uV3DKuO84sFyoFFg9zH3yNe9yI9MdHCl/cQpwF8Hc8DL9HFMle0F34xD
         TfkuxKGJ9pnOdqxjVQ83heK+wKEyI2Nwrv/bAgRLZJ5lJg2O0bjCbm23g+1ysHzS/DQ4
         eE03+ELaSa4dylEDoSSXeKtD9S6nDBl6JFst3lPJSf3Yfm4BUdjYpk/cJZTiz1oOhUCG
         VeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzoXo3/htFR31LA8s3Fj/XgdNRyw0c3OLiqfSUlNP70=;
        b=Ehc43Bjzh0VvbaajUHo4y7Rvt+bSsWkVyg9fBvHhqehQiecKZTnP/z7oTv7pV1WVmu
         KTa68M2v79s4lA9V+4+W6JJApWdCGY8RzSSY9W9rLhc/9Ko47RRbhFXfmmZ/8tEvDE04
         PIo4kndlYru8O/Ab3BRzLGz5jQjs2xxtjJnzL5Og+6jj95ozeLaXW+DUSRq3zKBckOeQ
         HOydYSfDEbwJOTeMEZ0gyBiivbITF290IGfr8tP/GJFySNR86RFSXxZPk3pdEuW3JCHW
         13AHBX5tvShR+YtMfMAVsYlGQtrcn1PkvymPyVPkvy1wrVcmYKyXiv5HoQhd9zBr2GrP
         Yy1A==
X-Gm-Message-State: APjAAAUYdgfLpPG69jXK8jx3sL1R5aMllVOAETUfyJYqr+QRuWVSI15O
        nqyCDGZPOvI1yt09CWaPmpFMei+9Xk/+3rM1TTE=
X-Google-Smtp-Source: APXvYqxFkYTLtJ5jfERlyBEPVUyKkNbQC9gBFh5BnS2AudwX6DCwCumL1SMCveo3Ef87ZvF5C3kVRU1B+91dGKp+K2E=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr2936371otq.224.1562332706828;
 Fri, 05 Jul 2019 06:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
 <20190624140731.24080-1-TheSven73@gmail.com> <20190705124646.GD2911@vkoul-mobl>
 <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com> <20190705131049.GF2911@vkoul-mobl>
In-Reply-To: <20190705131049.GF2911@vkoul-mobl>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 5 Jul 2019 09:18:15 -0400
Message-ID: <CAGngYiWrKSaNHMjh6n8Aoy7VfUVe3p9469YcL9hB0FZXwZLzLw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error path
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 9:13 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> To quote David you need to move to 21st century (like me).

So true :)

Your MAINTAINERS entry in linux-next is still pointing to
infradead, though. But that's becoming less and less useful,
now that most developers are moving to kernel.org ...
