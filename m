Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F266DC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CAA22543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563895954;
	bh=8JOyeEC1zTRyIsqC/PXugWUjwr/APz7sEZnATu2YyJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1sJnw8MjAcQ6twxpZOx5mbkInu3QwZvQAPdeneR+FWNv8Y61jqZCdnKJfuzmw06Xh
	 qRqYlrhUZKnssXikR5+Hs9nrDO1cPEEFxtZNvW04/0TSqMorpUyzvj9pLXDhbOeg6S
	 grio0GprpNK7SUZ+PHZeJJ0PoIOiOKKNMxaaI9kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfGWPce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfGWPcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:32:33 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30EC9227B7;
        Tue, 23 Jul 2019 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563895952;
        bh=8JOyeEC1zTRyIsqC/PXugWUjwr/APz7sEZnATu2YyJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sP3APy8eG7NLNOJcAtjsat+n0U+A76FGD91WwUGrbOXE0DyWCcMbzHxuOD0x1oVJW
         av3EmEpwzod0evwuCQ8DrqENnAYDiHSCpuX9H9pbX6yfwORvSyPgn5MzpfhNhJHdF3
         4DXkrdG50Caz25rF0/F7d4WzuOhz6hJ5YqOC2Z/g=
Received: by mail-lf1-f54.google.com with SMTP id 62so24790659lfa.8;
        Tue, 23 Jul 2019 08:32:32 -0700 (PDT)
X-Gm-Message-State: APjAAAVp1p1IB+JebWyBCzu2YwGgLl3wTLicg1hHixY6EjfJ/O62lAgZ
        6gBir5KCihZFG7h36gv8FH+zPFNK8yRbcTNze0s=
X-Google-Smtp-Source: APXvYqzOqlEdW228CqT7EvzrEoHFXs6Y3HU32V4M67K48CS0QmPYAt/PYW9cZBGXd1rWIk3F5U1PvLTxOdi0akEiPYo=
X-Received: by 2002:a19:48c5:: with SMTP id v188mr34818692lfa.69.1563895950429;
 Tue, 23 Jul 2019 08:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190722172618.4061-1-wsa+renesas@sang-engineering.com> <20190722172618.4061-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190722172618.4061-5-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jul 2019 17:32:19 +0200
X-Gmail-Original-Message-ID: <CAJKOXPctuy6j34gZ53xdUqVUwcVLWtm1pxUGSbUXQBoTkEKRUA@mail.gmail.com>
Message-ID: <CAJKOXPctuy6j34gZ53xdUqVUwcVLWtm1pxUGSbUXQBoTkEKRUA@mail.gmail.com>
Subject: Re: [PATCH 4/4] rtc: s5m: convert to i2c_new_dummy_device
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-rtc@vger.kernel.org
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
>  drivers/rtc/rtc-s5m.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
