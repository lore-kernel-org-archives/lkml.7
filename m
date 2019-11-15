Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7750DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFD32077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQLd1g5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKOKx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:53:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45164 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOKx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:53:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so7649784lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 02:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YrBKYAXW2pBZSbQ2SIp4S+nYebHNxgT7XYL6TriEP8k=;
        b=NQLd1g5fKoaez5J87XjZtjuNW4KXaDwXMaUwYF9ueSa8RJTFOY8QHy5z2i9uxqJ9Nz
         AzD6vtXsjMX2jQHd16HGN+jQQa17OAkoy5cAQYyTY5bwkY/6nGpfluYDjRXPzrZswyo6
         6iwraTyyS13J8R2LiQ2M38BXIsrM4+CEuv6715gfHhH6md62glQy4RYXyUO54TrMAucM
         Aaan0HThwCAP4um+hFu2j6hubBXbyIC4AEQpR+MCHHbb0rbeENqYeJtsu+XkKITlugRJ
         e0yR+FmPn4HnNOLoQ/UP+YpsCny9+oiz+Knpez74A35fsTFRJoezeWNz+jgOBvxQsea3
         K76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YrBKYAXW2pBZSbQ2SIp4S+nYebHNxgT7XYL6TriEP8k=;
        b=QtQ/khFyHCL54svGG8HMGfQPBeIa2jeRi6InWjTIhdbKbnTiLm0PJfqXG7bmoS3r+J
         QGn2gC5OD3KRH634vug8I1HZ9N8DyGldS7y59UNPIlRKVUkGKnLMfT7SUspYrtrjN/V7
         ElzxSxfrXKRSFXok0h2ea0kJDYIxhaqB+7m3pLgkQz2kSFUTT5hwkYEf0fg6SLKHkT7J
         enlmBKGnN0LbKUYzllI60B5B+BqzIbhUfT7AjYOGfsQdKBjG7I/XgQpEGK3uqYmYAcLT
         EtcMejvrJh/6ANyoG35VRrRk/Xy8uZJa91/uTRy7fYEWtOsBGbGPO67NnOFxDERUG9UF
         tm9w==
X-Gm-Message-State: APjAAAUuIyFSdRP3CX0QYR9orn7ZtF1cBHWYeuBYYknOk+tqAN2W3MYs
        DITvUbCZiNiuIVcLqHIYf+/aNA==
X-Google-Smtp-Source: APXvYqwJm9kjyX50miWZJi1AorPayww0DL6AYzoF4y4u+n5SXXKGJRe8XKtDsFsG7BO1UZzJN2egdw==
X-Received: by 2002:a05:6512:511:: with SMTP id o17mr255769lfb.167.1573815236204;
        Fri, 15 Nov 2019 02:53:56 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id r19sm4025146lfm.61.2019.11.15.02.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 02:53:55 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:53:53 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee subsys fixes for v5.4 (take two)
Message-ID: <20191115105353.GA26176@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these OP-TEE driver fixes. There's one user-after-free issue if
in the error handling path when the OP-TEE driver is initializing. There's
also one fix to to register dynamically allocated shared memory needed by
kernel clients communicating with secure world via memory references.

"tee: optee: Fix dynamic shm pool allocations" is now from version 2 which
includes a fix up with a small but vital dependency.

If you think it's too late for v5.4 please queue this for v5.5 instead.

Thanks,
Jens


The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-fixes-for-v5.4

for you to fetch changes up to 03212e347f9443e524d6383c6806ac08295c1fb0:

  tee: optee: fix device enumeration error handling (2019-11-15 11:31:24 +0100)

----------------------------------------------------------------
Two OP-TE driver fixes:
- Add proper cleanup on optee_enumerate_devices() failure
- Make sure to register kernel allocations of dynamic shared memory

----------------------------------------------------------------
Jens Wiklander (1):
      tee: optee: fix device enumeration error handling

Sumit Garg (1):
      tee: optee: Fix dynamic shm pool allocations

 drivers/tee/optee/call.c     |  7 +++++++
 drivers/tee/optee/core.c     | 20 ++++++++++++--------
 drivers/tee/optee/shm_pool.c | 12 +++++++++++-
 3 files changed, 30 insertions(+), 9 deletions(-)
