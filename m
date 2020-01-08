Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F22C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B59C2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I69W7MIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAHGyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:54:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37235 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:54:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so1088759pga.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 22:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=jrDSpPlac7LfKsNtNNcdyco4L0d7qWfB7luT8Ldf28Y=;
        b=I69W7MImSC2wNVx/FY0O7PzWcgYEwrZUPpWt7h55LmqvKIrIQDJUgcvL643IVqK6mN
         bvfR68TMy3Dls/cKYwYlmiG8iVgRgxM2v08um2gSy4qJG0HRE4DwpZOvX88psHT0NT2z
         b/Q/gp1vjy0nAnB5/nlsA9NHEByMbm188IcJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=jrDSpPlac7LfKsNtNNcdyco4L0d7qWfB7luT8Ldf28Y=;
        b=Ues/pNC0kO8KTZi6t85HsPGwCEYHe9goJCfpizn4BcQNyFypuZYascNCsqyFlUaieV
         OjoX48ReNvUU5rP1pCZInWijKTE2dij7C63aYDa2Ociqr3TQM7li6aQIt8vsiLjQj2NE
         v9Tj4km5ABWSl+T6di7u3A66wr355fvS+ir/THBNQNWmLpfhdGcN0oyquJI48HXhPi8l
         kSAlYAKXoZSNG7FDMHcJ9aCKmDL43N7sRzmDPzvTBxsnfrth3K5qWibSDVurUPgSG+7P
         qZVB1CTiAs/QEdSaxrhwvlrN0VweNLlsljMMpodm+S4/IW6pKP5PbWimcaBJcewIhQLA
         uJfQ==
X-Gm-Message-State: APjAAAUhpPIH6kRSEyzHDAxQ1o81rSkuw96NaO4/I1QOWVQfMOfsqBSk
        4RxGkFxiBpiW7JYE1bgWqclsE8W0s5iVZg==
X-Google-Smtp-Source: APXvYqz8or0Ls9NkRnH1QhAOAttYIbiRMPl/me//+J1jryiU1iq3zijNwoGBlvn8iwQILz//9BLm+w==
X-Received: by 2002:a63:1b54:: with SMTP id b20mr3695731pgm.312.1578466484350;
        Tue, 07 Jan 2020 22:54:44 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x11sm1836650pfn.53.2020.01.07.22.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 22:54:43 -0800 (PST)
Message-ID: <5e157cb3.1c69fb81.4f0ae.6172@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200108064253.GB4023550@builder>
References: <1578431066-19600-1-git-send-email-eberman@codeaurora.org> <20200108064253.GB4023550@builder>
Cc:     agross@kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/17] Restructure, improve target support for qcom_scm driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 07 Jan 2020 22:54:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-01-07 22:42:53)
> On Tue 07 Jan 13:04 PST 2020, Elliot Berman wrote:
>=20
> > This series improves support for 32-bit Qualcomm targets on qcom_scm dr=
iver and cleans
> > up the driver for 64-bit implementations.
> >=20
> > Currently, the qcom_scm driver supports only 64-bit Qualcomm targets an=
d very
> > old 32-bit Qualcomm targets. Newer 32-bit targets use ARM's SMC Calling
> > Convention to communicate with secure world. Older 32-bit targets use a
> > "buffer-based" legacy approach for communicating with secure world (as
> > implemented in qcom_scm-32.c). All arm64 Qualcomm targets use ARM SMCCC.
> > Currently, SMCCC-based communication is enabled only on ARM64 config and
> > buffer-based communication only on ARM config. This patch-series combin=
es SMCCC
> > and legacy conventions and selects the correct convention by querying t=
he secure
> > world [1].
> >=20
> > We decided to take the opportunity as well to clean up the driver rathe=
r than
> > try to patch together qcom_scm-32 and qcom_scm-64.
> >=20
>=20
> Series applied.

Without the change-ids presumably? I was going to review the patch
series tomorrow but I guess no more need! ;-)

