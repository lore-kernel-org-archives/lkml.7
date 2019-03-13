Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF504C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AB42075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jH4YsLzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfCMS2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:28:45 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:43290 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfCMS2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:28:44 -0400
Received: by mail-pg1-f171.google.com with SMTP id l11so2099371pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=n+5tgTyrxQRgcYNd8/VgFfORWnpmet8WmxLFpn0BYqA=;
        b=jH4YsLzuL89sUvvrHxMW24ffkSkn5sj0r+M3AntTNtTMD8/WVFT91SRDBpc5Qzj00d
         shiteAGP/aPbmlzVBHsbRtWE1UYAH/GtxSrb0DWy5Ep7385plrQMYK+36St3UnVKOOR+
         Y+RzlMsCiz1RdhoqYI1uJpd6XbPK7g+7RC6JOk6qwx/CY23wiGlWijuldrmYcgy27Gom
         txxQc3od66bIEOY1z4JqXNt3txybblX3B3eiGt6ndjASm0pjBoBbnPAp6XA/+IlJfIRW
         LCEtG5vAc9GeiOt01s3vl2UVHybS+4WD33RqdlM+zNd3muzvUtOidg61vVlK0PkuSRrH
         p2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n+5tgTyrxQRgcYNd8/VgFfORWnpmet8WmxLFpn0BYqA=;
        b=XuLhvuk9zWa/62BH8j8pNm8lv/CDCCH2aIAfw9gI6zBxStpdwLZN0lHWwXLNjfW1nU
         h15vYpE3OY7d0p0v81ZSKjCwzz/XGumC31RGagI4aPN+v5IYqjv7B2pny/TLMipNOkOb
         JidC2FqzMXbZ7iKZtafMOpfORrJzOIA1xOY+FHyTzKfsh8wizusx7cXzkT0/KAiWYjaZ
         c3KXGjo7g4JulIFy1lCjfaijueEeiHb9PMHNB5cI6QJzadryQHfvw2cMI75zR7eR8g5/
         5AYt2282B+YTtL4j15WphUeOeN9TxHyCCjPzcR0bnEelZStinLeSAUeHc4G26iuZc+6U
         6WSw==
X-Gm-Message-State: APjAAAWu4OTnk8SXN4opinIIi5v2lVT5XuINnTYG0Gvy4wNmRrqP/tTC
        vcvta+kCZBXYgRAmCPVNEu0vUw==
X-Google-Smtp-Source: APXvYqzyFHDM7KeF7IJzLCGDt3x1q/XHNqeE/ojza5MPRVLyqOcOLQNOrFdC7vGNrZQhchSZDg53Mw==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr24449449pgb.58.1552501723031;
        Wed, 13 Mar 2019 11:28:43 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f192sm33737661pfc.180.2019.03.13.11.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 11:28:41 -0700 (PDT)
Date:   Wed, 13 Mar 2019 11:29:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Loic Pallardy <loic.pallardy@st.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ramon Fried <ramon.fried@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Xiang Xiao <xiaoxiang781216@gmail.com>
Subject: [GIT PULL] remoteproc updates for v5.1
Message-ID: <20190313182942.GA8726@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rproc-v5.1

for you to fetch changes up to d664ce75ae1c7c1e0e3fd8fa71f7ca779906a9be:

  remoteproc: fix for "dma-mapping: remove the DMA_MEMORY_EXCLUSIVE flag" (2019-03-12 17:00:42 -0700)

----------------------------------------------------------------
remoteproc updates for v5.1

This contains the last patches in Loic's remoteproc resource table
handling changes, a number of updates to documentation, support for
invoking the crash handler (for testing purposes), a fix for the
handling of virtio devices during recovery, performance state votes in
Qualcomm modem driver, support for specifying board specific firmware
path for Qualcomm modem driver and improved support for graceful
shutdown of Qualcomm remoteprocs.

----------------------------------------------------------------
Bjorn Andersson (1):
      remoteproc: q6v5-mss: Active powerdomain for SDM845

Brajeswar Ghosh (1):
      remoteproc/qcom_sysmon.c: Remove duplicate header

Colin Ian King (1):
      remoteproc: qcom: fix spelling mistake "Peripherial" -> "Peripheral"

Fabien Dessenne (1):
      remoteproc: fix kernel-doc comment for parse_fw

Loic Pallardy (12):
      remoteproc: create vdev subdevice with specific dma memory pool
      remoteproc: st: add reserved memory support
      rpmsg: virtio: allocate buffer from parent
      rpmsg: virtio: change header file sort style
      remoteproc: fix recovery procedure
      remoteproc: correct rproc_mem_entry_init() comments
      remoteproc: fix rproc_da_to_va in case of unallocated carveout
      remoteproc: fix rproc_alloc_carveout() bad variable cast
      remoteproc: add warning on resource table cast
      remoteproc: fix rproc_alloc_carveout() for rproc with iommu domain
      remoteproc: fix trace buffer va initialization
      remoteproc: fix rproc_check_carveout_da() returned error and comments

Rajendra Nayak (1):
      remoteproc: q6v5-mss: Vote for rpmh power domains

Ramon Fried (1):
      remoteproc: qcom_q6v5: don't auto boot remote processor

Rohit kumar (2):
      dt-binding: remoteproc: Remove lpass_aon clock from adsp pil clock list
      remoteproc: q6v5_adsp: Remove voting for lpass_aon clock

Sibi Sankar (11):
      dt-bindings: remoteproc: qcom: Add missing clocks for SDM845
      dt-bindings: remoteproc: qcom: Add missing clocks for MSM8996
      remoteproc: qcom: q6v5-mss: Add missing clocks for MSM8996
      dt-bindings: remoteproc: qcom: Fixup regulator dependencies
      remoteproc: qcom: q6v5-mss: Add missing regulator for MSM8996
      dt-bindings: remoteproc: qcom: Add power-domain bindings for Q6V5
      dt-bindings: remoteproc: qcom: Add firmware bindings for Q6V5
      dt-bindings: remoteproc: qcom: Introduce shutdown-ack irq for Q6V5
      remoteproc: qcom: Add shutdown-ack irq
      remoteproc: qcom: Wait for shutdown-ack/ind on sysmon shutdown
      remoteproc: qcom: Add support for parsing fw dt bindings

Stephen Rothwell (1):
      remoteproc: fix for "dma-mapping: remove the DMA_MEMORY_EXCLUSIVE flag"

Xiang Xiao (1):
      remoteproc: debug: add crash debugfs node

 .../bindings/remoteproc/qcom,adsp-pil.txt          |   5 +-
 .../devicetree/bindings/remoteproc/qcom,adsp.txt   |  23 ++-
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  79 +++++++-
 drivers/remoteproc/qcom_q6v5_adsp.c                |   6 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 | 209 +++++++++++++++++++--
 drivers/remoteproc/qcom_q6v5_pas.c                 |  13 +-
 drivers/remoteproc/qcom_sysmon.c                   |  82 +++++++-
 drivers/remoteproc/qcom_wcnss.c                    |   6 +-
 drivers/remoteproc/remoteproc_core.c               | 160 +++++++++++-----
 drivers/remoteproc/remoteproc_debugfs.c            |  47 ++++-
 drivers/remoteproc/remoteproc_internal.h           |  12 +-
 drivers/remoteproc/remoteproc_virtio.c             |  61 +++++-
 drivers/remoteproc/st_remoteproc.c                 |  91 +++++++--
 drivers/rpmsg/virtio_rpmsg_bus.c                   |  24 +--
 include/linux/remoteproc.h                         |   8 +-
 15 files changed, 706 insertions(+), 120 deletions(-)
