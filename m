Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0644CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE69C206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561013125;
	bh=7B1t2Lh59wMHQUIE+uN8j8QjZZ9WGWxpnaWzK5i3AMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zGGPhB1tWfkpLW6k5dUfLDnahF2TynxyJNN4hfGrmMCpKWP6AuDjrsmJqL1QbhTU9
	 ty96Jm6Ct6stoFu1BkmqBqiFXOcEJZJ4Xj8zW4UiH8Bd038mphw78zSzUnA9eShezM
	 BCE1vyhN3tW4SagAvIK1eiQITsbvsxZ+KKcHknQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFTGpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfFTGpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:45:24 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9747E214AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561013122;
        bh=7B1t2Lh59wMHQUIE+uN8j8QjZZ9WGWxpnaWzK5i3AMg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ks+KzuBlz1+TXaILSP1LoVZbCmC7KmpfWi6RSi5ErY55ZuFOvOazwEiFhwYVzueFK
         Hg2KLZIrHkxsr8oE/X7jj2iJHgcSoU2KJ6cXG5atVyovMVjHbBPqPNajlgxQY8cnXw
         6/tseCRo8wlpCly3fXITnPqGlEDlnRZaiABZ5Gmg=
Received: by mail-lf1-f42.google.com with SMTP id y17so1595067lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 23:45:22 -0700 (PDT)
X-Gm-Message-State: APjAAAV5A7HDA/yAdjLBDw0kyA5Vu5yWpqWgVvRAEQkU8E1rp4zkg/ca
        dOCfwU6PSVPjgcQke6vEmmju3N8MTJI11rWq3i8=
X-Google-Smtp-Source: APXvYqzXMlEY/WRYRayoBb9QKi4Js4cCJqzNnoDhraKHkdb99GqSISyR2bUT9/dCId6OIt4j0w0nHyGdi/cre7W70aY=
X-Received: by 2002:a19:4f50:: with SMTP id a16mr3006815lfk.24.1561013120878;
 Wed, 19 Jun 2019 23:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190618185502.3839-1-krzk@kernel.org> <20190618185502.3839-2-krzk@kernel.org>
 <CAKGbVbvMVRiWXf8E8hpym_F7ovoXeeTc92-hh6hA6802487jOg@mail.gmail.com>
In-Reply-To: <CAKGbVbvMVRiWXf8E8hpym_F7ovoXeeTc92-hh6hA6802487jOg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 20 Jun 2019 08:45:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfnhHcTYiyj1yLD6QR6CzkGMZMY7cihUrc8yWNr4ZLzuw@mail.gmail.com>
Message-ID: <CAJKOXPfnhHcTYiyj1yLD6QR6CzkGMZMY7cihUrc8yWNr4ZLzuw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/lima: Reduce the amount of logs on deferred probe
To:     Qiang Yu <yuq825@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 at 02:55, Qiang Yu <yuq825@gmail.com> wrote:
>
> It looks like lima_clk_init will have the same problem if devm_clk_get
> returns -EPROBE_DEFER.

Indeed, although I did not experience it but it is valid point. I'll send v2.

Best regards,
Krzysztof
