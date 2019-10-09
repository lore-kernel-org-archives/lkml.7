Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E57ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FDE20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iKWeJdmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfJIP0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:26:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38938 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfJIP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:26:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so2928659ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOcaopzXOXD+usHp96MLejtldLwmcKRCmKe5gubp3hM=;
        b=iKWeJdmGRHccgf9FoMbmzUbBRxoUHujF6DrYvq+P3h8z3/GprEMW5NrvUjL0ldy49E
         5QO1X2+wfCkASte84vp+wlGB00QffleBOZHr5Vylz1e/euzezmmJhMQSGN2L25t50xla
         PkmWcucmGn2OMDcU9YwHCf4Q5ArXbKCXWL2Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOcaopzXOXD+usHp96MLejtldLwmcKRCmKe5gubp3hM=;
        b=FSwFX7v5na5zMyXeTfCnfHnUL+lwPCaCDiJ087Txc638CE4gvvBBlz9kv4wRk/lGu1
         HlMOj40czhGb54UUYCcl5qk7heyUMXk1AZFZXb2kLcjcOJBz8Y1CwnBrnbX6K29zR6t8
         qgH2wDnsATLbxUxI6ijfQ5utggDBYDUe+5vWd8091ZOoXyDFpo7fdpkIC70HtoHOV7q6
         cfogBibPAa5LsOCyHmFflBMA/NiBvfF/IjpDzs7EOvQD2Y68B/QJ6Yd72vrKI1DzaHPe
         mnsUD01IxPSWMcA+/VamBwWmQs6qSNCHpi4j0yy1PIlHANj2AwFeDwog1YJDj6kfgrFR
         7SlA==
X-Gm-Message-State: APjAAAX36qxiBg8TfTN9QiGBIVansN19SwjthJO7O1PuTbv9nZ0PX28v
        p3aTMqoQkJDGF19/Jn2SXnfnu+FMK0I=
X-Google-Smtp-Source: APXvYqz4UEpG17P4h2ph/7rj039LHdl/ezi1N02mfm3us+eAS50plIin9HS6dVbN5jkmD6kDpQUlRA==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr2689880ljj.43.1570634772242;
        Wed, 09 Oct 2019 08:26:12 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id d6sm523182lfa.50.2019.10.09.08.26.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 08:26:11 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id n14so2902007ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:26:11 -0700 (PDT)
X-Received: by 2002:a2e:9ec2:: with SMTP id h2mr2389130ljk.85.1570634770860;
 Wed, 09 Oct 2019 08:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191008234505.222991-1-swboyd@chromium.org> <20191008234505.222991-2-swboyd@chromium.org>
In-Reply-To: <20191008234505.222991-2-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Oct 2019 08:25:32 -0700
X-Gmail-Original-Message-ID: <CAE=gft76a_UFaSjca-1nR0Pf5TUU1FqWaEjzRyRhn_SkFmLsTA@mail.gmail.com>
Message-ID: <CAE=gft76a_UFaSjca-1nR0Pf5TUU1FqWaEjzRyRhn_SkFmLsTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: qcom: llcc: Name regmaps to avoid collisions
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 4:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We'll end up with debugfs collisions if we don't give names to the
> regmaps created by this driver. Change the name of the config before
> registering it so we don't collide in debugfs.
>
> Fixes: 7f9c136216c7 ("soc: qcom: Add broadcast base for Last Level Cache Controller (LLCC)")
> Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
