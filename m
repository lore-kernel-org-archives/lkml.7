Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E18C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBB420715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFaFecI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKVP1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:27:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42561 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKVP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:27:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so9077145wrf.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBh+C98xO+z8qsX915RR0pFfiuyA4L1CQVRjFLzavOE=;
        b=UFaFecI+e6XK8CQPbA6dCzXoCQ06/oN/oWaAhPOH1Qak+kbiErxtomFZ6fj4P7C9Zo
         3QX0sFM5e9uFdF9zuGQGx7l7Ps/PDPkMoBDOidrfjGJa/ujBhawqhB4Yu0prfQ3JvhOb
         XAOvNXeL9hiCSs6xfaStRiOAIRY9IQTi6+059rtxuPoSTk7s1aE2ezXaVtpEuhFptBUx
         4ZdgBqeOFwy2jWvsslYWbzd+NaHtOl9YxiljccQE2Z47s7NuAgSSbP36ZOYohtU1VuG2
         WNvmOhbrcOeaYo0vyIo2wn7LncEBuk89pu8MQTsxS5Te0dewt6/UbytRueHQ9lD65H4x
         hGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBh+C98xO+z8qsX915RR0pFfiuyA4L1CQVRjFLzavOE=;
        b=fy1vjo9gckOHAZ39jgka3ejl56unMgAk2RWuZlbjB9MIBlRJZHqN8XMGfPLQoORxot
         fr7ws0NjXvwi/9KliOs+XnVvkWkyEl4Gztyo6Ye8Ym4f4MC0Z0qgq2HSJbenKkAbI+ye
         Q6ahEWaqiervprUxgOGeBk2+NCwRxmdwlhMDl2uqKvPJVG3JtfZHxr1hP5d9ejOc8ZN4
         QhBWCvJyjKkaDyKE5HfBT4TNj2IEDFQxqzTNAXMUyNy6i0NdtQMY7z5l/+S3DsmGXyKx
         pSzZeLJuk6X1QtVTFnLOFlMEnonqVicB5U9F37uT4wrYAJr6RTtIj3qkuPp68UHrocF8
         GueQ==
X-Gm-Message-State: APjAAAUW0iz9HQx0gQ7UHDTvpFkRJcGAZIzR2ef5P56SRt1T1imsaDbI
        7MuKoIOfPzvp/GiCg6Tug4vETQ==
X-Google-Smtp-Source: APXvYqwi1bJWuQJ2ZyfSz6IK7AWXUIHOuNwTnYpwXJGni0c209ZDVHhlziX/ecY+BW5ZP9RiO7TvDQ==
X-Received: by 2002:adf:b193:: with SMTP id q19mr17173456wra.78.1574436434458;
        Fri, 22 Nov 2019 07:27:14 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a206sm4061081wmf.15.2019.11.22.07.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 07:27:13 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v3 0/3] interconnect: Add basic tracepoints
Date:   Fri, 22 Nov 2019 17:27:09 +0200
Message-Id: <20191122152712.19105-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
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

v3: https://lore.kernel.org/r/20191101130031.27996-1-georgi.djakov@linaro.org
- In order to avoid #including a file with relative path, move the trace.h
  header into drivers/interconnect/. (Steven)

v2:
- Moved dev_name() into TP_fast_assign() to reduce cache footprint. (Steven)
- Added path name to traces (Bjorn)
- Added trace for path, device and ret. (Bjorn)

v1: https://lore.kernel.org/r/20191018140224.15087-1-georgi.djakov@linaro.org

Georgi Djakov (3):
  interconnect: Move internal structs into a separate file
  interconnect: Add a name to struct icc_path
  interconnect: Add basic tracepoints

 drivers/interconnect/Makefile   |  1 +
 drivers/interconnect/core.c     | 55 +++++++++-----------
 drivers/interconnect/internal.h | 42 +++++++++++++++
 drivers/interconnect/trace.h    | 90 +++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 31 deletions(-)
 create mode 100644 drivers/interconnect/internal.h
 create mode 100644 drivers/interconnect/trace.h

