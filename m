Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA96AC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA7620679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I4qWR+mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfHMRJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:09:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36456 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMRJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:09:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so23256994lfp.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVzAnVzEMjxkSBqu8V9mlBdGqDjrrYQzVhEjxzd+3hI=;
        b=I4qWR+mzqRT7c1SEkHGhKmL6s1EYBMsgtyPriDKNziH+B4FMxlEGuvrJH5HcS4lcUd
         oEuShorJ4j1kTmfzSPRIGn/stYQAr97GOiXpjAyAAXj4cxkN8Dy0uFFDrdXb/ecYQt9m
         1yniZalDerzD5yTNTTGHitP5LFfOrIUdgwpGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVzAnVzEMjxkSBqu8V9mlBdGqDjrrYQzVhEjxzd+3hI=;
        b=OquOjVbJxpkvBABTgd8oYqkOhyBji9H0XgCndqtJwpG8tyegl2ytXKu/8lRVhlePCx
         vhq5COq6Z+lF7KA6lSZCJBDQgKI1yTyoWrk3xQB8bcG2hvTby68WyCbHnZl8EwmAR7Nx
         N0N80jXPyGLfGcC+wPNpdXP540l6vaVcmQdre3ai7vyAoJWd7187hlcs0tOtH2lnXeWW
         FrbtGor2ECZyHSNm8nq03H1OOjKzjDhUTpSXFNr0nzypjab7SH5Ov74KL8nkWXueIbeX
         ihd9KJBsTVApk3hzGWnOxezridK3bC8v4XcHR2Ia01P3LAEemxP35eT6MSx0BKOXqb/B
         aKlA==
X-Gm-Message-State: APjAAAU5BVtvJl1bt6i9Hl2UdK6HbHOkSwRu4v12WjobHFaMXmLASHtJ
        FDXyDfIsbNMeggq4GONIznpbZanfw5s=
X-Google-Smtp-Source: APXvYqzKd2jvOAIAq9QQLTcwQP4nSrgD+IXI5AK0cETe3HbZ3YK8qzpsZJgBJaQW1SqQN9dxr3KoIA==
X-Received: by 2002:ac2:546c:: with SMTP id e12mr14842973lfn.133.1565716159959;
        Tue, 13 Aug 2019 10:09:19 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t5sm21364322ljj.10.2019.08.13.10.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 10:09:17 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c9so77222363lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:09:17 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr22803433lfb.29.1565716156648;
 Tue, 13 Aug 2019 10:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190813145341.28530-1-georgi.djakov@linaro.org> <20190813145341.28530-4-georgi.djakov@linaro.org>
In-Reply-To: <20190813145341.28530-4-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 13 Aug 2019 10:08:40 -0700
X-Gmail-Original-Message-ID: <CAE=gft6ZpM6x21X+SxCbNDdNS5B51yYAFA0XBbViqLmr99n5SQ@mail.gmail.com>
Message-ID: <CAE=gft6ZpM6x21X+SxCbNDdNS5B51yYAFA0XBbViqLmr99n5SQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] interconnect: qcom: Add tagging and wake/sleep
 support for sdm845
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

On Tue, Aug 13, 2019 at 7:53 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add support for wake and sleep commands by using a tag to indicate
> whether or not the aggregate and set requests fall into execution
> state specific bucket.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
