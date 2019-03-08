Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0704C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC3D21019
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050059;
	bh=DgnfXS7Y+SMewUak7EVmawr6BE2qsnarBsP26cAGTug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9/6LsEz9xA4PxFVvFwcwL+n1x1LSk5HdjJKDrzP0kUyToI/tfT/RkDPy+czOes+G
	 vhrabWRjNqmUMjcdiDDAhFzgutDam5cnSPJbDsx6SVOiIwHfMJaTcB3FuEXrmrUjLN
	 5PkP/9Rwhi0UbDswVgOpmr5/La6btr3rwPHwqjWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfCHNA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfCHNAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F027C21019;
        Fri,  8 Mar 2019 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050052;
        bh=DgnfXS7Y+SMewUak7EVmawr6BE2qsnarBsP26cAGTug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SfI14QTufB/Q+Y+eqj25dH6LZGLlMwId3/VZdEfp+PwxdZqpaVIR84Wk2fGMurPS
         eHs2VgGAV7RITEOZ95nIh+qZA16aQ1oEW4I4BEo0pcJ0J3729GrDWpJLqqgNhdakN2
         VUi5pjVpWSPwb7hVkwSU3CiJQnnYoxGkrvuFV6TQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 67/68] scsi: core: reset host byte in DID_NEXUS_FAILURE case
Date:   Fri,  8 Mar 2019 13:50:37 +0100
Message-Id: <20190308124913.948986896@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

From: Martin Wilck <mwilck@suse.com>

commit 4a067cf823d9d8e50d41cfb618011c0d4a969c72 upstream.

Up to 4.12, __scsi_error_from_host_byte() would reset the host byte to
DID_OK for various cases including DID_NEXUS_FAILURE.  Commit
2a842acab109 ("block: introduce new block status code type") replaced this
function with scsi_result_to_blk_status() and removed the host-byte
resetting code for the DID_NEXUS_FAILURE case.  As the line
set_host_byte(cmd, DID_OK) was preserved for the other cases, I suppose
this was an editing mistake.

The fact that the host byte remains set after 4.13 is causing problems with
the sg_persist tool, which now returns success rather then exit status 24
when a RESERVATION CONFLICT error is encountered.

Fixes: 2a842acab109 "block: introduce new block status code type"
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_lib.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -757,6 +757,7 @@ static blk_status_t scsi_result_to_blk_s
 		set_host_byte(cmd, DID_OK);
 		return BLK_STS_TARGET;
 	case DID_NEXUS_FAILURE:
+		set_host_byte(cmd, DID_OK);
 		return BLK_STS_NEXUS;
 	case DID_ALLOC_FAILURE:
 		set_host_byte(cmd, DID_OK);


