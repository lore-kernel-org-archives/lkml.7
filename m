Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE9FC6197
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F43C2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPpefSxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfKGMME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:12:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33336 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfKGMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:12:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id d6so1033481lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pyy8vkTJSzgNxqiCr2+y5TMDgtVVbBOEIpX6C3EpP3U=;
        b=XPpefSxVqa4KAVZE9vPHMqqgshNjBfZB43iDpwfSv1FNBN2KzTgfMDWtKAlwqYLPq1
         AyKfc7mD2FN66uF/5zcH+FHNfwOgDRAfv4ckt/vciODMTECa4DA2++2YBU1+P8rHAcdI
         A55FfzBl52daMgUUHiudYHOl1uMr1jQr7KZq4SlaauK0m74l1mSFKuhmFa4zjLmPk4zl
         fhshw3j5FnaaHEhMel3ygDj+ZsHkqHQebKfA6+Zy0nkaZvvqEVW9JL1ZQGb0//bd+ohM
         q/dbY3l6XEUDPli8FGfJMCd7Ht2G12LvVSgLDN3/eR5TdPUNHvtqHfWtx0zoFGuCkeMg
         2vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pyy8vkTJSzgNxqiCr2+y5TMDgtVVbBOEIpX6C3EpP3U=;
        b=ohaqEOoWZnBp3WK2+PKRdo6MKM039JHgm89e08iFrVkuU2wDAuhwHB/qKlgAtYgLu7
         7JVrrVvIYd9x1ETvTL4Nh8VLRTx5wYQNp8ILkWDqKFLG8sa6PIylKO7TasIW/lsKv5oa
         vMuZxG0EOmvFhAIM2SjVts8GXVxfgo+lJOt5EjNfKYFF+04NmGIP1B6lsKnjXKxG5w/s
         mj47jevvXhFw2O2h7L4LAc0rU9bqd/yYRVg2zUJx33pJeVmbyT7gEJMi3BfnUdDt7OXk
         h9MtICiVM69g0gZ3o3LL7BS6+4gg6btaV78/Slqifxwi6WdYlRTiogkAJQ9b9peBLdoQ
         0lKg==
X-Gm-Message-State: APjAAAUycMWT3MoBIon7IXZWTHy++Thl9C/PJLQRU+/p/bffraYaZAuD
        gnJibzrQA3Nps0M3A9KDUecWLA==
X-Google-Smtp-Source: APXvYqyO00Wglntl8Ch/EQ1NSmfyf403om0J9/NXHBJF6084BMLQydB7qQX2RFthZZ9lFM43VEJjow==
X-Received: by 2002:a19:fc1e:: with SMTP id a30mr2209666lfi.167.1573128722113;
        Thu, 07 Nov 2019 04:12:02 -0800 (PST)
Received: from jax (h-48-81.A175.priv.bahnhof.se. [94.254.48.81])
        by smtp.gmail.com with ESMTPSA id k187sm2371024lfd.54.2019.11.07.04.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 04:12:01 -0800 (PST)
Date:   Thu, 7 Nov 2019 13:11:59 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] tee subsys fixes for v5.4
Message-ID: <20191107121159.GA9301@jax>
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

If you think it's too late for v5.4 please queue it for v5.5 instead.

Thanks,
Jens

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-fixes-for-v5.4

for you to fetch changes up to 61435a63b15233428088ccb0ad34e19fc00416c9:

  tee: optee: fix device enumeration error handling (2019-11-07 12:07:44 +0100)

----------------------------------------------------------------
Two OP-TE driver fixes:
- Add proper cleanup on optee_enumerate_devices() failure
- Make sure to register kernel allocations of dynamic shared memory

----------------------------------------------------------------
Jens Wiklander (1):
      tee: optee: fix device enumeration error handling

Sumit Garg (1):
      tee: optee: Fix dynamic shm pool allocations

 drivers/tee/optee/core.c     | 20 ++++++++++++--------
 drivers/tee/optee/shm_pool.c | 12 +++++++++++-
 2 files changed, 23 insertions(+), 9 deletions(-)
