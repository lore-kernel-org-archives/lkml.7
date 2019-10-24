Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2911420856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392439AbfJXDvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:51:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38053 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390377AbfJXDvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:51:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id y8so5190299edu.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 20:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqY8MkrFlRuB64lQselPYGZKvMHD/g09EyqNLXd31OI=;
        b=tW5tO2aI0Wm8eYh5okwLDaEw5rqNRh8KOMa0tuSTIf25LnKze+O/ZZPORvSnvc6xvS
         dHGH532/QLE8jUR94nquPNBpEzbovgiQ8CyfB6nSkgSi7qpbPjXv8yurs0leivhLq/yW
         KekOqqO6d9zOyrwKXQ36vqvEPVN9ZHpU2kjKLShbyJRGzZ/z7ZsaUutTN/lEfJ0c4OyO
         PMFgymzvk6cmLBnjLHqJjKKsYiUmBKxExVHQVPY0Ggr/82IU8NWcyG7en1gCWxJdYpy9
         BRU8QmV7tgQHTyLmUJDikhoBdPk30+04GPv0BIQPPsxb6hjNPSyINK0qo5Ivkl7FfR6c
         uK8Q==
X-Gm-Message-State: APjAAAX9SZ4qogNlRFVlQsUvbxHP5JDfzF0JWBona24A+wGX72/vly+0
        FfbLTj37o4Z05bW0TNyHjGxSxHdP/so=
X-Google-Smtp-Source: APXvYqy2Aos7VKYJac5NrpRMhQy3juy70DcxEtrhke9nMbsQwZw6Fu4Gw5JnWXjDiFHWcj9K2lmpUw==
X-Received: by 2002:a50:af45:: with SMTP id g63mr40404898edd.21.1571889082665;
        Wed, 23 Oct 2019 20:51:22 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id b22sm56795ejq.87.2019.10.23.20.51.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:51:22 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id q130so827055wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 20:51:22 -0700 (PDT)
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr2815314wmb.125.1571889081917;
 Wed, 23 Oct 2019 20:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191023120925.30668-1-tomeu.vizoso@collabora.com> <20191023122157.32067-1-tomeu.vizoso@collabora.com>
In-Reply-To: <20191023122157.32067-1-tomeu.vizoso@collabora.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 24 Oct 2019 11:51:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v675oCOr6JR6CXB28hrUuwBN2M9C9SS6UPNpbEAfw9ztjA@mail.gmail.com>
Message-ID: <CAGb2v675oCOr6JR6CXB28hrUuwBN2M9C9SS6UPNpbEAfw9ztjA@mail.gmail.com>
Subject: Re: [PATCH v2] panfrost: Properly undo pm_runtime_enable when
 deferring a probe
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 8:22 PM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> When deferring the probe because of a missing regulator, we were calling
> pm_runtime_disable even if pm_runtime_enable wasn't called.
>
> Move the call to pm_runtime_disable to the right place.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reported-by: Chen-Yu Tsai <wens@csie.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: f4a3c6a44b35 ("drm/panfrost: Disable PM on probe failure")

Tested-by: Chen-Yu Tsai <wens@csie.org>
