Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E49C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863EF20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123989;
	bh=rK2Pf0xervn4YMl5Tev4jcEGHBlJ/S3B9WfVo1Gkftw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SulzivuXS6ieg0aBrIfRRvcOW28oBDsKv5D/5J95robUj5JCPOh2AyFvgfUpJEfRU
	 LF+vl40p0QF6Q8VtNHqgytspHm0Gp5i9mnmiwYBjSTYtkIUT+FWjReUcceA6RnPdMT
	 V3R5q2ECYdrOnkbo8D/4ly9v6wMUagmyij2iaLc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbfJCQIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbfJCQH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:07:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F36F207FF;
        Thu,  3 Oct 2019 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118876;
        bh=rK2Pf0xervn4YMl5Tev4jcEGHBlJ/S3B9WfVo1Gkftw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jl6A3NiXbwWTBqMczvP/3qdLXM6Z/J+Ill4OdAntyODhlAcIdU4Dbje2PoHqjhfbj
         tMmUQxms29Q/X6C4uj5nEgpOaABXbtfNNME0kYbB9DxskHkz57IRGoTOq//ghXTek6
         JKXtlSBLUcO30jPG5xFcnS44LuCf7j6+Rf8/O+G4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 006/185] HID: sony: Fix memory corruption issue on cleanup.
Date:   Thu,  3 Oct 2019 17:51:24 +0200
Message-Id: <20191003154438.695963429@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

commit 2bcdacb70327013ca2066bfcf2af1009eff01f1d upstream.

The sony driver is not properly cleaning up from potential failures in
sony_input_configured. Currently it calls hid_hw_stop, while hid_connect
is still running. This is not a good idea, instead hid_hw_stop should
be moved to sony_probe. Similar changes were recently made to Logitech
drivers, which were also doing improper cleanup.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
CC: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-sony.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2710,7 +2710,6 @@ err_stop:
 	kfree(sc->output_report_dmabuf);
 	sony_remove_dev_list(sc);
 	sony_release_device_id(sc);
-	hid_hw_stop(hdev);
 	return ret;
 }
 
@@ -2772,6 +2771,7 @@ static int sony_probe(struct hid_device
 	 */
 	if (!(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "failed to claim input\n");
+		hid_hw_stop(hdev);
 		return -ENODEV;
 	}
 


