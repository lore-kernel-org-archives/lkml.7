Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383292077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQwipTpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCMFAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:00:52 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:35819 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfCMFAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:00:52 -0400
Received: by mail-pf1-f169.google.com with SMTP id j5so521725pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 22:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:in-reply-to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BSiY41WUZOTJX6QSlHgyNV/xoUIDQJyY1QmOU7z+YQ0=;
        b=vQwipTpPuSmZ+uQerM950KEkfxBNYEIk3x1OXb0O4xCw9RSNf9QBAlUGX2dcxoXcAe
         Avkq0M/kS3txNs2J8Ahc/JsUS/wbuydxNHEOSGV8Ja/mM0iN5gVI772NKRuLrZYxRJVi
         ay+OSFJdigWpCxXijIsB3YoEvSUB71zE8tfTji+mpwnqihMOYcPNki2Kc4/BV9I8h+CI
         /R+0LDT0tQo1K2CdVruzVbTrSgr4TiK/YZp5wune0lc4FJxUk1IxUPasSGmZ7MPE2i87
         z4rYxP347OFHX4b7sN28sSiHWri2xnSk0ubNoGBwnp7JIh/OBmIsgJ/VjR4qz8I3CBCy
         rz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:in-reply-to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=BSiY41WUZOTJX6QSlHgyNV/xoUIDQJyY1QmOU7z+YQ0=;
        b=uTa/jemuT2MjRFNQ6b5oe9ZX7MS5Ml5D2pJfd1qkREOULKq+eYp0gpMl2f6p4j39ah
         /Nrpgo40uEtWTp/WKt1LSr/Odcr7hp2WpB27K4/6rStw0DZop9mGGvVeSLC7Ri3tux9A
         KDR9P4FqgSwkME6g+Xgq6JeXwrn2FUiNQcQwpEbCfDMOzo3HejTlPri+oIBUz8GZds62
         JrIuOakHo1ytphPZlmq71SGQ5Z0l/AWvH2Dsx1I3dl5RbjMM3UbjEihkLG77XcjbuA1i
         v6j+lxEPRrS+jdHzeiFnIdy/1S2ezJ5mV/qGHkwwC21EqM8OLPgySBf6qzOsJa6ZJRTB
         xX+Q==
X-Gm-Message-State: APjAAAUK8tY1N78yZV0jPiCL5AyBEQLbQLsvAALd2pncHiErsI1nNXsA
        yDn4MYjAd7VS7RIn1fm6Ix0=
X-Google-Smtp-Source: APXvYqx4i5GNl2fe0fQF1j1gnZ7657M+hVFY9b9o7vYXvS6mdbmecvuK0YNbY7X2r4DvDXyG98jFRQ==
X-Received: by 2002:aa7:80c8:: with SMTP id a8mr43264095pfn.193.1552453251297;
        Tue, 12 Mar 2019 22:00:51 -0700 (PDT)
Received: from ?IPv6:2405:204:a4ad:ea32:8a86:7e8d:4ca:6fc7? ([2405:204:a4ad:ea32:8a86:7e8d:4ca:6fc7])
        by smtp.gmail.com with ESMTPSA id o2sm24654602pfa.76.2019.03.12.22.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 22:00:50 -0700 (PDT)
To:     christian@brauner.io
In-Reply-To: 
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linuxtronix.de
From:   Jonathon Kowalski <bl0pbl33p@gmail.com>
Subject: [GIT PULL RESEND] pidfd changes for v5.1-rc1
Message-ID: <d5a0a45e-77c3-afc7-fed2-8453d8e95bb4@gmail.com>
Date:   Wed, 13 Mar 2019 05:00:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the work on this system call! I am interested in making use 
of it in my process supervisor. It works pretty well and avoids the 
long-standing issue of PID reuse.

One thing that instantly came to mind is to be able to delegate killing 
to some third process depending on the confguration. However, I don't 
see that permissions are attached to the open file description, but 
seemed to be checked when calling pidfd_send_signal as they are with 
kill(2). Is there any particular reason this was avoided? For instance, 
if a process with CAP_KILL opens the procfd, shouldn't any process that 
uses a descriptor pointing to this same file description be permitted to 
send signals? It would be a lot more useful that way.

There doesn't seem to much benefit of using file descriptors for 
processes otherwise if cannot use them that way, apart from PID reuse.

So, is something like this on the roadmap in the future, and if not, 
what was the reason it was avoided? I don't see a problem with using 
CAP_KILL to not check permissions at call time, otherwise I can see why 
it would be a problem in general (because processes can change credentials).

Regards,
Jonathon Kowalski
