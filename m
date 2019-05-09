Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9745BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A50217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSSI9So3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfEIUoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 16:44:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42893 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfEIUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:44:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id 188so3199649ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=u5JctK9VwFR0CrlwMKl4EFJwqF/RV4BqCjXfF5OYTho=;
        b=vSSI9So349IDd4QQ5HWvmAUoGEIcUs5qcm4t66tR8UZnI9yCzTP0HiYEfeBZhmqKv5
         JbT312FVwJD9k97zX7fTqRRWWKBwA2n+bKmQCuHD+v5cPogNuY/GgeQoAUjPm3xSf1wj
         d51CdnT85KUhtHtMlZ6XntQCs71L48C4NZq29A6rFIKLt5XnopEqbXbrzYqNt4OeBsoV
         cyP5BOAYV3yBiEiPKZxFhnGB7SEVQfCGyxnOKKRCVD6HamqzBlMUqCe49aa5xhbhT2G5
         zxilQ5wFagOzeAON2r+4iFbCDWMPA8QMIVis356w8Ekk22d/9tvl+c1hGu0z9I9SaNvb
         88EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=u5JctK9VwFR0CrlwMKl4EFJwqF/RV4BqCjXfF5OYTho=;
        b=aWMLsgDP8dYLvbFAd3jq9a9AnbeV8l1lDxde3wHn01A0b4ZpD6FnOk1XTgO7A7mHBI
         IoXE0UsjBLtcB2UJXDYFQQV4z1kPDHOpc3h6rrsDb9GB8aV34kSM/0V8t4ACrX+FE+U/
         C8IgXG8vtBQz7VQ59qhFXepQbe0ep78klzpwbm6uEuccsq6xOy5kH12wEfDCbt7x9Znn
         KQhqAc2L9LTbvc6NaT7FjAlYQFB1S9Vmkp1bCWs59Ak5dAXFi5eFAicw4Ju7LMEs0ZUm
         CvSsrV8iCgixlT8s0YlRYkKHDB/1/xdWwWRjSZocUPGNIWg1MDoQh3Tg6ceLe5QHInZg
         a22w==
X-Gm-Message-State: APjAAAWgGnjhQZm7filrWA+2F27v8cWaTmaHAK3PyqiZ2PauHo/cAvR2
        /oOEuH/MKqB7UgKTPdKL4/84l2Yh
X-Google-Smtp-Source: APXvYqzgbUHWqRYS/qzyYDUopXlUXSiJGu1lOA/TYLQ5qiWbOHlcwpV56sVB0oZ+WzlA1BIRrOvxcQ==
X-Received: by 2002:a2e:8996:: with SMTP id c22mr3760508lji.81.1557434640277;
        Thu, 09 May 2019 13:44:00 -0700 (PDT)
Received: from tamaverik ([188.243.27.255])
        by smtp.gmail.com with ESMTPSA id u3sm621499lfc.73.2019.05.09.13.43.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 13:43:59 -0700 (PDT)
Date:   Thu, 9 May 2019 23:43:57 +0300
From:   "Alibek A." <alibek.a@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Block device naming
Message-ID: <20190509234357.24025f65@tamaverik>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! 

I want to address the following problem:
On the system with hot-attached new storage volume, such as FC-switch update configuration for connected FC-HBA on servers, linux kernel reorder block devices and change names of block devices. Becouse scsi-id, wwn-id and other is a symbol links to block device names than on change block device name change path to device. 
This causes the server to stop working. 

For example, on server present ZFS pool with attached device by scsi-id
# zpool status
  pool: pool
 state: ONLINE
  scan: scrub repaired 0 in 1h39m with 0 errors on Sun Oct  8 02:03:34 2017
config:

    NAME                                      STATE     READ WRITE CKSUM
    pool                                      ONLINE       0     0     0
      scsi-3600144f0c7a5bc61000058d3b96d001d  ONLINE       0     0     0

Before export new block device from storage to hba, scsi-id have next path to device:
/dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdd

When added new block device by FC-switch, FC-HBA kernel change block device names: 
/dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdf

and ZFS can't access to device until reboot (partprobe, zpool online -e pool scsi-3600144f0c7a5bc61000058d3b96d001d - may help or may not help)

Is there any way to fix or change this behavior of the kernel?

It may be more reasonable to immediately assign an unique persistent identifier of device and linking other identifiers with it?


With regards, Alibek!

