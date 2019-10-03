Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B4C21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNaQZuIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfJCP4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:56:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40109 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbfJCP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:56:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so3334000wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NKFrC0B8XfOBdcYy4waFnHZo34mHGp46OVgivkV/nsg=;
        b=aNaQZuIW2iG4+SCv7VDtSMgRNVP7FlZdetl6sUWXBtp7oeSQxR665x5njpcYyKI2xk
         Uvv8X3BSDSZUsLW1oGFuQlamFhdFIrNfwlOq1B3hFoMi0A+obcRQOOxbwyvUAS2evrAJ
         c8NcY1rr6yYJPvcSdXbwU2qpl3HfG5D+VizDd0pNvxHe4qBoWnyL11CaCqma1vmkILLv
         2qq/s4v66IZRtqsJTlOAIledIGofXIi242nk8K6kWHqNHeewn0+boxqT+7rO9Kv7jSca
         MaaoBvL9LQtm9cjZuqmMY+DRN8fD8+JXAqasrQ7apCP0SX9BNrV6EG/wnPQmxzf2wZkt
         wiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NKFrC0B8XfOBdcYy4waFnHZo34mHGp46OVgivkV/nsg=;
        b=Yd0pzhMJAlkJ0DurZ1jARXdhryzKGgMP00eAMXYk358euMQrI50hTSTwx/3BZnEuva
         H53JCRqCQDW2AT1OCr+Xn5NSvce01A9bfUuiDAjA2xB1U7yd0MjCRaWSH0yfVGx5Ga6J
         eKXpJN0NiXk5CSu0OfHYTrU6vzHhnjuFcHnwRjX0WDRoz193YSMIAweUgRd86H7cxH0w
         6hkyzITQZ2IzDekXheFTb9GM/AHTJ6TQRzVkFYtLb+LZ25OpeFczby0hwA7vBTfFSK9G
         2p9gJxGCi2E2wprAVHWBp4ahFQvUrZ0p4fphDiTtswHzet9bIUf7Ef9pj5BZH3+SmCx8
         g5Bg==
X-Gm-Message-State: APjAAAUzX7Vt22kmZLBdE40IdjG/EjA6W+j6QdFu0HjJHHhHZY3qJY/2
        h5KZ5zE4dmhbVE3MA5RrkFtFWQ==
X-Google-Smtp-Source: APXvYqyeWhVDnASI2XK685gTnJ8+XSIi9Og7/oNl3GooJ5VN2khjLyPsF8m05wz1FN+mrQonzf/z+Q==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr6827149wrs.4.1570118168901;
        Thu, 03 Oct 2019 08:56:08 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 79sm5324176wmb.7.2019.10.03.08.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 08:56:08 -0700 (PDT)
Date:   Thu, 3 Oct 2019 16:56:06 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [GIT PULL] kgdb changes v5.4-rc2
Message-ID: <20191003155606.o5y5vmnszyzotbvw@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.4-rc2

for you to fetch changes up to 086bf301f541eb4acfb5dadae7b1b207ad1b95a3:

  MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb (2019-10-03 16:42:10 +0100)

----------------------------------------------------------------
kgdb patches for 5.4-rc2

This is just a single patch adding a new reviewer for kgdb. New reviewers
will be a big help so I decided to consider this to be a fix!

I'm looking forward to working more closely with Doug.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Douglas Anderson (1):
      MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)
