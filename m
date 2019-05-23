Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B267C28CBF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E259A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="1bLiW/1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfEWMvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46430 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbfEWMvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26so4289606lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMmk2xMTkCY6jSkcBGDN9/7ybK/nNloRLyRDYt7L/zc=;
        b=1bLiW/1HiRaBIAhNe0+QhlOl10V76Cwy0MtDym3GfT7ezxhkD3yxuVpPi5SuTcfx24
         g5f2JIaRPF1eBXx18xyV1sweXJsOIdRY+sVf6p12eBP6ksnBE4LD2QvMr2XooOApvIlB
         XnpQkQbPH/UCtw1bQgjGuP4Q1RxniC7rw0d2HaajRQsfuWKMQXiT5mBuT/VIR5OQJ762
         +yFvPIz7PCaAwY9tjJPicuIhViTgzPNBRsyucrxqQTNa4WEmXDegex66omgDXV/uCe6k
         rXtno4qygE5dj8TDqFhQsl1SYGQmJ/VrBIKzvUzyeEBBLm/sl0rdkiWCaCu63h/+Awbj
         glaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMmk2xMTkCY6jSkcBGDN9/7ybK/nNloRLyRDYt7L/zc=;
        b=r7tMDZPxcX4u1mPOdIUQtXK2fvqkE8jgsueCRKJhs4KrJtA/JJRGau0IasP3H4lAnS
         sye4nHDeSAMiH1hA2lUyQboaf/GIK5cF0+pcl3v1BcmjFX50By1SvQpGsSoobljJaEux
         H3JVcSnWdlSnsVsnWL6gfBDi2GSmy6aYlSV2/2Qtglqdhc2emqY+r1AcHg346hgA/1bC
         O82PHV09CCLCIRlWoP6fmX1AaTgfPtZh9idt4Obnr2kAFwesDvPplW1OKdrIQ42pRVwL
         ZuLJplNzmQ70FJiIkl0yfA5qbE5EpSxJ9QkDmAmlyuoLyagc0xaJSBmum1HjheEhCOgO
         e99Q==
X-Gm-Message-State: APjAAAUUcCvJ+qnJidawB0xTvQOY5kIDT3REptZEIugumYjssvCqLDi/
        F/XaWxGgj5S2TZzzHt5Bo/afd8MVN0E9XA==
X-Google-Smtp-Source: APXvYqxX0coEjY0024D4lKShz2OT4M6tyAKuuaaCNpO4kCc/n+27WtPuyWYJ7VqM0dqV2Z1SUYdELg==
X-Received: by 2002:ac2:4c36:: with SMTP id u22mr2113982lfq.33.1558615906558;
        Thu, 23 May 2019 05:51:46 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:45 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] Fix more coding style issues in staging/kpc2000
Date:   Thu, 23 May 2019 14:51:34 +0200
Message-Id: <20190523125143.32511-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches fixes a few more minor coding style issues found in
staging/kpc2000/cell_probe.c. There are only two more types of
checkpatch.pl warnings left in this file with these patches applied:
"line over 80 characters" and "Macro argument reuse".

Changed in v2: don't bother fixing the __func__ usage in the out of
               memory debug message, instead add a patch that removes
               it completely.

- Simon

Simon Sandström (9):
  staging: kpc2000: add blank line after declarations
  staging: kpc2000: use __func__ in debug messages
  staging: kpc2000: add missing asterisk in comment
  staging: kpc2000: fix alignment issues in cell_probe.c
  staging: kpc2000: remove extra blank lines in cell_probe.c
  staging: kpc2000: use kzalloc(sizeof(var)...) in cell_probe.c
  staging: kpc2000: remove unnecessary braces in cell_probe.c
  staging: kpc2000: remove unnecessary include in cell_probe.c
  staging: kpc2000: remove unnecessary oom message

 drivers/staging/kpc2000/kpc2000/cell_probe.c | 81 +++++++++-----------
 1 file changed, 38 insertions(+), 43 deletions(-)

-- 
2.20.1

