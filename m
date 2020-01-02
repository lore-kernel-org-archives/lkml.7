Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A381C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F3C21D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhQiZSmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgABXTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:19:46 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:41005 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgABXTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:19:46 -0500
Received: by mail-qv1-f74.google.com with SMTP id u11so21473789qvo.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 15:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2rkxtj75qMmfFejsblg4LJbRA0O8Af2ULdce3nvFog0=;
        b=uhQiZSmKc1Zb11oPLNBuwsrSubMw8/+Y9CncU93zXzCLH5ifXZcQCiHKDmPEFUv3ut
         aB62L1LiZqkh4XfxljqKAUGR7ztSjhaK35zg4OIOn2DiIFKMkXJhlZAUyfM6lLCcT6lq
         1Le2d488KwFvDyVeupm55mU1VKtCHL6zZD6VeuVJtzgWOKC0e9Hp2A+DZMhzuzoD/X/5
         zplDjv9kBkqYgFS7Aat2AqzkFQx+i/UD+oV1jP2NkLGfJnlNLHnfhlh4TiHSOd3IdGGL
         2GSauE6rKMKxsuGL1tddqDROOPnwgAZKglkFdhuCq7JNiElGB3DcuiwkcJnGB513Ou1D
         j3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2rkxtj75qMmfFejsblg4LJbRA0O8Af2ULdce3nvFog0=;
        b=aUvsvwWkNebspZNOFo3DfNhn5zt2yMqgzjh0MNgquiUQjw+1q3QgYUAQay1UlGzZEU
         pWAMp6cqgf0p9dQa0hknXT+THK4Fi67Km5NVehmuW6k0laPLl2hN/Yo6j4qslG5S03cV
         1yenM7A9QQ098rfrVm5Y8yW0Y6WsklQ+Ethix4e2OlItUf8ckGrQs5SZIxGKW/rrLq2w
         rKpQHusFRuxnIXcHyCo37jmwwZQ7XHn5y7F9xSIPp2dvPN5G2NZawQGtGXdTBrX1fusP
         YCkYpvf+Z6cFmhM5oHgN7dVrjfAl+oJbyaZJOGiaMwcbovWRtG4j1wRsYEo5XkNqSlaQ
         AoCA==
X-Gm-Message-State: APjAAAUCTvigLFmHsJwd2r7jOwr7vFiXAws9VokrI45m5oinwMaAZczz
        4zc/wqpgZs68TCoSFOYzaUBxhYNR10rlfLU=
X-Google-Smtp-Source: APXvYqx8c7zVcXDY/Cwj64hjKpKRzguhHQv4ZIEGXQzRIUaYrwfKYydw5gsrFLdwtIbWB3v8ihWrFV0GdnMBDbQ=
X-Received: by 2002:ac8:383d:: with SMTP id q58mr60717171qtb.45.1578007184895;
 Thu, 02 Jan 2020 15:19:44 -0800 (PST)
Date:   Thu,  2 Jan 2020 15:19:38 -0800
Message-Id: <20200102231940.202896-1-semenzato@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 0/2] clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        elliott@hpe.com, Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches aim to make it clearer under which circumstances
hibernation will function as expected.  They include one documentation
change, and one change which logs more information on failure to
enter hibernation.

---- comments on patch versions ----

As suggested, v3 makes the log messages more consistent, by including the term
"hibernation" in most of them (if not all).  (I think this was worth it, also
because this code doesn't change often, but we're quickly entering the region
of diminishing returns.)

v2 uses better terminology in the Documentation, and removes a suggestion
for a workaround.

-----------------------------------

Luigi Semenzato (2):
  Documentation: clarify limitations of hibernation
  pm: add more logging on hibernation failure

 Documentation/admin-guide/pm/sleep-states.rst | 12 +++++++++-
 kernel/power/hibernate.c                      | 23 +++++++++---------
 kernel/power/snapshot.c                       | 24 ++++++++++++-------
 3 files changed, 38 insertions(+), 21 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

