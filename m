Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FB8C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2D12086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XdfbE24d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfF0MOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:14:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37271 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0MOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:14:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so5436560wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 05:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdXcbqi//1yQdo7sH21GuoXxU61NLp73gRkdlfRljFs=;
        b=XdfbE24dBpd/sTmZ7q4zvtKudeNA2u1ZlCAXEV6LSSX9MhXFeHsJA89RAGLWnAXKz5
         SVrwt61pY7t/JEyrDiZRvdMmw8qKctFALBIdVUuWRHU/WnvcCMDN0IK8U+OnimL7puwF
         Slbnn8jecmWciwC7EuS8Tpk8VdmPuwZClsYozfuX6VZCVQoOeDpzVlchZJU26FXwdfy5
         pORUGm/YZEaHE/qjgWXlN/Ue67kPhK9qdJhmrEEL3hxk4wJJEcoOXRqO7ZG4kfkJ6OeQ
         UAG56yvB+/TjPpdUMEllkNehJ0aDgHDSIXuvklQkgtlY3BaehtSzHPujwV7ITEOl4np3
         uOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LdXcbqi//1yQdo7sH21GuoXxU61NLp73gRkdlfRljFs=;
        b=tNLqmXmD17IFQaemoPTY7puE+AC1Nc+Vv+JiV7OuvQsy3xuStHB+i0wBWu+IvoF0Op
         YkDOqItXb5z8Po4kD8Ef7mvr6ftgNlwvsT8TJALnNiCf+LRDYK8n8vl6sAilZHa9Q/Zg
         CU5HAuVVINPsKgxP6RJAmt6uRpbQ8PZvZz+9SNpWqCDwia7zW0uek5vbjHoy8Gac7K5S
         c9dV8KRNVA1VGp0BFQuMK+aQnrSMXmQ4FVYUrCh3mnp8b97cpiCIPGimR5cNEXBhnepe
         UEEj6gmI1BGjwvpM/5/C9NcnDz2/+xVopsrhhSggQWNs57/OPGLQoohBDSoSwVGStzA8
         BKvA==
X-Gm-Message-State: APjAAAWQdbOjQNicy3lWh3t2KA0+KhqfWeidsiUndmi+cXGc/EaGQzUG
        7xzoI8JEOmDD4LrPFQISwX2lYg==
X-Google-Smtp-Source: APXvYqxfToTeP7Z6wbZ2zjURbfpnhMu6weuA67216EZ1Md0Y5D3hlgGZi/3X8aMdt1KW9lO/15lYrg==
X-Received: by 2002:a1c:9ac9:: with SMTP id c192mr3273937wme.0.1561637639202;
        Thu, 27 Jun 2019 05:13:59 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i11sm6160594wmi.33.2019.06.27.05.13.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 05:13:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 0/2] ASoC: soc-core: update dai_link init
Date:   Thu, 27 Jun 2019 14:13:48 +0200
Message-Id: <20190627121350.21027-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My initial goal with this patchset was to allow a dai_link to have no
no platform component, instead of having dummy by default.

However, when rebasing, I discovered that Kuninori Morimoto had recently
done that in a different way :)

I am still submitting my change since it should allow multiple platform
components on a dai_link, which is one of the FIXME note in soc-core.

I have also added a check on the codecs component availability to align
on what was done for platforms and cpus

Change since v1 [0]:
* Fix registartion typo
* Rename dlc variable to codec/platform

[0]: https://lkml.kernel.org/r/20190626133617.25959-1-jbrunet@baylibre.com

Jerome Brunet (2):
  ASoC: soc-core: defer card registration if codec component is missing
  ASoC: soc-core: support dai_link with platforms_num != 1

 include/sound/soc.h  |  6 ++++
 sound/soc/soc-core.c | 67 +++++++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 35 deletions(-)

-- 
2.21.0

