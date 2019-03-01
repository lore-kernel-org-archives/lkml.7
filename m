Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A202C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E6820818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gTkbjbLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbfCAR21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:28:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35015 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733255AbfCAR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:28:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id j5so11737531pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:to:subject
         :message-id:references:from:cc:user-agent:date;
        bh=mtTiAgUXgiDg0Ju2GcPu+saGxj9IwBSraOIw5qCV7kY=;
        b=gTkbjbLHOC/nieuIT+kBv44ds5kXVpPTMmTcfTS4XBMiPA8Ks/5ohjLb0B5FMjUNzE
         ZvhjlR9wrTuxQ3Xdbpq9DD/VWEUfxEiTBNlIwA6w89tH4nG3Cg/bROcYF9lyoGbXKacF
         Puviq8zaqyOPu3Lo0f4GlCTFPusZfOV52pNo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:to:subject:message-id:references:from:cc:user-agent
         :date;
        bh=mtTiAgUXgiDg0Ju2GcPu+saGxj9IwBSraOIw5qCV7kY=;
        b=IKd70pt3kwyUaAY554L3u8jLU+4ua1ZBgGKuybD6yNnPUT8guShPq8WRbm+MPnV7Cw
         SR1Bac3c4lz8ltpOuQYiQQhRiJKbbhHWW/b07C0WcR5k9wMJQgSaPrSdLVm0/1GFIzG+
         HyZXE2Nt4eFYyGTTuoXClcH/jROARQQThORqBFLZg0hDZRhcl30HRghQDr5M/NN7Pwas
         20XyAqXhKrFXMAj4BI0z0NZQsPu2qbZ7P7N5R1WJ52lwx8Iz6AYIz8gzYIQUnu3hwc8J
         nhUHdjElORcYnOlA1z94YmG1lR0hS7gywkSHVGodjv+8W3FuXr+o4udxqUF/a3MKNCYL
         rx0g==
X-Gm-Message-State: APjAAAXfNGxaLHzRUrVAs3opC0BTT5Jaa41dtoGHoRNcW+49TyfIWiVQ
        vj0E13E9AxNnxoDHtWt9uP03gA==
X-Google-Smtp-Source: APXvYqzPRcioNyWgs6+R8h3coUILeyB7EoZ2KdwUWQSYVoNSN7+ioGA0bieollGi4iQFLKdjeX3oXA==
X-Received: by 2002:a63:470a:: with SMTP id u10mr5956403pga.17.1551461301053;
        Fri, 01 Mar 2019 09:28:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h11sm16748713pgq.57.2019.03.01.09.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:28:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190228135919.3747-8-ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/7] drivers: firmware: psci: Announce support for OS initiated suspend mode
Message-ID: <155146129938.16805.4528027710288083607@swboyd.mtv.corp.google.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-8-ulf.hansson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8
Date:   Fri, 01 Mar 2019 09:28:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ulf Hansson (2019-02-28 05:59:19)
> PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
> Platform Coordinated mode, which is the default and mandatory mode, while
> support for the OS initiated (OSI) mode is optional.
>=20
> In some cases it's interesting for the user/developer to know if the OSI
> mode is supported by the PSCI FW. Therefore, let's print a message to the
> log, if that is the case.

I don't see anything wrong with the patch besides the potential for the
logs to wrap and the informational message to be lost, but would it be
possible to express the PSCI features that are supported in sysfs at
/sys/firmware/psci/ somehow? It may be useful for a user to know that
their firmware has PSCI support and that it has a certain set of
features available, like OSI vs. PC, or both. I don't know of any use
that userspace would have though, besides maybe the CPU state residency
counters being used by some sort of statistics collecting program or
just plain knowing that certain PSCI features are present, so perhaps it
could just be done in debugfs for now until a real user exists.

