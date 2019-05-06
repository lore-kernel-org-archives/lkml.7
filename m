Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5B3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008F720C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153818;
	bh=m8PUzezVg4mUsEUiPciQfr6l0rmMTKutw+jQ/sYN8D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fveppG2v6blMZvcCLx6Spu+JMJkXFToL1WcVN8ay3Hnd871eO84CQdp98EUcbxAiW
	 EAqHEiU7yi/Mq/1BwCUoavnvnKvRWEZ7/4wbZuzj2IvNhOXF6vJyTIIXGG4jnoctqU
	 ov/cS8zgaE8p/jJUmnWHmM5kkPlDTBOtycBMzLgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfEFOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbfEFOnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:43:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B7220C01;
        Mon,  6 May 2019 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153812;
        bh=m8PUzezVg4mUsEUiPciQfr6l0rmMTKutw+jQ/sYN8D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uab24UkOsGv9WLGO/laCgQ9XQ76wdDprMJ3HlZfUga4KkMkO38ZEJ9lHAAkTEvcVL
         mgUP286ZUNLNDr1PWNRgq/oZxWvMKInnKtd+ZXBsIa1//imiUonOn3OzdqdJlxtaPb
         Au7sQN34SSUrhkvJ2l7Ey/0sFX+JuM5p16SWxnxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Le Bayon <nicolas.le.bayon@st.com>,
        Bich Hemon <bich.hemon@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.19 98/99] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Date:   Mon,  6 May 2019 16:33:11 +0200
Message-Id: <20190506143102.699671981@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Le Bayon <nicolas.le.bayon@st.com>

commit c86da50cfd840edf223a242580913692acddbcf6 upstream.

It conforms with Reference Manual I2C timing section.

Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-stm32f7.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -424,7 +424,7 @@ static int stm32f7_i2c_compute_timing(st
 		 STM32F7_I2C_ANALOG_FILTER_DELAY_MAX : 0);
 	dnf_delay = setup->dnf * i2cclk;
 
-	sdadel_min = setup->fall_time - i2c_specs[setup->speed].hddat_min -
+	sdadel_min = i2c_specs[setup->speed].hddat_min + setup->fall_time -
 		af_delay_min - (setup->dnf + 3) * i2cclk;
 
 	sdadel_max = i2c_specs[setup->speed].vddat_max - setup->rise_time -


