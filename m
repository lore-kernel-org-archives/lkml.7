Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E6C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3CE2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3PCNOEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfK3TO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:14:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43718 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfK3TO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:14:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so16064622pgq.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0slaDgm5WExa69hMb+aN990RGgSzsXfiBo+CrjlQPrk=;
        b=q3PCNOEM7xVKLmGePDbetxDDf2KJZYMKFU2Fqt0VQZdpAtETBrxnACx1AqRMwUwX5p
         wPPQoBI6U5mXoqPXfIJ4B37ORmxOfWdnp6gtf6qiF0XkzckykFTxFwumX03JtsSC3NEn
         36OFKqu+ixce5QsAfm/JkiHWf5r0IfsvqUlvtNZWS1QHHf9fo0wlSm2iavM68hyIBrTJ
         TB2D0t6xR4iKH1bcwu56vh3hZE8/Czw1HcM/uuPepPilVuEQcNb3rU4RmS1LjySVRwpq
         LfvhZtegxQAZIzVsY50DFmyjvEwriiZj/Ir2SioT9HJ5Qr2FXuTn2I+2WgltcZvaVqtT
         j/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0slaDgm5WExa69hMb+aN990RGgSzsXfiBo+CrjlQPrk=;
        b=KaaipNyP/Kddn0IlGWLg+hYxoquM9J7a/RryEWdiCA8Rm2l2cqJVL6nM1ph3VufCWT
         zAT3TlmNNcSK/V4Yn368e6w8yuRgNUcl/a6CoXC0DyTS/5u84pWGbuIN2G9oyKU3kdJW
         YfulPzXItVl/cDw0SAoborcJWr6wmse3DREx4kVM4pU3Y1pJB5Qo107E9J+NvKSma8S2
         LZ4lpW5/q4u15l4bJjmPSEyZiP1S0elyN8iI0EAqSN+GyHyJgMI5YyTy4hhYpqNUO7Tu
         nOdQ8xiBCFE/ieq4l2tAHbrD///UlrCpc7oFLIiBU/OBGQJtxUBQ1X3rRxXU9VkMKrb3
         T1rQ==
X-Gm-Message-State: APjAAAXyhK/b6pcF2q8iAtNMQxBZNcCfEr+yI/vvCG6fd/XhxbGF0a57
        rYFbItE0MS1Ca7iNsgsWuynuZg==
X-Google-Smtp-Source: APXvYqxvKx90gqdjiivfLalck3qcod5MvC2qISaCoIrWu0whZ6oGNF8KgnJikgA9evf25gNBMuvyVA==
X-Received: by 2002:a65:5608:: with SMTP id l8mr3398540pgs.210.1575141267131;
        Sat, 30 Nov 2019 11:14:27 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a22sm5637177pfk.108.2019.11.30.11.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 11:14:26 -0800 (PST)
Date:   Sat, 30 Nov 2019 11:14:23 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [GIT PULL] rpmsg updates for v5.5
Message-ID: <20191130191423.GB151303@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.5

for you to fetch changes up to 8cf9b615653e40debdcf3b6f1d69e6b580d71173:

  rpmsg: Fix Kconfig indentation (2019-11-21 10:04:49 -0800)

----------------------------------------------------------------
rpmsg updates for v5.5

This contains a number of bug fixes to the GLINK transport driver, an
off-by-one in the GLINK smem driver and a memory leak fix in the rpmsg
char driver.

----------------------------------------------------------------
Arun Kumar Neelakantam (2):
      rpmsg: glink: Fix reuse intents memory leak issue
      rpmsg: glink: Fix use after free in open_ack TIMEOUT case

Bjorn Andersson (2):
      rpmsg: glink: Don't send pending rx_done during remove
      rpmsg: glink: Free pending deferred work on remove

Chris Lew (3):
      rpmsg: glink: Set tail pointer to 0 at end of FIFO
      rpmsg: glink: Put an extra reference during cleanup
      rpmsg: glink: Fix rpmsg_register_device err handling

Christophe JAILLET (1):
      rpmsg: char: Simplify 'rpmsg_eptdev_release()'

Krzysztof Kozlowski (1):
      rpmsg: Fix Kconfig indentation

Navid Emamdoost (1):
      rpmsg: char: release allocated memory

 drivers/rpmsg/Kconfig             |  2 +-
 drivers/rpmsg/qcom_glink_native.c | 53 +++++++++++++++++++++++++++++++--------
 drivers/rpmsg/qcom_glink_smem.c   |  2 +-
 drivers/rpmsg/rpmsg_char.c        | 12 ++++-----
 4 files changed, 49 insertions(+), 20 deletions(-)
