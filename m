Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EFDC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF2420815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="NpHXUmMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfEZPfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 11:35:46 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:42994 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEZPfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 11:35:46 -0400
Received: by mail-pg1-f173.google.com with SMTP id 33so4697683pgv.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hPbxk4I14QvxRcb7WA6V+88SxxNIE6ziYaM9tmkpMDg=;
        b=NpHXUmMimASW5WMeq0/Y94Q93wqGGhtdw8koSAxTMVAR4f8SEwMKIGCcaiin5mJfRd
         oIyGZ4ibpkvN9ycb2H//XK1UE9UqL1LdR+eTUeKOkI10vraaLaIi4JU//faiKj4iAE4E
         lO11jrY8bgczmvLKG0cxmhR5GuFihL8+FNmHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hPbxk4I14QvxRcb7WA6V+88SxxNIE6ziYaM9tmkpMDg=;
        b=EHqcFlK+JpT70sQLiHeeO15fZgTiuHdD07foVZmSzuwx6WPGAEyufG8BZxwqLjHW7m
         Sl/VbfnFhpOkbJsQC8Mgp8/e0LtJ7s1MxZTWx6rjaFOAEUMR7wNicg5g0ivoeXIplxe0
         DyOlxxlOh8QwotWQw2cFaJ9P09X1+sWGjcvytol9xeuOTF0VdFNd0gKTXaik1+CCs9ag
         so3wjSrqWekB5oGc02KjSaW89rBQUDL3HOn7R68JSyk41Kwr8rKRgDJ03K/1ENle4QIT
         vGf7vk0XKusSnx8Xpi1Y24vvHWqfaIf2w3uMRq5nShPm3wINXj03Ab5Sy4uOy3ihT/1z
         isbw==
X-Gm-Message-State: APjAAAUts4mrggK+wdFRPsbL+yoQ9nBnObkqrd9rbWj4g7Ml8/CKd/fS
        DZq+CisRZe96knxkyBr6A5+4cg==
X-Google-Smtp-Source: APXvYqwDryZPFz2RYGrEUOHv1Uqf5aabrlyEgg5EUT9j5DhPlCgU1mErTECPXm5sDXmY9yBB7C8bnQ==
X-Received: by 2002:a63:246:: with SMTP id 67mr121965588pgc.145.1558884945548;
        Sun, 26 May 2019 08:35:45 -0700 (PDT)
Received: from localhost.localdomain (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.googlemail.com with ESMTPSA id y25sm10523637pfp.182.2019.05.26.08.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:35:44 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net v2 0/1] Allow TX timestamp with UDP GSO
Date:   Sun, 26 May 2019 08:33:56 -0700
Message-Id: <20190526153357.82293-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.

This is version 2 which moves the tests to net-next.

Fred Klassen (1):
  net/udp_gso: Allow TX timestamp with UDP GSO

 net/ipv4/udp_offload.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.11.0

