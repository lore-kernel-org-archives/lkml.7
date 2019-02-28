Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EEFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5137C218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lnzO17MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbfB1TXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:23:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733265AbfB1TXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:23:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so10168126pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:to:subject
         :message-id:references:from:cc:user-agent:date;
        bh=USKO1K91LHMIrRcecu4GrjSCsQ8aKYxK98h4rZfPM44=;
        b=lnzO17MF3asErotrWpFFBkjjaJUylxRJY6IXHqTRnZxxQgg4JyjxRJKxTHpSXu0GVx
         I9DVp1XY3Hgc1fokdb6z/VJVprTyxFtXx/PjvVYMzlU11vb++iHg/Y+oxFeyRGBtVy1I
         obFxHmO0n+YN2lGFTBMaqSiJS6wpBqW1F9JII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:to:subject:message-id:references:from:cc:user-agent
         :date;
        bh=USKO1K91LHMIrRcecu4GrjSCsQ8aKYxK98h4rZfPM44=;
        b=trqytN11jOdabBFo2aeVQOrWB4CTkajYzi/WK9FuFEpignkZpRj1BQRRUKBAWr/M6o
         tcjOP2vhrQ3B/DkXMKstWJ5j43OMKARymx/H9p3ur1b1UQbcnMX4qwVNLTb6XKDqFgh2
         +rg88demYZFEgZX+SRpOC7FFHjjdsoQAaYzSTQAL9xnx4V9XEX1yYdQqhaxkxSshWWzM
         orYwUOUWyOkKcGjtCOGRIUq0IDFaaM/HPr92rPtaVqCnVmYMZQ6CaYxNpVgNrrxwtzFN
         Ruhr7czO551GjUEtEe7O0zIxRert+tx1saPLILYR1NLjTdjj4+dH5bxpN+mZaaoyzMrD
         K7Dw==
X-Gm-Message-State: APjAAAWL4NT/0DZBc9rRebb2HrCSWToXosJlRNd3lfCrgV6QvH4VaSad
        m78P5w75WxZHZ+6z8Xv+aUOcr3LEwiOiIw==
X-Google-Smtp-Source: APXvYqyc2bfeSAQgnS8JzgrJBBHaSOUGQC618j1GxRTtb5TtO6n646l3U2+r+ln7KnK0vDrE6z9EJg==
X-Received: by 2002:a63:e801:: with SMTP id s1mr743386pgh.378.1551381793569;
        Thu, 28 Feb 2019 11:23:13 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m17sm33918868pff.170.2019.02.28.11.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:23:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190225065044.11023-2-vaishali.thakkar@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org
Subject: Re: [PATCH v4 1/5] base: soc: Add serial_number attribute to soc
Message-ID: <155138179198.16805.9027110619113379120@swboyd.mtv.corp.google.com>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org> <20190225065044.11023-2-vaishali.thakkar@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
User-Agent: alot/0.8
Date:   Thu, 28 Feb 2019 11:23:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaishali Thakkar (2019-02-24 22:50:40)
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> Add new attribute named "serial_number" as a standard interface for
> user space to acquire the serial number of the device.
>=20
> For ST-Ericsson SoCs this is exposed by the cryptically named "soc_id"
> attribute, but this provides a human readable standardized name for this
> property.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

