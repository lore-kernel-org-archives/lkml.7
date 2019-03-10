Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78108C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FFE20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6LRP4TY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCJRol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:44:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45641 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfCJRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:44:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id d18so2622288qtg.12;
        Sun, 10 Mar 2019 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=L8OIvE4OM34lFiaugtqa8w1MiGZcdM/o1HbxgYDMSIo=;
        b=o6LRP4TYgY7czD/Rb+PNXujcRbA/uSvJBMHXzm5m2IX4cX0Ju8qoYMA+FgFAYL+Wct
         cB1CGKeoqmFa51ySYHEeStZWm1iAEtap+IL2O2M6msgRJkGqLvE+nL+5qPtpl9WMR115
         +4rQ8/UfBT0YzQ32wCrGWb9NNGnOFMaWkfq4gREco6Di/uDNyXSNI3kW8QJycayj+v0c
         k1qHptVdnqrYoYLxcWIS3CvPI56u7SnRTJ5C6DyJYv7MqrTz2aEK1DAdqAb8zHMjWOIr
         wGjTPI7R2Oa4QvOQ8wWTLcshtIy+uMseB2D9gjdbjLdT3H29Tyt69BiPipBz53xgY0NK
         RPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L8OIvE4OM34lFiaugtqa8w1MiGZcdM/o1HbxgYDMSIo=;
        b=Kd9w/a186uQm6GlhCfLwRd7XpX8T7wKCb52TL87VRt/WaXxQFF9WU5giVC6+m75aMd
         /EyxNpnVTHgwn+drWGcbeCFDSDfUnq5jeLlBGN3yXQCoKJwvS3TrC1sbCfmC+G0NHrTp
         kt+21BiDFim+WHu/yGLijDLp15K2NfVBQNRQhKoZjX8nym7METTCNy6/ea4KKhTA8o3p
         TqsOq6lPVd5JktNffosTQa9c1LD5w+O0z5jdKIkbCN6Q+MgbsK8coTZebMqFx9BBLHH3
         ppTOSR4T7L46qR/JkUtsU8HZvhefilKRnTNPsrxCbzJG6iwUvjK0M0J8tdW0TkSzSzLM
         xvww==
X-Gm-Message-State: APjAAAUYjPFNnjObsJp1TnUw3NFQ2qz/I9Idqpx2JJETEe8ODYfOeO0v
        Jd965Ud7EO59e5P43LB/DoE=
X-Google-Smtp-Source: APXvYqyJdbJjP9KszTUftQwBhNMOA0CwQzFu0DX+uXqnOl1/9lwloV5GjehAf3QCXupmU5JYWUM11w==
X-Received: by 2002:a0c:fa92:: with SMTP id o18mr3821751qvn.81.1552239879330;
        Sun, 10 Mar 2019 10:44:39 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 17sm2752290qtt.18.2019.03.10.10.44.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 10:44:38 -0700 (PDT)
Date:   Sun, 10 Mar 2019 14:44:34 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v3 0/7] move out of staging
Message-ID: <20190310174434.7t73fdbqbqezh3z6@smtp.gmail.com>
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
It changes device attributes to use more suitable ABI functions.
Finally, it moves the ad5933 driver from staging directory to iio main
drivers directory.


Marcelo Schmitt (7):
  staging: iio: ad5933: change multi-line comment style
  staging: iio: ad5933: organize includes
  staging: iio: ad5933: add SPDX identifier
  staging: iio: ad5933: change help rule message
  staging: iio: ad5933: add ABI documentation
  staging: iio: ad5933: change attributes' ABI call
  staging: iio: ad5933: move out of staging

 .../ABI/testing/sysfs-bus-iio-ad5933          |  39 +
 drivers/iio/impedance-analyzer/Kconfig        |  18 +
 drivers/iio/impedance-analyzer/Makefile       |   5 +
 drivers/iio/impedance-analyzer/ad5933.c       | 811 ++++++++++++++++++
 .../staging/iio/impedance-analyzer/Kconfig    |  18 -
 .../staging/iio/impedance-analyzer/Makefile   |   5 -
 .../staging/iio/impedance-analyzer/ad5933.c   | 809 -----------------
 7 files changed, 873 insertions(+), 832 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933
 create mode 100644 drivers/iio/impedance-analyzer/Kconfig
 create mode 100644 drivers/iio/impedance-analyzer/Makefile
 create mode 100644 drivers/iio/impedance-analyzer/ad5933.c
 delete mode 100644 drivers/staging/iio/impedance-analyzer/Kconfig
 delete mode 100644 drivers/staging/iio/impedance-analyzer/Makefile
 delete mode 100644 drivers/staging/iio/impedance-analyzer/ad5933.c

-- 
2.20.1

