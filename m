Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6358C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AAA20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mvbKPUtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfELTnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 15:43:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37010 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfELTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 15:43:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so497360wrs.4;
        Sun, 12 May 2019 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkKnBKUFEKkDHQcg46RtzXFD9NeWizWJPkqwcfN4Wh0=;
        b=mvbKPUtz35AGODuQ9K5K6a9T+agne7rqu9/Qr6o1q6lNuwng+f59HDCKbvTvdMlJ6c
         tay6/jDjraQPYW1yUkEX32PfpaWB9yXprec5o/OLr4xfqfIGtmLiFZNGzGQSZA1a/TX9
         Kab/vzHiIfFZXzV4zrPTtr2VW74QWPjDHVeWcv2VDSmkOF/CD4WUficUaKu/UmHSgMsS
         kM/USbd+tjhfVG0CvGBFR2hglW11J++QoSeo1I4E3zyeGR2JwPClPed6M5rDxkhr/AU2
         IxDfmUb27bzNVkGpcVVo+otej5AgJqxc7JJm5pKUvRuyMiQBzJwsxG5XN9me8m7pS/ya
         IZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkKnBKUFEKkDHQcg46RtzXFD9NeWizWJPkqwcfN4Wh0=;
        b=TMkizR6RPgEFoWqCHWxexAPHNCNal69SXmXbiXR0LWV2tEDZM4+L/fz0sD8nm2IIEt
         LaGMM3kkvtEkafR6laGmkIPbOV4u03GTgBqN3wCdaNM8qyYZw8NjTgBPXNVEPMLBvJaV
         0+zveCG13fmh8KvscZDLJmrUSUlYKiRu7KzrsBiVp4/TFM/P3zxcFIBZgFj9rtFeXXLb
         r6EfuCUZ4yXzwPqKkjSYgiAeq8xv61wkxLapZA7cNugviXa4ZGLTsi0Qa9JSg0HbRs/X
         SdJmEanEyL3QR/fujbjBc4oaHAaav0YKAJBv2Cvf4lkaLFV47T3vBPL6kpdY2CEO5HfE
         6uVA==
X-Gm-Message-State: APjAAAV/Dqn9t3dEGuoIP5ncG/5GMFu6mgXPrNSwlH0fyz6Zzh3IcEzc
        4ra68YYFGejiKV/OtueTVwk=
X-Google-Smtp-Source: APXvYqy1d05NDscbWQi/nz+Tj2aWJx8x7CvKkvlyeMlWGow/RSrPZ6ZGd7eG1OmLtgniNupyS7n6mA==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr9410128wrm.153.1557690191211;
        Sun, 12 May 2019 12:43:11 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD00ECBE9107EA8EB108.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:ecbe:9107:ea8e:b108])
        by smtp.googlemail.com with ESMTPSA id r23sm13685178wmh.29.2019.05.12.12.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 12:43:10 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] typo fix for the Meson8b clock controller driver
Date:   Sun, 12 May 2019 21:42:59 +0200
Message-Id: <20190512194300.7445-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple typo fix for a clock which was introduced with the
v5.2 development cycle.
Nothing critical, so I'm fine if it's queued for v5.3 (no need to send
it as v5.2 fix).


Martin Blumenstingl (1):
  clk: meson: meson8b: fix a typo in the VPU parent names array variable

 drivers/clk/meson/meson8b.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.21.0

