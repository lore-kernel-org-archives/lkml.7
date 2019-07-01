Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8DEC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0042921743
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJbtVUbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfGAJBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:01:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35693 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfGAJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:01:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id u124so8415192vsu.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Jz5LEA2XCY8WxB7ahvqb8ZAK22nsgzGKs1ifY5Dk/U=;
        b=uJbtVUbZumTe4WM+B5cBl49oqWTtQjEH1u5VqEXDSDXX5Gae0YkHMB3/FHyIhOfkMK
         E6fG2kzSVK9HvQbalX/EN5hrDp1UMlKPv2MDUx+TQgiOzC1Af0Vad4VceJ0E0FEgrzFq
         bLCCiWjgdu/5m+2knBRyCgP88VTZ3Dy5pkruJGDPwcAYJrtlxM42m70Jz8UhznvVEUQ+
         bAUdFmTxWFajg2OYnjPYWdKancO2oe6zm7fNmRV6axzmHWmMpE9/kHpS/yKpk0FnJ11K
         t0tSuHU0qGXrsdAM5QKYN+cV0Xl7dhOM0pu4UvghNeybg1LWu/OiVUB6HIGsKspHeUi0
         AY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Jz5LEA2XCY8WxB7ahvqb8ZAK22nsgzGKs1ifY5Dk/U=;
        b=sLjmqSvOwKFrWy/5CT/o03hfAX4POPB7OKpXHjxcJzH4u0i8KyqHB2wQXAIzkIj9pT
         PiYKgc8Ssyp18OWse6k/284+sgmajLnhwvB5yCM9Z0Io55WzTyEVoES67PF9/yWW67rj
         Lyi9eSvvbmGtdjGQkwbsEbXPkJBXVqwqhK8qdlF+4rrjQrkAycMQ5WkmALcwZARALQRT
         TaOYyBlb4RNjWhkJCkl/kexuH0v9sWusCIK+tkG4yInfpEX4cc2AFLivittkjCvSVFc9
         c/lvvCLmJcYFLLjSMQA4FXN+SoEy7SXxyNZ6cRrY2Jf5W/i/XCYGCu/ZjaLKxcW0/5Ja
         W2ng==
X-Gm-Message-State: APjAAAUYONknrC/+DX+eHwKZrRpOwAYQk2fXnYLDG4yFSaZXyMBLH13R
        aR4Zzelk/JsUGh0xcxPo76aZkunONI8sCOm174vn5oUo
X-Google-Smtp-Source: APXvYqxsynQrL3vfc5mOg4U8prttDVExu+ydIjOZmPNanoztxU6OWq4kI+zwsq97Ws7pHugalZDkCDe1rXiXjn989FQ=
X-Received: by 2002:a67:d410:: with SMTP id c16mr14718423vsj.61.1561971659065;
 Mon, 01 Jul 2019 02:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190701083604.24528-1-ttayar@habana.ai>
In-Reply-To: <20190701083604.24528-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 1 Jul 2019 12:00:32 +0300
Message-ID: <CAFCwf12F+LWE4brhJ9rj35yJfdnv=EqRtXfo4MVUpKYGCc6JKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] habanalabs: Add debugfs node for engines status
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 11:36 AM Tomer Tayar <ttayar@habana.ai> wrote:
>
> Command submissions sent to the device are composed of command buffers
> which are targeted to different device engines, like DMA and compute
> entities. When a command submission gets stuck, knowing in which engine
> the stuck is, is crucial for debugging.
> This patch adds a debugfs node that exports this information, by
> displaying the engines' various registers that assemble their idle/busy
> status.
If this is a new node, then you are missing the update to
Documentation/debugfs-driver-habanalabs

>
> The information retrieval is based on the is_device_idle ASIC function.
> The printout in this function, of the first detected busy engine, is
> removed because it becomes redundant in the presence of the more
> elaborated info of the new debugfs node.
>
> The patch also updates the device idle check:
> - Add reading the DMA core status register, because it is possible that
>   QMAN has finished its work but the DMA itself is still running.
> - Remove the MME shadow status check, as the MME ARCH status register
>   includes the status of all MME shadows.
This seems better to separate into a different patch.
So I suggest first a patch that fixes the device idle check and then
this patch (that adds the debugfs node and uses the idle check
function).

Thanks,
Oded
