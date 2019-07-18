Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20907C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD2221848
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419100;
	bh=1M5uP+m8cuTDZeta1c/3TZC1egzglcR2qlnV2iaMkKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iGzTOvaF7GKeMpWHQ5f5vTFyP2otmPnfTy1F7uXWj3o6mwC47AFUUc7vbn9e4oFfJ
	 ZUlkOjnRDUbV1dfD139WPyjOBB26O+IITYSlA//dZJHdp0S/g+HNN71JxvNXrPO7ln
	 zrrnN3ZzmRwMlO0bBhXNAa6E1Mdjv+SV//Q4YfeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbfGRDE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389830AbfGRDE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:04:57 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28F92053B;
        Thu, 18 Jul 2019 03:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419096;
        bh=1M5uP+m8cuTDZeta1c/3TZC1egzglcR2qlnV2iaMkKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6rU6dGKSXoqvnfIcloEihcRJTlwcNCSlF9GaLjnbxWSVGq43FgNKcHWzsYnHc8Ji
         pd7Vf3mZO4DM1TBDr27+QGqdobMVgzypBpFUAI8R3dRGqEUAhI+ySziZQkrJc/iUoU
         xllD+mO5aBDSzmv7kYnNqSXXH7ip+CtM0jGFpL9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cole Rogers <colerogers@disroot.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.1 03/54] Input: synaptics - enable SMBUS on T480 thinkpad trackpad
Date:   Thu, 18 Jul 2019 12:00:58 +0900
Message-Id: <20190718030053.613001211@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030053.287374640@linuxfoundation.org>
References: <20190718030053.287374640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cole Rogers <colerogers@disroot.org>

commit abbe3acd7d72ab4633ade6bd24e8306b67e0add3 upstream.

Thinkpad t480 laptops had some touchpad features disabled, resulting in the
loss of pinch to activities in GNOME, on wayland, and other touch gestures
being slower. This patch adds the touchpad of the t480 to the smbus_pnp_ids
whitelist to enable the extra features. In my testing this does not break
suspend (on fedora, with wayland, and GNOME, using the rc-6 kernel), while
also fixing the feature on a T480.

Signed-off-by: Cole Rogers <colerogers@disroot.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -176,6 +176,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
 	"LEN0092", /* X1 Carbon 6 */
+	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */


