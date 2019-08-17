Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4298C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FFE2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixPLfl74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfHQEB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:01:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41951 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfHQEB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 00:01:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so4104176pfz.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 21:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=41DUNyHfGDYGOFlacUiPuaR42aKSRfTphWQX5UDtD6o=;
        b=ixPLfl74xidyeGDAyESYrtkRAaaOMaad+qjnu1XULZZimjYFtEn181iLZpP1ym0gTA
         PyreXM8okqrfOAAnHjzFtE/FnJKkFAp8pd4+9ldH2Wlq/lH1I1IyQLfzS8xi6udjNbnC
         tvTGPUZ1nfHWe6ixN8ihl34CXoXxiNO57br9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=41DUNyHfGDYGOFlacUiPuaR42aKSRfTphWQX5UDtD6o=;
        b=FtFGS6MyJ37LsBASvuLOIXtK4A+jjZDmnORzkQbmxGPnKWoTyRBcRjGj8tVYwHdMEW
         zjQXU3coBGr2+cLFIYrPdX3AW3kaBrp+4m6G1IpqZ+mlDHMarytH4bH8947P97xjfZ+p
         dbPd7rJ0OX5Il51xaEN4jXcVa6OqZlJ6qc+8IvhxLhwWtEUYncta4xS2Z7IV7aK8w4qd
         M6ZMDevqCY4tTOF9zZRHd3VfvVqraTyxcw4lGcVpRyy/ph+xst0b5t3Kly3tiYkhqnP2
         D/jgRQgoJJQTVY8xgzA+V+6X4WmNjQt06knjbZZYTyWw1m7doSRXvT8plPs2lOwQ7e7C
         34Fg==
X-Gm-Message-State: APjAAAV0MzVjCZXaXXI/1e2i+VsE57ttnCvfUC5Cgp9vCUUaDRMpQFNU
        9tv31b3Cml3YGTAj88rHLnEq/w==
X-Google-Smtp-Source: APXvYqziDXUQ6baa9UVufZvuqukFBB8IgCHuhJBV0YUPgaMdR05hRMBSBQY/Mi09HZoEtziD5Ch3kA==
X-Received: by 2002:a63:1046:: with SMTP id 6mr10700399pgq.111.1566014515650;
        Fri, 16 Aug 2019 21:01:55 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j15sm7429996pfr.146.2019.08.16.21.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:01:55 -0700 (PDT)
Message-ID: <5d577c33.1c69fb81.f966d.6963@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9dc86fa912d9b6e21857598ad81ff88564468e5d.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <9dc86fa912d9b6e21857598ad81ff88564468e5d.1564091601.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH 01/15] drivers: thermal: tsens: Get rid of id field in tsens_sensor
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
Date:   Fri, 16 Aug 2019 21:01:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-07-25 15:18:36)
> There are two fields - id and hw_id - to track what sensor an action was
> to performed on. This was because the sensors connected to a TSENS IP
> might not be contiguous i.e. 1, 2, 4, 5 with 3 being skipped.
>=20
> This causes confusion in the code which uses hw_id sometimes and id
> other times (tsens_get_temp, tsens_get_trend).
>=20
> Switch to only using the hw_id field to track the physical ID of the
> sensor. When we iterate through all the sensors connected to an IP
> block, we use an index i to loop through the list of sensors, and then
> return the actual hw_id that is registered on that index.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Nice cleanup!

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

