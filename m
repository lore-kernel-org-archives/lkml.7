Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDBC3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C773420B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566175668;
	bh=TQ2mABB4dVkwGLK/rAfTN2VIrVNFxID0x4wJh6wmPHk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gwZv5RD5NhABL4siS6E+CDFkispEgbldhpEYX69UWlnDSsh6pE4qjM8PBEx4OzVEl
	 bhPExltqA/a9qniQyAcyDy8BGRwS6/aODCpXDvrUxvbUXQmXsCC+EOGazyJmgMH7CO
	 9Su+6HetufLBnJAiSoNwsI6zmszcHXB5Q5sIEN/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfHSArr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 20:47:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37895 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfHSArr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 20:47:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so119618pga.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 17:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0ucN8dYY5G9i42DmmhmlfEYMDNGfWkl/1N/uulaX63U=;
        b=ZA7AIkOJduBp5xxJxaIUmknJfpCpmOthRWdyUg7JtaHUjOh2YqsqwhDK9iHOZIYIoi
         xiBJq0TUDesCmP7pazuhDrf+S8DG35YkltZKUL/Oebzc0RjCvJ7wEcgH8FwY7RUP03J+
         o98XqJAvinIxob4wOzbL6Wntyp7PCPA3WtUJN3Cc1yRkPfK7Q2B94KXQ0f1pZixyIKNU
         566u4PuQk1DqFEJ2yUUWsrj+GiiTJLZeRoNQalwrYvVIHqLB2NMDdvLffX/ZQ/6Bt3oP
         x4NZVAcyrA4j76V+JPVcdTTMXnThfCQXoiybJaxCTb3a86KB5Hgacw8Es1jVA7L7KvN4
         16Iw==
X-Gm-Message-State: APjAAAUR+ewTkGf1MtCGpy6Vi2NFVqXvxjOH2mIMg4NUN5G62aQ2F7ab
        0IUpsViqDxUE3V0GSvbEM7+Q3Q==
X-Google-Smtp-Source: APXvYqxMs72RnwgANqr3dH5Y1saPOVPhoQD5u0UW/JUzUOvCIYa+ZK8lo+IMPiTgIZeWq7k/640c4A==
X-Received: by 2002:a63:2043:: with SMTP id r3mr17661312pgm.311.1566175666535;
        Sun, 18 Aug 2019 17:47:46 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id b5sm13488960pfo.149.2019.08.18.17.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 17:47:45 -0700 (PDT)
Date:   Sun, 18 Aug 2019 17:47:44 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA Manager (late) change for 5.3-rc6
Message-ID: <20190819004744.GA20155@archbox>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-fixes-for-5.3

for you to fetch changes up to dec43da46f63eb71f519d963ba6832838e4262a3:

  fpga: altera-ps-spi: Fix getting of optional confd gpio (2019-08-18 17:40:02 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.3

A single fix for the altera-ps-spi driver that fixes the behavior when
the driver receives -EPROBE_DEFER when trying to obtain a GPIO desc.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Phil Reid (1):
      fpga: altera-ps-spi: Fix getting of optional confd gpio

 drivers/fpga/altera-ps-spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
