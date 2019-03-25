Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3B0205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553534942;
	bh=EmGSsHSiWmDdbwNYs/8yVnqQwNno7Gna9nJ4yVYsLtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K36K2S5cfYiAZhypMLZ5SahV/kpIOfRfLArHwLifrkEP9uH236J2TYaOSKFTvPxF4
	 /TzW1dOIX8VdS/ZzQZtOdWalqgEyW/7xx+Q6FFrNIjFyueh8mbc3A7SbqioUeM94sU
	 jQuiTinuIlIej6bzoGPCiKVzC9ri3wHd8jRK3j7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfCYR3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYR3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:29:00 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B267B205C9;
        Mon, 25 Mar 2019 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553534940;
        bh=EmGSsHSiWmDdbwNYs/8yVnqQwNno7Gna9nJ4yVYsLtQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wchuxvIxqVNAJ5sx+hOD8ZzFFbBuyi/0eSdd6qDLobpv4BhlC+pFA+eyDZYHakem+
         A+cUxcEFgAgIdkxRhi0WOV0pTB3YwRNcFpFuwRGwNHrxAaAQInqNfZ2uAnzt3DjkRT
         ALK5kT/NDK6Hg2FlFFZ8Cn55Cd2NxmO1Y06VEYZ0=
Received: by mail-ed1-f47.google.com with SMTP id d1so8256906edd.13;
        Mon, 25 Mar 2019 10:28:59 -0700 (PDT)
X-Gm-Message-State: APjAAAW7y/P4QwW60QHx3q+6ktgt5+pneyd3Vrsbus+Fk3eRWH0K+kic
        h9NXL14ioK+05i7j7QYCEDjBeo/HTaTnNxAcil0=
X-Google-Smtp-Source: APXvYqzCTNAzgFjwgioHWE83ttM5vHsZiaCoL+4Qa/Q65zAQ2lRGE0ejSd/FKAUTqMkqMZqYL/OYB0OhNd+uQxNqCNM=
X-Received: by 2002:aa7:c70a:: with SMTP id i10mr17327757edq.153.1553534938297;
 Mon, 25 Mar 2019 10:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-2-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-2-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 25 Mar 2019 12:28:22 -0500
X-Gmail-Original-Message-ID: <CANk1AXRCdd_AwXj1aMwzu7ff4yxuBtN21mju62skbJnhXDwtcw@mail.gmail.com>
Message-ID: <CANk1AXRCdd_AwXj1aMwzu7ff4yxuBtN21mju62skbJnhXDwtcw@mail.gmail.com>
Subject: Re: [PATCH 01/17] fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register address.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:23 PM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

>
> FME_PR_INTFC_ID is used as compat_id for fpga manager and region,
> but high 64 bits and low 64 bits of the compat_id are swapped by
> mistake. This patch fixes this problem by fixing register address.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan

> ---
>  drivers/fpga/dfl-fme-mgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index 76f3770..b3f7eee 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -30,8 +30,8 @@
>  #define FME_PR_STS             0x10
>  #define FME_PR_DATA            0x18
>  #define FME_PR_ERR             0x20
> -#define FME_PR_INTFC_ID_H      0xA8
> -#define FME_PR_INTFC_ID_L      0xB0
> +#define FME_PR_INTFC_ID_L      0xA8
> +#define FME_PR_INTFC_ID_H      0xB0
>
>  /* FME PR Control Register Bitfield */
>  #define FME_PR_CTRL_PR_RST     BIT_ULL(0)  /* Reset PR engine */
> --
> 2.7.4
>
