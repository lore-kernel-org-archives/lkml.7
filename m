Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA0C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA13227BF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003271;
	bh=Sdd+9oGeB8DlpNRG5CotalsKfgsgUEcu2SQl7U+pO2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DC+t/oF5eMKsWMT2zTvFnaF254GOLVx9QYdVNtH+AraZkdR8DvZ0bUNmuHYXx7L2q
	 BGcBIggWNjXlMKjkMu4bGFU/BcVmo8Eq8xJyo9Osa/o/nfrN2KX1U8Lbofu6uFD2ns
	 swTIAzM7fIBe0SttiyUNaGrS2BPz9GOH53zO2Thc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgABWOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgABWO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:14:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A2524653;
        Thu,  2 Jan 2020 22:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003265;
        bh=Sdd+9oGeB8DlpNRG5CotalsKfgsgUEcu2SQl7U+pO2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EB6yzEYOwvgeLJOpDn4sFf8UXyxTY+9rnl2NyLi4+/ZsRfkFt0pecRyxl1SHBSniy
         U+RkzqXPKh8jDsJtg1hB3WV/RGVAM84CXQwCQ9p7FtOVQJsn+z4KQ6iYEvXTUTsFpO
         YYOTsdnYEAHipqo9ZIqMX8NnmnZD3bLE6qGbnp98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 063/191] PCI: rpaphp: Fix up pointer to first drc-info entry
Date:   Thu,  2 Jan 2020 23:05:45 +0100
Message-Id: <20200102215836.725789187@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

[ Upstream commit 9723c25f99aff0451cfe6392e1b9fdd99d0bf9f0 ]

The first entry of the ibm,drc-info property is an int encoded count
of the number of drc-info entries that follow. The "value" pointer
returned by of_prop_next_u32() is still pointing at the this value
when we call of_read_drc_info_cell(), but the helper function
expects that value to be pointing at the first element of an entry.

Fix up by incrementing the "value" pointer to point at the first
element of the first drc-info entry prior.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1573449697-5448-5-git-send-email-tyreld@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/rpaphp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 18627bb21e9e..e3502644a45c 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -239,6 +239,8 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 	value = of_prop_next_u32(info, NULL, &entries);
 	if (!value)
 		return -EINVAL;
+	else
+		value++;
 
 	for (j = 0; j < entries; j++) {
 		of_read_drc_info_cell(&info, &value, &drc);
-- 
2.20.1



