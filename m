Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB6ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F772070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne2oqzo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfJGPMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:12:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36297 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJGPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:12:34 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so29352771iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTNIlZe+EdZVGG81HeluEl5PY/3Uq8GfkNMqYYi6lVs=;
        b=Ne2oqzo3lM0h47eqjURdWmhmFSIBlEB3GBusCr3D8jHo6sLs1I7/m08oy+dzdA9/XS
         GWAe6rzF0lRZzxQLtZVaclX201QJOmnoXZszZXVvjpbTPD3G8O6olD0JGOx2MmhFMBhG
         GM9yPR0GbuBRHZCOozmrCcPvc6pCyc94A+VoFDbX1YRuiv031Jq8lktRhx76GQviLcEX
         IZna8p8GV54/VTQruw81XGihL45w0EaxvZo05/nn1QRRW6LgR9n+fEOMr9NSe4+P+IZl
         8XThJi1bYsa3IfwWQOXhaqq9WOMQWuldyVZPlasMst5S3vRSlPQ1i9pb7ZNH4NYW9FyO
         zZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTNIlZe+EdZVGG81HeluEl5PY/3Uq8GfkNMqYYi6lVs=;
        b=uU30R8nDsOu7jpu6iZWw2lelSF/uZmjz5Z4fSUo3w9p0KdXp/Cv5d4xzyMqzfBfTU2
         IqlKCPTUlkn1FPJlsDvmIJfodX6inx5p24fDMBvmjgCNN4huaJNDNj4ARineauXjJTrw
         IqeE5XqfkD8U0dlsP97pDQi1NiiD3xrugFL8LLI2jLPedHPcOUJ9GHRptTjw8r3NljUI
         9/jiGZcRzA7KIrJ0WHzQi56rVq2xvlVsH/s6Aw/epxsHSRkaTymmou3zWAO4k5G/N7Nm
         jQy2+ECw9WVOLJmpjpFJ7exy6neAS09bO/BBxHyYdbYRzeeUhutueL7ZB9ZXFBiRhWOD
         HiQQ==
X-Gm-Message-State: APjAAAXMPicsgsKkmXd9UBIQquI3S2ej5IYEQMcw5Ddg/P8QAyM+ML5K
        guYTsDBTKrtpbglhTwepkXABrtP7jHzVbM8VB6cR5A==
X-Google-Smtp-Source: APXvYqwjVvEIBF1oeHfIZ9hknNqCBGyZJX1ke0y4rqi7/ogm/ZY1CcjP6dK75kC/nVARrTJwndeMA/LIkiwi3HstniI=
X-Received: by 2002:a92:ce48:: with SMTP id a8mr28074054ilr.281.1570461153887;
 Mon, 07 Oct 2019 08:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191003191354.GA4481@Serenity> <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
 <20191006192109.GA9983@keith-busch>
In-Reply-To: <20191006192109.GA9983@keith-busch>
From:   Tyler Ramer <tyaramer@gmail.com>
Date:   Mon, 7 Oct 2019 11:13:12 -0400
Message-ID: <CAKcoMVCDk+VDk6PSznTzMfJsjhZMdo6wBKZLzNbjDCkg73-WEw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Setting the shutdown to true is
> usually just to get the queues flushed, but the nvme_kill_queues() that
> we call accomplishes the same thing.

The intention of this patch was to clean up another location where
nvme_dev_disable()
is called with shutdown == false, but the device is being removed due
to a failure
condition, so it should be shutdown.

Perhaps though, given nvme_kill_queues() provides a subset of the
functionality of
nvme_dev_disable() with shutdown == true, we can just use
nvme_dev_disable() and
remove nvme_kill_queues()?

This will make nvme_remove_dead_ctrl() more in line with nvme_remove(),
nvme_shutdown(), etc.

- Tyler
