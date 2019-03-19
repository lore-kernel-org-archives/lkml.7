Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082CC2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="vf7//+5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWyhRtCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCSWs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:48:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53235 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726823AbfCSWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:48:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0232922203;
        Tue, 19 Mar 2019 18:48:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 19 Mar 2019 18:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=8cJoxKnn8Sw9D7HK8T6WWot8f+
        suZDUi6lSQ+EboyaU=; b=vf7//+5rtJkAVAat0LP2T692Dm2CmqOrnI75k18Nxq
        JSR8taS4NGgkpuKpsQP68eKApoYle63kQCDULOmeTEkaPa6r9PaJsqulDsg8hWwZ
        h20SfQrUF3xp/oszRvKTXuGa7oYqBCntr3qGcENNKaiVteq88s2PEu//NrG0SsMa
        L4SmkE0sX4BVT6/aVL3gU0XXEjN5Uu6KFTVKbo/soEGggv7a6VNKg/1iFcRLYz5X
        XK4sfB5AqMwcKuM8GhL78HPwhu1yXFmsCAd6cVeuYUQ7IIfemxjnskTvd76Y9Elr
        wtlFFWvC1IYKklvhZtOQtEgYOMaIl3HcGCu+jhHAlD8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8cJoxK
        nn8Sw9D7HK8T6WWot8f+suZDUi6lSQ+EboyaU=; b=tWyhRtChlhxtKIzpmPkHQh
        2qgtdtpQYCAwOANwBN/oKsUC5Zbq7dtpLP8tQOpM0QV74u+CNrV9Nipneho4mV66
        wHW1YpBHau2VeCNDzBVT9Oykllm3OfMYPsf5rmgCxl4pi5nlnTfhrMraRItCZJYB
        EZmuEb19Ak02Yc/x15MepcsiJyFsrdF0BNJxgrD37d1g3rlUCGvOcLMQ1SdiwJYx
        9piw0UxVm9ffI/qKtxVTpo550zgHwnz4hrnJY39pct/Yh6X97SJATUyaNBvk2g6W
        oeSx0J70xCT1zRWHMWyO/jM045uU3mre+kydn01/eKqAylQ1zNagwo5zrHB1fp6g
        ==
X-ME-Sender: <xms:uHGRXPgBYSMWSHTht5-zortsTEO7YLqXnyxopenptR1O2lPhMtWjIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrieehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugfgfgesthekredttderudenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucfkphepudektddrudehtddrleefrddugedvnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvthenucevlhhushhtvghruf
    hiiigvpedt
X-ME-Proxy: <xmx:uHGRXG5b7crosLT4LofHbQE9m8ClCeU9CWMuJ7HNh0SYv4qTnoZDKQ>
    <xmx:uHGRXB_egHZMdPXm8NLh3990XsQ0owIdIFX85magIvjSYeN6Cv9l_w>
    <xmx:uHGRXF8ipK2aZjnrSwWfYFTG6FuPrXxVrwD0LUWPesgNJdMAhMf4FQ>
    <xmx:uHGRXAIyG1gFKDTclMjkty7_9ctnNFoqYcIKo_G0ekJ5dM3nST7ZaA>
Received: from jelly (unknown [180.150.93.142])
        by mail.messagingengine.com (Postfix) with ESMTPA id 252AAE49D6;
        Tue, 19 Mar 2019 18:48:21 -0400 (EDT)
Date:   Wed, 20 Mar 2019 08:48:23 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Aimo =?iso-8859-1?Q?Mets=E4l=E4?= <aimetsal@outlook.com>,
        nlopezcasad@logitech.com, Jiri Kosina <jikos@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: logitech: Handle 0 scroll events for the m560
Message-ID: <20190319224823.GA26366@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hidpp_scroll_counter_handle_scroll() doesn't expect a 0-value scroll event, it
gets interpreted as a negative scroll direction event. This can cause scroll
direction resets and thus broken scrolling.

Reported-and-tested-by: Aimo Metsälä <aimetsal@outlook.com>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-logitech-hidpp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 15ed6177a7a3..f040c8a7f9a9 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2608,8 +2608,9 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		input_report_rel(mydata->input, REL_Y, v);
 
 		v = hid_snto32(data[6], 8);
-		hidpp_scroll_counter_handle_scroll(
-				&hidpp->vertical_wheel_counter, v);
+		if (v != 0)
+			hidpp_scroll_counter_handle_scroll(
+					&hidpp->vertical_wheel_counter, v);
 
 		input_sync(mydata->input);
 	}
-- 
2.20.1

