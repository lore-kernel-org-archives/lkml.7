Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53496C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ED4206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcnqz7wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfC3BGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:06:37 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:34522 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfC3BGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:06:33 -0400
Received: by mail-lf1-f50.google.com with SMTP id y18so2635404lfe.1;
        Fri, 29 Mar 2019 18:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8X24xORstmfsFADZYpHj23YNkhU5nxe4FWvqB7xtqWI=;
        b=gcnqz7wZXQWvR5+4xEUyMfF3ma8BklT0r64NvznSaS/oAMeMZsXmIr4VJ0ROw7r8aX
         r6UQOQKEMXMHS71vOeJPbPVWtk3fB1+9z4ZunpymcB30YdscIUMhc/iGqa6AKG36D2ib
         vLZJA17VUHgGMK0cHx7vkf61ZKt0oii+bAmw/VB0Xv2T76wLNTQ9NUVmx1S5/DSrAz2y
         PvZNXwRk55n3Ay0Wxi9m8j/Yx3EHkqckEEY8vi3hj0U0046TcZ4QfUbCDcvg9BML1GHr
         QEcfnfRSIstb3/ENWdmizRQGsXhE41RkBjmZ04KUf8GKQ71Sq7LhH7xU4lKJGDVKbmhQ
         otIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8X24xORstmfsFADZYpHj23YNkhU5nxe4FWvqB7xtqWI=;
        b=ByJ1XtIB9chTFWLpGjl+PDgg0+luMRjgrNoyafTzHY0ektQYqi4bM7zMs0yn2Kej+n
         w5JzV7SB9vfWYwQboJXUQfLpBS8P6QxMh0zJyt4vrjoZp2kAnhfECWK7Y733SQkIMTlx
         QzWoAo9qDQrBIe6AP3RSyGdq3jpPNt1yUIV2x8LuqbBcNYU/I/182306HEt6uqRifJSb
         YJSsZvJArhOB9ZkjLl8RaswpJ8JhJqL5LUc+tUtVUSZH3oh6JdEG9upeDhIzM4hGXFQc
         blc3Z0TgC8wvDcB3NLJCpnHhov4UD7Ll2W75BW6HsuCI6CkPn0Gpcf3O091UlJlgrjtr
         Z2IA==
X-Gm-Message-State: APjAAAXCN62JfFzinPh0yqwjENZrt8P70JYOIelHO8d+UmzRXFZL3xZt
        /IDtGBpwM5bu4c5ybg7KiD8=
X-Google-Smtp-Source: APXvYqzz0YlEYhuBe2SSwszVRL2y5vBdzuFTYJfiaoKNLMmofuJ1a/CMWz2WiIdF+yF4zQ1UlIWpFw==
X-Received: by 2002:a19:8c1e:: with SMTP id o30mr4647283lfd.137.1553907990925;
        Fri, 29 Mar 2019 18:06:30 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id v21sm556514lfg.26.2019.03.29.18.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 18:06:30 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 0/2] media: ov6650: Add V4L2 asynchronous subdevice support
Date:   Sat, 30 Mar 2019 02:06:08 +0100
Message-Id: <20190330010610.15094-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190329202903.5622-1-jmkrzyszt@gmail.com>
References: <20190329202903.5622-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Janusz Krzysztofik (2):
      media: ov6650: Move v4l2_clk_get() to ov6650_video_probe() helper
      media: ov6650: Register with asynchronous subdevice framework

 ov6650.c |   44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

Changelog:
v2->v3:
- use v4l2_i2c_subdev_set_name() - thanks Sakari

v1->v2:
- labels should be outside conditionals - thanks Sakari
- rebased on my former fix so it applied cleanly

