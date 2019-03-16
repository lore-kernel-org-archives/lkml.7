Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA01DC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79302218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQnHo95U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCPPGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:06:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46414 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfCPPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:06:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id i5so7248083qkd.13;
        Sat, 16 Mar 2019 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Fo35odr7LLr+oqKHRziExag6oopT6CznsINfhjFdjGE=;
        b=JQnHo95UXE7qbuZyXXTJKcOnjVrnKG3I+/yF5jyWRU+bmnB9vkzM7gjo/pviRdVTRD
         9ypmCWl8sigwIUcur/4eb1jDbe/83RejzjhyoMqHpTxOyDKVMAbO8N4m/4sn4F1DWuzG
         PyFfhuo53H9/32T7RlbhLB7pySF7MJAePaByguOLCJHbB/lSVSWrXf24fTgqIPpcrwJ7
         Qeh59GbMzKVNrlCK/AA5GKrWieaEVr8KtLprhghOuiOLd+tJmGkATuolpccUb9BmmVGd
         CeOIV64liAhFu8n+tpy7C3tW/olZqwHqsirpqx+gFptf2AXKC4BAInzi0iPIXEEhxh5u
         4U6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fo35odr7LLr+oqKHRziExag6oopT6CznsINfhjFdjGE=;
        b=gWQjwp+7oPB84Ajeg0HEH11X1B3mlNimtyEvFsz/x4a5VozvP8NMwPkvMqyEKF/w8i
         gfMBLChfyaxgfHgbX5n1e8nI+yIlTuwkwLIrUImOHTWNguenU+smz8JONGCkX30VYvk6
         Ry7ibhXi0lZQ3tOoo3BmGY2psdoJDKfUFHk4eULZ3rzcGzQ6RLrTtDoEJKleUTftGdtZ
         FMQCCBBvF8lpEEbr/3Wcb6ECTuengRM+zZdprnoQ0K/u6QY84ulrzz7s9/Ze+kkBkulI
         Mjok5xJ1He1lN9y74UivYms0KgW2KHuRNOIO/sseC+/NttKvt24HumSxE12g8i7TGGvL
         Aaww==
X-Gm-Message-State: APjAAAV3qS7dPNrD/WUR+RIhYV3t1yH4HloXfynDZo2MGkdD+jv3KZt8
        WseuVfZvs5yUtBQoe5/iGro=
X-Google-Smtp-Source: APXvYqy9+Gc4er2zOZHpu25hIAFHlzQa7tQaoUQQcTxgu32J2mgJ8BhNM0j/fZcnk0AXAXM1W3oTYg==
X-Received: by 2002:a37:a543:: with SMTP id o64mr6989398qke.235.1552748761664;
        Sat, 16 Mar 2019 08:06:01 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id a6sm2735918qkk.5.2019.03.16.08.05.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 08:06:00 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:05:57 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v4 0/7] staging: iio: ad5933: move out of staging
Message-ID: <20190316150557.3cjy5r4kdsqetq7s@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series of patches make code style adjusts on comments and include
order.
It adds a SPDX license identifier of GPL-2.0.
It makes Kconfig help message more compact and correct.
It adds an ABI documentation for the device attributes.
It changes device attributes' names to match or be similar to existing
ABI.
Finally, it moves the ad5933 driver from staging directory to iio main
drivers directory.

Marcelo Schmitt (7):
  staging: iio: ad5933: change multi-line comment style
  staging: iio: ad5933: organize includes
  staging: iio: ad5933: add SPDX identifier
  staging: iio: ad5933: change help rule message
  staging: iio: ad5933: add ABI documentation
  staging: iio: ad5933: change attributes to match ABI
  staging: iio: ad5933: move out of staging

 .../sysfs-bus-iio-impedance-analyzer-ad5933   |  35 +
 drivers/iio/impedance-analyzer/Kconfig        |  18 +
 drivers/iio/impedance-analyzer/Makefile       |   5 +
 drivers/iio/impedance-analyzer/ad5933.c       | 811 ++++++++++++++++++
 .../sysfs-bus-iio-impedance-analyzer-ad5933   |  30 -
 .../staging/iio/impedance-analyzer/Kconfig    |  18 -
 .../staging/iio/impedance-analyzer/Makefile   |   5 -
 .../staging/iio/impedance-analyzer/ad5933.c   | 809 -----------------
 8 files changed, 869 insertions(+), 862 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-impedance-analyzer-ad5933
 create mode 100644 drivers/iio/impedance-analyzer/Kconfig
 create mode 100644 drivers/iio/impedance-analyzer/Makefile
 create mode 100644 drivers/iio/impedance-analyzer/ad5933.c
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933
 delete mode 100644 drivers/staging/iio/impedance-analyzer/Kconfig
 delete mode 100644 drivers/staging/iio/impedance-analyzer/Makefile
 delete mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.c

-- 
2.20.1

