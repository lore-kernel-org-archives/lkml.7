Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01FBC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 10:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CC321655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 10:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=living180.net header.i=@living180.net header.b="DsC4bf8v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JlS6C2du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLUKCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 05:02:40 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39461 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbfLUKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 05:02:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3F66D681;
        Sat, 21 Dec 2019 05:02:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 21 Dec 2019 05:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=from:subject:to:cc:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=mf756YqPUpw9UW/+oFcO+1ckXv
        2z+LXd4Xw3O6R0G5s=; b=DsC4bf8vmfRDgXGfVzYsW+QjpKWc+SqH4nCtcOEvRn
        9QEwqkjvUtXiVm7iqOdCaEdNY7j3AadtSURm0uDVyZ4F6zgeX5JtaVXhXj5hFO97
        5HyA1s9fffQTUA5YlZyoFJ5LQReux9GGegqSQfcYBjNB5xNGg/Ag7I6m8FMBc9TT
        h4qrKryGg7v2irbiKT1LrCMSJVAlRN8vowSUBVDfHRPfb6z6qHSIuyHNNQcQbFZs
        f4LKjJZDrv3QwmkkRTXy6IrhPIsAg5yIflR7xg/zNjrkpsIYP2Pt9T9iXTFMTq8C
        3lLdL9Aknp0N5DUKuKNXF7YUxi1j3GD6Ufp1pY30G6YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mf756Y
        qPUpw9UW/+oFcO+1ckXv2z+LXd4Xw3O6R0G5s=; b=JlS6C2dum9PdULDRLAWokZ
        V5vtHVnK/bJWNNUSF6T+2kmMI+CkvPM9hIzwvw0Ulkf3tNo+OhlL+/nPyBarK0J0
        WgjTPGUHu10lBzvZmgvxjznWT8tpDFZTIPuyhOUraodMV4zpqnSjtCGH+5iFh38U
        wnw8x+zIZZxBfcTwH7iwJJs/Wpq7enkf8a03gdSndIhm8+oR718pyKlKwvhaoLBe
        YLETwZxuXqC0nmp3R9Q7tjzurvV+7wKLDSZ0dywN3PVYrpGb1SrrIseoJyyQH785
        UKXzUR1yhASPTCowuxILnbbTic9R6w8EqM7KpXPLDIWwqPAvWMf/RQNXtzKEZzBQ
        ==
X-ME-Sender: <xms:ve39XT52BArQOBl0uR7NLQzah9aJuA-J_WcWQR1-BArC0Kpze5xmCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdduhedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffuvffkffgfgggtgfesthekredttdefjeenucfhrhhomhepffgrnhhivghl
    ucfjrghrughinhhguceoughhrghrughinhhgsehlihhvihhnghdukedtrdhnvghtqeenuc
    fkphepudejfedrudelledrudduhedrvdegjeenucfrrghrrghmpehmrghilhhfrhhomhep
    ughhrghrughinhhgsehlihhvihhnghdukedtrdhnvghtnecuvehluhhsthgvrhfuihiivg
    eptd
X-ME-Proxy: <xmx:ve39XViU8MPTwiCvNGQvRQtrLvLDgrs-lNCorTEaIwKJBRXJ6E9NBw>
    <xmx:ve39XeGTG_D1EhCNhwDoCxwE-ySzZh86yZHGS7B0H-z1YRAQmIqEFA>
    <xmx:ve39XaSzBaS877-V6w89PohpkcHkOpuBS-z-FlDQoLh7IR9EF-sPkg>
    <xmx:ve39XYzRCg6qWB820pMNg0EUTCs_-7ua-vOaSNwJ-gds-_HFtux3fw>
Received: from [0.0.0.0] (unknown [173.199.115.247])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6B0D8005C;
        Sat, 21 Dec 2019 05:02:35 -0500 (EST)
From:   Daniel Harding <dharding@living180.net>
Subject: [5.3 Regression] x86/ioapic change causes suspend problem
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <6f3101a3-8404-2a6a-b2c1-d6b2e4179938@living180.net>
Date:   Sat, 21 Dec 2019 12:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over the past few weeks I've been experiencing problems with 
suspend/hybrid sleep on my laptop (a Clevo N240BU, Intel Core 
i7-7500U).  Instead of the suspend process completing normally, the 
computer hangs with a blank screen and the CPU fan spinning above idle.  
I have to forcibly power off the computer to get it to turn off.  If I 
invoke hybrid sleep, the hibernation image is intact and I am able to 
resume from that after powering the computer back on.

I bisected the issue, and traced it to commit 
dfe0cf8b51b07e56ded571e3de0a4a9382517231.  Before that commit, suspend 
works reliably, but afterward it hangs most of the time.  I verified 
that the problem still exists in version 5.4.5, but have not tested the 
latest master.

If there is any more information that would be useful or if I can help 
to resolve this issue in any way, please let me know.

Regards,

Daniel Harding
