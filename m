Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91A8C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC5C2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjMDps5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfFRBbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:31:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41448 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:31:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so8358634qtj.8;
        Mon, 17 Jun 2019 18:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kjb0KkcLsfA472XYdnRcQ6swrLy5rBSD+ZCDoLQnCFA=;
        b=VjMDps5zs04C62YPKuFEV3G/lnx3b6AEJU/bF34Y97PexFC7zhoj5sj7D7BYDAFxw+
         7fismKYtG7YJdtATl3jglE3u9YeOLW/cs6dckgkBhpuMuW7A7Sx8jrgnhJa53Numm+aI
         sHJciKbHs/l/nWXb3OcJ3BewIghWlyk1FC+RxfMbQOQp8FXx7FZ1Ij18eDC+SdvcO77m
         uWnS1bo3luGl+L6PDtGaVOl8s9Z7fHn/oRAyNx3JHgG5YQM638HAbGDNz7wo1UjCXsL3
         nhq1GnnqZcqChIx75L36WcAeO49eeSdpnNnUTYot83dZJiMo1BcXMVryEHgoWuXj+Grz
         86IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kjb0KkcLsfA472XYdnRcQ6swrLy5rBSD+ZCDoLQnCFA=;
        b=Nip5JvzOVmPuS/5BBYGjPVSwuR/3n+Q7SItzgB3gkKJ7f4abWDMVQbnvrcule3/y9s
         lOExiX9bz4XGLIP+0j4jbnf5F4wX+gGlqnb041BswR7xrejuCYVYdzvzTf9SyELmDT82
         DIV5CL5tJZ7/TomHh1JlcB79pjr96+JOQnHILLBfCoJ7XuPQohEPt3ft1wE+pKCY7YFF
         B3Bv6jl4/zGoJAt2VxYz87VJxVhpQXRY4azrrwbxiLI1DqZ2q5b//X2U6efKLGFmTgV4
         gXs3vOdQ3MqK4QtWZGuPJzeqVo2cys6F72soqSODTBoed+2EujWxJVp/blhQGR27qFG3
         MGWw==
X-Gm-Message-State: APjAAAVpgIzfXD6mSIGVdhcuO+WPDzj3Tx71wdJV2p0P1y4ddB49cSM0
        NHekeTZ5s0/l2WIIX8WpvPnIsHXLsA8=
X-Google-Smtp-Source: APXvYqwqy4zci5OY4W4YOp3pVEpnmfWyRvXNDWLLZdXYtHKsBJwqTku8+oIgo7mS2kmvtduL7FaauQ==
X-Received: by 2002:ac8:323a:: with SMTP id x55mr6654287qta.211.1560821497979;
        Mon, 17 Jun 2019 18:31:37 -0700 (PDT)
Received: from localhost.localdomain ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id c30sm8340874qta.25.2019.06.17.18.31.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 18:31:37 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 0/2] Honor VPD check in usb/storage for SanDisk device
Date:   Mon, 17 Jun 2019 22:31:44 -0300
Message-Id: <20190618013146.21961-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, USB storage devices disabled VPD check by always setting
skip_vpd_check.

The first patch add a new entry to scsi_static_device_list related to SanDisk
Cruzer Blade, which have VPD, adding BLIST_TRY_VPD_PAGES flag, which implies
try_vpd_pages.

The second patch check try_vpd_pages, and only set skip_vpd_pages if
try_vpd_pages is not set.

This patches along the wwid one [1], makes SanDisk Cruzer Blade device to
present correctly wwid, vpd_pg80 and vpd_pg83 in sysfs, and let the window open
to support another USB storage devices to support and present VPD.

[1]: https://lkml.org/lkml/2019/6/11/1408

Marcos Paulo de Souza (2):
  scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk Cruzer Blade
  usb: storage: scsiglue: Do not skip VPD if try_vpd_pages is set

 drivers/scsi/scsi_devinfo.c    | 2 ++
 drivers/usb/storage/scsiglue.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.21.0

