Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898F3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F88520661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="U+Q4puwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfCFLM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:12:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42329 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfCFLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:12:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id j89so9990561edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 03:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peBwF4s7AcJireIW9aEtgVMb0skheqT5dujZbapujjU=;
        b=U+Q4puwiim6Jb7u4OLSexsa7dEXMdqiBgn0bfCnW7ueHxwqQkYiLqtcAFz1YZG8a48
         IV9Yronx9+kfZ4LRWxeHTuYZnDzo9xlixk5ipPU1751eoVlcJHstazFQ/2gKBOJ4wSlY
         2lhbxzkfLgOs1vNSLKTBIer0bmBbGFsvPw386R48jcyF+onY/BZ8Q9XOYmZGIAbU1VAD
         I67bS2qDOBRtExGkzf+9EenvgAqpjXcsAYXMI906j4V+866d9ITn+wfyAric7bXMzsTV
         rFkGl64CwczORVIY2lxlz16+cH56iBOlVzdGn6Ravo8XVpkeeqAHNothMPWL91tncDrl
         IuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peBwF4s7AcJireIW9aEtgVMb0skheqT5dujZbapujjU=;
        b=MtmG67dsFsJ00dA793UdTNyVbgM8kBeh/yrrH3cZMYYwztq1zImXlo9JAxHVpVk2ZZ
         z5eE786wkT05ogBO2MCiWSempbS05Dj/pjpa7s/1CIHqJoIdsDDh5jueZ1hmO3D4orqb
         vv54uLJieBp9+VLcHo2myQQNxAOh5LG362edBnZkSFbCJPKhuJNXniZtb/OVVBVWh3Q5
         wv8XChFIowj89m0rExx3UGIZgePwuR5EUk0SzrJMbg9D6Ia1B5d/TE0uWIndyx05vEQc
         BBKkNS5EpQsquDL2dNp7iw9w0yxIspXj9pitXIMHR1ZtSnpX/qZHFr/homnyYGs3MBKd
         X9+A==
X-Gm-Message-State: APjAAAVQSPyVt57BC27bqnDYCA0yK/k/4IqchJ1YG76xeADBuPUYFSei
        ZdbinL1CrSKMQMdW6dr7wFXPPw==
X-Google-Smtp-Source: APXvYqwL6qLqdtmDQRVfTtB1ememvfNYtB5rR34Lz4vhgk+9Ie37InYAacfORqy89rYDFGFr4IYarQ==
X-Received: by 2002:a17:906:3112:: with SMTP id 18mr3600815ejx.84.1551870745347;
        Wed, 06 Mar 2019 03:12:25 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 03:12:24 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 0/7] FlexTimer Module Quadrature decoder counter
Date:   Wed,  6 Mar 2019 12:12:01 +0100
Message-Id: <20190306111208.7454-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie is to be applied on top of 
https://patchwork.kernel.org/project/linux-iio/list/?series=147
(a more recent version of the serie is available here : 
https://gitlab.com/vilhelmgray/iio/tree/generic_counter_v10 )

Main changes in v2: 
The code is a bit simpler, thanks to more use of devm_* functions.
The polling/32bit signed version has been dropped, as not needed and
no other driver is doing that.


Patrick Havelange (7):
  include/fsl: add common FlexTimer #defines in a separate header.
  drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
  drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer
    #defines
  dt-bindings: counter: ftm-quaddec
  counter: add FlexTimer Module Quadrature decoder counter driver
  counter: ftm-quaddec: Documentation: Add specific counter sysfs
    documentation
  LS1021A: dtsi: add ftm quad decoder entries

 .../ABI/testing/sysfs-bus-counter-ftm-quaddec |  16 +
 .../bindings/counter/ftm-quaddec.txt          |  18 +
 arch/arm/boot/dts/ls1021a.dtsi                |  28 ++
 drivers/clocksource/timer-fsl-ftm.c           |  15 +-
 drivers/counter/Kconfig                       |   9 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ftm-quaddec.c                 | 356 ++++++++++++++++++
 drivers/pwm/pwm-fsl-ftm.c                     |  44 +--
 include/linux/fsl/ftm.h                       |  88 +++++
 9 files changed, 519 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
 create mode 100644 drivers/counter/ftm-quaddec.c
 create mode 100644 include/linux/fsl/ftm.h

-- 
2.19.1

