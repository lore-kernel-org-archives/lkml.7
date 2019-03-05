Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1014C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACB020842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NtPbMt7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfCEVD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:03:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45483 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEVD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:03:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id i12so8697662otp.12;
        Tue, 05 Mar 2019 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GH9PWq7BwLFfuuMZa78aaB8pbIhV8onTtf7NpZHzVy8=;
        b=NtPbMt7QB/c6LegEcoxN3Aqi1GU23MFJ+ja4h41ZYe3/3OCyLbfyvPghTJsd44FPli
         ma76PuUDof9RdoMPGHf8gOWnaHkJhR5774K4+w1R94EKlYVqn+Ft0+Ssvjm9s25AqGZ2
         lGxja8nUc/7nwb4aqPLcr+Fw7FYDdMkYTDc09MZTDx1bq/JKXAWkjANhK543CANVAYuB
         VEK9WyvisFe34Mi0kOO+sUfSgpIegFR1SPTvmgdo5T5pnkdKsViDdHwV3m7m5pkJSnoX
         o91azTXC1U+m66hxHJ8DpiJ5eXNqrpxccGCAQPVd7EGYALvLfqQ0nukv81+sedTAPPLH
         IYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GH9PWq7BwLFfuuMZa78aaB8pbIhV8onTtf7NpZHzVy8=;
        b=TmbRpRhoYgKF+OjBFDLr54hRTiQ96oTT546j0OKfE3rKssoSSZM0zMa/7WLx8ZkS7d
         ymoXHQboz+XcuYZCZrXM/ZaMEL/SdfWgCbPzKbOQfioKOXiTdbPnxHeu4NVik6tHcqMU
         HECEHa++NheuuFLbxfYSL//vMnR0nsl9i6Efgz1Yyfa4+QG7aAFWy49h9YD3rGWK88sN
         ig9ZcxRlYdlhxaaPg13vh1iQxhTt5xudjFCf/bnN0kAhlonpeVQvAgvyD5q7qGB2lVVc
         NXO1M4VaJC8YPfgmtNMCrRZynjfUgb1BJfkZ/gjkJG1KT/beJou+6aTX8/MHzm30fE/P
         RKJA==
X-Gm-Message-State: APjAAAXnVSq6u6RdhHAD6Cj3a1/RZ6upYqWccFspGYziybsIkL2Nw+zr
        0WWiRqid+41CQvIAaafcQ/6hJzJaZgZRM0u1t947I4Ez
X-Google-Smtp-Source: APXvYqwPiDXybaC+IkpseC0vNHek7azGoumctxYWbPQ1zioQjVZmEXZEPxGkhAUTPXZU+f9jKiXaqeMUNyx16FWqaVE=
X-Received: by 2002:a9d:a11:: with SMTP id 17mr2338491otg.148.1551819807613;
 Tue, 05 Mar 2019 13:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20190304131129.7762-1-narmstrong@baylibre.com> <20190304131129.7762-2-narmstrong@baylibre.com>
In-Reply-To: <20190304131129.7762-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 5 Mar 2019 22:03:16 +0100
Message-ID: <CAFBinCC30DR7dsk589Z2yQr=HkOQofNYX8y-ds1DM_gV=iBujg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: meson-g12a: add cpu clock bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 2:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add Amlogic G12A Family CPU clocks bindings, only export CPU_CLK since
> it should be the only ID used.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
