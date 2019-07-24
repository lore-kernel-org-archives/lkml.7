Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBA9C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5491218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563945616;
	bh=QswBjLGZ/SynxA7IlU0qqMKjsNxmGvZiToeI/baJXNk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MuCHJhHQWCTcQKTSoD+ysiO98Cje44Mc2O19iorVE4k6i5cewBu31W25mkT34hOmJ
	 4NTlqomN1VvZN2HtkwMuR7o37D78P9IYjFzZueBWgDVyFoL4ZFfKxv3C7tyWLsq3G+
	 3SDPLN4Hydpl9PeLXSylFBMxqeHER+G8Ju7qgEu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGXFUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:20:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfGXFUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:20:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so20569096pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 22:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m4QDXoQJCgqv+0KjGs2opKRwM744dByyftRnkLkrxXw=;
        b=h42nf4pPvhTC8grrjGl6uf4yVuoa6Vfjm0wwQ0M/0TgXEEXMEd+0eb11aPgx5UUO4w
         pTvYc4VVAzfaS3aObkBBWCfAVdrLA22JRM68F3FZ0YKrks15FxOsttM9UyptKHgGmG1s
         X8jHzuN0z7cEUmOT9JunEY+pNidloe9PF6lMM5K16gHAgIcUD7BHu+SAcdC1IeuhbKU5
         QoBsH8CTLi8ysWdpTox2oUDi200W/nsST5eGN5nwU/geDCxh6rIG1CPPnyJg0seldFhg
         OAztRS7p1CWHX+D6VNTHW0gLdGIZxXBLJBMsVpvGzDgxnug7zcJP4x7f53ZGcxj/pz7n
         za5g==
X-Gm-Message-State: APjAAAXQHc37MSb/sNIz2X9RX/0I239vG8MdOqpdQ/2t3kHmUsDOcd29
        R0NWgpEuqxphRJ86p1dXl+FBoA==
X-Google-Smtp-Source: APXvYqz6Gtvl1sx5/K6rd1hMxd5BJOlgR8qiDTZeJH0cbbd+jHWtrTDZTVhnFYTJoy/6J1LHPip6mA==
X-Received: by 2002:a65:5202:: with SMTP id o2mr56746898pgp.29.1563945614134;
        Tue, 23 Jul 2019 22:20:14 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id a6sm39858550pjs.31.2019.07.23.22.20.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 22:20:13 -0700 (PDT)
Date:   Tue, 23 Jul 2019 22:20:12 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: [GIT PULL] FPGA Manager fix for 5.3
Message-ID: <20190724052012.GA3140@archbox>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fixes-for-5.3

for you to fetch changes up to c3aefa0b8f54e8c7967191e546a11019bc060fe6:

  fpga-manager: altera-ps-spi: Fix build error (2019-07-23 17:29:17 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.3

Hi Greg,

this is only one (late) bugfix for 5.3 that fixes a build error,
when altera-ps-spi is built as builtin while a dependency is built as a
module.

This has been on the list for a while and I've reviewed it.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
YueHaibing (1):
      fpga-manager: altera-ps-spi: Fix build error

 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)
