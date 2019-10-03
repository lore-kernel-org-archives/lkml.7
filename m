Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F1A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zXh23Z7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfJCRqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:46:21 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:37566 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbfJCRqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:46:20 -0400
Received: by mail-pf1-f170.google.com with SMTP id y5so2227580pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YBqTO1SR8JZ4rSW8NROiJQC8y+FlKcm5wmclx7YsqJA=;
        b=zXh23Z7/bQMXb1njJl5nd10TBMyIcKR2f6rXFwRg7lRseFfvNdwk5hGEOeUVaFd6AE
         T04YhoYOJAfsK9QdRuija7o1DJFJpKusBRlgy6Puv1OJRPq8hBrCTL4vhDXSQPVWZaAr
         BEnZfDQlRVp7q4Ibb8SMcqypMkzM6YCeCGNOr0MYXvk7+IxbSwPJ7DkhPfaJ3JlMIBA+
         dzQ5cMFBlQ6H6S2TM1HRBDgs+WnT+7nUT7ao4Gfm+pgHXG7R9hGzcZ7bT59+ywHCnSFt
         YloS1Cr05MEyMlQnVdxLlouP7nHl9mitEblkfcbO9Ej4wJzDsMYd9yHDy0fSjWNu9ZVd
         eBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YBqTO1SR8JZ4rSW8NROiJQC8y+FlKcm5wmclx7YsqJA=;
        b=sxRTymrT7zPRvOnjCt91cUrr6OTmTF/IDizNgPvXegeoJKc9UNqsfb/BWaSSz7vt+9
         0YMuaeF7ZpUXRIFThnXoiFRTc2nkZfGVrvVEEPoWjfkKBWDN771aGYGodybZsoQS9GlM
         TU+wRSbiAU4rLe+eVmOjXkhBNsKuHEUh7NtHOj1HOyKFClw8jn1AaTd0KKuK/gEl9P1X
         fbtVH6fFkJUXpV2LpRWsPTy7l7Pope0rUlER4g6BBWNaElBjTGvpTtjIL49Jilv0Adr6
         gNbllUDjUYqyXDN7mwCY8EBCaANT351OgzQWOCLt4gMUs2My8UU6fBbykIrnomQQepvH
         bIoA==
X-Gm-Message-State: APjAAAV8cF89mexAH0YrjN+8HGpqSnDeP/XE0UBFswj0VlYNXJYdnu13
        zEZWGzSV1//pTN/iTBJYdUhKsE7nEBA=
X-Google-Smtp-Source: APXvYqwGyyHM/joodBfrobBkDYq8xYqnEIe7owkvzFzx1uMOZNAZN9I8MRSWEPPfqOEb5FEBHtqCJA==
X-Received: by 2002:a17:90a:ae0d:: with SMTP id t13mr12067312pjq.60.1570124778487;
        Thu, 03 Oct 2019 10:46:18 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a084:116f:9da0:2d6c])
        by smtp.gmail.com with ESMTPSA id e9sm3138664pgs.86.2019.10.03.10.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 10:46:17 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: g12a: add audio devices resets
In-Reply-To: <20190925093358.15476-1-jbrunet@baylibre.com>
References: <20190925093358.15476-1-jbrunet@baylibre.com>
Date:   Thu, 03 Oct 2019 10:46:17 -0700
Message-ID: <7hr23tvi1i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Provide the reset lines coming from the audio clock controller to
> the audio devices of the g12 family
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.5 w/Neil's tag.

Thanks,

Kevin
