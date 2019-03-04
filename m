Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F10C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2B820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688838;
	bh=OL/rU9U5JILSklnJIL3Vtsdku5FOX12icst4txegSlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aq7PGkCYIQcwiHZQRD8pvndJxNTlFo8Nb6tfIhpZa+OYWPUOsWxKwkkQ7/ZcgA80l
	 M7VB3XoIt/zrywJnPkmMe/C3LGKT5bcdhFUFoVi+ODMWu9zhgUnxeTbwUBcZZIGdGS
	 V4RCWhc5tA8b2V3W5RQe9ryD57fgxcnGrTRgePN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfCDIkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfCDIcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660F320836;
        Mon,  4 Mar 2019 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688365;
        bh=OL/rU9U5JILSklnJIL3Vtsdku5FOX12icst4txegSlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vR0fXeIy+yT2OKT5urhLWTWQCiydVsnjgBF28/Sjhm4kL5TRuipz4b5yxXVD8bWcS
         sePKWSsedTcDsgdiXPyqWnRYS4dIKW8LyEzNJiYrcubFSY/L3dCgZL5P2HxZMP+Tl9
         f0y0ryv3fPigiGlR1vuLPLER8RLQ89FHmnOauJL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Silvio Cesare <silvio.cesare@gmail.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 23/88] ASoC: imx-audmux: change snprintf to scnprintf for possible overflow
Date:   Mon,  4 Mar 2019 09:22:06 +0100
Message-Id: <20190304081631.526159592@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c407cd008fd039320d147088b52d0fa34ed3ddcb ]

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-audmux.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 392d5eef356d3..99e07b01a2ce9 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -86,49 +86,49 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
+	ret = scnprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
 		       pdcr, ptcr);
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_TFSDIR)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS output from %s, ",
 				audmux_port_string((ptcr >> 27) & 0x7));
 	else
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS input, ");
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_TCLKDIR)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk output from %s",
 				audmux_port_string((ptcr >> 22) & 0x7));
 	else
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk input");
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_SYN) {
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"Port is symmetric");
 	} else {
 		if (ptcr & IMX_AUDMUX_V2_PTCR_RFSDIR)
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS output from %s, ",
 					audmux_port_string((ptcr >> 17) & 0x7));
 		else
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS input, ");
 
 		if (ptcr & IMX_AUDMUX_V2_PTCR_RCLKDIR)
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk output from %s",
 					audmux_port_string((ptcr >> 12) & 0x7));
 		else
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk input");
 	}
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret,
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 			"\nData received from %s\n",
 			audmux_port_string((pdcr >> 13) & 0x7));
 
-- 
2.19.1



