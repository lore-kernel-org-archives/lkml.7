Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF37C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143A1214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497697;
	bh=dmt+uw8ccP6fPsAvxsDSIEL8lDUGSZZ81Kdaci9CeMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xpEzkSlA8YAdZJC/Mt3XgzHhiWb0kRkQWL7sQS6XXarWb425Ioflb2YOqTGQZzwe3
	 /XLJ4Qqh+1WUTbX+85AOz4zCB9EeiIFh4PHjSV/DE1ecVlIV4bwe7txVNnUc/2oecS
	 T0mMMF1sbEMhJu5TlqSi/BcYw+h5/JTvdEmgrY8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfKKSlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:41:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729401AbfKKSld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:41:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71211214E0;
        Mon, 11 Nov 2019 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497693;
        bh=dmt+uw8ccP6fPsAvxsDSIEL8lDUGSZZ81Kdaci9CeMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yH3ZS/qzTHyMJvePUKShBfjDw3ZTV17m4c+KA7PmSH7FHki7RliitLHYsbZXcyaT/
         AFygmqkq1UjCin+J8sX1yyquQ04X8U8sVClZFzG9uX16bmhvqXGoYB5Cw5op3DFGLb
         qMMw3KVH055TQDwH7Sl5bSvuaG38DxpDXC646ae0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 029/125] soundwire: bus: set initial value to port_status
Date:   Mon, 11 Nov 2019 19:27:48 +0100
Message-Id: <20191111181444.767630053@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

commit f1fac63af678b2fc1044ca71fedf1f2ae8bf7c3b upstream.

port_status[port_num] are assigned for each port_num in some if
conditions. So some of the port_status may not be initialized.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190829181135.16049-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soundwire/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -805,7 +805,7 @@ static int sdw_handle_port_interrupt(str
 static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 {
 	struct sdw_slave_intr_status slave_intr;
-	u8 clear = 0, bit, port_status[15];
+	u8 clear = 0, bit, port_status[15] = {0};
 	int port_num, stat, ret, count = 0;
 	unsigned long port;
 	bool slave_notify = false;


