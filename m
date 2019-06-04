Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5DEC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A937023CB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LswJWZfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfFDQyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:54:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32850 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfFDQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:54:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so3250905pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=gsZInba9qrm7ODb1Yq1UhqmbBbAzbVjS4lLusubD2Ls=;
        b=LswJWZfy0lu8/m4EY2hN5vUBYjLbzIT/pf+JSF0lQ6U9Y9NIEvJa6+GFHY9rgaj8qi
         qU4lFztnpLWhlZy9grrENap6Snf4V/1jQk0ZHyBIEqqGQ7BxCKyacYn5gvRSp6IiOTa/
         u10YwlK6hJfJNh2+Vb2RSJ5qHGVtCqk6ZBheE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=gsZInba9qrm7ODb1Yq1UhqmbBbAzbVjS4lLusubD2Ls=;
        b=cWKpFYGYswXqFxC+k74oKlHtw/MYgsX1IdvZYcJFWNECRUdAlnrFnQv0iu3We0ClF3
         j9u8+4aeKNxgNK/XqIeO+2NKk2u0CeutAuTctoU0TULcItQzd1zIc4oD1xN5yl3bXuxs
         BkpMQt6lqrtEZWVLwv8Am/etMKBXCXcn0dNNL12ipgpeHatMzeM5fo0XtvkcyQwBfeWm
         5MaU0RKGbYtDwFUP9iNupMlGQW5x/iSumRS6u6F69ImANlzYhbVav+f+bDAfYV0BHs3y
         Pgt6p8e1X3Ia6QqIe09KDUBePeDa8iyhKstOWjt6W5hZ8kBDfiUwV3FmfeNUbetDnD6z
         U/HQ==
X-Gm-Message-State: APjAAAWhPqjsjKAgTflShm9S9lhPHLaexlzA73tL7yEjDnNn6Eo76+La
        j9//JT+9dFyCK1JV9aFnmGyJ4kSOB1A=
X-Google-Smtp-Source: APXvYqw9pQz0rGAmcjPIXcqIkj2VDqLOxoPXUACeihkAkH8amjHnLXEgaHBbXE2DoKkgmbIh57yGoA==
X-Received: by 2002:a65:56cb:: with SMTP id w11mr36437881pgs.236.1559667277056;
        Tue, 04 Jun 2019 09:54:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g3sm22917280pfm.150.2019.06.04.09.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 09:54:36 -0700 (PDT)
Message-ID: <5cf6a24c.1c69fb81.c970e.907e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190603155612.GC63283@arrakis.emea.arm.com>
References: <20190517164746.110786-1-swboyd@chromium.org> <20190517164746.110786-5-swboyd@chromium.org> <20190603155612.GC63283@arrakis.emea.arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Dan Williams <dan.j.williams@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [RFC/PATCH 4/5] arm64: Add support for arch_memremap_ro()
User-Agent: alot/0.8.1
Date:   Tue, 04 Jun 2019 09:54:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Catalin Marinas (2019-06-03 08:56:13)
> On Fri, May 17, 2019 at 09:47:45AM -0700, Stephen Boyd wrote:
> > Pass in PAGE_KERNEL_RO to the underlying IO mapping mechanism to get a
> > read-only mapping for the MEMREMAP_RO type of memory mappings that
> > memremap() supports.
> >=20
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> Not sure what the plans are with this series but if you need an ack for
> arm64:
>=20
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks. I'll resend without the RFC tag and see how it goes.

