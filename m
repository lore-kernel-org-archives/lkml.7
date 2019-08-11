Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A0C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798BC2085B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="CTDI2f9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHKORJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 10:17:09 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:39615 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfHKORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 10:17:09 -0400
Received: by mail-yb1-f179.google.com with SMTP id s142so8036339ybc.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1k10DVZX38KqG7NN+n2wPTA9UK8NfscpxQDUmI83NeE=;
        b=CTDI2f9nfiEREhjRyqr16/Wu2BsL8YzNd4VagGVOSl/B5YDxTgQQwOMQrHIfXbI1aC
         bU+ex0Qt6s19RDFxRkvd3jnxZXezvIJnlCkbrLAfs0771eX+aOiO+VM6SvupxtUrrok6
         cwcjvg2olRbuuf2kxl24x5d76bEJk+0zihyEsPkROa6YLdN08WepvGyXkrc4pwrCKsPz
         viFjyN1Mcdb5bJcI9vYrG85O9ddA9vytStRifndDrw0+uv3V89FSZRbUwGfvfcBLvwSZ
         1vBV2/ufvHw956SOQde8iTMGqfdqGbeosRXodWYiRmiVaEtbTziKoG6DDNLIQjHOUJ0p
         p9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1k10DVZX38KqG7NN+n2wPTA9UK8NfscpxQDUmI83NeE=;
        b=SlV43Ov23wwRn/+ZHrGffLULkoFi7CUR2QjZlsDfkMYZyFlu5bwzYuCAlwlm5h8CT5
         9IeCTE9y2uetdVmDc7xm/VtFpXd04tjR49Ievsnr37rvdxQ26h31WMV6ileeNd2I9PVL
         HxXeLb776r7Mq4qeoZIsY2aFLReBYD2xi8U+hpS7GrGW2PGZTrLS97BQPWYKKXkxWaPM
         +s9+js5wLQq6JNqgKRkp1t/+94KcUksPv4DR394m/OoY+Bn/4IqdP+IzLUz0kg0LIjRO
         uWBpodRyl9NQvnUMkD0v3SDAEK+y1+v4TQW3FgYIjGnhACKZGZEstRopA+9Kp/jEtV/M
         QJeQ==
X-Gm-Message-State: APjAAAXZAxu7x8Mk+mh3VpcSZ0vSNIn3pGzKn6j1CpoIzvCIozgNUGHN
        Sbd8krOllgB8b/JO62WqrVvgZA==
X-Google-Smtp-Source: APXvYqzTe63h2ZGbEdSFO7kx+kUNMCQJw33B0alWQfVL5Rp0etQWvZiBS06QAEvaOpGoJkoVyqHvGQ==
X-Received: by 2002:a05:6902:52e:: with SMTP id y14mr12008418ybs.272.1565533028035;
        Sun, 11 Aug 2019 07:17:08 -0700 (PDT)
Received: from graymalkin (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id q132sm23579060ywb.26.2019.08.11.07.17.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 07:17:07 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@graymalkin>
Received: by graymalkin (sSMTP sendmail emulation); Sun, 11 Aug 2019 10:17:03 -0400
Date:   Sun, 11 Aug 2019 10:17:03 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for v5.3
Message-ID: <20190811141703.GA12153@graymalkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here is a trivial NTB bug fix for v5.3.  Please consider pulling it.

Thanks,
Jon



The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.3-bugfixes

for you to fetch changes up to 49da065f7b1f27be625de65d6d55bdd22ac6b5c2:

  NTB/msi: remove incorrect MODULE defines (2019-08-05 15:42:27 -0400)

----------------------------------------------------------------
Bug fix for NTB MSI kernel compile warning

----------------------------------------------------------------
Logan Gunthorpe (1):
      NTB/msi: remove incorrect MODULE defines

 drivers/ntb/msi.c | 5 -----
 1 file changed, 5 deletions(-)
