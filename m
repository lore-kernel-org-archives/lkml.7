Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D70C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A6E2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369509;
	bh=4oVFRwTrhSJYqm90AUDvkrAPd5iMpjYa08WCRWwKIfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iAUj/ADHWRNGZ/YIvMQzrzi9hQnWYATlPRkvZf2eQ4OmJ2KLMKNiKQsB3Tu3r6Q7X
	 JJ7IB7qattHjMxEMF/MzAn3H9b7TbmnSqvd6KNZ86p070uxcymmCCcY+PDjvx3Ybof
	 GT9WTigh/W8cyccTNcaT3KFfS4XqPOYzad9fBmUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbfDDJS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfDDJSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:18:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ABD32054F;
        Thu,  4 Apr 2019 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369505;
        bh=4oVFRwTrhSJYqm90AUDvkrAPd5iMpjYa08WCRWwKIfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhZwiTn2Ua5HMoq2OC/lTyQxy/gClbOEP9lpCzQ1ZpfyOeUeHPNfiJvgxRJDREnk4
         QnWfuSIzlkK8rznVlb9lKWYZjkNfKyc6Y07AnTd+5v6/GlasuIGv+2yMKHy/I/4tgY
         v3VWp+QcyBNbhfy0mW5GGT9Smagqk5zJ7o9Cx7ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Vincent <brainn@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 241/246] drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers
Date:   Thu,  4 Apr 2019 10:49:01 +0200
Message-Id: <20190404084627.735701105@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c978ae9bde582e82a04c63a4071701691dd8b35c ]

We aren't supposed to force a stop+start between every i2c msg
when performing multi message transfers. This should eg. cause
the DDC segment address to be reset back to 0 between writing
the segment address and reading the actual EDID extension block.

To quote the E-DDC spec:
"... this standard requires that the segment pointer be
 reset to 00h when a NO ACK or a STOP condition is received."

Since we're going to touch this might as well consult the
I2C_M_STOP flag to determine whether we want to force the stop
or not.

Cc: Brian Vincent <brainn@gmail.com>
References: https://bugs.freedesktop.org/show_bug.cgi?id=108081
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180928180403.22499-1-ville.syrjala@linux.intel.com
Reviewed-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 529414556962..1a244c53252c 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3286,6 +3286,7 @@ static int drm_dp_mst_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs
 		msg.u.i2c_read.transactions[i].i2c_dev_id = msgs[i].addr;
 		msg.u.i2c_read.transactions[i].num_bytes = msgs[i].len;
 		msg.u.i2c_read.transactions[i].bytes = msgs[i].buf;
+		msg.u.i2c_read.transactions[i].no_stop_bit = !(msgs[i].flags & I2C_M_STOP);
 	}
 	msg.u.i2c_read.read_i2c_device_id = msgs[num - 1].addr;
 	msg.u.i2c_read.num_bytes_read = msgs[num - 1].len;
-- 
2.19.1



