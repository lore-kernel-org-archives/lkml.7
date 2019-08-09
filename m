Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7040FC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3840C20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G54KRPbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfHIVR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:17:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46336 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfHIVR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:17:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so93457005ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4vLpkUXGaCx5ksGKXq1B6fru5dxWZeG1Id+VcyLndE=;
        b=G54KRPbppyCf6lOgHptflnWoJgyVEK93H+cXO/vp8LfwGrelRzgN5+IYoCLqXUrfYO
         X/Z645f3sLIDye0s3bOMNqrnMltaBkTAyYjneZ6d8DcT9/YcwkbfnK/Nth/KaLZbh+2/
         SYW0DZALxCSJQavegwiXuKNfFYGJX1d3/zt9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4vLpkUXGaCx5ksGKXq1B6fru5dxWZeG1Id+VcyLndE=;
        b=kbXfGctnCvBxOt2hMPmwOd8VLHX2m5XQRr573tUiM0qry31i5oAIkUj80oUuWy+esI
         Kgktu2N5cGCEiH3VL8nCUPgAjv1hmGIvPkv2oUYcoa9b7TaOnW95o3/UxZsUPJE1FmnP
         AzVU4+5P5DPLbXcIZBGEJKjW5Dg1b+eNQDtJKl3zxHS+XcR1HBGgDNsTjQsrQSY36JaS
         WXgPXjN0GvKEmjhxs99ZMwCLfxgs5nRPc9bQBltjPMXNvPjw3lbe5wuGgO0tFrlGH+68
         hfgFCNrqEeWBjGsUOj8dhheKKEqX3jzt0gSMK3l5DucScJARto1NhInZoY+vCMtaJslP
         QBSQ==
X-Gm-Message-State: APjAAAWyg8XqWT22DZbBcYoQd7Z2wLsMBJb995vGS7AFlt+qy8eqMJSd
        8s/gYG+yDCG0ql2kUIMpZAeFgZ8dqQI=
X-Google-Smtp-Source: APXvYqzc2k3hn/GiaBKLOEEHFrWjMLerVQiyRCoXzLfP1VEUUE43c31MwD1YBgWtrJ+sJNnFxpTjOQ==
X-Received: by 2002:a2e:8802:: with SMTP id x2mr12292920ljh.200.1565385476215;
        Fri, 09 Aug 2019 14:17:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f12sm1019381lfm.14.2019.08.09.14.17.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:17:55 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id z17so4848099ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:17:55 -0700 (PDT)
X-Received: by 2002:a2e:93c8:: with SMTP id p8mr12301485ljh.6.1565385474677;
 Fri, 09 Aug 2019 14:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190809121325.8138-1-georgi.djakov@linaro.org> <20190809121325.8138-3-georgi.djakov@linaro.org>
In-Reply-To: <20190809121325.8138-3-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 9 Aug 2019 14:17:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft5JD9QuH3cZpPX=4eJMjbyPi8nes1--6qcsKdb1sw_rNw@mail.gmail.com>
Message-ID: <CAE=gft5JD9QuH3cZpPX=4eJMjbyPi8nes1--6qcsKdb1sw_rNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] interconnect: Add pre_aggregate() callback
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, David Dai <daidavid1@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 5:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Introduce an optional callback in interconnect provider drivers. It can be
> used for implementing actions, that need to be executed before the actual
> aggregation of the bandwidth requests has started.
>
> The benefit of this for now is that it will significantly simplify the code
> in provider drivers.
>
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
