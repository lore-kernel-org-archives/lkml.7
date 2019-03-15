Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2E821872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="HuR+Bph/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfCOHHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:07:31 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:55576 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCOHHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:07:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id DA82FA31
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 07:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vLO9PH6nT7H8 for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 02:07:29 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id A937D575
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 02:07:29 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id y13so6276409iol.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rvoc5N0OKbgURgsRZmYFf8nD7xmDm2R+NWjLWIN4Hfc=;
        b=HuR+Bph/g02wi6IY4dIRYUR2jgZ0AbafH+9fYlvhavrrOENSeUnkO9dyp7HrqYQM8d
         bqg4tG7EEAspgbsI9KWrUSSxbCbV/DnKypK9eOGF7a8HDjCu09xRH67k4CtgcHxgcRkO
         i31KpL5G0qCL/oTtu2uCAlWHCMrdjoqA4wFsM76DC1ANysTs62q8YC0XIAr2SE8OnVpE
         297VbHBv899n10BTeyVCrE0jNc/dBuePDU66LIr9wdgbMAFVwmbogRDR9Q+r/KJ0siFX
         Rxb12/aZEnCdppV7G0DoeKw+823mnXZCoh3BfQRN87ICENOdGpyyhyLrAf1UT3yLTznF
         Llrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rvoc5N0OKbgURgsRZmYFf8nD7xmDm2R+NWjLWIN4Hfc=;
        b=N0eh+TIhsrY8/S0h9/KXWT65FxUbSgQbqhcGCzmcjWTQg0cdjJQ47qqTyPU8DsIgmx
         EBhHBZwIVeWAjhw4049sbz/2/VJrxcAEVyeY3K3xZW1nhUfoUY7eBBQKXOH2Jgt+hj64
         NvBK90HqOMMb0TnLt36Aw45nXi9WDePRoaIJp9oyjjC3bUSEMAHblkCecCbpuFeRx/2k
         SFOyfrQ0vggCZGZ17p9cgB1OFgeay3hFd+cw9PTcELi99gTFEdOkrKKMIS+gbJiOlnmd
         nuE4m77fOrueOReq+8xkaD1M78yeOnWX2eDCT1/b4L+AFxftI90Nn0z33BsngmFUKT2j
         rXHw==
X-Gm-Message-State: APjAAAUtngrrLiczUNlVj7bpkTKgUkmyTLkcd440JJFUUVRaNfMtFu7g
        1aL3VS+jCaAP5Ujx5epl+RnU4KDODb3hYW27WoCD4noeBMeZGM484F0FRXbW0mm4kVd3dXMo1w5
        0p6UpQuKeheulY6OkdyB7R2XRRU0Q
X-Received: by 2002:a24:22c5:: with SMTP id o188mr1224411ito.68.1552633649237;
        Fri, 15 Mar 2019 00:07:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQZOIz5ZIc0m1YqCtz+/ZaqgN5bwpbz4pe4gLDAwDoK9DlDfJXPEcFxu+2bjJMnm7nDE+5fg==
X-Received: by 2002:a24:22c5:: with SMTP id o188mr1224398ito.68.1552633648994;
        Fri, 15 Mar 2019 00:07:28 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 14sm687858ity.24.2019.03.15.00.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 00:07:27 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: ipwireless: fix missing checks for ioremap
Date:   Fri, 15 Mar 2019 02:07:12 -0500
Message-Id: <20190315070714.20623-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314123550.GI31119@suse.cz>
References: <20190314123550.GI31119@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipw->attr_memory and ipw->common_memory are assigned with the
return value of ioremap. ioremap may fail, but no checks
are enforced. The fix inserts the checks to avoid potential
NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Reviewed-by: David Sterba <dsterba@suse.com>

---
V2: fix typos
---
 drivers/tty/ipwireless/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/ipwireless/main.c b/drivers/tty/ipwireless/main.c
index 3475e841ef5c..4c18bbfe1a92 100644
--- a/drivers/tty/ipwireless/main.c
+++ b/drivers/tty/ipwireless/main.c
@@ -114,6 +114,10 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->common_memory = ioremap(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]));
+	if (!ipw->common_memory) {
+		ret = -ENOMEM;
+		goto exit1;
+	}
 	if (!request_mem_region(p_dev->resource[2]->start,
 				resource_size(p_dev->resource[2]),
 				IPWIRELESS_PCCARD_NAME)) {
@@ -134,6 +138,10 @@ static int ipwireless_probe(struct pcmcia_device *p_dev, void *priv_data)
 
 	ipw->attr_memory = ioremap(p_dev->resource[3]->start,
 				resource_size(p_dev->resource[3]));
+	if (!ipw->attr_memory) {
+		ret = -ENOMEM;
+		goto exit3;
+	}
 	if (!request_mem_region(p_dev->resource[3]->start,
 				resource_size(p_dev->resource[3]),
 				IPWIRELESS_PCCARD_NAME)) {
-- 
2.17.1

