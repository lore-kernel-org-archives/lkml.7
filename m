Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EA8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833222133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="2QC/vo+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfEWLgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:36:32 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:35765 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWLgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:32 -0400
Received: by mail-lj1-f176.google.com with SMTP id h11so5151798ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcNmkTb8iT2ZbAtgyuxqn+Ua2QHtCHTWatTbEbDqU3Y=;
        b=2QC/vo+ZOVICORGm8VD8UaIT5W01p9qsjoUT09th54L9n317SVhhJEll6Qb3vpM/e7
         Hh31im5IGWYkXoXYaXKOBU49Q/f9awhgAw7Pf/KkzDi4dDrn1OGszPqpAKD1PKiL9SDC
         HXGa1KVqP7TqlTP/UZbtB6GZdiaWbo91Zd7jTHiq46jin8sCGawUFQaYoSB4raknyuLo
         mOvc1R6a8nVbips3U+a1IHHT2n/FDzO8iOwM3h5+JRGh85fVuKyaxnxENv4nHKNFdNuF
         8oSuoorqg7uo9WT7q1CxmHMjjPE7m4biH2uNuTWdGXtEHGBQVIZpNb8tlez1QzNycFls
         s0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcNmkTb8iT2ZbAtgyuxqn+Ua2QHtCHTWatTbEbDqU3Y=;
        b=Xfg06gyozSA62pTPftq18Vf/FezHg/qXlHJRiXv+DMRr+MitxEJf2aCiGy/TITwSTJ
         4jcNvTC/Q7W630aJ39Hk8tyFt3uOw1dEkshFMB3oh6SJyTA5grcQz9nLAdPfRvOuung0
         d8pd+lZiCMKWx5Be0ulLCshjjhxnreb53tDyGU2euKwvyYtlHxZ2ieQjYxr0MIp9esIX
         d8dpWwyWKDdvwxFEVSd3ipcFPx9NFv1IHcH5AtH3657NUDF6PNKHqSvVFbxv2XP3qBpQ
         i10pXRAfPK/XWwWtrAUQubGr31Zi0kq0XNS3cDv9tvU+W8gwGxrj9pZyhSxdi293gz9l
         yICg==
X-Gm-Message-State: APjAAAVCMxQjb3uN1PqFTaBgaZ9jvq3+ge/1X9XIaEMWea2EzWfzRscJ
        AJXunkXKw3WtDWaoHkccYDiBG1YyLHkB1Q==
X-Google-Smtp-Source: APXvYqxshKCD55Yo2iCoEhLs8bv9/IcKvt6bLEvW6WAFDH5FXDM/3N487weHx8ZdF261hm0TIJzKUg==
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr4937287ljj.110.1558611390288;
        Thu, 23 May 2019 04:36:30 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:29 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Fix more coding style issues in staging/kpc2000
Date:   Thu, 23 May 2019 13:36:05 +0200
Message-Id: <20190523113613.28342-1-simon@nikanor.nu>
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

- Simon

Simon Sandström (8):
  staging: kpc2000: add blank line after declarations
  staging: kpc2000: use __func__ in debug messages
  staging: kpc2000: add missing asterisk in comment
  staging: kpc2000: fix alignment issues in cell_probe.c
  staging: kpc2000: remove extra blank lines in cell_probe.c
  staging: kpc2000: use kzalloc(sizeof(var)...) in cell_probe.c
  staging: kpc2000: remove unnecessary braces in cell_probe.c
  staging: kpc2000: remove unnecessary include in cell_probe.c

 drivers/staging/kpc2000/kpc2000/cell_probe.c | 80 ++++++++++----------
 1 file changed, 39 insertions(+), 41 deletions(-)

-- 
2.20.1

