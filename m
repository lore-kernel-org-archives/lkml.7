Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC0B206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564554387;
	bh=a/KogRlHxJB10Am7tLBVdIdkzhNsicqq5uVlgPI9Gxk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=J2RxaYDEkEwzhmR+d3gFxR12TcJJ1mo4Qp+UVdOB6+d6iyLr0TZ2E05sJWBx00AIM
	 MBBYBUptAprU1oB4uCoBsslb7h/99Hu9XHdK+jNcTaHT/b1ZDbzZOalIQtzoKUf3jg
	 PFrGUSgVPWENI+WUHqMQWKzdIk13TjG8P1Ek5kbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfGaG00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:26:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33048 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGaG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:26:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so31262517pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HAOLv596ncbzrxFqsd5j/5xyKL5UaQEyvWTJoC/mZ44=;
        b=j1OOOcBreVvq2mthkFAwECd8z6c889LhpjRbsojHuECpqc35iq2lffHXxtlp9nAHZE
         JLLB+jyN+/9CepCNNhd3A/m5hNZlrzfqSIzpTrDZFbGSSUu493hPfgqTa5vlpAbVSQSU
         mqwsssGZ6rq+I+uADUjiFNs5JT4O8NTNDBgzLnwF7IERkRlu7fPX5vS9UE/Yr2aJ/seO
         ewAJyGvNx1+mHeD5i09a7NyfMoYENXsoqREf5N5FM6SDZYDIg094jXQ+YajTx7d8z+Me
         wgrRoaJhpIEZPmg+0ygWSB3nMSTr+0NXPJ9MewLFT59Wa76l4SlmrH8mxp5D1/KKxtNr
         IHPA==
X-Gm-Message-State: APjAAAX/BJs7xuwJPVssXCrwkMDEeoEqj7qr280dzo3VGkLFcHfo8muU
        PGya4JZl2Klx0SBre9N0FnwSzRbNzug=
X-Google-Smtp-Source: APXvYqwDsSubnNZNyJ4UIWSL8jTDvtUjH2IsV9rDHBvTWREnA0QhTeTktmXz4xrWr1N3323jQKOdnA==
X-Received: by 2002:a63:fd57:: with SMTP id m23mr47036013pgj.204.1564554384881;
        Tue, 30 Jul 2019 23:26:24 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id q126sm23915950pfb.56.2019.07.30.23.26.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 23:26:23 -0700 (PDT)
Date:   Tue, 30 Jul 2019 23:26:22 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        broonie@kernel.org
Subject: [GIT PULL] Please pull FPGA Manager changes for 5.4
Message-ID: <20190731062622.GA4414@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.4

for you to fetch changes up to 2949dc443116a66fd1a92d9ef107be16cdd197cd:

  dt-bindings: fpga: Consolidate bridge properties (2019-07-24 14:19:15 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.4-rc1

Here is the first set of changes for the 5.4-rc1 merge window.

They're all more or less cleanup patches:

- Carlos' patch addresses a checkpatch warning
- My first patch changes the return type of a function to align it with
  the fact that nothing checks the return value and it uncoditionally
  returned 0 anyways
- My second patch somehow fell through the cracks before and cleans up
  the FPGA bridge bindings by consolidating them instead of repeating
  the same paragraph over and over again.

All of these patches have been in the last few linux-next releases
without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Carlos A Petry (1):
      fpga: altera-cvp: Fix function definition argument

Moritz Fischer (2):
      fpga: altera-pr-ip: Make alt_pr_unregister function void
      dt-bindings: fpga: Consolidate bridge properties

 .../devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt   |  5 +----
 .../devicetree/bindings/fpga/altera-freeze-bridge.txt       |  5 +----
 .../devicetree/bindings/fpga/altera-hps2fpga-bridge.txt     |  5 +----
 Documentation/devicetree/bindings/fpga/fpga-bridge.txt      | 13 +++++++++++++
 .../devicetree/bindings/fpga/xilinx-pr-decoupler.txt        |  8 ++------
 drivers/fpga/altera-cvp.c                                   |  3 ++-
 drivers/fpga/altera-pr-ip-core-plat.c                       |  4 +++-
 drivers/fpga/altera-pr-ip-core.c                            |  4 +---
 include/linux/fpga/altera-pr-ip-core.h                      |  2 +-
 9 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
