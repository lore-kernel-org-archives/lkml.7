Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CBE20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZHL5jkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCFWMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:12:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33140 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:12:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id h11so9529656pgl.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=4WiXplkSOqcHAkHALHgT+HxYhesWO1hQ7GJbig7RVyk=;
        b=EZHL5jkX5qbGfxl8nHlpemRyDYPtRUUF8BqR7R+LyYl09emsiMaMjpb8at5njzSWSa
         5TUM39b3EIrl+bPvY1qKOfF/pL+HbeQ+gR3U8XfXJyOesdbQV+grAIGhgsPGCL9zRLGu
         /gQZ2Xz6jIPuHJeSpOKcOELifPCjIa/OLhDqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=4WiXplkSOqcHAkHALHgT+HxYhesWO1hQ7GJbig7RVyk=;
        b=IWIiAXvqzTbV585GX+ZWVPSELGnDrHeQTwK9rgBGGUvhfv2snPm2rCX5ik2HD4hBQr
         StqHjcatm8363p4ZLEowP3DmmIJAvxtUImjTe+jmhkdR8x01jw8TK3Mkur1S6aZQaVO0
         NiTm8f5LqLUP9DhwwT5yC9+gWPexuT+IiIp9YNhAKdNvNagZbmOapK8s3cm3p0yd2STp
         JiuCavVxnrcAooDeJZrelvoQlBQri9axfcM6PVTWdr2NFi3ZOR+3jt7GQD+zM+dmrslo
         8irVyeu2kzoSnfxENjwqnmLLSW+JvOTrg7ZvtUHIQLsUiEyk5gkk1GDb1ZInBuClFQnT
         zR6A==
X-Gm-Message-State: APjAAAVfd3slGcnr/kNe62VNY5F1BrlGROpmRDIPXMCkj+dfRDKNLhDX
        JW4Wma4n84KlafPa4Yibw3hYEw==
X-Google-Smtp-Source: APXvYqx5DQysWH15e3DdRqD2wtSnG5aRgv2S8ML9sXSAOVXqK7UYxu2mQkhSLTQoDzEJShm3X9fRiQ==
X-Received: by 2002:a63:591f:: with SMTP id n31mr8218228pgb.304.1551910363808;
        Wed, 06 Mar 2019 14:12:43 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e184sm6121172pfc.143.2019.03.06.14.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 14:12:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190304171450.GB10971@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org> <20190221121827.32427-3-rplsssn@codeaurora.org> <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com> <20190227222913.GA10971@codeaurora.org> <155146312862.16805.13188707704058408931@swboyd.mtv.corp.google.com> <20190304171450.GB10971@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the controller is idle
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org
To:     Lina Iyer <ilina@codeaurora.org>
Message-ID: <155191036168.20095.16985811185745151630@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 06 Mar 2019 14:12:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-03-04 09:14:50)
> On Fri, Mar 01 2019 at 10:58 -0700, Stephen Boyd wrote:
> >Quoting Lina Iyer (2019-02-27 14:29:13)
> >> Hi Stephen,
> >>
> >> On Tue, Feb 26 2019 at 17:49 -0700, Stephen Boyd wrote:
> >
> >Ok, can you explain why it's even a problem for the TCSes to be active
> >during suspend? I would hope that for suspend/resume, if this is
> >actually a problem, the RPMh driver itself can block suspend with a
> >driver suspend callback that checks for idleness.
> The RSC can transmit TCS executed from Linux and when all the CPUs have
> powered down, could execute a firmware in the RSC to deliver the sleep
> state requests. The firmware cannot run when there are active requests
> being processed. To ensure that case, we bail out of sleep or suspend,
> when the last CPU is powering down, if there are active requests.

Ok, do we actually bail out or just pick a shallower idle state that
wouldn't trigger the firmware to run something that may conflict with
the active requests (i.e. some light CPU sleep mode)? The commit text
seems to imply we block certain idle states.

>=20
> >But I suspect that in
> >the system wide suspend/resume case, any callers that could make TCS
> >requests are child devices of the RPMh controller and therefore they
> >would already be suspended if they didn't have anything pending they're
> >waiting for a response on or they would be blocking suspend themselves
> >if they're waiting for the response. So why are we even checking the
> >TCSes in system suspend path at all? Assume that callers know what
> >they're doing and will block suspend if they care?
> >
> In suspend, they probably would do what you mention above. All CPUs
> might conincidentally be idle at the same idle, when a request is being
> processed.
>=20
> >Following that same logic, is this more of an API that is planned for
> >use by CPU idle? Where the case is much more of a runtime PM design.
> >Even then, I don't get it. A device that's runtime active and making
> >RPMh requests might need to block some forms of CPU idle states because
> >a request hasn't been processed yet that may change the decision for
> >certain deep idle states?
> >
> A process waiting on a RPMH request, may let the CPU go to sleep and
> therefore this is a possibility.
>=20

Ok thanks for the info. Can these details be included in the commit text
so we don't lose sight of the bigger picture? And can this patch series
be combined with a larger cpuidle/suspend patch series so we don't have
to review this in isolation? I don't understand the need to add more
APIs that aren't used yet.

