Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE70BC32757
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD1E214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSWNJRfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfHNSTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:19:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39387 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfHNSTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:19:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so53485475pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=cemWnJlXygQVUHs5+9IULKNWTiOcpifvvGT6fgr1/ss=;
        b=bSWNJRfNBipTymbkmcbI5jJ3xyct+DaLS3dGG6WRYspIUm5G+b1NTo0h1QJTLpvS7m
         J5I65FRuW6QrGcoTfpiTZgdQCr5st4md64gdF/URuzzvrSyp8enuxe4pg4FyEk7nkNrc
         zolJ+z234CDVbXYq6L2hbnJQvCju5CwF5qCjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=cemWnJlXygQVUHs5+9IULKNWTiOcpifvvGT6fgr1/ss=;
        b=i2r+xFd05S4/p2rQhEdLG9XGXEe4pTJWiJPqKp2UHxR7lqHDmQEnD46fXe9h/aeFmp
         ZYPm1IeRjdx8UcajTcZOl88y/ZVdsVf5PZ7+U6s8VxghjvDgh1ltVE3d2N8xeIbtwUvl
         sUaUKnOd6V1tDk/CrCu6COCdEO786EaDwlCeb446u2KvwZLOQjaG5g8psBjj/YBjIelZ
         mQ6ZakJtKEgQ4WpYl3oye3UnpKHZCMtRyE2++DrnvSEFAkKUevQzRQWuxrkhsVcxxmKz
         4U6BU1cAyvhIpu3Wd6d0KOYegU0rRoNK1OyFgPGE/s6ratCeMKvdnMtlYCw0GKFrkVAZ
         iRHw==
X-Gm-Message-State: APjAAAXbz+3LPhkREHfaqk/zMEFmYZF2toOjvAbpZDSPz/ORBnzHiiCQ
        hocJjUimayVuwUhv3DU21QbwLuEpbW6ieA==
X-Google-Smtp-Source: APXvYqyq21lgcDuREFVcb4CjJEe4M1+jIFdEW9koO5WaBv/ywvDRXPU6oHaKN9VXlRtTSxSUXPMCmA==
X-Received: by 2002:a65:518a:: with SMTP id h10mr398117pgq.117.1565806771571;
        Wed, 14 Aug 2019 11:19:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o4sm790460pje.28.2019.08.14.11.19.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:19:30 -0700 (PDT)
Message-ID: <5d5450b2.1c69fb81.ec1c1.1cb2@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813082442.25796-1-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org>
Subject: Re: [PATCH 0/4] Add RSC power domain support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 11:19:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2019-08-13 01:24:38)
> Resource State Coordinator (RSC) is responsible for powering off/lowering
> the requirements from CPU subsystem for the associated hardware like buse=
s,
> clocks, and regulators when all CPUs and cluster is powered down.
>=20
> RSC power domain uses last-man activities provided by genpd framework bas=
ed on
> Ulf Hansoon's patch series[1], when the cluster of CPUs enter deepest idle
> states. As a part of domain poweroff, RSC can lower resource state requir=
ements
> by flushing the cached sleep and wake state votes for resources.

This series looks like half the solution. Is there a full set of patches
that connects the RPMh power domain to cpuidle and genpds?

