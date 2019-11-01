Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A0CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4798F21D71
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EC15ozzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfKANAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:00:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45506 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKANAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:00:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so9586853wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnAtrIp1CQEJrAviLU5bc1LnukML3+XTcip2l+4dcgE=;
        b=EC15ozzq5r6O7Xmzqx3qzWh0ljIqUYns6h1WdyJ7AKAd20rZqTYo9V9KHWyQiCtzJc
         647HxCf7/prcMBcdFlUb80gkD8T5S30CtKLZvt5UJ4OJGH8gNIxehms7v8Fs+Y7IBDIF
         YtWlCjv71EcQ+rsc5bShlkFA17hS8F5ax7Xv9WftYOAtj1Y7JC64GTo7j+4hyTapTeR2
         GLiE/RjbbB+jkC+dEm2veHwxFVO5lieAqz+rHWsx5p61xB2Pf5xq0SGSDK2BZSb7RPRJ
         YQevWkOvlEwSkJSLoJkq2wkc7gSZiOr6JkUy7L3agZGpFF2ZgMcCD/fj+PlyWwbxm0r0
         NliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnAtrIp1CQEJrAviLU5bc1LnukML3+XTcip2l+4dcgE=;
        b=qUQMYtVfJysNnWdPH0E2dztI5pe9ZoD+vYyNPvbkNWrdTXQ9ddyrBL784QCux191g4
         HO/hN5thQCKvHoxIt3RO5mvE/fgLMrysC+jaoYUA851VjbY8j7u9h+cboEvHyqJaeUtN
         E1K6VyHxh1W60LON4hLYiFyqkM6nFkENKSm4K74f/rf6sbApcc9ulxvMr3LbQ5VlkHn3
         z7gWmgdaHEvP8oULuJDoo/h6O5/Unwa+bmxxFcv2mQAn+vFz1FpRvgIA+05QEeBXeBrb
         7BzuYndxodQIbjzquQRmDGxl31xYla/wFqo4AGJGRGpjKzQi86/XpbeP/tmjTeB1S5v1
         od4g==
X-Gm-Message-State: APjAAAUm819B4Myp9IZJ2bUJjb6HBGlgIHqCZOpcjB1aNqOGL9PNKkW8
        PMdYB7D5bCDIF6hdvysr1HXF3w==
X-Google-Smtp-Source: APXvYqwBJap78uhfylY8s1lRyzHMgoLG9vqE82nyBm2uLab+9M9LZMN2Ea5nZ9jbJRyQeJNGuqcRdQ==
X-Received: by 2002:adf:db42:: with SMTP id f2mr3231266wrj.287.1572613233401;
        Fri, 01 Nov 2019 06:00:33 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x7sm14208476wrg.63.2019.11.01.06.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Nov 2019 06:00:32 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 0/3] interconnect: Add basic tracepoints
Date:   Fri,  1 Nov 2019 15:00:28 +0200
Message-Id: <20191101130031.27996-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracepoints can help with understanding the system behavior of a
given interconnect path when the consumer drivers change their bandwidth
demands. This might be interesting when we want to monitor the requested
interconnect bandwidth for each client driver. The paths may share the
same nodes and this will help to understand "who and when is requesting
what". All this is useful for subsystem drivers developers and may also
provide hints when optimizing the power and performance profile of the
system.

v2:
- Moved dev_name() into TP_fast_assign() to reduce cache footprint. (Steven)
- Added path name to traces (Bjorn)
- Added trace for path, device and ret. (Bjorn)

v1: https://lore.kernel.org/r/20191018140224.15087-1-georgi.djakov@linaro.org

Georgi Djakov (3):
  interconnect: Move internal structs into a separate file
  interconnect: Add a name to struct icc_path
  interconnect: Add basic tracepoints

 MAINTAINERS                         |  1 +
 drivers/interconnect/core.c         | 53 ++++++++-----------
 drivers/interconnect/internal.h     | 42 +++++++++++++++
 include/trace/events/interconnect.h | 81 +++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 30 deletions(-)
 create mode 100644 drivers/interconnect/internal.h
 create mode 100644 include/trace/events/interconnect.h

