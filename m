Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA155C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF7221530
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054425;
	bh=SuB4i8h8ITu7QQYW79zXbx7bSl6XPA+HOjxhxQW3ndI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SBdpxC/w8pWeWMU2HSOT5HqLvygZtZGzZHYW4P7mKsmj4gHxU3IJMprVxNvwSd4ZJ
	 mZcgejIXPXO1Gac/6c9cQUJGj5bek9kbmq0t/woeOqSOrDcrZA5Mgz7dDKEaQ43Rm1
	 fkAW65U+KbXcg2koMsbPHQQBlCQb3Yt0sT0uOFnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfFTSNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbfFTSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AFBC2082C;
        Thu, 20 Jun 2019 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054420;
        bh=SuB4i8h8ITu7QQYW79zXbx7bSl6XPA+HOjxhxQW3ndI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yudL3FOm0AGdwJvn47ya50ALOfdw/KIh6KDS5qKYSFDmCjO/LBVZIZWowV53PCv7G
         57NRHhQOPDVfNW9Z/sd/NpTtNL+s/IYbbxckdjR9nRg4XBebOcqxBAbYk/4Vavx1dW
         VAM5aOdTCYs5H3LW/s4uSU+2r+14j63oV58wySec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Srouji <edwards@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.1 23/98] net/mlx5: Update pci error handler entries and command translation
Date:   Thu, 20 Jun 2019 19:56:50 +0200
Message-Id: <20190620174350.244446896@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edward Srouji <edwards@mellanox.com>

Add missing entries for create/destroy UCTX and UMEM commands.
This could get us wrong "unknown FW command" error in flows
where we unbind the device or reset the driver.

Also the translation of these commands from opcodes to string
was missing.

Fixes: 6e3722baac04 ("IB/mlx5: Use the correct commands for UMEM and UCTX allocation")
Signed-off-by: Edward Srouji <edwards@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -441,6 +441,10 @@ static int mlx5_internal_err_ret_value(s
 	case MLX5_CMD_OP_CREATE_GENERAL_OBJECT:
 	case MLX5_CMD_OP_MODIFY_GENERAL_OBJECT:
 	case MLX5_CMD_OP_QUERY_GENERAL_OBJECT:
+	case MLX5_CMD_OP_CREATE_UCTX:
+	case MLX5_CMD_OP_DESTROY_UCTX:
+	case MLX5_CMD_OP_CREATE_UMEM:
+	case MLX5_CMD_OP_DESTROY_UMEM:
 	case MLX5_CMD_OP_ALLOC_MEMIC:
 		*status = MLX5_DRIVER_STATUS_ABORTED;
 		*synd = MLX5_DRIVER_SYND;
@@ -629,6 +633,10 @@ const char *mlx5_command_str(int command
 	MLX5_COMMAND_STR_CASE(ALLOC_MEMIC);
 	MLX5_COMMAND_STR_CASE(DEALLOC_MEMIC);
 	MLX5_COMMAND_STR_CASE(QUERY_HOST_PARAMS);
+	MLX5_COMMAND_STR_CASE(CREATE_UCTX);
+	MLX5_COMMAND_STR_CASE(DESTROY_UCTX);
+	MLX5_COMMAND_STR_CASE(CREATE_UMEM);
+	MLX5_COMMAND_STR_CASE(DESTROY_UMEM);
 	default: return "unknown command opcode";
 	}
 }


