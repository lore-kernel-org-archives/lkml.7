Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5630C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB6A20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DoZQM3CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407479AbfHISVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:21:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39756 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436479AbfHISVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:21:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so42479225pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=NoJS3EPA4E/Zez3LCtMYEWvxXoiMwupWncuL9aQv4k0=;
        b=DoZQM3CBR5/yXZ1WMe8/vQbS+GqyAmVL1BAEgCZz7s6gcMvJ9lvCGZh27xL4I98oBr
         UZpZv/EnPLXjGSuK+aH9AJCEEgoXXptR/WtBbhxqxjaDlsy+XLvZ+9gMAcpRyEAKU8iH
         G7NQrLUbsbIbeknuokH2wZBuy1TPlfCa9FDNxPHbC9W+hRDdDJDbl3wbMt7u+Bq3tuME
         2DMTxeA+rqV+2qb/ovRnbjOndxKjeuKWJVlKc3n9S/8CxnopAdDXLwfSe7t/B4W+O77i
         9STGtWhsZy8PRubMtpqDHycH0jJGdbAUfbWztJ9oeeXvd5SJi386nAeFHWfKHZGKSMZA
         KozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NoJS3EPA4E/Zez3LCtMYEWvxXoiMwupWncuL9aQv4k0=;
        b=Qh2c9rAwCb8MQJTNIp3GW3SHef5GJc/A/w5nkU8IUJO/IIVqOfo1zpXwhLvgmeEUwa
         7jZT4OC1vhJH03IZ8i8Rp2hsxasuLp56WvHxNpOXOQMF1SVAq6LFHWf4KLO4E1ES0KkH
         1zfQYjLmx9vrlQD/RFHXJ2x96EsdLjkPwFGEKEHi6zLEXp1/QfbO7/2/iVPw7aYicGL+
         VhWlE8sVhByDx51o4P8qQ21GOvAabdkPB9OA3L56eg/hp7+hdeWNIRPUBDOEUKAiHnLx
         XL3IxS7BdAs7IX17klaGZT/i9fw8QBFhEdu+nKdVDn08cms5rsZPbsZYW7jmJ9xZiLiu
         Pobw==
X-Gm-Message-State: APjAAAUNOomjxbXibeA5d263b/sXaYOr929Js2KFWi9xGDh1yyUn8UYh
        bQeZwdTjkaXw+SmVN9de45pHyQ==
X-Google-Smtp-Source: APXvYqyJVLva9n72E7jE6jYUxrqVOTKGDoQHkgCTXp4MT8/0tRLXX0iCYQKo/mt/9fdtrQTkogz0oA==
X-Received: by 2002:a62:ae01:: with SMTP id q1mr22290623pff.219.1565374905793;
        Fri, 09 Aug 2019 11:21:45 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b873:707a:e893:cdb3])
        by smtp.gmail.com with ESMTPSA id d129sm110949243pfc.168.2019.08.09.11.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 11:21:45 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: g12a: add support for DVFS
In-Reply-To: <7hk1bn43fq.fsf@baylibre.com>
References: <20190729132622.7566-1-narmstrong@baylibre.com> <7hwofrh1md.fsf@baylibre.com> <7hk1bn43fq.fsf@baylibre.com>
Date:   Fri, 09 Aug 2019 11:21:44 -0700
Message-ID: <7h1rxu42tj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Kevin Hilman <khilman@baylibre.com> writes:
>
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>>> The G12A & G12B SoCs has kernel controllable CPU clocks and PWMs for
>>> voltage regulators.
>>>
>>> This patchsets moves the meson-g12a.dtsi to meson-g12-common.dtsi to simplify
>>> handling the G12A & G12B differences in the meson-g12a.dtsi & meson-g12b.dtsi
>>> files, like the OPPs and CPU nodes.
>>>
>>> Then G12A & G12B OPP tables are added, followed by the CPU voltages regulators
>>> in each boards DT.
>>>
>>> It was voluntary chosen to enabled DVFS (CPU regulator and CPU clocks) only
>>> in boards, to make sure only tested boards has DVFS enabled.
>>>
>>> This patchset :
>>> - moves the G12A DT to a common g12a-common dtsi
>>> - adds the G12A and G12B OPPs
>>> - enables DVFS on all supported boards
>>>
>>> Dependencies:
>>> - None
>>
>> Not quite.  The last patch to enable DVFS on odroid-n2 has a build-time
>> dependency on the clock series that adds the CPUB clock.
>>
>> I'll apply the rest of the series to v5.4/dt64 until there's a stable
>> clock tag I can use for the clocks.
>
> In order to test this, I noticed another dependency needed for the PWM
> regulators to work:
>
>    https://lore.kernel.org/linux-amlogic/20190729125838.6498-1-narmstrong@baylibre.com/
>
> With that and the clock deps, it's working well on my odroid-n2.
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Also now tested on g12a: u200, x96-max and sei510 boards.

Kevin
