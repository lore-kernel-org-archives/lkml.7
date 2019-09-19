Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F10BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2911821928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568912025;
	bh=FFjfzYLjbs6xiYqzb5TUJVAKnXU4IQmkmRJVbwHd9kQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MSa2TXeabD/tvtm+JgGdHVbJVjEoIQ7GKCiyAUxEtXCGMy3nhNJV6AjhBtGZFkIBJ
	 KdAegDnq+QlrWc1/sEn7/E+OOgPGPS6Pl1+L+wTd2893dooYQ5Q+Bm7TMq8XmTo8kS
	 kmjqVe1DHDDTcASLYov7uNtCsFT79AXGMHxTXooQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391848AbfISQxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfISQxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:53:44 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C93F21929
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568912023;
        bh=FFjfzYLjbs6xiYqzb5TUJVAKnXU4IQmkmRJVbwHd9kQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X5FHl49n9rz4MbQ8i9Mta4NQgCpNcRFFwra4mQrtdHclDL/kI0RmP2Xyy1nbN5STk
         sZPVsme46Ws+NDePKeKaEq/reeT7D2S9MuY0ZtpQ/MlxfqBc6zmBNSQhqY8s30GNAg
         G26st+c838VrD7na2hPqx9AXs1/KUJ4zc7Y05RBU=
Received: by mail-qk1-f172.google.com with SMTP id p10so4076006qkg.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 09:53:43 -0700 (PDT)
X-Gm-Message-State: APjAAAX/qumDoQXlI01apV9MhI+VjiS+CZ2OH1XxHUWpU3UpfsCgst/N
        Rx89+X39UUY4id/IjlbwyEK+5GllYGdQ80YOqw==
X-Google-Smtp-Source: APXvYqz2I7+d2ST7dqTncIUVd79T+TgL3EwsoQ408VFi3nroSJ0HjZZSQ1StT9xLMNL7INlnAComuhodW8LklS4qtxU=
X-Received: by 2002:a05:620a:549:: with SMTP id o9mr4018717qko.223.1568912022261;
 Thu, 19 Sep 2019 09:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190913160310.50444-1-steven.price@arm.com>
In-Reply-To: <20190913160310.50444-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Sep 2019 11:53:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKnyGpU-W1s-LbwPh6huLxWeW4-onD91fknUe0DO3DwdA@mail.gmail.com>
Message-ID: <CAL_JsqKnyGpU-W1s-LbwPh6huLxWeW4-onD91fknUe0DO3DwdA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panfrost: Prevent race when handling page fault
To:     Steven Price <steven.price@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:03 AM Steven Price <steven.price@arm.com> wrote:
>
> When handling a GPU page fault addr_to_drm_mm_node() is used to
> translate the GPU address to a buffer object. However it is possible for
> the buffer object to be freed after the function has returned resulting
> in a use-after-free of the BO.
>
> Change addr_to_drm_mm_node to return the panfrost_gem_object with an
> extra reference on it, preventing the BO from being freed until after
> the page fault has been handled.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v1:
>  * Hold the mm_lock around drm_mm_for_each_node()
>
> I've also posted a new IGT test for this:
> https://patchwork.freedesktop.org/patch/330513/
>
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 55 ++++++++++++++++---------
>  1 file changed, 36 insertions(+), 19 deletions(-)

Applied.

Rob
