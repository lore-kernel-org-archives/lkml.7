Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0823EC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8122077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iyr3QIx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLIRnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:43:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36558 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:43:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so6095461pls.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=MHQW4be184f/yf/1QbvgrnCI9Q3h1KDp0e7s5WvOx80=;
        b=iyr3QIx/LlLHFds2Y0VY7sk3AvbQjB8nonA4QpSaZ2DizI2XHJIFCO3R9xSwCWErm0
         Veok7GkGvaf1ZaWsbm58BjFDKmNO0QW7VQbGK2OylGry81YPzyrOZ8ChIjo/HRyHe/9w
         5W1ZydJDWdl05T2eFpBCbGFQxlo1jPJTBlIId49ZIYuUpBFgGDUgVaClVnykwG8QuPzB
         nC4EbmZxgrZFm3oplSADQENMQ0nW4FYpTlo34zSTxSysd6qLFggv1PHFHIX8PK396mu/
         FbMBDk4met2+Xkk5mbADRvUfFR6JZrioG9W0enUtz4GGnhZDHtRRx0/+fUfrAcJDdTwH
         1hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=MHQW4be184f/yf/1QbvgrnCI9Q3h1KDp0e7s5WvOx80=;
        b=avE9wMR539wFAzQAI/9eA+CnQCTO24Yt17ZV80DaqYTMsnqSi5cjadv8fisLffzSZJ
         Aeqy0Maj3YY9tFtJVuzK2r7rgHHQXwuYBcAvD8g6VMPthpTVC8srowMeIUJh5ORvC1V4
         B3JBez21l1Y1ypagiX/9//OA8Lu03teCvz8QMXa//VHxA/NzEB3+v5KxFV16YT+pu1c4
         x6vnHoZY9CbEQRTxE+WHT9n/oaAgqCHFBxVRMKAx6eZBLzT5eVhjujMnUn5qTgqKYgVO
         RtVk6uk7RuIfWr7KEbxju3V4LgJUiyf+hfqFJ5CgNkgR+mTcpUXc7n6ZVs16zkJTKk1U
         6hNQ==
X-Gm-Message-State: APjAAAUuXrq7pWVYl7IQGVcl9tiM+m395fek5KL5KQgC5ptWR6wglC0d
        qHfTp9iaJsTcqvwiiMUllUYqbw==
X-Google-Smtp-Source: APXvYqzcC8oy+td3BTTUw+K1ObFMNnlnH7pe6d915LO+YFlwaA6F3N3fqTSMgG+B/hT7n6lxTQThDw==
X-Received: by 2002:a17:90a:dc84:: with SMTP id j4mr235074pjv.70.1575913387367;
        Mon, 09 Dec 2019 09:43:07 -0800 (PST)
Received: from localhost (66.sub-174-194-147.myvzw.com. [174.194.147.66])
        by smtp.gmail.com with ESMTPSA id k4sm106115pfa.25.2019.12.09.09.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 09:43:06 -0800 (PST)
Date:   Mon, 9 Dec 2019 09:43:04 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, palmerdabbelt@google.com
Subject: RISC-V v5.6 patches will be collected by Palmer
Message-ID: <alpine.DEB.2.21.9999.1912090933500.308630@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Folks,

Most of the backlog of the RISC-V kernel patches from the past few months 
have been cleared, and now Palmer has graciously volunteered to handle the 
patch collection for v5.6 and to send those upstream to Linus.  

I'll continue to handle the v5.5-rc patches and pull requests, and will 
try to take care of some of the patches that have already been posted.  
Anything that doesn't make it will be handed off to Palmer.

So pretty much any non-fix patches posted from now on will go to v5.6.

If anyone has any questions, feel free to discuss them here.


- Paul
