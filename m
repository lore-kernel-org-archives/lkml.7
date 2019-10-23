Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B98DCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A0C2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="iWWJBSsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403876AbfJWJqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:46:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33499 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390717AbfJWJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:46:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so15537898lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NUrailuYahzDYxkjJS54qJtYYGOoPtD3tuebWIbgYWw=;
        b=iWWJBSsJMWh1Sxb4ok0cc4yWTbK22wcrpajWflfoJ5mqYzLy07wUSgAxJlGypl8z/q
         9MVuHNt+EQ/9e8qsWdk/bHxYVi5GitY8dOZ+wHlGHCMYnzRIF0smxhm2fjUXKVKBsfLO
         22UibMFwZBSCiO+AWUXbaLYCQVMuAti7Asu/nZ3TJplyEIWg9ZRaciU0UOFhKDoYQKCl
         OEjfHC/REyqAsqI/wO+CThHnIDKGTM4NZsEz0zm52Ay2m3kfAZjYE4hw4wY7mCYjQdsI
         pvZRSqSUSbXbtECtL/0lrKKkT5nPJPDuPw8Z1oq02RO9+tQn2wmnNK6LqGSgb2xRTb1P
         Ku4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NUrailuYahzDYxkjJS54qJtYYGOoPtD3tuebWIbgYWw=;
        b=auaVUjUOvEX7y70mDZA/sV6/06kUyURBZpVTIMPUjg+PKKbIfwj81/+OELrCc1PJoi
         YHDv9pXYP2JDVsvMGJ61idktiwkEqYciDpo1NGpclrKBm+P1PuSMRm0d0bfZuNFuNpEX
         66c79ggKePmEe0VP+HwHMKGq3orReILpdxkqfFRmx/xGVvbWxuBhD135GLA8ypcZ0U/O
         3AYtYxv3ucrGncLJpYsRBbb95LvAcG+H/EA5hPM7UL25/OVaMdoMpK+BZgDs3VzKKvsY
         C8Zrekz7jQ96QYdOnMT+hoFILds1HXIcPuTlRKpw9fbO5zXNeOCa7lJg2gf1lfU39LGs
         dtOA==
X-Gm-Message-State: APjAAAU/nCEiIklxJekbFMoyi5FFX3fST911jii5Cw8YMnnQzy/dhLN2
        84WXlI4gYO/MBhrsKHuLPUDudA==
X-Google-Smtp-Source: APXvYqyiMaknslJYi92ku9LKesfFa2KrWv5Ps1HmUYO6mVbOAVW1HiJIA3EQ9rCcz+fX/7UgngQNjg==
X-Received: by 2002:ac2:4c15:: with SMTP id t21mr19713464lfq.7.1571824010612;
        Wed, 23 Oct 2019 02:46:50 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id z6sm2124716lfa.10.2019.10.23.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:46:49 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:46:44 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] LiteUART serial driver
Message-ID: <20191023114634.13657-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for LiteUART
- serial device from LiteX SoC builder
(https://github.com/enjoy-digital/litex).

In the following patchset I will add
a new mor1kx-based (OpenRISC) platform that
uses this device.

Later I plan to extend this platform by
adding support for more devices from LiteX suite.

Changes in v2:
- binding description rewritten to a yaml schema file
- added litex.h header with common register access functions

Filip Kokosinski (3):
  dt-bindings: vendor: add vendor prefix for LiteX
  dt-bindings: serial: document LiteUART bindings
  drivers/tty/serial: add LiteUART driver

Mateusz Holenko (1):
  litex: add common LiteX header

 .../bindings/serial/litex,liteuart.yaml       |  38 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/tty/serial/Kconfig                    |  30 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 373 ++++++++++++++++++
 include/linux/litex.h                         |  59 +++
 include/uapi/linux/serial_core.h              |   3 +
 8 files changed, 514 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.23.0

