Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C325B20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QZgNI45D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392754AbfETRKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:10:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38115 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392703AbfETRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:10:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so7089363pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=I7O1t0HTMIayhEjL+JB+8Z7qxurHkXoWUdusDgjI/aw=;
        b=QZgNI45DOAwYaDO1iHICnzp4zHKGESb3mm7wGS2JhmkSoAYChyrynGZrvsxv2RRwFV
         O5jOc+IVUU3xphkbgMuIIJBamG/nurDaVgvwodpNwYOXcQomCmQDTu5SpbYpzcNXuD9Y
         6P2mIgfpgnkVSVjWYL6H9vtosiFubgEEcgjE0fv5qHKs5AQ0Xf1efIiGcx62oznUyjIs
         AcSLpXr98N7w+pcE0juLeZxwWhIXxSf1wCbg58+6vO2cWDwaQ0xK6eXP1kOCR7sen0Oc
         WOCF1P4/bsM5Q6CIyzvQu2h1HQp/LP4ZLD0aBF+7YIVJmDzaLvHfXNQYCew9RFUjM+DO
         +DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I7O1t0HTMIayhEjL+JB+8Z7qxurHkXoWUdusDgjI/aw=;
        b=jI/m5a2hY1kWQYIZCg1ywH7+tdDY515PVgN9n1xnjhffM2nAwsqO4eBwn2OkplX8Er
         bqe+fCaIhk9FJ5GX/JMAFFCdinuibupXoXYs042SWunKZRIbAkyioWaSHIdlKuicaXPm
         PrlR5t3CQBtGLNMgioQvh+ybrYLuE+obluXg1GMVPbHIG4fwieuMn5YUyhI6iit2Fv6C
         Dlj6d4+pcDpjGZUqD5uA2YfH8w6Smv1Y0ek/sEmVfn3MG9oDgcC/8onJWfUvwC6Mzy2l
         n0AK081dL7CFlq0UjsxRZnjuqTu6cipPEclnHLOGtLiT1F+m9+ClC8lcs75Hx1EWszPA
         JMQw==
X-Gm-Message-State: APjAAAVHy4g07VcNRvYNa6Cy/0TLxH8ygIQNlwXeyHq2SEwkv0y6jF73
        stt+tcYZnkfcrKfkH/7iV6LkHw==
X-Google-Smtp-Source: APXvYqzaOlQqLS/+QC42OQ5Qr8ZY2ncGO7QbGmE1r8wBifQgCAbuNUputplZ7iTSIWjw5VjtKCNaTQ==
X-Received: by 2002:aa7:92da:: with SMTP id k26mr36518157pfa.70.1558372222724;
        Mon, 20 May 2019 10:10:22 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e483:1cc0:e2c2:140d])
        by smtp.googlemail.com with ESMTPSA id e10sm37432545pfm.137.2019.05.20.10.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:10:22 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: amlogic: Move 'amlogic,meson-gx-ao-secure' binding to its own file
In-Reply-To: <draft-7hsgt9842a.fsf@baylibre.com>
References: <draft-7hsgt9842a.fsf@baylibre.com>
Date:   Mon, 20 May 2019 10:10:21 -0700
Message-ID: <7hmujh832a.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Rob Herring <robh@kernel.org> writes:
>
>> It is best practice to have 1 binding per file, so board level bindings
>> should be separate for various misc SoC bindings.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Carlo Caione <carlo@caione.org>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-amlogic@lists.infradead.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> It seems this one fell thru the cracks and didn't get applied.
>
> Feel free to apply directly.
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>

On second that, we're going to have dependencies on that for the v5.3
cycle, so I'll queue these up.

Kevin
