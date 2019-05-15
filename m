Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD14C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD1620881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919626;
	bh=QpFXXmpMTOdZPQAY3EtC5FGc6JxRxY/eUM5iSrnA3Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VIqs5M7dZj1wb7tKIJmCRU55125hmZYFV/MHMc0CtNw6wMowk4Wr+/XW7Y/NfJta5
	 5cm72Ji/BZ2OWXdnLtnuFUmz59aKDxibda7yBG9pR/jm2kY7XVJNDHR6rixIqD66QE
	 090MlMNLf9JaMhGAXW+HmoOdorFKp6NJOlWm5mFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfEOL1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731966AbfEOL1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:27:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C444920843;
        Wed, 15 May 2019 11:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919620;
        bh=QpFXXmpMTOdZPQAY3EtC5FGc6JxRxY/eUM5iSrnA3Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7AkAijL1bWVoJpPl1POxXovh5Fsyy6MVbI59DR7IvVAPr6kGT2ktXZrpZ4Vv2Gsi
         L12rgTov5s36V1uAZ85AuDvTfhVrBF2IHgLBa7ZrS6U4nfvCVEeCafY7s0lEYGzQKX
         QbZdcWRtkL6ymVnBQVrLZOrjugMcVJoCoEq0qpKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lei YU <mine260309@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.0 006/137] hwmon: (occ) Fix extended status bits
Date:   Wed, 15 May 2019 12:54:47 +0200
Message-Id: <20190515090653.152307752@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lei YU <mine260309@gmail.com>

commit b88c5049219a7f322bb1fd65fc30d17472a23563 upstream.

The occ's extended status is checked and shown as sysfs attributes. But
the code was incorrectly checking the "status" bits.
Fix it by checking the "ext_status" bits.

Cc: stable@vger.kernel.org
Fixes: df04ced684d4 ("hwmon (occ): Add sysfs attributes for additional OCC data")
Signed-off-by: Lei YU <mine260309@gmail.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/occ/sysfs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/hwmon/occ/sysfs.c
+++ b/drivers/hwmon/occ/sysfs.c
@@ -51,16 +51,16 @@ static ssize_t occ_sysfs_show(struct dev
 		val = !!(header->status & OCC_STAT_ACTIVE);
 		break;
 	case 2:
-		val = !!(header->status & OCC_EXT_STAT_DVFS_OT);
+		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_OT);
 		break;
 	case 3:
-		val = !!(header->status & OCC_EXT_STAT_DVFS_POWER);
+		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_POWER);
 		break;
 	case 4:
-		val = !!(header->status & OCC_EXT_STAT_MEM_THROTTLE);
+		val = !!(header->ext_status & OCC_EXT_STAT_MEM_THROTTLE);
 		break;
 	case 5:
-		val = !!(header->status & OCC_EXT_STAT_QUICK_DROP);
+		val = !!(header->ext_status & OCC_EXT_STAT_QUICK_DROP);
 		break;
 	case 6:
 		val = header->occ_state;


