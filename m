Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CD220645
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMHsIt13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbfCAR6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:58:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37788 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388293AbfCAR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:58:51 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so11769279pfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:to:subject
         :message-id:references:from:cc:user-agent:date;
        bh=96T5xiZgFJP4BWjNMHpO6Jd+7XuB7mOugvvWERG8K0Q=;
        b=jMHsIt13MfCg+lKpBM3tQJYarQa2TAZSSHLBQhJ4ok9Km8Xy3uTKS6v/iu7xEBJyhp
         wOvXUj21j8Ty7ssW5HUKMjifNIj+Vw4fjJ1RtxXIaMOlJH33nmuHtO+GRSdJDw+aJNu5
         6gXqZ5aIYzKtKsKrIyOKm9nCRaqwzqGVpIHYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:to:subject:message-id:references:from:cc:user-agent
         :date;
        bh=96T5xiZgFJP4BWjNMHpO6Jd+7XuB7mOugvvWERG8K0Q=;
        b=D0ljpiz1rdUqi77Oqu83Cksj33wz0bZZXaCddzmNv2jAY4oFKyshkj7ZQaZ8527kbL
         poVsqnPd8xrNN6OH/54ZiMF/yIHXGzmBTzUMAOfmr/ufu6JG3vaLPLhVe/aaYjHEoihT
         7N6kL6PAKyF5KzkvFuAQB84l6ONt2Ldo00LGiLv6+nb8KXST5rZ2v9G0qfl0ENkdtkVf
         0C4vFENZIJYnfOqrb7emJf+dRluyzdPbvXXVHwakkWgzcSxIG8n+m/FaxSuTO29VIyI3
         s1GqUcUFok4wRRQAQTbpsaAfFSIZ3OOyfajZDT0Xzv48s41u5xB8/EVGxyznQFTyK83F
         RsxQ==
X-Gm-Message-State: APjAAAW0aFGA3LsDUBcNPzN7gFA7nV+DgKMkMIUxGHUGihLpNFMiiTrN
        xSK63gUqbnXTPj1c0Emu3OceIw==
X-Google-Smtp-Source: APXvYqwjj0DQT9msBHU3GELZS3TetAphz37TVMk+fwgCeLydReNBAe/EWj7mLQStQpqpi2Y5C+kr1g==
X-Received: by 2002:a63:7503:: with SMTP id q3mr5631220pgc.98.1551463130540;
        Fri, 01 Mar 2019 09:58:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v7sm17924329pga.50.2019.03.01.09.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:58:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190227222913.GA10971@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the controller is idle
Message-ID: <155146312862.16805.13188707704058408931@swboyd.mtv.corp.google.com>
References: <20190221121827.32427-1-rplsssn@codeaurora.org> <20190221121827.32427-3-rplsssn@codeaurora.org> <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com> <20190227222913.GA10971@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org
User-Agent: alot/0.8
Date:   Fri, 01 Mar 2019 09:58:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-02-27 14:29:13)
> Hi Stephen,
>=20
> On Tue, Feb 26 2019 at 17:49 -0700, Stephen Boyd wrote:
> >Quoting Raju P.L.S.S.S.N (2019-02-21 04:18:26)
> >> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> >> index d6b834eeeb37..9cc303e88a06 100644
> >> --- a/drivers/soc/qcom/rpmh-rsc.c
> >> +++ b/drivers/soc/qcom/rpmh-rsc.c
> >> @@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, co=
nst struct tcs_request *msg)
> >>         return ret;
> >>  }
> >>
> >> +/**
> >> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
> >> + *
> >> + *  @drv: The controller
> >> + *
> >> + *  Returns true if the TCSes are engaged in handling requests.

By the way, this says AMCs are busy and then TCSes are engaged. Which
one is it?

> >> + */
> >> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
> >> +{
> >
> >This API seems inherently racy. How do we know that nothing else is
> >going to be inserted into the TCS after this function returns true? Do
> >you have a user of this API? It would be good to know how it is used
> >instead of adding some code that never gets called.
> >
> This API is called from the last CPU that is powering down in an
> interrupt locked context (say during suspend). If we are waiting on a
> request, we would bail out of the suspend process. There can be no issue
> requested during the last step in suspend. The PM driver itself does not
> make any TCS request. Currently, this API is used by the downstream code
> in its last man activities. The usage by platform coordinated mode is
> still under discussion.
>=20

Ok, can you explain why it's even a problem for the TCSes to be active
during suspend? I would hope that for suspend/resume, if this is
actually a problem, the RPMh driver itself can block suspend with a
driver suspend callback that checks for idleness. But I suspect that in
the system wide suspend/resume case, any callers that could make TCS
requests are child devices of the RPMh controller and therefore they
would already be suspended if they didn't have anything pending they're
waiting for a response on or they would be blocking suspend themselves
if they're waiting for the response. So why are we even checking the
TCSes in system suspend path at all? Assume that callers know what
they're doing and will block suspend if they care?

Following that same logic, is this more of an API that is planned for
use by CPU idle? Where the case is much more of a runtime PM design.
Even then, I don't get it. A device that's runtime active and making
RPMh requests might need to block some forms of CPU idle states because
a request hasn't been processed yet that may change the decision for
certain deep idle states?

