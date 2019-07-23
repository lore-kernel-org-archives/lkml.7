Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E0DC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E29227B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563895638;
	bh=9WN1euChLZIS5nZpn4AMQ7ghHpd6FynN6bvGc+MhFl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vr3hT7sfJMaFojwKp3JuTP5OzDbJA0PRDg4KYXeX2UX02REBri+vxH28UPaKOaoBt
	 7pO6lDNh+0ui4Zw8LiWSNonEqzH5k73zUKkjg1OzIlf/HsGhAZMIz7XO1KcsOyIezE
	 QhNvimwM32NFhXf/lDR6RouXF3mqDvrcy1dTSmZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbfGWP1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbfGWP1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:27:16 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DA6227B7;
        Tue, 23 Jul 2019 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563895635;
        bh=9WN1euChLZIS5nZpn4AMQ7ghHpd6FynN6bvGc+MhFl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1dQkd4BQHYUfmswOrSO9WT4+Hwd8bKZvxGJG3oyqsqxthHNiyLgCCqHLJW8zo6gOt
         9qv/hd1dOJ7HhTReScykyaQlE1aOzvdWJmoxuunVBj1iUZexkl6pJd1gfschYDo31O
         fFm9nMF9JfX6Dh0U1/rgnq2w7Lmd/K3tLjwpcafI=
Received: by mail-lj1-f180.google.com with SMTP id m23so41396530lje.12;
        Tue, 23 Jul 2019 08:27:14 -0700 (PDT)
X-Gm-Message-State: APjAAAUrdoNwh4YkCpqo1PSfUJnyqCpUSTsS5owNLE5ncShXjF3d+gkM
        vd09HuLu+zMnom1AqqEM1KnLdwas/VqQJW8Pw/Y=
X-Google-Smtp-Source: APXvYqz58d5i6M/HQ64+pNTNnkPQ90YEnqyBIHUL+geHE3CVj/AoFW26FG7W4EQpj/ik6yQJ2pZ1RbQl31nAD3d/0kw=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr39694281ljc.123.1563895632872;
 Tue, 23 Jul 2019 08:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190722172618.4061-1-wsa+renesas@sang-engineering.com> <20190722172618.4061-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190722172618.4061-3-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jul 2019 17:27:01 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcjEnrBiCD_cBDaeWcVqEDh4k8Lyx6cN=XCwuuytxK72w@mail.gmail.com>
Message-ID: <CAJKOXPcjEnrBiCD_cBDaeWcVqEDh4k8Lyx6cN=XCwuuytxK72w@mail.gmail.com>
Subject: Re: [PATCH 2/4] rtc: max77686: convert to i2c_new_dummy_device
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 at 19:26, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
>
>  drivers/rtc/rtc-max77686.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
