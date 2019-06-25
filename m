Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7DCC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483B42085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdYu6MwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfFYS6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:58:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39398 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFYS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:58:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so9346741pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:subject:cc:user-agent:date;
        bh=ceYwWxpHgj6RW/JYcqBajIskiEr+F+sxlQ3dc5T/nMg=;
        b=GdYu6MwK2G6F/JAK6zs9UqaJ/hUBYG2tPDfevtw76pWAuvtim4Xw6/eapRfCA9MPKG
         FI5lNa+s+EAHloUsXAVmZoJrAp7wjrZiEWJooZ+yqVxu0AcsPVjoWYPj7f1nVVteyED0
         d7uDZALsf8zJZQ2xUxjoM8EnSmVFD0bXCuX50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:subject:cc
         :user-agent:date;
        bh=ceYwWxpHgj6RW/JYcqBajIskiEr+F+sxlQ3dc5T/nMg=;
        b=DmFHZwdz3j81A3aV/qg9qLypYX+5Pl39Kwz3IjgT4GSgvVSSTozPAJAnMpfQ+4NVZL
         LiMTN02Y8Ris9uk97bqa6Z1R7ILj9jptRohNK9fNFtdP33DTQAZd5PlP0ZYIlmmdGLv8
         qP6Tmh3Qr3bvLdNs/zGh6CVVPX8Gj3mrZI/YbNGKLjrc6IMOAMxRsmenF0AX+jH+NRnv
         tgIgLX4X8a3sz8g4gKBqshk0VYiGlhDPb79eKV5fWk+oRh4HuUXP1uriWFn/5sFw0jCe
         VdamdwwTmWZjpzXjt5amCSV9mx0rqnyniiU2+oNDLVrV3BsszdXYm/j8xcqt+mi95C2g
         w4IQ==
X-Gm-Message-State: APjAAAWqi9HFuIHEEE2X/GYdpw2MY6gBSpZaDvARY1LoVKDDDHKrWgAE
        ndf7UkIsHnI5DuWeoBot8p5zPQ==
X-Google-Smtp-Source: APXvYqyLpKjy/3GnTOLrntTEq9f0J0rhFfy/VGKWAVK0naGezt3DbNhjBQAa8zeZYIrQi4p3+5v1zQ==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr271486pls.8.1561489113820;
        Tue, 25 Jun 2019 11:58:33 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d5sm18582177pfn.25.2019.06.25.11.58.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 11:58:33 -0700 (PDT)
Message-ID: <5d126ed9.1c69fb81.82999.a20a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190517015305.23194-1-robdclark@gmail.com>
References: <20190517015305.23194-1-robdclark@gmail.com>
To:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-cheza: add initial cheza dt
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 11:58:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2019-05-16 18:52:46)
> From: Rob Clark <robdclark@chromium.org>
>=20
> This is essentialy a squash of a bunch of history of cheza dt updates
> from chromium kernel, some of which were themselves squashes of history
> from older chromium kernels.
>=20
> I don't claim any credit other than wanting to more easily boot upstream
> kernel on cheza to have an easier way to test upstream driver work ;-)
>=20
> I've added below in Cc tags all the original actual authors (apologies
> if I missed any).
>=20
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Abhinav Kumar <abhinavk@codeaurora.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Probably too late, but at least for the list records

Tested-by: Stephen Boyd <swboyd@chromium.org>

