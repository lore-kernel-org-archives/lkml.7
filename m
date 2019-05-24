Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE835C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7056621773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="HJgoaP5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390814AbfEXLIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:08:11 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:34322 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390604AbfEXLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:08:11 -0400
Received: by mail-lf1-f41.google.com with SMTP id v18so6840843lfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7oGIGUHfrIIEjfNNRqGi/2xzPgG8aUQ9pTUobrsjH28=;
        b=HJgoaP5+gqMm1YH+q7FJqO7CYyWFZvR6fT5VeknZR5WabOd9YCcw6uy7CCMgNjU12I
         sqIRsVdfNxCRa551lfgs2tdyX+ykcpsiCQ3AOkBN6qdvoMYvo5vcqqrcUKeBY6LLMbtD
         I9BMtzSylb/k/REGevZWD1kSFsqVrPl1R9oLr/mxW4sU1elKWHwKTGnjZ+/uc34Fl+AH
         vvlHsk9BCM8Co+oACI9pgPe0Rzt/0wCsmxUjYXsIrgYT7pVYEgzuR4FXp3Y4+KOGENEz
         Inb7XROGuVX18DVNSvPrqt2109QBwPfs6UqJf75h/xwOqlli3OozYtFZ3w7iMuBAu14j
         GARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7oGIGUHfrIIEjfNNRqGi/2xzPgG8aUQ9pTUobrsjH28=;
        b=hhGup8EzTeRyHQEZwlfH9s1gjjadWfIWzFK9q6U7MgVm2+J1jcgcf0Eianm+rV43l9
         aCejz9TtyMq2Rc/bCkYsC86vHguu0xGuA9wmig1I/uD9CURUD6Z5ptagyuzQ6bD5GN4L
         cx3xh8hGJVrvGpcR7F4V8vfu7feY/dnNSzSsJPOmJRHTXblcdc3DVeMa0DH4h3Z4WDUU
         h4PdtigFWtMdOTnq8XSUPSDX1RCXWX/EU2JT/FCvM5duapj6rcFPMvwKoyas736HJB0J
         K8/ffb3ejLxdmpAqJD+z060IDJFclLVe/xMAeg5I4aBjYyDhr5PCanwdIBQgkzZPmG37
         bBNA==
X-Gm-Message-State: APjAAAVvSWw/IjAuV+wUkTAc63HM88PUMee3RTnzWqhc3mtqo+vUaUMB
        gvtmpVyAMAOR8/dqJfQUi4XLSg==
X-Google-Smtp-Source: APXvYqyHVuXmrj3IngkH3jiB9BLpMGMuMwu5ydZM+10r4gXyniq6KO6/Sy3nmq1jgPtonYTFLhqP8Q==
X-Received: by 2002:ac2:419a:: with SMTP id z26mr14250127lfh.122.1558696089232;
        Fri, 24 May 2019 04:08:09 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x21sm446234ljj.43.2019.05.24.04.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:08:08 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fix whitespace issues in staging/kpc2000
Date:   Fri, 24 May 2019 13:07:58 +0200
Message-Id: <20190524110802.2953-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches fixes minor whitespace issues in staging/kpc2000/core.c as
reported by checkpatch.pl.

- Simon

Simon Sandström (4):
  staging: kpc2000: add spaces around operators in core.c
  staging: kpc2000: remove extra blank line in core.c
  staging: kpc2000: add missing spaces in core.c
  staging: kpc2000: remove extra spaces in core.c

 drivers/staging/kpc2000/kpc2000/core.c | 33 +++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

-- 
2.20.1

