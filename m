Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16390C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C180A217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nou534kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfEXAPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:15:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40202 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfEXAPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:15:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id r136so5763790oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/Q+M3D/f31BjghiNjOc57yo6l8Vxd0pYHlve49qAjA=;
        b=nou534kHwoDKIDJsqawXYheb+9fDqSaHbkgw8vFRhFL/uGfktKnn/XHtIveDUjl/ye
         oz9ror2NPIQlkiTsRhJK+AjyflTmUtlRdlCj+zCQmAV6GjIFb8tL6SXPYLAr1OwATxRn
         7FaJ8l2v6FB0jAulv6lr+kxiRofnSDrnU7yKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/Q+M3D/f31BjghiNjOc57yo6l8Vxd0pYHlve49qAjA=;
        b=OnFR774b/3+Fh/nf3++6rLfyKO0ktlhJyR+ySj68NghoDp9GOVLa1A7XwE8eygqMl3
         O/rQ6RYku6biwdBvxtxmHjFhRVMWiDjnZeEJY73ypaYIJhI6XUc+wwadmROZ6wDlD0N6
         ImA8ie2RSOnqyNXHI582OaGnsD2rKS3DG7F9KUKK9fqqhVzKQbAsxzyK2Y2nmquas51a
         mBKphdVdEHu3FK5XsrFiLPG378GFgPrIfw8kYfVCkFKuJGrP0gorpQF0rNacCQpoadMI
         bRwrExLTkVnWA/uFrNDwiVUyIk9t7QZUHrj2Iuc/DXKyGgsmophjm2b2CFU70lg65+K4
         y5yg==
X-Gm-Message-State: APjAAAVxVQHbHflo13hQ8RHtcJAVrX1/YPp4ppV5ovjEBKRUxlYiQ8qv
        7GcIHcR4Uj6xjCFGY5IbK52emkH7LI4=
X-Google-Smtp-Source: APXvYqwcVb9/4lP7vRt8hiDy+mScAH6NA9afJz4qMx5ODUY/34p6D8mpcRqbRdjveIn0cSOC59SvtQ==
X-Received: by 2002:aca:d44a:: with SMTP id l71mr4293763oig.41.1558656931255;
        Thu, 23 May 2019 17:15:31 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id o128sm391651oih.48.2019.05.23.17.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 17:15:30 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id i8so7109429oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 17:15:29 -0700 (PDT)
X-Received: by 2002:a9d:4b92:: with SMTP id k18mr25836368otf.351.1558656929524;
 Thu, 23 May 2019 17:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190521151519.158273-1-rrangel@chromium.org>
In-Reply-To: <20190521151519.158273-1-rrangel@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 23 May 2019 18:15:18 -0600
X-Gmail-Original-Message-ID: <CAHX4x86bnXh_xPqU4ZwuT9RpVtyDwEP1NDWbKDWmNbXfKKEVxA@mail.gmail.com>
Message-ID: <CAHX4x86bnXh_xPqU4ZwuT9RpVtyDwEP1NDWbKDWmNbXfKKEVxA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add version sysfs entries
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 9:15 AM Raul E Rangel <rrangel@chromium.org> wrote:
>
> Add the ability to extract version information from the EC.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Looks good to me, thanks Raul!
I applied to the chromium branch, and it works.

Reviewed-by: Nick Crews <ncrews@chromium.org>
Tested-by: Nick Crews <ncrews@chromium.org>

> ---
>
> This patch is rebased on platform/chrome: wilco_ec: Add Boot on AC support.
> https://lkml.org/lkml/2019/4/16/1374
>
> That patch wasn't in the for-next branch, so I'm not 100% sure if it
> applies cleanly to for-next.

It doesn't apply cleanly :(
You can add https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
as the platform/chrome remote to ensure that it will apply cleanly.
It would probably be good for you to re-send this after rebasing it on for-next.
