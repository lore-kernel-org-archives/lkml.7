Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF02C5B57B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 18:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59FF216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 18:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BV1BIcha";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BV1BIcha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfF2S4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 14:56:55 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47948 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfF2S4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 14:56:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5309A8EE0E3;
        Sat, 29 Jun 2019 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561834614;
        bh=1KZhaxtkJRxfrKc7nv1ygTJA0Gwrm6nucR5l2ijaXZs=;
        h=Subject:From:To:Cc:Date:From;
        b=BV1BIchaS2HhOPf7/TC81OlpMbroVdwNf6nyEYzDDBPpFxKfcFM1qhLYanlUeusAG
         0P354YaJYJQCZkC8CyKF2g7jru14prRaRIKx3QSJHIdjT6byIaG+nzhiWuGA9PMorG
         /q6P2/N6e7YiYztQ8VTsRe9WYO9+RyEc0dJmUOTQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r28EQWhnDg8I; Sat, 29 Jun 2019 11:56:54 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C2B608EE0C3;
        Sat, 29 Jun 2019 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561834614;
        bh=1KZhaxtkJRxfrKc7nv1ygTJA0Gwrm6nucR5l2ijaXZs=;
        h=Subject:From:To:Cc:Date:From;
        b=BV1BIchaS2HhOPf7/TC81OlpMbroVdwNf6nyEYzDDBPpFxKfcFM1qhLYanlUeusAG
         0P354YaJYJQCZkC8CyKF2g7jru14prRaRIKx3QSJHIdjT6byIaG+nzhiWuGA9PMorG
         /q6P2/N6e7YiYztQ8VTsRe9WYO9+RyEc0dJmUOTQ=
Message-ID: <1561834612.3071.6.camel@HansenPartnership.com>
Subject: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 29 Jun 2019 11:56:52 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symptoms are really weird: the screen image is locked in place. 
The machine is still functional and if I log in over the network I can
do anything I like, including killing the X server and the display will
never alter.  It also seems that the system is accepting keyboard input
because when it freezes I can cat information to a file (if the mouse
was over an xterm) and verify over the network the file contents. 
Nothing unusual appears in dmesg when the lockup happens.

The last kernel I booted successfully on the system was 5.0, so I'll
try compiling 5.1 to narrow down the changes.

James

