Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29769C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE27C21873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563418976;
	bh=S3zB4DvXVPTe8ROWrqlgu7FLbjfqLceLVwwFDxHyByo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UAQ6Nzhxeaf2W2zGFWAVFOovquQ/XyRNaRdpTauTg9wk12/mGFya+aI6e7MMRxGPz
	 LUyMk/xVX0yQHdcybff7xyPhLO5MwwoM7GsXFjXn8rdL0kb/Q38ql0xyUvG2BT+8Qx
	 3AiRtKDp+1ATa1oarEUlGckpwzJGM0FNQ7ZfHT7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbfGRDCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfGRDCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:02:53 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C4962173B;
        Thu, 18 Jul 2019 03:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563418972;
        bh=S3zB4DvXVPTe8ROWrqlgu7FLbjfqLceLVwwFDxHyByo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yNgNL+mbTmERsJGCCaGt9NbPGwDmDUtwNHpxXEvcLSmQ+PcDJcTs1LfU8cp23Ei87
         Fy4evM8tOc6FM2PIU5RF+bWyC02ZagaG/naHxsv0I5413yi6hgYxwzGt5MWvZY0GCi
         9Psv+5n2V0iFgm0Qob2M+PNAdU703zd+cKKYTILs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cole Rogers <colerogers@disroot.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.2 03/21] Input: synaptics - enable SMBUS on T480 thinkpad trackpad
Date:   Thu, 18 Jul 2019 12:01:21 +0900
Message-Id: <20190718030031.073218961@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030030.456918453@linuxfoundation.org>
References: <20190718030030.456918453@linuxfoundation.org>
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
@@ -173,6 +173,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
 	"LEN0092", /* X1 Carbon 6 */
+	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */


