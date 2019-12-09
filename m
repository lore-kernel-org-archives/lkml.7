Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A792C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08582068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eBzDFNJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfLIWfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:35:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45222 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfLIWfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:35:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so7433596pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 14:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DpEDnczTgLmUSLdSdUYrI+chr7EHogU/r3WqtZ4to3E=;
        b=eBzDFNJnIO94AMgtEUzQcizLOePZOk9ymDnd7glk+21xbOY5st/iVlmzg31PmaX8If
         nIQwr5BWKpHW6KEFvdiqB2uuXizK//53pmw061q0FwTlIBtDRlCkVqEy7GyIydGpGg6B
         SAXqYXQOZIz6XwWOte5TdVpbtUpoW8cmxZIuqBpZt+FN4GKPuLLEQVHjJXZdjcrAVGv9
         Gm2zbhS/g0j9Mu4lHwpnJyaSQ52xzffjzEvR/4VlPc8OsEwTBlf8rvau30/afqLye9rd
         /iohDEY85cmNGxR+gH6wQpnDfWsl6jNyWeHrBa1exNXL/YIkBa22RgYi+5xYzq5sZDHc
         jx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DpEDnczTgLmUSLdSdUYrI+chr7EHogU/r3WqtZ4to3E=;
        b=NgkqVqZKTYawhDJtnuAMpzaZysTelErVu0qe/QRIqw9xoWOLFq+dkRqCWJaEM4t9R7
         QImhS9pspCJBboZLPxkqYg7LxSnTESGyCivHYlZ9WoIHah3BodrxwHPKSrk0i5coawpc
         ZNUJph9ACvSAm1OVX0zVqZlaOQqtcXHOT9rmVv7ZAafNhGHnvum7xFbR88C6sDAVDPqa
         Kbjh2DXNjhmDNsIG76FPjDlEs5CpsT9DSTZ6iJ4v9zB+wUG+IjUFk9h108daq+thjIkl
         cdJrWdEkGq8AfR8SVMjGKugcV+lC3r9dgzcDCvKS/eI2EoYbcj3/ggybGHZG0JbB28G0
         +usw==
X-Gm-Message-State: APjAAAVFFe+23taocdgKFqp2OYhp4qK9h6oYde794oCZa706866UHif3
        DF1TTv3fbCeaAIPuSs8W2enNEg==
X-Google-Smtp-Source: APXvYqzf9KQsOlR/3bHydft6MqOQT/ZvVC5FuQTsBmeouaIiaqFg1BNIjH9a/lbszhQIz2OsAmf7ZA==
X-Received: by 2002:a63:5920:: with SMTP id n32mr10910399pgb.443.1575930941752;
        Mon, 09 Dec 2019 14:35:41 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id h128sm480972pfe.172.2019.12.09.14.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 14:35:41 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-sm1-sei610: add gpio bluetooth interrupt
In-Reply-To: <20191205131900.2059-1-glaroque@baylibre.com>
References: <20191205131900.2059-1-glaroque@baylibre.com>
Date:   Mon, 09 Dec 2019 14:35:40 -0800
Message-ID: <7hy2vlqg8z.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> add gpio irq to support interrupt trigger mode.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> hi,
>
> this patch depends of 
> https://lkml.org/lkml/2019/12/4/644

Just to be clear on the dependency...  This DT patch will not change any
behavior until the driver patch is merged, correct?

But if this DT patch merges before the driver patch merges, we're not
going to break anything, right?  We're just going to (continue) to not
have working interrupts.

Kevin
