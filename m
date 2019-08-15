Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67C4C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF5520656
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="SFv3m91M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfHOOuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:50:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41156 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbfHOOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:50:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id m24so2452173ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYT2OSHdO2DhGI1fwQFHGoFCd1oy7Hq2Yne9sDtdOm8=;
        b=SFv3m91M3bw6JeMwDStZK9fHM0zPXfPmHV+zj7XOFgng2BkLQhXyTBN+CDlDyE3tE+
         pJYRl0W5IoisMmUL3u7KLavEtBV8WbsayMKI2Ndj7PpuPn1m/sYhPMWdV3hvRDwf7U2d
         W2r62kWw8X9sgxRVC+sHMOJrk2mP8bbSHWARbLYevcM4vkV/a9IZuCwt9svHaU72eNYg
         f37aWSotRPlDW6ZHMaPfJWofSRQCKFiPXOs3wTJ2ZGvu35ErDBW5VN69RYP5Ke8IbTHb
         ihrcejBWCucjoAABUL2XgxJ8VCzXm6zX+46m1qzRBmD10PQ0H9C/UYl+cRKw15fVUYIX
         RXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYT2OSHdO2DhGI1fwQFHGoFCd1oy7Hq2Yne9sDtdOm8=;
        b=qcPRJSu0ylXdgJvwxYnXB5JSIN8Glnez+WnuB4CHH09f8KbfAvr55fUa5oCVD0XVgk
         PQ2fD04h1NeNJXQ6V0oEz8Dwz6CVvwglNZqxz1fLZIef2D5u/svEtEXN+0SHNAj14wtK
         5BacBHdim8udUYw1xuN/xB2XGeV19ro0b9a9Bi/x235wd6deiSrdoZsA66eZBADHce5H
         x4sys6Hi+dkOgwruQZuhqgQCicFqU0FYbsVQgyMo2ztKKxYejufE/auX4SQuEEvUvU04
         1RexMWdI16ZOLqjNjLkexksL5zyLHcvJ7Sum27jcJARHenVnqDfY3w0BLcI+ImSZcFhP
         e0kQ==
X-Gm-Message-State: APjAAAWg8iKnHwLLGKxu3DL8K+fYiWB3XFs33m6VSLbvIAxrShVjMxJ9
        1gRlhGBILlPRF0hKtL6QSYPQzqr8eFxyUMlPQB3QSw==
X-Google-Smtp-Source: APXvYqyfs8OtHgp4GrtWZwMaMMg8hiNezGefnRigGy1I7CavN0aKhlm20eEzQ6pzBIanR2L4TTIMz54bjUdmC6/qSH0=
X-Received: by 2002:a2e:96d3:: with SMTP id d19mr613083ljj.185.1565880609143;
 Thu, 15 Aug 2019 07:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190814103244.92518-1-maco@android.com> <29990045-b05e-1411-a5c2-32e735265a04@acm.org>
In-Reply-To: <29990045-b05e-1411-a5c2-32e735265a04@acm.org>
From:   Martijn Coenen <maco@android.com>
Date:   Thu, 15 Aug 2019 15:49:58 +0100
Message-ID: <CAB0TPYGczqoDz=ReM75cYc4hbS58V-a4m_qJ8GoAoWtepXTWNA@mail.gmail.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:29 PM Bart Van Assche <bvanassche@acm.org> wrote:
> Hi Martijn,
>
> Is the loop driver used in Android Q to make a file on a filesystem
> visible as a block device or rather to make a subset of a block device
> visible as a block device? In the latter case, have you considered to
> use the dm-linear driver instead? I expect that the overhead per I/O of
> dm-linear will be lower than that of the loop driver.

Hi Bart,

In this case we're using the loop driver to make a file on the
filesystem visible as a block device (in the file is a filesystem we
want to mount), so unfortunately dm-linear is not an option.

Best,
Martijn

>
> Bart.
