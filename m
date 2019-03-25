Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A40CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137EE20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfCYQBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:01:03 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:46800 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCYQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:01:03 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 95F9E3C00D1;
        Mon, 25 Mar 2019 17:01:01 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IUdq-zcC11Ge; Mon, 25 Mar 2019 17:00:54 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id D2EEF3C00C4;
        Mon, 25 Mar 2019 17:00:54 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 25 Mar
 2019 17:00:54 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/10] ALSA: aloop: Support selection of snd_timer
Date:   Mon, 25 Mar 2019 17:00:34 +0100
Message-ID: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following patch set any sound timer can be used as timer source
for the aloop devices if selected. It can be select by the additional
timer_source kernel module parameter:
-2   the jiffies timer will be used as done without this patch (default)
-1   the sound timer will be selected depending on the linked sound cards
     (snd_pcm_link()). The sound timer of the first linked card which is not
     a aloop device nor a dummy device will be used.
0..N Select the sound timer by the card number.

This patch set is required for forwarding audio data between a HW sound card
and an aloop device without the usage of an asynchronous sample rate converter.


Best regards,

Timo

