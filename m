Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E119C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E102190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiCY2xX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfCURDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:03:41 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50522 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfCURDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:03:41 -0400
Received: by mail-it1-f196.google.com with SMTP id m137so5435462ita.0;
        Thu, 21 Mar 2019 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsZ6VtN8xg1EYTkPVplpBGjeSIxB0v+HVdl7xDay2Hg=;
        b=YiCY2xX9L654WpDc/ZZVtIAej8gqrWZE7yVNc5TMdKAPRxkNrMrgltrRLqVUez1b6G
         BgJc7sutWzLYg7ALmticNVfE3yD1LX09bKR+ENANsbxxnGOG/unRhnFKDD44h11igMnL
         XrALT0Q9TBqHIEdaEnjC7SzZ4goNSYAGkQhU09T9RhTT+8nZ9TvygJSv7pt37l6xWv/N
         R8Ws/4nWNOgsNJC6o8VofAsL7ved/nWn/XAQKUjyOZnzy18IiW+HG5FWI2lbN4f/heq7
         WxtnJcWuMxN9JhqDcIX79W+tczaQxSlURuRgraNO3XB8R607iPOGvlgxonBAPYs0S7oC
         5Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsZ6VtN8xg1EYTkPVplpBGjeSIxB0v+HVdl7xDay2Hg=;
        b=cqLgLrOcTCTSy7PH4RoabvOa1KR2STIHB6DbCqDdRWw+EFI5PLMOhQ4bYgSy5KaENs
         EpR2MLJyVcg/WR5uwg9gnGld1ClcS9eeRzx1Hcazmx4E1pmY70I8LIA9F7M0kVJ3mS/W
         twGkj1VMNjNK+8j8XpH/LxTMB2KpgoNfnOuqlR9AI0q6KYOXEztjG7G+ON2ePRVA3a1h
         IL5UfcgiewSZ9bd7FXZRv5+yBgRFkJMK3vD7MccNfribqsc4/cGWtaiS6MzcDeFqnyM/
         lvGixppXi2RX6wRjIeSMRV5AFwz4RBCypXG1DJDgw56sqpymiu7kkd98KrwqYjxMfVyQ
         b1sQ==
X-Gm-Message-State: APjAAAWMLkDAHUjVDu76KTUlvL7CNs641b6AJ+sHBHwY7UMleoJ+hFBp
        h8K8S8YmFWz9cX7W2DKcRs0Qen9aiVrvHg==
X-Google-Smtp-Source: APXvYqwe5TM5sgcgTYmHKsoG5h7HeJoPt5wf3tUjU2p/Fg/iFQEzjOGQFdW+zfBSdehEewI2x6zDqw==
X-Received: by 2002:a02:a50a:: with SMTP id e10mr3759058jam.104.1553187820424;
        Thu, 21 Mar 2019 10:03:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id t23sm2577951ioj.19.2019.03.21.10.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 10:03:39 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/1] mips: ralink: allow zboot
Date:   Thu, 21 Mar 2019 11:03:33 -0600
Message-Id: <20190321170334.15122-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-submitting this patch to the correct linux-mips mailing list; I just
learned the linux-mips.org one is not used.  Sorry for duplicates.

Do I need to do a `make olddefconfig` or similar for existing
defconfigs?  I am unsure of what the procedure is here, and I couldn't
find anything in the kernel docs about what to do when you add a Kconfig
option.

Thanks,
George


