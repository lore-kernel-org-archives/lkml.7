Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD5C2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255604;
	bh=Fy8oe6xRhkv+e6UZeZhGyNTnky7VcJYCTV9w/yVfi2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=COdfYNT3alLQQjg10u9d5lUq/rKqoaegoYwKHF1Rx+MaNLkruCEYdNCYdPaMGPJxs
	 DKS0Cqei+47KD5sp0iWoqWxrUFvpZ9CuF0AsWCt3N98rarTydNOxmmZhPEsVZ/Sotp
	 ZGhVlyy10VaBIuzGCx7Ii/ouA4YmZAQH9ug9Fp8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbfCVLxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732826AbfCVLxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 794B82082C;
        Fri, 22 Mar 2019 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255598;
        bh=Fy8oe6xRhkv+e6UZeZhGyNTnky7VcJYCTV9w/yVfi2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KT+fyFatbchU6gzdmy0fmS3PNHSA3jcM8DDqZLsrBZZ+eSBqxGLt2NOXgR5c8dlMw
         C5qbu0O09qcwgq+4CEEp4Ozeukkjmsc0H5ddOSJnRELQ3GK13UAXKvhMcp14IA6TK0
         iu8FCMI6YO7fcUgC32vIelLO+6Eqkt1S89YgSYGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 121/183] nfit: acpi_nfit_ctl(): Check out_obj->type in the right place
Date:   Fri, 22 Mar 2019 12:15:49 +0100
Message-Id: <20190322111250.468536937@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit 43f89877f26671c6309cd87d7364b1a3e66e71cf upstream.

In the case of ND_CMD_CALL, we should also check out_obj->type.

The patch uses out_obj->type, which is a short alias to
out_obj->package.type.

Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/acpi/nfit/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -329,6 +329,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 		return -EINVAL;
 	}
 
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		dev_dbg(dev, "%s unexpected output object type cmd: %s type: %d\n",
+				dimm_name, cmd_name, out_obj->type);
+		rc = -EINVAL;
+		goto out;
+	}
+
 	if (call_pkg) {
 		call_pkg->nd_fw_size = out_obj->buffer.length;
 		memcpy(call_pkg->nd_payload + call_pkg->nd_size_in,
@@ -347,13 +354,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 		return 0;
 	}
 
-	if (out_obj->package.type != ACPI_TYPE_BUFFER) {
-		dev_dbg(dev, "%s:%s unexpected output object type cmd: %s type: %d\n",
-				__func__, dimm_name, cmd_name, out_obj->type);
-		rc = -EINVAL;
-		goto out;
-	}
-
 	dev_dbg(dev, "%s:%s cmd: %s output length: %d\n", __func__, dimm_name,
 			cmd_name, out_obj->buffer.length);
 	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,


