Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E50C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DE12173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PtNGh7vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHQEDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:03:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40092 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfHQEDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 00:03:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so3235779pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 21:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=pXBlTpO2GjUBQ6jSlgDI9YWY/1MbzSJdSmD+5A3FCkw=;
        b=PtNGh7vdCiqdD4hRdr+Xk39n62axtunyuxtDDhHVeiRibm/5+qNv7A0Qq5H0fQrvFb
         dK1to8T3Hzk4lk1FgmxzaeHrs0J8Vrw3AA0+NUUBJhxrZ7keL3WoPRDblDOzVtLBvHRN
         NLaK0cMstfNtFwF9dRVjl5PnxkN9j3QyjgI3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=pXBlTpO2GjUBQ6jSlgDI9YWY/1MbzSJdSmD+5A3FCkw=;
        b=GB2d1bTzFp3zpamd4W4Yr0wiFH/HZ1G6FzH0SVUOEY1kf6f7OIcZgyIgS2a8YoxNNe
         ScOzKhJCfWwENq6IixZ4DmJRL3tIFJd/kKrbg5egi0zb/PFCWv73ZCWUm323IViCDw3s
         6hzAa3cw3XFjPH7nFM6O+gOwj4CL0+TX+SHSW+Dc0+8CqHV4x0agdA1d6qR5FH57mD3/
         uOMxgW73ZUEDuUf9204/AnZKrYckuPkWYSWBYTgGWfx5bgbjewzPnXC1tqJ8n6q9CnS9
         QQcawMR752na7LZUyHlB90svqG3lfcHRNAKjkRpEP1h1yF5zCR4BTwpi9p0rJeui1f7N
         pDBw==
X-Gm-Message-State: APjAAAUA/a9T5q3Rvj4uCk7ynm+RQkLjipN7h2FM9g/i4qNaR+a5eavZ
        KCc794i26AJvm38wfjPsHhDhnw==
X-Google-Smtp-Source: APXvYqwK84XyJsvkHeRp3YZ8xSrSKr9P+aAKUhjZ/tpZXI4A6mRuv4TX1+/8f9hDVYtb92wTY6DJLw==
X-Received: by 2002:a17:902:2888:: with SMTP id f8mr12244041plb.26.1566014614940;
        Fri, 16 Aug 2019 21:03:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z16sm7101782pgi.8.2019.08.16.21.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:03:34 -0700 (PDT)
Message-ID: <5d577c96.1c69fb81.48f7f.43b5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0f2027f458f8b7f17acb024cf47082052f416805.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <0f2027f458f8b7f17acb024cf47082052f416805.1564091601.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 21:03:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-07-25 15:18:38)
> Printing the function name when enabling debugging makes logs easier to
> read.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

