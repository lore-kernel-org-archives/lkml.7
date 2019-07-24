Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33782C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25E5229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997008;
	bh=PEi2GMxy1WhnxhrKDoRAkYCwvjG2K+359OY+tDPNug4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lj4cEoMD5t5/Rwih9H6ZqjAQbc79bxoFEuo8WFvvwcZ3uwqQnyZr4dTXdcwAGQSN2
	 VoTf847t5YuwWEWwO54C4IIlHmOdW9aekM9F43pPqeL655XrQHEPRANphm7x/oFs14
	 Ab7FBpvBFZsiR7CvWYRmZBbuI2n3XwK8aN7PxLTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbfGXTgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389335AbfGXTgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:36:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1177F214AF;
        Wed, 24 Jul 2019 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997001;
        bh=PEi2GMxy1WhnxhrKDoRAkYCwvjG2K+359OY+tDPNug4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/TPcz7w9QG1wvfo2B8NGjJ6AdSrgcoUOXyZH7protYWkpBgYOxKTsVT9MLkKuLcp
         EHnEqbrcGSmoudca6Pqogf6YijTh/XUDIPXuPz4URWYKtg79h9EZsUmDjOvC7QRi9s
         9XO56j6icjC1DlpFOKtHfSlveWikMP4cA1Fu8Jok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Black <dankamongmen@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.2 288/413] Input: synaptics - whitelist Lenovo T580 SMBus intertouch
Date:   Wed, 24 Jul 2019 21:19:39 +0200
Message-Id: <20190724191756.859421785@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
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
@@ -176,6 +176,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
+	"LEN009b", /* T580 */
 	"LEN200f", /* T450s */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */


