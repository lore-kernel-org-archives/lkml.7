Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE10E206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919273;
	bh=upxbJEKR/5VlTz49I77bWxzSs1Z4uqKmXoxzyIoncz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TTO9zjydkw8d7OOLHSXG07kuIV5Fhkinkeqe9kKANBisynQay8bip5VW9YVHQKV6K
	 joDhDHSVyAeUWI7610vi4SKOqB6+wjBviPvpDhtu90AaEDzEgZ9uZQWRrnxqIOs/sP
	 oOx19lwgG+enM8VthPZp93atjSqYIJTD0IjQW6b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfEOLVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbfEOLVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:21:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D8B206BF;
        Wed, 15 May 2019 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919269;
        bh=upxbJEKR/5VlTz49I77bWxzSs1Z4uqKmXoxzyIoncz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=12mJBq11CPcgzeSUGl9L6Be4t6Wo7X7ekgVrHnN8BIOnl+dSVHFrTLBj2mz4kNBXu
         YMJ+7u5EOQFIm/bWCYbGGt6QGRFF6l2nir7QuCkemklT0LW8mJAMXxoqO48mX3/x5M
         3ak3wM286iPu4t0itjFcLxnofyjMA8fWSB+Z0z3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/113] acpi/nfit: Always dump _DSM output payload
Date:   Wed, 15 May 2019 12:55:03 +0200
Message-Id: <20190515090654.483522396@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 351f339faa308c1c1461314a18c832239a841ca0 ]

The dynamic-debug statements for command payload output only get emitted
when the command is not ND_CMD_CALL. Move the output payload dumping
ahead of the early return path for ND_CMD_CALL.

Fixes: 31eca76ba2fc9 ("...whitelisted dimm command marshaling mechanism")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 925dbc751322a..8340c81b258b7 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -542,6 +542,12 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		goto out;
 	}
 
+	dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
+			cmd_name, out_obj->buffer.length);
+	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
+			out_obj->buffer.pointer,
+			min_t(u32, 128, out_obj->buffer.length), true);
+
 	if (call_pkg) {
 		call_pkg->nd_fw_size = out_obj->buffer.length;
 		memcpy(call_pkg->nd_payload + call_pkg->nd_size_in,
@@ -560,12 +566,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		return 0;
 	}
 
-	dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
-			cmd_name, out_obj->buffer.length);
-	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
-			out_obj->buffer.pointer,
-			min_t(u32, 128, out_obj->buffer.length), true);
-
 	for (i = 0, offset = 0; i < desc->out_num; i++) {
 		u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i, buf,
 				(u32 *) out_obj->buffer.pointer,
-- 
2.20.1



