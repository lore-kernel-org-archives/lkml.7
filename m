Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13807C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C8E2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033810;
	bh=+BKNhstZkIim4IgI8aZWRD5EJTEYYGqYqAS97BenvGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TnCncZJYU4386gLjGArrA1SMe6yfuqsMXYdwCbUZ+2IFszZzcLDk4bhoa7j6QgROl
	 1gt5Cv/tf6jXsrY3J+0VONgrJNSGLpUER9Zqojies190+KmAtLy44oJK1sadvAc5la
	 TK8ZI1D+YvU8hujEG53EY0CaHDgmLcj5Mji9FX+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391004AbfGYFnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404889AbfGYFnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:43:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B468521850;
        Thu, 25 Jul 2019 05:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033389;
        bh=+BKNhstZkIim4IgI8aZWRD5EJTEYYGqYqAS97BenvGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppCi9XG+OrhyXcZT/5tw79Zm/6f5MEebhRR7CR1B0mBF8ELrX8iQ5n7AfLRgqHEfb
         rY797LcB8SzegDv/cqeMHW9hdwoE9s3j6om2rFb5WrO6sgJQdBpmR+BX6X5Q7u3qfq
         kVhQNsr0nytQbRZ9VvU5C9niMKMPXT8+D9iliN/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Black <dankamongmen@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 191/271] Input: synaptics - whitelist Lenovo T580 SMBus intertouch
Date:   Wed, 24 Jul 2019 21:21:00 +0200
Message-Id: <20190724191711.475428348@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Black <dankamongmen@gmail.com>

commit 1976d7d200c5a32e72293a2ada36b7b7c9d6dd6e upstream.

Adds the Lenovo T580 to the SMBus intertouch list for Synaptics
touchpads. I've tested with this for a week now, and it seems a great
improvement. It's also nice to have the complaint gone from dmesg.

Signed-off-by: Nick Black <dankamongmen@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
+	"LEN009b", /* T580 */
 	"LEN200f", /* T450s */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */


