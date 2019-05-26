Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB6FC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D362075E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtL9uSIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfEZUsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 16:48:13 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38786 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfEZUsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:48:12 -0400
Received: by mail-lj1-f176.google.com with SMTP id 14so12915037ljj.5;
        Sun, 26 May 2019 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnNXTlUJ0JZePDmFboabIvf4BbFB+04UY9OlZNiUXEk=;
        b=WtL9uSIVO7aVej5859ERtPiS3O495Mr1bnXxNKXiqhA7TIeuXR15kNwYV7IJ0PDQVP
         TldXaBVMejTFe7xiCFALNXSM8Ul1IYPBnGIGlSOoHS+5vbo6KD+K4PI965u0HKNWsvNs
         WHJYoIGYotFEAB7mylEYPmWCkPisrBYmz6nLEZ0kzNyOEKD6VC6/K+QOhGeANUE+QNIV
         OX6QcTdiO5NkCEY4qPNIWeH8m5ar9d8dVdLdaB9UCMZjWDXdeGkofnAQyDoquLG4wyuG
         BcfL9eJnpGms74svKy1ZvnALdZMO8bRIL0Hs2aVxgkHHzCHMYuFRY6fjVV04QA/+y5Jt
         74HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnNXTlUJ0JZePDmFboabIvf4BbFB+04UY9OlZNiUXEk=;
        b=PtHjyYxF1Q0LTthOc7WAyb9vB5D8F2PmteEQWXe6hMOOXWr2zmd4YWpAEO5QuSEoHZ
         yJZItLI+amrQX1gtPEvRaaLK0fgN6lInQRDVuRDo4MCXHZoQ9GK0v2wQ18Vuc0fNn9gn
         x7AgfMc45KJ4XvIlrki0RlPAHyT/if8U/sx1GkwU+Cwc2hVp7uqAkyjjE0NzE+iB/AFX
         9oMPNGMTR0s2m76CrAaxE4lPZN4xVuB+CV9U9pfmnqqeV1wiCH3LYCWIPV9x+xIQ6DRm
         xtBJXhVO5ShtS0ABt0mpXkdWS5rQyk9ny6//Qw35Q5QlfdSsIDrAOFqjpThtc560CJ+i
         XELA==
X-Gm-Message-State: APjAAAU5ZlKHTyXt2eDG8DnbwZ0SBf76nOt9ipfwz68RFa0cw0dLxjoX
        X52c/FXXJiKEdl/OHtyaFk8=
X-Google-Smtp-Source: APXvYqwJzpUotxAkdwaOibB4nQS6FiLDfgun0vU7i/sCJOOprIvcb4q+88YKUjX9FYpTSirLfw/5VQ==
X-Received: by 2002:a2e:5515:: with SMTP id j21mr32630078ljb.198.1558903690682;
        Sun, 26 May 2019 13:48:10 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id i187sm1859475lfe.64.2019.05.26.13.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 13:48:09 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 0/5] media: ov6650: V4L2 subdev compliance fixes
Date:   Sun, 26 May 2019 22:47:53 +0200
Message-Id: <20190526204758.1904-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An attepmt to make the driver more compliant with V4L2 subdevice
interface specification.

Non-compliant frame half scaling is kept in .set_fmt() until composing
is implemented.

Janusz Krzysztofik (5):
  media: ov6650: Fix V4L2_SEL_FLAG_KEEP_CONFIG handling
  media: ov6650: Refactor ov6650_s_fmt() helper
  media: ov6650: Fix active crop rectangle affected by .set_fmt()
  media: ov6650: Fix frame scaling not reset on crop
  media: ov6650: Add .init_cfg() pad operation callback

 drivers/media/i2c/ov6650.c | 71 +++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 28 deletions(-)

-- 
2.21.0

