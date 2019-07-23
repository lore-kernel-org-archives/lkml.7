Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751CEC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A41421841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NSMsF/Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfGWUTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:19:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39004 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfGWUTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:19:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so15696188pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=j+oQw2jdtWVrhOuLyebLNsd7ea1r8/8WD8EWU9cDAVo=;
        b=NSMsF/ZhLMfKzsKJ2MspdGWNCHdp7/PJbl+7N68yde2T9b7DjaJfjPc857JDqwI1qG
         ztbRuSuLw0ZiEngAIk2lr7lgbNw92V5Ke9JI45W9JpPLiUqz9GAyeFXMO/N0XaYJLgVe
         Usz6WsyTsIwMMnJcc6EmsOhMRqeNtKrfT2vWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=j+oQw2jdtWVrhOuLyebLNsd7ea1r8/8WD8EWU9cDAVo=;
        b=O3GivmWSmQYZHUT7DB5vo8Z7L/NoDHnX4mHX//+voZVWO7J7cRrOxgkvzDYsjSf291
         3Nh3c5pYwc63+HSCZ+Pza7c5oCFjYv89iKJo0UrmNYMDdTiVpqMRWh5aaeEKxlXYp0RE
         7HCyOD8+4xjpctHiOuNirP+8/JUMTZDHqfWxQ7FckyPBwymOEy/y8K+cf9u0NygY5ySq
         wxyX4UVY8iBHyRm4iHCnNXGraKx0BGXfwH7bPycTBTIUDwA18FhrkInzDPiBksyj97AR
         7lHs4EynWkltmoGN8Cs4rKHJ5GRNhcr3XL4VB5seaR9M9ELC+Rb98/C8Jq2guMl34nXc
         wBHQ==
X-Gm-Message-State: APjAAAUetRSwZvRLQVQYjDhmTCnRzS9v/NMBiplG1AzDqGUwAQKXqsJz
        1sC1sW8QnW9p7tEX0rvIRdoNXQ==
X-Google-Smtp-Source: APXvYqy9POj2+Xo/YOz/WRQitO0yZSvOEN3J5hTLe0FEyZ6UIHk6V8VuYl0CMgI/lhCvoIzz8gSysw==
X-Received: by 2002:a63:c748:: with SMTP id v8mr46673106pgg.418.1563913140016;
        Tue, 23 Jul 2019 13:19:00 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k6sm53132496pfi.12.2019.07.23.13.18.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:18:59 -0700 (PDT)
Message-ID: <5d376bb3.1c69fb81.2bb4e.7771@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190723192159.GA18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org> <5d375054.1c69fb81.7ce3f.3591@mx.google.com> <20190723192159.GA18620@codeaurora.org>
Subject: Re: [PATCH V2 1/4] drivers: qcom: rpmh-rsc: simplify TCS locking
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 13:18:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-07-23 12:21:59)
> On Tue, Jul 23 2019 at 12:22 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2019-07-22 14:53:37)
> >> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
> >>
> >> The tcs->lock was introduced to serialize access with in TCS group. Bu=
t,
> >> drv->lock is still needed to synchronize core aspects of the
> >> communication. This puts the drv->lock in the critical and high latency
> >> path of sending a request. drv->lock provides the all necessary
> >> synchronization. So remove locking around TCS group and simply use the
> >> drv->lock instead.
> >
> >This doesn't talk about removing the irq saving and restoring though.
> You mean for drv->lock? It was not an _irqsave/_irqrestore anyways and
> we were only removing the tcs->lock.

Yes drv->lock wasn't an irqsave/restore variant because it was a
spinlock inside of an obviously already irqsaved region of code because
the tcs->lock was outside the drv->lock and that was saving the irq
flags.

>=20
> >Can you keep irq saving and restoring in this patch and then remove that
> >in the next patch with reasoning? It probably isn't safe if the lock is
> >taken in interrupt context anyway.
> >
> Yes, the drv->lock should have been irqsave/irqrestore, but it hasn't
> been changed by this patch.

It needs to be changed to maintain the irqsaving/restoring of the code.

> >> @@ -349,41 +349,35 @@ static int tcs_write(struct rsc_drv *drv, const =
struct tcs_request *msg)
> >>  {
> >>         struct tcs_group *tcs;
> >>         int tcs_id;
> >> -       unsigned long flags;
> >>         int ret;
> >>
> >>         tcs =3D get_tcs_for_msg(drv, msg);
> >>         if (IS_ERR(tcs))
> >>                 return PTR_ERR(tcs);
> >>
> >> -       spin_lock_irqsave(&tcs->lock, flags);
> >>         spin_lock(&drv->lock);
> >>         /*
> >>          * The h/w does not like if we send a request to the same addr=
ess,
> >>          * when one is already in-flight or being processed.
> >>          */
> >>         ret =3D check_for_req_inflight(drv, tcs, msg);
> >> -       if (ret) {
> >> -               spin_unlock(&drv->lock);
> >> +       if (ret)
> >>                 goto done_write;
> >> -       }
> >>
> >>         tcs_id =3D find_free_tcs(tcs);
> >>         if (tcs_id < 0) {
> >>                 ret =3D tcs_id;
> >> -               spin_unlock(&drv->lock);
> >>                 goto done_write;
> >>         }
> >>
> >>         tcs->req[tcs_id - tcs->offset] =3D msg;
> >>         set_bit(tcs_id, drv->tcs_in_use);
> >> -       spin_unlock(&drv->lock);
> >>
> >>         __tcs_buffer_write(drv, tcs_id, 0, msg);
> >>         __tcs_trigger(drv, tcs_id);
> >>
> >>  done_write:
> >> -       spin_unlock_irqrestore(&tcs->lock, flags);
> >> +       spin_unlock(&drv->lock);
> >>         return ret;
> >>  }
> >>
> >> @@ -481,19 +475,18 @@ static int tcs_ctrl_write(struct rsc_drv *drv, c=
onst struct tcs_request *msg)
> >>  {
> >>         struct tcs_group *tcs;
> >>         int tcs_id =3D 0, cmd_id =3D 0;
> >> -       unsigned long flags;
> >>         int ret;
> >>
> >>         tcs =3D get_tcs_for_msg(drv, msg);
> >>         if (IS_ERR(tcs))
> >>                 return PTR_ERR(tcs);
> >>
> >> -       spin_lock_irqsave(&tcs->lock, flags);
> >> +       spin_lock(&drv->lock);
> >>         /* find the TCS id and the command in the TCS to write to */
> >>         ret =3D find_slots(tcs, msg, &tcs_id, &cmd_id);
> >>         if (!ret)
> >>                 __tcs_buffer_write(drv, tcs_id, cmd_id, msg);
> >> -       spin_unlock_irqrestore(&tcs->lock, flags);
> >> +       spin_unlock(&drv->lock);
> >>
> >
> >These ones, just leave them doing the irq save restore for now?
> >
> drv->lock ??
>=20

Yes, it should have irq save/restore still.

