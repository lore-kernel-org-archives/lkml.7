Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09414C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78CA20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="daAxOYfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgAHTBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:01:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43916 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgAHTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:01:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so1480003pli.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+JYKs8IBCn+dDMZJfNg8HbS7zBGKMw04iMj1o0iHpZw=;
        b=daAxOYfB/C6ZvBYmYDxatyUSCRJpDXZuC6cvFHZXVHZR+k2InB/TQF45/MbsM8t+RZ
         jAoffKmaXBtl/sonYDuNalnkTfvVzW/P0s3K4ldjdajpRlKaufKaOW78Duq7Pji4/+Gl
         bGOWnS+27/G55F1bvWNfnqgPX5C1D2222ojSeMI1C3fPYZ68Wq970gu86tFI4mcEjc9R
         mHzd45AnODBO1ZqeToWiLcAD3MpGV1hYBNVKCbVOd2yZWNYJdsM7jl95UFwdolN1BIto
         vfGKAQ9j7COtPMODwCbCI6GBHTHW8OfTeogKLBu3vHTo3hr4S2RvF+aZzcbCAgJQXzph
         Ukcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+JYKs8IBCn+dDMZJfNg8HbS7zBGKMw04iMj1o0iHpZw=;
        b=gixbfV3AZgooZGCG6nTar6u4OedMvbjwa9UjKOODK4xMCMSqXvlKakru6Hs+BPUK6f
         7eNJ1Y8xdeGe+brrB2aZvJHmjASk5UbfJig51XJOVrpyVgFqCFNPn9S8zbXK0PrhTU3k
         5lQpfnxWryMKa7rticc9tRovB15g+rk880K/7RsKYz2l3EhhQe3e+pPcf4K8G78AENQ9
         MyJqO33/blY63r2zkj77h6B7z5d3RNyhhVTQ1dDNvk4h5SJliUn9ZQTQ7o0vC1UdE14y
         fspeIC65EVQw434fES1jlQa1y5IaKRENgdBTM/ol2SEtwHv8CyW+4CwZ64L4B8DJrBqN
         8Y4A==
X-Gm-Message-State: APjAAAW21vgbdT3NKUlyPfUkuO5TPqQej2ntm4XtCFjW51WQnyoXEOsn
        qqCcpf7cNqsyL8929xd+2OELExpY1Ds5Nw==
X-Google-Smtp-Source: APXvYqytkmEwJ7nWAkafKbqKMtVMYlkDminYrsnNeeN6pSN+L09PCE1fv+E4wVe0/cBFSbqYklIegQ==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr87829pjb.90.1578510087816;
        Wed, 08 Jan 2020 11:01:27 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id j10sm26200pjb.14.2020.01.08.11.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 11:01:27 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/3] ARM: dts: meson: fixes for GPU DVFS
In-Reply-To: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
References: <20191225010607.1504239-1-martin.blumenstingl@googlemail.com>
Date:   Wed, 08 Jan 2020 11:01:26 -0800
Message-ID: <7hftgpg4c9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> While testing my patch to add DVFS support to the lima driver [0] I
> found one bug and two inconveniences with the GPU clocks in the
> Meson8 and Meson8b .dts:
> - the first patch is an actual fix so the two mali GPU clock trees can
>   actually be used on Meson8b
> - patch two and three are to prevent confusion when comparing the
>   frequencies from the .dts with the actual ones on the system
>
> Neither of these patches are critical, so I based them on top of
> v5.6/dt (meaning they target Linux 5.6, not v5.5/fixes).

Queued for v5.6,

Thanks,

Kevin
