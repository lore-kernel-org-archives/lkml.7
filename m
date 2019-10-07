Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19781ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E506F206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKT9ySkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfJGRHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:07:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42795 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:07:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so20227618qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2K7rXlp5X/h8ftzby/KietV7LryoE7u4vg9KSTfQIbs=;
        b=CKT9ySkTfIiYroy6J96o8UPUxe9+acVcRANOXINUzq+2CkAZkvPJeGXo+CBDeO9dI0
         oddOFvsguco+H0TeBx3nmOp2HP5Rc3r7TdyB9Mt00WmgxI91B54LmDA7j+ZRXUfE62cY
         wvWoVdMCX6jS0MV+TAbmr6AEy4++UXAcPsnEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2K7rXlp5X/h8ftzby/KietV7LryoE7u4vg9KSTfQIbs=;
        b=Ts4cQuGolOhOvIQDfvPsWywgEsUffA1Ic9/2vKYqWAS0E7GYOXHHATfCeRggTkJNAr
         crRtrYd/ygk4U93od/DsPVshfSmK6aWNwXAtINTSOYZ7MMfWfIpp++Kp0hBfM7XU7t1j
         FfmsYkFIi1Ct9UqrfbKsiMk35gUZUxZc0uHwDaA1tSbC6UR8OGrjuc4Veok21bgbNOVQ
         BoTVCoSYfE2i3rIZBuNkX6Sw0Zb2hozonuB2hDF+Mk0isvVAivgLOiXkuR6jONlDbuM+
         xWpXcQLcF4Pm40HqkQvtZIKxBcVaV4190mXmx7Nvy3giSOEkms7lTqs5jihaPBRTJMS/
         4FdA==
X-Gm-Message-State: APjAAAXcPM1SNR35A2zLsw+87HS0uLV3jrQ/osM5I/bLFl25jBK0p2w1
        g6Fxwpd9nnA5pxyxCToIj6fe5wu/RxvLSMuoozg+xw==
X-Google-Smtp-Source: APXvYqyZ2JVdHT9qz9I8PsmKucNM8Is44BfBqxJCxK98WAy+0lfyTExVu/81vESxndFenTE4mepOqqFvEjRyGUIa0aY=
X-Received: by 2002:a0c:edc2:: with SMTP id i2mr27888828qvr.229.1570468068020;
 Mon, 07 Oct 2019 10:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190910075907.132200-1-hsinyi@chromium.org>
In-Reply-To: <20190910075907.132200-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 7 Oct 2019 10:07:22 -0700
Message-ID: <CAJMQK-jawP2+Ba0AkquqU16vVnq_yGJN=Bepk7kLRusp_zdq2A@mail.gmail.com>
Subject: Re: [PATCH] thermal-generic-adc: Silent error message for EPROBE_DEFER
To:     Eduardo Valentin <edubezval@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:59 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> If devm_iio_channel_get() or devm_thermal_zone_of_sensor_register()
> fail with EPROBE_DEFER, we shouldn't print an error message, as the
> device will be probed again later.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Ping on the thread. Any suggestion for this patch?
Thanks
