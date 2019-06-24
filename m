Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90FDC48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793F9205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370576;
	bh=A1RrtKwHN0dBw+kQjkpEeeBB6NYU+o4WplT4dVU1GkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUPnCVm3ARB3L9kgGPjlEtpNIv6NE0a7jCjk6hx0svPjeqONU5mxV9BPsbfmMg+S8
	 TKxKrTO+sskFe3mBYa01osSeCmKeCZp0uvF3PQ0vk2ZwUl2rQUpdiL0LWCAU9x24w6
	 JNyKsct54xGnD2RyPTP8sF+Ow8kBYTJwUTE6h0i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfFXKCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729448AbfFXKCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:02:49 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C37EA208E3;
        Mon, 24 Jun 2019 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370569;
        bh=A1RrtKwHN0dBw+kQjkpEeeBB6NYU+o4WplT4dVU1GkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TECAI53UWwYQbVAnN0a4V7RoiDJF2yVkXMH1PJAAsxt6Q3fkX5bikd/vwmu6C8xAN
         3SNrX+d3j8TmHHhhDq2rr1hda8qH2KcB9dOGUpfJLi6Huk2ab05mtj1LzMygFN5LoT
         0C6gko7OJWRo7Bio4OM6nKMTbteS+Qwy4mYjOz/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Mikhaylenko <exalm7659@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 23/90] Input: synaptics - enable SMBus on ThinkPad E480 and E580
Date:   Mon, 24 Jun 2019 17:56:13 +0800
Message-Id: <20190624092315.584974854@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Mikhaylenko <exalm7659@gmail.com>

commit 9843f3e08e2144724be7148e08d77a195dea257a upstream.

They are capable of using intertouch and it works well with
psmouse.synaptics_intertouch=1, so add them to the list.

Without it, scrolling and gestures are jumpy, three-finger pinch gesture
doesn't work and three- or four-finger swipes sometimes get stuck.

Signed-off-by: Alexander Mikhaylenko <exalm7659@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -179,6 +179,8 @@ static const char * const smbus_pnp_ids[
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
+	"LEN2054", /* E480 */
+	"LEN2055", /* E580 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	NULL


