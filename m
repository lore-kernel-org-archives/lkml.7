Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEB4C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2518F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5XF2mgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfILJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:26:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35309 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbfILJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:26:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so18781677lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nf9tEQrY91aUt4IWPBnEd1O7PNd6a6XOY7RZBD/1LbQ=;
        b=k5XF2mgKP8GYjwNfK/5U5szRWBPjZNDLYgASzMw5o3uofn/U8S0NJenUp6wFl4McNB
         jLfpivXXX3rnuN5W9xZ9jLSzyogf5fWgrKHLJJmx+6Vgw3id0iknV+lD0Zd3psjrJa4N
         T88g2SjCbXohaqrcwHB+7GaIVWPp68a5AYDx98Ey9h77jU2b4idFGKwt4lqRdc15/dLz
         O410hzzzlDk/cGueXK+SZIr4FcKz1dQXCX1TL44uEM3V8UKif4MRzmGE/+v788Swu3Ly
         cb86JnWISFvqt628n9DGDYkr3N9uLnqNqjLGyDen10U4Gnx4s7z1D7JwVvZxIIb2NsBL
         DXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nf9tEQrY91aUt4IWPBnEd1O7PNd6a6XOY7RZBD/1LbQ=;
        b=Yx53qBppZMRBHedjEsuvX4WdDbHm3Bk1xeO5drfFQ6hqesHF74BqZ2DMpE5zm2aKxs
         1UQ1MiWp7bI1nOSR987J1wLoxfXLoMN2A/cFHXknm8H6zGDvSZ7SxjeO0jg7SQUCA6iR
         QHtxKPfupMCYuo8FW5FqlT4A2EdvThvlBibLvHdS8WYzATIDKDhs45xWHabPyXocgTg5
         ZKjB7Q94RXECM95UzcByxLx5P5v683JlhNoBjzY6MGEyIYBNTtwnWho8dwK8nwHRiyB/
         1VGwCRHJp3n54ttBe7kG+keAlAlqciDEnIrAWlC3X/fyngNTKtHrR+kubbAtqNtLkMLC
         CBSA==
X-Gm-Message-State: APjAAAU1kRreeNwNgMS/LeDdjM+Nr/hT1Y0cxetf3a0F6c2XYXiiXpRB
        Oxsw7F5ORiRp4eMJCWi2CpCVtIdD3CIOEu5pyL7Xjg==
X-Google-Smtp-Source: APXvYqwFFq2fXxLxD1qvNzknrji54/UB+pi5FNhxEBi7CEgsrvRh/0Tsh9xZnMTvI1zRZ6w+mhNzwkXzCRxF7bX0h9U=
X-Received: by 2002:a19:117:: with SMTP id 23mr27456270lfb.115.1568280386680;
 Thu, 12 Sep 2019 02:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190911204853.7e6aad26@canb.auug.org.au>
In-Reply-To: <20190911204853.7e6aad26@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:26:15 +0100
Message-ID: <CACRpkdYBtX09nJhwLHSF5-MMpTO6gc3i_QtanWrS4DBgppvY2g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 11:48 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>   cc3abdb73df4 ("pinctrl: iproc: Add 'get_direction' support")
>
> is missing a Signed-off-by from its committer.

Thanks, fixed it up!

Yours,
Linus Walleij
