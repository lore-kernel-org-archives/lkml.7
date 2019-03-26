Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A6D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582392;
	bh=EzpcXdCHU+XOHpT4KBjFuFoTEotb/DRq2n7K1NcTmVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pe041kzELL4+ke7UcLQdlWEEwTSPiaavAZL8ZvP8NvX7TNBNgN3jF9VaEn98afm87
	 QYf86Qd6+Yzay3+PTv9k+h3s3kOnCAmORY8PEhTrLwjE600vZsFN+ykAveQlKL39CW
	 uaHq4Tz0LExGj0jo5pT6ELUaGXbi7IS/AxY6q9Qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfCZGju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732440AbfCZGjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:47 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D209620870;
        Tue, 26 Mar 2019 06:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582386;
        bh=EzpcXdCHU+XOHpT4KBjFuFoTEotb/DRq2n7K1NcTmVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+TzWOGKmft/TqYeukDSZnInXGTfq+vdwxYZ1OZtwcjaMwrEL0ArpMXjIVn5oOhod
         1JbPSqAUFA0WGTv0GDOaAT44Yb/nJbd+eVJsS5Zsg78mDGIcODshGIHsVlYQ4KMMWc
         spscS+eE+naC8X/tNu6HH3CMBUCwtl9VJo6LbJto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qtran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.0 21/52] scsi: qla2xxx: Fix FC-AL connection target discovery
Date:   Tue, 26 Mar 2019 15:30:08 +0900
Message-Id: <20190326042701.979104754@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qtran@marvell.com>

commit 4705f10e82c63924bd84a9b31d15839ec9ba3d06 upstream.

Commit 7f147f9bfd44 ("scsi: qla2xxx: Fix N2N target discovery with Local
loop") fixed N2N target discovery for local loop.  However, same code is
used for FC-AL discovery as well. Added check to make sure we are bypassing
area and domain check only in N2N topology for target discovery.

Fixes: 7f147f9bfd44 ("scsi: qla2xxx: Fix N2N target discovery with Local loop")
Cc: stable@vger.kernel.org # 5.0+
Signed-off-by: Quinn Tran <qtran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4968,6 +4968,13 @@ qla2x00_configure_local_loop(scsi_qla_ho
 		    (area != vha->d_id.b.area || domain != vha->d_id.b.domain))
 			continue;
 
+		/* Bypass if not same domain and area of adapter. */
+		if (area && domain && ((area != vha->d_id.b.area) ||
+		    (domain != vha->d_id.b.domain)) &&
+		    (ha->current_topology == ISP_CFG_NL))
+			continue;
+
+
 		/* Bypass invalid local loop ID. */
 		if (loop_id > LAST_LOCAL_LOOP_ID)
 			continue;


