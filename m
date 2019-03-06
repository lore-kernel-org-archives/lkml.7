Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A2DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E63D20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfCFAhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:37:11 -0500
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:57922 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726699AbfCFAhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:37:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 12D5A182CF66C;
        Wed,  6 Mar 2019 00:37:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheep79_5b79f1be7861c
X-Filterd-Recvd-Size: 3395
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Mar 2019 00:37:08 +0000 (UTC)
Message-ID: <8d9f56e98854efb8858768119d935ac6091cfc50.camel@perches.com>
Subject: Re: [PATCH] hv: utils: fix coding style
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Jes=FAs?= Castro <x51v4n@gmail.com>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     miguel.bernal@zapopan.tecmm.edu.mx, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Mar 2019 16:37:07 -0800
In-Reply-To: <20190305234542.5243-1-x51v4n@gmail.com>
References: <20190305234542.5243-1-x51v4n@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 17:45 -0600, Jesús Castro wrote:
> Checkpatch script is showing a coding style error and is showing:
> 
> ERROR: else should follow close brace '}'
> +	}
> +	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
> 
> This commit fixes the coding style, not a functional change.
[]
> diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
[]
> @@ -139,8 +139,7 @@ static int hvt_op_open(struct inode *inode, struct file *file)
>  		 * device gets released.
>  		 */
>  		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
> -	}
> -	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
> +	} else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
>  		/*
>  		 * We're switching from netlink communication to using char
>  		 * device. Issue the reset first.

Rather than merely shutting up checkpatch warnings,
please try to improve the code for humans to read.

This block is probably better as a switch/case and
the separate bool issue_reset automatic seems
unnecessary as it's only used in one case.

Perhaps:
---
 drivers/hv/hv_utils_transport.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
index 832777527936..6b27dd7be9bb 100644
--- a/drivers/hv/hv_utils_transport.c
+++ b/drivers/hv/hv_utils_transport.c
@@ -125,35 +125,35 @@ static int hvt_op_open(struct inode *inode, struct file *file)
 {
 	struct hvutil_transport *hvt;
 	int ret = 0;
-	bool issue_reset = false;
 
 	hvt = container_of(file->f_op, struct hvutil_transport, fops);
 
 	mutex_lock(&hvt->lock);
 
-	if (hvt->mode == HVUTIL_TRANSPORT_DESTROY) {
-		ret = -EBADF;
-	} else if (hvt->mode == HVUTIL_TRANSPORT_INIT) {
+	switch (hvt->mode) {
+	case HVUTIL_TRANSPORT_INIT:
 		/*
 		 * Switching to CHARDEV mode. We switch bach to INIT when
 		 * device gets released.
 		 */
 		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
-	}
-	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
+		break;
+	case HVUTIL_TRANSPORT_NETLINK:
 		/*
 		 * We're switching from netlink communication to using char
 		 * device. Issue the reset first.
 		 */
-		issue_reset = true;
 		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
-	} else {
+		hvt_reset(hvt);
+		break;
+	case HVUTIL_TRANSPORT_DESTROY:
+		ret = -EBADF;
+		break;
+	default:
 		ret = -EBUSY;
+		break;
 	}
 
-	if (issue_reset)
-		hvt_reset(hvt);
-
 	mutex_unlock(&hvt->lock);
 
 	return ret;


