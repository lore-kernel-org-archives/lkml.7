Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007DB2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254454;
	bh=WEQsBcVUkXUMU1+k5JhCL9Xb2zzOlH1RjwKojptDEfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JEN4d3dC5eQlUOyfRl5QS8A4Iokf3V8YLEJzS3VAnRQ01icWaVRsOXCxPINqxX3JA
	 90l75PBiZPb9x6/PkzwLShk1vO9Ec6giP73EttsE9YMhRMqGRTGDHppQzSVguZJ/B4
	 CNIVBbZE2cc+vaQGcYbEIe+3HAIXlsl6JpjoN8Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfCVLeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbfCVLeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4279821916;
        Fri, 22 Mar 2019 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254450;
        bh=WEQsBcVUkXUMU1+k5JhCL9Xb2zzOlH1RjwKojptDEfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wkH/pNhKyAYlNTo//PX4X5CSxmUIjtmu5uW+TaDGiVQ9FlZGczgV+jLf4CPEFPMky
         JlkSXf/kcs7JBeGQ/zx6UF3I1v6wztxjbjIxAqJlYD4D8IY1W/lXbA6yR/bKNt6xoY
         vw5TZkRxddXoKlxTR+qjlO6lgqiOQuf1b1Cm+XZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.4 114/230] iscsi_ibft: Fix missing break in switch statement
Date:   Fri, 22 Mar 2019 12:14:12 +0100
Message-Id: <20190322111244.637417126@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit df997abeebadaa4824271009e2d2b526a70a11cb upstream.

Add missing break statement in order to prevent the code from falling
through to case ISCSI_BOOT_TGT_NAME, which is unnecessary.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: b33a84a38477 ("ibft: convert iscsi_ibft module to iscsi boot lib")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/iscsi_ibft.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -513,6 +513,7 @@ static umode_t __init ibft_check_tgt_for
 	case ISCSI_BOOT_TGT_NIC_ASSOC:
 	case ISCSI_BOOT_TGT_CHAP_TYPE:
 		rc = S_IRUGO;
+		break;
 	case ISCSI_BOOT_TGT_NAME:
 		if (tgt->tgt_name_len)
 			rc = S_IRUGO;


