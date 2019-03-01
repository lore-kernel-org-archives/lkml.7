Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE4FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989EA218B0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Dxfcb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfCACwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:52:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34373 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfCACwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:52:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id w4so26222031qtc.1;
        Thu, 28 Feb 2019 18:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2ouc+cg8TlBHaJZoXCHlt07od+tAcu91kLq/UPARe2o=;
        b=g1Dxfcb42pJnC83VsG7hj1pVvBbwVEAuZI8azikQ3ifyx4J/4hQ/SaORoskKlqTAvS
         8/fks1elon4x5IO05ReQfBMv37YfT4M9bEdARITzDl+gkegt/KuE686t1n8l1qBar6kz
         TqW2CAnQxLt+MFHrKiUIb6oDc6ZwYXoK/Y4o8n0DyqBiCnFKo2XRZzF3pGU4t9lRnFaD
         CkTXSpyXCJThQu4equ63UGjGI6WF4CYKzhHoBSkmX7gT9YHi+7UhlZwdCy4HblBy6rDF
         iodLnAPg4muXIIOTpPS2uRI4SFzCC6p0BmzMXTMdAfsopXwa9CDyhQ/6FTY+gnmlvzsz
         QP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2ouc+cg8TlBHaJZoXCHlt07od+tAcu91kLq/UPARe2o=;
        b=lv7wuAvDm+VHUKkG9OVHuFz26wTCzmQ1+ngnwK3w34fx6C/C7zQ+AqRwGMvt6Vjry1
         jAakmKYrGG/4H8mK2GCcI4rzXkK7f0+M5hvWSy00hzQ7Jz8L8GLcsdvUXDJfzqdggDuX
         UWK8hv77C5WqXthI4itiuJfVgijiUiLtZGspYxuSyQEiIyBhZYN4M/10fPP8RoyMyOr0
         BpViPv5nUyr2Qcclmkc2f0OttTZ/fDxoDp5AfHinNeyue7NMPGnfn/RQXt1UeRthxbTM
         7HdDRIwtRbsEHlBWU2YUKmM0Ph2SV0o25bzs6Po31vGHTgnhgaDQhHA81cZL59K/dro5
         ISnQ==
X-Gm-Message-State: APjAAAWzjVVU8EafBmdP0nYDdy1fzwtOvLXGckWLu7HItM3aaUg3hHM0
        I5wtNvoKWx9O4k5OSzJRY9Q=
X-Google-Smtp-Source: APXvYqxo2wFo/HjEbkizLY/uvImGbZLpPNC2G8E/bZa6W2epO8B9jTtACzOkL98exURKVG/YdX5QMw==
X-Received: by 2002:ac8:34ae:: with SMTP id w43mr2195151qtb.145.1551408736149;
        Thu, 28 Feb 2019 18:52:16 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id r47sm13667117qtc.48.2019.02.28.18.52.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Feb 2019 18:52:15 -0800 (PST)
Date:   Thu, 28 Feb 2019 23:52:11 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v2 0/4] staging: iio: ad5933: move out of staging
Message-ID: <20190301025211.ve6crq7rqd2cxbj3@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add SPDX license identifier for GPL-2.0 along
with minor code style ajusts.
It makes Kconfig help message more compact and correct.
Also it adds an ABI documentation for the devise attributes.
Finally, it moves the ad5933 driver from staging directory to iio main
drivers directory.


Marcelo Schmitt (4):
  staging: iio: ad5933: add SPDX identifier
  staging: iio: ad5933: change help rule message
  staging: iio: ad5933: add ABI documentation
  staging: iio: ad5933: move out of staging

 .../ABI/testing/sysfs-bus-iio-ad5933          |  91 ++
 drivers/iio/impedance-analyzer/Kconfig        |  18 +
 drivers/iio/impedance-analyzer/Makefile       |   5 +
 drivers/iio/impedance-analyzer/ad5933.c       | 811 ++++++++++++++++++
 .../staging/iio/impedance-analyzer/Kconfig    |  18 -
 .../staging/iio/impedance-analyzer/Makefile   |   5 -
 .../staging/iio/impedance-analyzer/ad5933.c   | 809 -----------------
 7 files changed, 925 insertions(+), 832 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933
 create mode 100644 drivers/iio/impedance-analyzer/Kconfig
 create mode 100644 drivers/iio/impedance-analyzer/Makefile
 create mode 100644 drivers/iio/impedance-analyzer/ad5933.c
 delete mode 100644 drivers/staging/iio/impedance-analyzer/Kconfig
 delete mode 100644 drivers/staging/iio/impedance-analyzer/Makefile
 delete mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.c

-- 
2.20.1

