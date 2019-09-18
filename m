Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B0FC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA6B22490
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fVyFu7iC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfIRTle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:41:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39719 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbfIRTle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:41:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so539465lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUtNy6zmsY/nY12iTbVrTLFA5neR54fGcg9sdDNwfEY=;
        b=fVyFu7iCUvOtyuHv+Xj2YthhNrZOr4I5cNqzFjMxLMOPNrE71+G8H1jVo9wOMKgtTc
         TNIIlFcXqPJtyGWq7EIhgQ/QTvke2Pgso2evo8wAVJRrFT99b162lg4tZoUwvjLXnxF5
         bBF15QD8KKnIOevl3afUFS9klNlHkQ2aatRIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUtNy6zmsY/nY12iTbVrTLFA5neR54fGcg9sdDNwfEY=;
        b=FtvXVRV9DMSEM65QOt9NY7buM5LH1d/582UlT44p4QAaCi6O1AwZUzY+zi8jAl3u8a
         O48EBqkpGWdXn+navHVc61TArYBnqW36IMfxm2HgPbxbD8/L/WnFEWKPaF5sKffYPh7S
         qD54fkl8bv8Mj4lmHUVv7S91CX+YJ8q2SfoZ9rlAjLjPH1gWwjnyavejZA3fGQdvEoG2
         uvGqxrGqdBTEOdGsxdWxtRzyDn+jZCe0bRb4jH6Qzve2Nl5E+PjIENzKmM+DhSPy4jYz
         6qKZV786/PChQMrdzRiHkD28xMVfNmjwoAlHiL4SMao++oR/aLlelYY52mX0L6HHhQJZ
         6COA==
X-Gm-Message-State: APjAAAX+06nVgh/GS0zc+i53gQjwxITrYfyneyqA/EacBzEuJbRrM4BA
        sSfvf0Pk6O2Jt+gmJ6axu4BnqOKQA2w=
X-Google-Smtp-Source: APXvYqyTuFJXDZkDpI6rFgqONh5loE9bQJrwPofYLOI6mtGtOUcaiBhHL6tDN1j57ftjbgLt31afKg==
X-Received: by 2002:a19:8c1d:: with SMTP id o29mr3020497lfd.73.1568835690626;
        Wed, 18 Sep 2019 12:41:30 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id e29sm1177199ljb.105.2019.09.18.12.41.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:41:29 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s19so1132116lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:41:28 -0700 (PDT)
X-Received: by 2002:a2e:9881:: with SMTP id b1mr3145788ljj.134.1568835688462;
 Wed, 18 Sep 2019 12:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190910160903.65694-1-swboyd@chromium.org> <20190910160903.65694-6-swboyd@chromium.org>
In-Reply-To: <20190910160903.65694-6-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 18 Sep 2019 12:40:52 -0700
X-Gmail-Original-Message-ID: <CAE=gft6=4m79QX8Bca9izRUUkumio_YKBNY8aY=XPjj=WE_BYA@mail.gmail.com>
Message-ID: <CAE=gft6=4m79QX8Bca9izRUUkumio_YKBNY8aY=XPjj=WE_BYA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] soc: qcom: cmd-db: Map with read-only mappings
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 9:09 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The command DB is read-only already to the kernel because everything is
> const marked once we map it. Let's go one step further and try to map
> the memory as read-only in the page tables. This should make it harder
> for random code to corrupt the database and change the contents.
>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/cmd-db.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index 10a34d26b753..6365e8260282 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -240,7 +240,8 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
>  {
>         int ret = 0;
>
> -       cmd_db_header = devm_memremap_reserved_mem(&pdev->dev, MEMREMAP_WB);
> +       cmd_db_header = devm_memremap_reserved_mem(&pdev->dev,
> +                                                  MEMREMAP_RO | MEMREMAP_WB);

It seems weird to have both flags, like: "It's read-only, but if it
ever did get written to somehow, make it writeback".

>         if (IS_ERR(cmd_db_header)) {
>                 ret = PTR_ERR(cmd_db_header);
>                 cmd_db_header = NULL;
> --
> Sent by a computer through tubes
>
