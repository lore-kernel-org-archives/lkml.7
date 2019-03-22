Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4B92192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256120;
	bh=gYdProl+vBB+QyJ0sWDz/QQWMA7Xjsjs898fpFoslCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmB6EqpLm6Dmq5QsEALnoQwLsY6zhRupZdPT3H/RnGZBV1kJHd/R1xaaUEc22HiDG
	 tkVYVD8HdyXZHA4ZJxu/wgYGhqC+fHKyZYfNHmYo8Nm+t/0Pn9KhvWEJNbqJubmfSP
	 8YOBUD6XwYbA1DQv+zG8UDqtD0eI9UklCkA9l/Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbfCVMB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfCVMB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128252192D;
        Fri, 22 Mar 2019 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256115;
        bh=gYdProl+vBB+QyJ0sWDz/QQWMA7Xjsjs898fpFoslCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XcmDFSPK4FwWAPGyJWZrXHXbJmRkFidC9HSTzDk4ezxWUQDe8hW/lt/F72eIY9zrH
         FBHOVO1z1l7L7RSit3Od89Lhu3WX261TmBuTBZH//P1O7xSYHTLgkGDaaJ+ZfFDt5t
         K8yZ3D4cky8WYNenTtlv4/OxY2/7w7WlOCzG3lb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 113/280] nfit: acpi_nfit_ctl(): Check out_obj->type in the right place
Date:   Fri, 22 Mar 2019 12:14:26 +0100
Message-Id: <20190322111313.843546391@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -533,6 +533,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
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
@@ -551,13 +558,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 		return 0;
 	}
 
-	if (out_obj->package.type != ACPI_TYPE_BUFFER) {
-		dev_dbg(dev, "%s unexpected output object type cmd: %s type: %d\n",
-				dimm_name, cmd_name, out_obj->type);
-		rc = -EINVAL;
-		goto out;
-	}
-
 	dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
 			cmd_name, out_obj->buffer.length);
 	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,


