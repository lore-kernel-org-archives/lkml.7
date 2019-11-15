Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249B2C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C3920732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXpz2/GG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfKOTii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:38:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41071 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKOTih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:38:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id p26so7151415pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=rpIokldTgdr5Exrhz1mWV7HaLCSuNS/NOSl6iO2Uvg8=;
        b=UXpz2/GGf6m28T8JsRJL22/FmaujD4Zkm42D4hqF1gSN9xyzIKBP3jZPikdFoLutN0
         1QwHjpjumV9GiZEurjnQujKejh1y/BRNClPVP3v+DWWoMqXo/U/+jfny1z67SpJ8Aedd
         x6F5L4BYk9ZEUUHmuomaBUpqdhxgthCmLWzwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=rpIokldTgdr5Exrhz1mWV7HaLCSuNS/NOSl6iO2Uvg8=;
        b=OWDK688RIZkqw5duYjIL4utHt45DADV9Ick5ueaEYxehg0Lz+1ubp4skUNohuZUAwm
         C5PYAxZZ6LIDEqf84H/KPnme/Kxv0oKTgaCLgfK5cXRW0sqvjFskhgl7XHkPnorrQZqI
         cHwfbz5buE0ceA4R5w8J5bk36dM3q4pYaV3wdAhDMz+C1nLbRvFM+nXY1vPjCR2bFasO
         C1pKuTDSCFWvDNqXYugCxHv1Epi87W1SAVe42i6mED16/rJTbmgN4ll14UhcqTbXAmux
         MRAFDypxfHvC2HTI1eN8Ak64Z15um4iP/5SgfGnQIwrc5Ufjub2+xSnuv+0LJH6Hu5hg
         Clug==
X-Gm-Message-State: APjAAAUQnMOnUnsBIAf/SPR5zgdWL3yVh52nx/oxIa5zD5fPfhafQsTB
        WvKj2nUx2d7ICEetqAwunouB4kMunws=
X-Google-Smtp-Source: APXvYqykqc5dyf2YeTH9F9RX5Ivj9h24yWKDFvAQmQ98bDBv24JthZfMkfiBfpD1ahLZlS9AfiPdcg==
X-Received: by 2002:a65:6145:: with SMTP id o5mr17611208pgv.38.1573846714978;
        Fri, 15 Nov 2019 11:38:34 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h23sm10528899pgg.58.2019.11.15.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:38:34 -0800 (PST)
Message-ID: <5dcefeba.1c69fb81.258f2.f70e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a2bb92de65e90768bf1d6b8c0b7fbd43cba704d2.1573814758.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1573814758.git.saiprakash.ranjan@codeaurora.org> <a2bb92de65e90768bf1d6b8c0b7fbd43cba704d2.1573814758.git.saiprakash.ranjan@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Update the device tree node for LLCC
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 11:38:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-11-15 02:59:12)
> LLCC cache-controller was renamed to system-cache-controller
> to make schema pass the dt binding check. Update the device
> tree node to reflect this change.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

