Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E18CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C2F2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0mvzOnol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfDPAgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:36:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36979 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDPAgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:36:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so9416281ply.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9LW9oDrDOfSGvpoZkKI/VkDuSjYcw4ys+z/+hdQ51C8=;
        b=0mvzOnol21+zhT0xk/DTynqIzdztHdwdoeBgmCTwIYNHprOhVkodmPGDrncEFr/V1l
         PaK8jnk1mfpjpFIHCbsik5pmoWuhzbMeAJMDtZt93R+Yj/Zz7IxToxjzSKticXyPmAcs
         jiG4WUiSvbz1jZjh4hEpGUvWwJnfOTL+oCz/NHFKEz9Viy0R7xJ1gGOccRH7wbmxZ6Bl
         hMaC9U7ZhET9KyaNTWumBmZb6HzxowREv1h+wNX6TEtxiW4MM/WAh7O6Nqlea+WYgJAh
         442z3K9ihjLt/BjmW57fwCeeTk+wZCYzQfbotH3264Zu0GH2ux/56l9l8XfTsmnnoTz9
         lZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9LW9oDrDOfSGvpoZkKI/VkDuSjYcw4ys+z/+hdQ51C8=;
        b=JJaiv1cJyFLxmrLgp8zeqQ8JQcWAKguVa8p439zcQZr7MPFvb/nbdS+i3ceBvmF9uc
         J8Q1O62WdQE+YWVIXNXtJ+bO0LBtfF6I9/VO/iw+6h7Ow+unQo/oSV42TvEwKM2fkd0M
         jP+SMAjJM0HpCP0c1w8ufG6/4ogmRoGhDJkNvi9mGQdKBUd4zxIfkkAB3kMXMH4cGnsT
         g3wlv8PQhU3bGkDSP0h2kGU8XejSbS6w9FNO1+hUi1V1D7junxdSByDJt49YAOoJ0LRo
         Ek9SMq+Ngpn7KijOgKCATWn2VKAnpxkpM4vlTw14Rccsb1VRHFbBuIrZvZR2rqCtWEei
         D8Pw==
X-Gm-Message-State: APjAAAUXZGnkVg44/Vvwg882cZ5bo635I9SjLDeNmHUb1VdHNdQYcniJ
        xY//FuGPJKIFrW7FquzaVX7Npg==
X-Google-Smtp-Source: APXvYqz3RdrNaXl2jYx0J9GwKjwfWro/psp6vqDuoyxppC7ziOaydkZO/trrVZQVNSbcX589892JkQ==
X-Received: by 2002:a17:902:e391:: with SMTP id ch17mr80473920plb.196.1555374960387;
        Mon, 15 Apr 2019 17:36:00 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id h4sm44827165pgv.61.2019.04.15.17.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 17:35:59 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] arm64: dts: g12a: Add boards peripherals
In-Reply-To: <7hmuldwghj.fsf@baylibre.com>
References: <20190325101453.3009-1-narmstrong@baylibre.com> <7hmuldwghj.fsf@baylibre.com>
Date:   Mon, 15 Apr 2019 17:35:58 -0700
Message-ID: <7ha7gqrdld.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> Following [1], add regulators, bluetooth and ADC keys on :
>> - meson-g12a-x96-max
>> - meson-g12a-u200
>> - meson-g12a-sei510
>>
>> Dependencies :
>> - Patch 1, 2: None
>
> Queued for v5.2 (branch v5.2/dt64)
>
>> - Patch 3: SAR ADC node at [2]
>> - Patches 4, 5, & 6: USB nodes at [3]
>
> Looks like I can queue these as soon as there's a stable clock headers
> branch I can use.

Queued for v5.2,

Thanks,

Kevin
