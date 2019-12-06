Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0432FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBC524676
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iP/LrjVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLFTQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:16:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37394 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfLFTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:16:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so6076419lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 11:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dp6TtsDVMwDLXVNf7z26o9XIaBeojD6ZI0FYrgN+jxw=;
        b=iP/LrjVMleDaUJuXaUiNHfkocDJ+QBeAdqfEUhPU+zL8YR3HhO5xKQTteOaptagCby
         4JT64mVbmW9G6XScfGCKDnVfbX1uYpgrUiMjou2dA9VpJ+z/yCj7jafk2C3g2wUjptE5
         9tG9mdoGs2Tt9k7WwtEd68QJq7G3aLTs5ahc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dp6TtsDVMwDLXVNf7z26o9XIaBeojD6ZI0FYrgN+jxw=;
        b=DXEvauyRaFAXzSzWQcMAKXkQMSRNzz/EzjRh4Whoa1abX/knMfziV2nW9Q1/WwS9Yp
         vPYM9DKlEeEuj0n3/OqTw4dktl9W67qwFWMvb7h9/AlxlM2hdOQsOH7mo+E57H8m8LWC
         UTSQ9wP4lXwOz7rJLkQsYLuCpMEFR+J/uXXfmVB7XqIDOIWjIVc5svW1VJ1J6Y4v3Teh
         u5LUJc9UOPOnP6ViGkIoebVbSVji89oOr4bAWPmxO9OPLWOwakrdod2XhrbXHmcjGULU
         iut6n5qS8jMnzxTysyJHSww1RCRIG7JzFI8O1UFiY7wdFq8NDai4eKVxYDHnBUIXu3Ot
         pGng==
X-Gm-Message-State: APjAAAXQ+6LW2KNIKGgQWmlgdR1lbtWwjUtsiEj5fwMM116aUZjpQx+J
        NnIwv/NuFQqtj0CIgaRLbyJh+iiprKw=
X-Google-Smtp-Source: APXvYqwIrQP95wfnRpUaBSQ1js3MSss6YGiQIeuFWXrh1c7x4fBsJIgSzjSHzG0u9zd8GWWUnB0u+w==
X-Received: by 2002:ac2:4476:: with SMTP id y22mr9146713lfl.169.1575659808846;
        Fri, 06 Dec 2019 11:16:48 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v21sm3061155lfi.7.2019.12.06.11.16.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 11:16:47 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id l18so6099492lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 11:16:47 -0800 (PST)
X-Received: by 2002:ac2:4945:: with SMTP id o5mr8789546lfi.93.1575659806793;
 Fri, 06 Dec 2019 11:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20191118154435.20357-1-sibis@codeaurora.org> <0101016e7f30ad15-18908ef0-a2b9-4a2a-bf32-6cb3aa447b01-000000@us-west-2.amazonses.com>
 <CAE=gft5jGagsFS2yBeJCLt9R26RQjx9bfMxhQu8Jj4uc4ca40w@mail.gmail.com>
 <0101016e83897442-ecc4c00f-c0d1-4c2c-92ed-ce78e65c0935-000000@us-west-2.amazonses.com>
 <0101016eac068d05-761f0d60-b1ef-400f-bf84-3164c2a26d2e-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eac068d05-761f0d60-b1ef-400f-bf84-3164c2a26d2e-000000@us-west-2.amazonses.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 6 Dec 2019 11:16:10 -0800
X-Gmail-Original-Message-ID: <CAE=gft5cS54qn0JjxO58xL6sFyQk4t=8ofLFWPUSVQ9sdU4XpQ@mail.gmail.com>
Message-ID: <CAE=gft5cS54qn0JjxO58xL6sFyQk4t=8ofLFWPUSVQ9sdU4XpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add OSM L3 interconnect
 provider support
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:42 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Evan/Georgi,
>
> https://git.linaro.org/people/georgi.djakov/linux.git/commit/?h=icc-dev&id=9197da7d06e88666d1588e3c21a743e60381264d
>
> With the "Redefine interconnect provider
> DT nodes for SDM845" series, wouldn't it
> make more sense to define the OSM_L3 icc
> nodes in the sdm845.c icc driver and have
> the common helpers in osm_l3 driver? Though
> we don't plan on linking the OSM L3 nodes
> to the other nodes on SDM845/SC7180, we
> might have GPU needing to be linked to the
> OSM L3 nodes on future SoCs. Let me know
> how you want this done.
>
> Anyway I'll re-spin the series once the
> SDM845 icc re-work gets re-posted.

I don't have a clear picture of the proposal. You'd put the couple of
extra defines in sdm845.c for the new nodes. But then you'd need to do
something in icc_set() of sdm845. Is that when you'd call out to the
osm_l3 driver?
