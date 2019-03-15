Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D769218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VIvFWUTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfCOREn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:04:43 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:37244 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfCOREm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:04:42 -0400
Received: by mail-io1-f53.google.com with SMTP id x7so8864344ioh.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0y322dadzcF8rGTrVBhXmhsQAvqqmwqIL8Nqbapc8bo=;
        b=VIvFWUTKFUUMaZ/w3VnYkkYNl1qc07lIuCFZbKWUFRNIq8XeEkS1dOtcelSJ42ndho
         LnJIxQPG61HyhdKvVWKIIBttjIEbM9AcOEgR1uQ+H0u2vPl3zyFIfaghkeEe+GdfPMsa
         9b02BPyAy3s3Tp1Bmc62sH6MT0fXukk17yXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0y322dadzcF8rGTrVBhXmhsQAvqqmwqIL8Nqbapc8bo=;
        b=ev1XNOL4taFLoIbsirtD6mQetPOy7zo0KrFjO6uXhwaoW5RrFCkjnlAgcb8y0I0PND
         evgVo3Gl1HYYNAz2/kBBu/WXGIwwp8llWXY4yIIX5M1K7YPJwavkLv5cl3CXeoiDp2z6
         +ImfAxUgsORrZhw4zfkPj5Onv7K4mrbKa1cQlzeRv+UhPy4nQ5XxwHeFsgyKnlUNy2vG
         zOgloYmjh6KcWHJEGNIq8I1PoVYA2eypkf008zLqEZR3TX/AUwChHJcT5lO30CISxY8b
         /VIX9b1BOQ8tdmcQJXswS8WWn2Dyos+0yyN1PopnfxARImj4oxL+hdvGaV+W8ygihF7i
         tpOA==
X-Gm-Message-State: APjAAAWHbzHCC9HYxyluVlfnq/JUCZgSQ41Rj73qkAYD70CiPzRAV0q0
        6SF+yX8t/q0lC+0/iS5acFQGdg==
X-Google-Smtp-Source: APXvYqxzpJMK4o8yq6adIpvvlTK3qr0QKoNy5+iHi4Adk8+rKQSCV8o5p7SfrLzm5VqvDP392TdR7w==
X-Received: by 2002:a6b:e50a:: with SMTP id y10mr3004492ioc.91.1552669481863;
        Fri, 15 Mar 2019 10:04:41 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([2620:15c:183:200:3175:8c2d:44b6:cfea])
        by smtp.gmail.com with ESMTPSA id o129sm3363720ito.0.2019.03.15.10.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 10:04:41 -0700 (PDT)
From:   Tim Wawrzynczak <twawrzynczak@chromium.org>
To:     bleung@chromium.org
Cc:     olof@lixom.net, lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH 0/1] platform/chrome: mfd/cros_ec_sysfs: Add sysfs entry to retrieve EC uptime. 
Date:   Fri, 15 Mar 2019 11:04:12 -0600
Message-Id: <20190315170413.108114-1-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wawrzynczak (1):
  platform/chrome: mfd/cros_ec_sysfs: Add sysfs entry to retrieve EC
    uptime.

 drivers/platform/chrome/cros_ec_sysfs.c | 34 +++++++++++++++++++++++++
 include/linux/mfd/cros_ec_commands.h    | 15 +++++++++++
 2 files changed, 49 insertions(+)

-- 
2.20.1

