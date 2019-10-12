Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29066C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 04:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040492089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 04:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfJLEJv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 00:09:51 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17416 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbfJLEJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 00:09:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570853383; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=oXaclZr+VrF425thVZGSlC3VqKjp/BQxbM4FYqQAS14LUohnYwbk4K35IMa8Sx2oO8QmP5fR89JHs3idumWrMOCnXqHfsWWqrmIzbyED/6blLYgRq6bc9fDjdBzn000CXm1+6keP2DB3FgLkmubS1Ne8kQEJWO54XPPvZFB098M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570853383; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=3t0KcqUengCbxkgvjOossht4GKUHcCzitqU1dmTGMJU=; 
        b=E8fMBJcZovgqbB4aw92vOIb8MnH4U532hxyw268keKxk/NfHcw3ZvJEr19FhJevMT+uCYBLtOiZtJfGG2+XoEIQhvhOe1S4RO31QExRFiiTkFlE4f7/q6lIwQ6oUBzyho9AcnSauUq3jz/pJYVq9nM2nuV7zUoU88cQKFC2r4qg=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1570853381986565.1916973927841; Fri, 11 Oct 2019 21:09:41 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191012035420.13904-1-dan@dlrobertson.com>
Subject: [PATCH v2 0/2] iio: add driver for Bosch BMA400 accelerometer
Date:   Sat, 12 Oct 2019 03:54:18 +0000
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a IIO driver for the Bosch BMA400 3-axes ultra low-power
accelerometer.  The initial implementation of the driver adds read support for
the acceleration and temperature data registers. The driver also has support
for reading and writing to the output data rate, oversampling ratio, and scale
configuration registers.

A huge thanks to the reviewers of the first version of the patchet!

Cheers,

 - Dan

Changes in v2:

 * Implemented iio_info -> read_avail
 * Stylistic changes
 * Implemented devicetree bindings

Dan Robertson (2):
  dt-bindings: iio: accel: bma400: add bindings
  iio: (bma400) add driver for the BMA400

 .../devicetree/bindings/iio/accel/bma400.txt  |  16 +
 drivers/iio/accel/Kconfig                     |  19 +
 drivers/iio/accel/Makefile                    |   2 +
 drivers/iio/accel/bma400.h                    |  86 ++
 drivers/iio/accel/bma400_core.c               | 839 ++++++++++++++++++
 drivers/iio/accel/bma400_i2c.c                |  58 ++
 6 files changed, 1020 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bma400.txt
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c



