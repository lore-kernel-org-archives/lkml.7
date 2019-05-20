Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05A6C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750852173E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QPI/0EXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390010AbfETQsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:48:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38345 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388933AbfETQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:48:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so6971852plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Vpv1DN8EBhtKb87cGhyJ5jDNciiux86pE0rF8kV5anU=;
        b=QPI/0EXLgUxAizQQp+dpGLgwI1Z9jwTSQYDwrECfSRd3uZls2oSgbhTYBR7s/zDFRq
         wyMaNtE7ghGrsfUn3wl0iYUp6+pcXKHmQuWle9Pw9Ez6+dxZgxyTpbHn9NOirC7WRbjT
         ECm5VTMyDT7OUfx/Ogt404q4ftwdgiEWY6Eo/HIAfZLcb3Hhg7hrzSWUjPoWfCNanAUO
         jMHHo/O/aiR3vwTxC+nAKSvimPab6BfP6J8itkE6ADAUUNMiF7StTyeVJrjANhG8IDSB
         zBXMxekpJl9tGqXo8do3NMWaL5SlbfSzBYD3qZi4vKHIgYoFjMWk16rwSA2rtLKTJ0gz
         30oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Vpv1DN8EBhtKb87cGhyJ5jDNciiux86pE0rF8kV5anU=;
        b=LI2eoinfDUb6gvof5e9iXHYdD9oJXU6b3G+Mr5cq8mmLduNCHR+y+1ttS7T0BWCTi9
         0TaKDmbxa1G0/9AMmkmOstJ2mfpeVXRYC/wBr0yG3WF4x8hkxErpY0/OoiDdLvycaQRb
         11mVgRy9e8t+snjZ++diNdMCcedD9gAsSRRDoRvdVJHxemhXMDaQ53SiOVuzSRRTNyRt
         tdmSQObirgHrdx5DNgdCapkUz0UorCV6/n0gLfT+owevmDFo7eH4Nqz2a5u35lUHgF3C
         OjIhU8ltDjT+SZtCQivLkYtesSTcM16HH2OGPVa//uEBemvnrwS3gvhY3fS8q0inhsCM
         gZ3A==
X-Gm-Message-State: APjAAAVOZFKPg2NTzXKnUzkAgGPG8OZCH/gFOoSgMpF90TigMS/SsUDK
        LYoGG6e7s7CwNHL3ZXGK4k28jA==
X-Google-Smtp-Source: APXvYqysMaZyPln+k/pU+4hULFRtD/HxMzhT4oDAxWzPHQZQ1SyWi45lHBtw8TfwNthofEo4JX3sdg==
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr19217707pll.191.1558370929609;
        Mon, 20 May 2019 09:48:49 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e483:1cc0:e2c2:140d])
        by smtp.googlemail.com with ESMTPSA id r1sm11689953pgo.9.2019.05.20.09.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 09:48:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: amlogic: Move 'amlogic,meson-gx-ao-secure' binding to its own file
In-Reply-To: <20190517152723.28518-1-robh@kernel.org>
References: <20190517152723.28518-1-robh@kernel.org>
Date:   Mon, 20 May 2019 09:48:48 -0700
Message-ID: <7hr28t8427.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> It is best practice to have 1 binding per file, so board level bindings
> should be separate for various misc SoC bindings.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> It seems this one fell thru the cracks and didn't get applied.

Feel free to apply directly.

Acked-by: Kevin Hilman <khilman@baylibre.com>
