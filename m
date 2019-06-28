Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E208C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C41E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfF1Gf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:35:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48343 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfF1Gf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:35:56 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hgkUF-0006YV-Ek
        for linux-kernel@vger.kernel.org; Fri, 28 Jun 2019 06:35:55 +0000
Received: by mail-pl1-f200.google.com with SMTP id a5so2942660pla.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 23:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rg763IUCOLn//QYbXaACukPUtIg7NLpq/IpQFYmUqJE=;
        b=do+Pk5H006brFCfu8N0hQwoMLG9Mw2qEyEVtYmC/ag3P26+0w3vyUqh/1BYICILHhQ
         dLY/wTpJUpD+8RKYtKBsN+OKn2KsXYj13qySBUNlt9WgqEp/NnuOu1a54ZJ8rZkcniEN
         WtcTnB/tY1xymIOTgzV8xgur7+YUiDWDnE8zFXWhyugvn9UON/pNsCBkeVs/hSnVdLMo
         OK5BSTR7Nnxo+TKOZzvyI99qLs6vDc0azM47rC+SeM2VfR4NHhzmJmr4jYuoBXdl0kcj
         fbz7V35FjoffrxiZSIvjB++CzjuwrPEPDfJ2VA2451UaKjztbnOgGlWW51SiwRhx/Vs5
         fphA==
X-Gm-Message-State: APjAAAUxsG6ySDby+jUyKXXjCTQLgdLv96mom5Fh4Y+uVDPjgWyCrhBw
        sdnWUkK+0DCpV6TxK9lHulXehbzpOXd67q0KUIZwl4x0W8Z4u+DaXpWEUJv4lLR4YfXcgOZdlU7
        ub4A6OJbbNQT5wSKPq/06sC31TGtwQ/e3q/hkDpXYLQ==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr9423313plr.309.1561703754229;
        Thu, 27 Jun 2019 23:35:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/yhCRthlAYn0qft94ePOe14fr0LxwjUI5ovriF1juSlUqvtRTiY4W+tbeXRLlc/X6/7OijQ==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr9423296plr.309.1561703753996;
        Thu, 27 Jun 2019 23:35:53 -0700 (PDT)
Received: from 2001-b011-380f-3511-c09f-cbfd-7c09-2630.dynamic-ip6.hinet.net (2001-b011-380f-3511-c09f-cbfd-7c09-2630.dynamic-ip6.hinet.net. [2001:b011:380f:3511:c09f:cbfd:7c09:2630])
        by smtp.gmail.com with ESMTPSA id s43sm1175750pjb.10.2019.06.27.23.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 23:35:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: ca0132 audio in Ubuntu 19.04 only after Windows 10 started, missing
 ctefx-r3di.bin
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <156113479576.29306.8491703251507627705.malone@gac.canonical.com>
Date:   Fri, 28 Jun 2019 14:35:51 +0800
Cc:     alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <B0FDD5B2-EA6F-4ABC-8BF5-6231AA31EB70@canonical.com>
References: <156097935391.32250.14918304155094222078.malonedeb@chaenomeles.canonical.com>
 <156113479576.29306.8491703251507627705.malone@gac.canonical.com>
To:     conmanx360@gmail.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Connor,

The bug was filed at Launchpad [1], I think the most notable error is
[    3.768667] snd_hda_intel 0000:00:1f.3: Direct firmware load for  
ctefx-r3di.bin failed with error -2

The firmware is indeed listed in patch_ca0132.c, but looks like there’s no  
corresponding file in linux-firmware.

Can you please take a look at the bug?

[1] https://bugs.launchpad.net/bugs/1833470

Kai-Heng

