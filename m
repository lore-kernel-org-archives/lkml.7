Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2225C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D77206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYsUPdWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfG3RMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:12:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45081 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfG3RMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:12:40 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so129837853ioc.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuAqgyT6yUGUSgvAqjMSwXgUBYtT9/ywKvmMd+QhrUc=;
        b=DYsUPdWeuQrPbbz9oLqVvUmGB+DaxrosWoXWRGuCdXj+qtefg3ZZspGjqhJTixu63l
         rkrIUmmRWFN399cgEvl/4HAUWOL8XRFBm8sulgIyl6opVRvEBVud8kS6Ru7IhTB8yFP/
         Y7fkABV2R0pcejAjxhiUnk55iWM07b6H6XPR7PloZWZUSuxfyoH09p1pH/fQY8UvI1L4
         NHG4JghhOEzWWouLO9eBzrWUG2OU0UtrbGMbxJBPzp20mMXyNrPo3my1rmD3Bi2zXLON
         vbmefLdM/DyIPZKkqV5y5TTN5/kG7wsOSiRADjHifnjunaB6ro+Ww1c3pbzTi/pWpj7I
         6iUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuAqgyT6yUGUSgvAqjMSwXgUBYtT9/ywKvmMd+QhrUc=;
        b=ovRbOFtR5UcRx943fVYVWoZyLP5T3+ogpU+orN5ZIDKamv3gvYqbvvkn2vRpwGk/sB
         fgXf2sYEMpcSh9Candjy257gR7TrNeeQXvda4YDvAGOMSgrt6xtNFPOh0WENc3hX50wI
         OcX2K6aoSdCqdc31lNT66zyTKcK391nEYJlGMfR9+2HuRJMkhycnlNv7obM+WIuNkLZF
         etqqT5H4trNDIZ9kLQ397RSZR2SmVNQteR5Mw9H92UuVRFtFMrkeWhKnkKXndINmyly/
         1hKscA9He5jPDTW5t2hcXnm4TbX9UtYH2hN7KJvftWzviinfm0gJLVRKcHF1pzijD3rc
         OtsA==
X-Gm-Message-State: APjAAAUPY+OW6SwlLlXddDvKZphGN8HUT5eYXiuhCcU52OqAAllOKaJP
        9bv7YNtctoGFune3GCE4wKhso3MM5WrkuIRVKGQXEQ==
X-Google-Smtp-Source: APXvYqy58T24UQZphReS7BNOZhjEUh5NvaXraVCRspRWDO98XJTHfekYk3nbBfMR4/vvpVuKc0QKQ4XDhBmtNHGd1K4=
X-Received: by 2002:a6b:2c96:: with SMTP id s144mr106481800ios.57.1564506759148;
 Tue, 30 Jul 2019 10:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190729170035.GB26214@xps15> <20190730093733.31861-1-suzuki.poulose@arm.com>
In-Reply-To: <20190730093733.31861-1-suzuki.poulose@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 30 Jul 2019 11:12:28 -0600
Message-ID: <CANLsYkxN+SqZwEueL06agr1ppASKsf94fsU9Mw0LwOK1qOwh5Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] [UPDATED] coresight: Convert pr_warn to dev_warn for
 obsolete bindings
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 at 03:37, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> We warn the users of obsolete bindings in the DT for coresight replicator
> and funnel drivers. However we use pr_warn_once() which doesn't give a clue
> about which device it is bound to. Let us use dev_warn_once() to give the
> context.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>
> Changes since previous version:
>  - Update replicator driver too.
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c     | 2 +-
>  drivers/hwtracing/coresight/coresight-replicator.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index fa97cb9ab4f9..84ca30f4e5ec 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -192,7 +192,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>
>         if (is_of_node(dev_fwnode(dev)) &&
>             of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
> -               pr_warn_once("Uses OBSOLETE CoreSight funnel binding\n");
> +               dev_warn_once(dev, "Uses OBSOLETE CoreSight funnel binding\n");
>
>         desc.name = coresight_alloc_device_name(&funnel_devs, dev);
>         if (!desc.name)
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index b7d6d59d56db..b29ba640eb25 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -184,7 +184,8 @@ static int replicator_probe(struct device *dev, struct resource *res)
>
>         if (is_of_node(dev_fwnode(dev)) &&
>             of_device_is_compatible(dev->of_node, "arm,coresight-replicator"))
> -               pr_warn_once("Uses OBSOLETE CoreSight replicator binding\n");
> +               dev_warn_once(dev,
> +                             "Uses OBSOLETE CoreSight replicator binding\n");

Applied - thanks
Mathieu

>
>         desc.name = coresight_alloc_device_name(&replicator_devs, dev);
>         if (!desc.name)
> --
> 2.21.0
>
