Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC76CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AA021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127737;
	bh=O6Uedc+t3oR/nZFDtOShcAF50q+D7dg0euXv/3zhENk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sFCMkcPOJFg9t1mvAg0QGSMhS+8PsRa0rTB5Htrpu/vjuOHVKo1hLybibdq071N35
	 cH2/l0r+zhnN6brQp4lkievC9SYHOsqQcxhPsRuweeXnfQkDFschWolJ4PAOl8WYq6
	 8+Trscpwly1IN23/cd2roDpfYKyFwP3ia7TBFVvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404045AbfDXRmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388393AbfDXRf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:59 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFA62054F;
        Wed, 24 Apr 2019 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127358;
        bh=O6Uedc+t3oR/nZFDtOShcAF50q+D7dg0euXv/3zhENk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsXP+35R8prscIg9zjbxEyd3qnifris1QKFSxz1muE1VsLy0D+rOrZ2s5BC5R+iQz
         69pO9a/87qS5SJf/VVKb/mVmwIR+FDyG3viMea7duh+pkwkZQPiezDlJSjmTu7iKgG
         a+auBTlwe/x1Hb/B8vgzI++2yP+wvpN1kSi1wegk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.0 060/115] iio: dac: mcp4725: add missing powerdown bits in store eeprom
Date:   Wed, 24 Apr 2019 19:09:56 +0200
Message-Id: <20190424170928.666428213@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

commit 06003531502d06bc89d32528f6ec96bf978790f9 upstream.

When issuing the write DAC register and write eeprom command, the two
powerdown bits (PD0 and PD1) are assumed by the chip to be present in
the bytes sent. Leaving them at 0 implies "powerdown disabled" which is
a different state that the current one. By adding the current state of
the powerdown in the i2c write, the chip will correctly power-on exactly
like as it is at the moment of store_eeprom call.

This is documented in MCP4725's datasheet, FIGURE 6-2: "Write Commands
for DAC Input Register and EEPROM" and MCP4726's datasheet, FIGURE 6-3:
"Write All Memory Command".

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/dac/mcp4725.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -92,6 +92,7 @@ static ssize_t mcp4725_store_eeprom(stru
 
 	inoutbuf[0] = 0x60; /* write EEPROM */
 	inoutbuf[0] |= data->ref_mode << 3;
+	inoutbuf[0] |= data->powerdown ? ((data->powerdown_mode + 1) << 1) : 0;
 	inoutbuf[1] = data->dac_value >> 4;
 	inoutbuf[2] = (data->dac_value & 0xf) << 4;
 


