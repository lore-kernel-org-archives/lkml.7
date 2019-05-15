Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F893C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F7C20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921539;
	bh=ItPj+Nbvo0KNZmmn+28rj26rGJqd7jzYZpfB+8lrKk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K++BPCaQ3h3b6S7OhHiJj8aBcEfHQhIJ2vCziCZcXJ7QGapYPgYSnOjQ6t1AhEAT7
	 2SkwtsH8aRJjuG/pnxYn9L50JSb2xGYB/wpIpiDo78+8gmOWSP2MmQKkNYOL832nKv
	 ZOX6cf0alge6HSIeYs9C2n0lOA/uWnDeVtFdrbrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfEOL65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbfEOLPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:15:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EAB20843;
        Wed, 15 May 2019 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918948;
        bh=ItPj+Nbvo0KNZmmn+28rj26rGJqd7jzYZpfB+8lrKk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/YO6AKqmdwRQTr8TjsFQ0qNShEiMefSW1UCS21YonNNKUkT2w2KpthJ4uc1iKcUj
         iw5JLC0eWGVRfZc5FBlkFySoS1vRC2STq4sYRzUscM+mdzO8VpWiMzppcwY0TPMRTw
         +840oCcvpUktwjTinLQRpuYXBuneJgc7TefLllHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 002/115] platform/x86: sony-laptop: Fix unintentional fall-through
Date:   Wed, 15 May 2019 12:54:42 +0200
Message-Id: <20190515090659.332039601@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 1cbd7a64959d33e7a2a1fa2bf36a62b350a9fcbd upstream.

It seems that the default case should return AE_CTRL_TERMINATE, instead
of falling through to case ACPI_RESOURCE_TYPE_END_TAG and returning AE_OK;
otherwise the line of code at the end of the function is unreachable and
makes no sense:

return AE_CTRL_TERMINATE;

This fix is based on the following thread of discussion:

https://lore.kernel.org/patchwork/patch/959782/

Fixes: 33a04454527e ("sony-laptop: Add SNY6001 device handling (sonypi reimplementation)")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/sony-laptop.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -4422,14 +4422,16 @@ sony_pic_read_possible_resource(struct a
 			}
 			return AE_OK;
 		}
+
+	case ACPI_RESOURCE_TYPE_END_TAG:
+		return AE_OK;
+
 	default:
 		dprintk("Resource %d isn't an IRQ nor an IO port\n",
 			resource->type);
+		return AE_CTRL_TERMINATE;
 
-	case ACPI_RESOURCE_TYPE_END_TAG:
-		return AE_OK;
 	}
-	return AE_CTRL_TERMINATE;
 }
 
 static int sony_pic_possible_resources(struct acpi_device *device)


