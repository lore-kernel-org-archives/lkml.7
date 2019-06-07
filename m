Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB28FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA82208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y8xkfHK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfFGVIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:08:41 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:46193 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbfFGVIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:08:41 -0400
Received: by mail-qk1-f174.google.com with SMTP id a132so2123975qkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=E4XEGd4DqdBQRyG19CHJo5811yC3cY/TwcQ6u8XftFo=;
        b=Y8xkfHK1OZ7tf/p7+OEuKsd86A4js8cJVS0t5BgppRwxS23p5R5zyKuTN0dz+Mo88x
         6uQFnQ91U/bHhDQWfnqC8RxR0jv3HhyvLlm8vaOqxw2Z5eR0sav++IN1KdJd9dYV5Y3C
         fT5D+62A0l5OqoXpNsTuB5Erk9sL2zY/DCOSTw4juP43K4xzPn69nzkPxuuoQVJFOz2c
         4qbadClltzYLOXmxGzSDkkOmai7TskMPMOUDiNwA85HCOKvALa880+3+opO1/a2YvMgd
         7+x2N0THC1GoVWsNPk5j9pADsXpGD8InJ9LkLs0r8XJZol1dtoXStIsatT9xlo4Kbcdo
         VksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=E4XEGd4DqdBQRyG19CHJo5811yC3cY/TwcQ6u8XftFo=;
        b=lsEk/WGrzPOk8lq92t+q9Alrz4/k1ksULZZE1p17tWy/meT3rkllYgyKzcyBCPq2oH
         ItOIgG7vVQ9Tv9CuM9pQSDT0XK6xNg0+TbBCrt0Yeo/nHP75TZgvTv+OS3692Ync9No/
         /QuA/hqsAYx0nFrIYFaWEZhtZzOrLLTkiQWG6BPDRW4yPjVvLHQN6Iv178giNAjRgfDj
         JFTCfbwxpjVEkxOmxccRYfnk6oA8TN5qRJkfzIYRaIrl7Nq4LJcx1EghWyAQIYazWguM
         0lIg4MSmUlIaI/6C2Y16/ljpdcFIwshmWULUYI0elOijQI0+0+jqazfjCTGzA7F2VIz2
         sg1w==
X-Gm-Message-State: APjAAAWpsIqAL+E2B6+dcScjdfxjj5bBxDncyo4ssUN5ePS/ch/kzdPZ
        sIrBMfLm1+xoxloztfMsFeZfNQ==
X-Google-Smtp-Source: APXvYqzB1xYDxn6tlil+RdfJuoEo0ORYAGfENTnBCZYrw4vak0QBv8QAHAPZwlXqLe61VwGLoTl4+Q==
X-Received: by 2002:a05:620a:1425:: with SMTP id k5mr44972163qkj.146.1559941720051;
        Fri, 07 Jun 2019 14:08:40 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i55sm2291302qtc.21.2019.06.07.14.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 14:08:39 -0700 (PDT)
Message-ID: <1559941717.6132.63.camel@lca.pw>
Subject: "iommu/vt-d: Delegate DMA domain to generic iommu" series breaks
 megaraid_sas
From:   Qian Cai <cai@lca.pw>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     James Sewart <jamessewart@arista.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Date:   Fri, 07 Jun 2019 17:08:37 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next series "iommu/vt-d: Delegate DMA domain to generic iommu" [1]
causes a system with the rootfs on megaraid_sas card unable to boot.

Reverted the whole series on the top of linux-next (next-20190607) fixed the
issue.

The information regards this storage card is,

[  116.466810][  T324] megaraid_sas 0000:06:00.0: FW provided supportMaxExtLDs:
0	max_lds: 32
[  116.476052][  T324] megaraid_sas 0000:06:00.0: controller type	:
iMR(0MB)
[  116.483646][  T324] megaraid_sas 0000:06:00.0: Online Controller Reset(OCR)	
: Enabled
[  116.492403][  T324] megaraid_sas 0000:06:00.0: Secure JBOD support	:
Yes
[  116.499887][  T324] megaraid_sas 0000:06:00.0: NVMe passthru support	:
No
[  116.507480][  T324] megaraid_sas 0000:06:00.0: FW provided
[  116.612523][  T324] megaraid_sas 0000:06:00.0: NVME page size	: (0)
[  116.629991][  T324] megaraid_sas 0000:06:00.0: INIT adapter done
[  116.714789][  T324] megaraid_sas 0000:06:00.0: pci id		:
(0x1000)/(0x0017)/(0x1d49)/(0x0500)
[  116.724228][  T324] megaraid_sas 0000:06:00.0: unevenspan support	: no
[  116.731518][  T324] megaraid_sas 0000:06:00.0: firmware crash dump	:
no
[  116.738981][  T324] megaraid_sas 0000:06:00.0: jbod sync map		:
yes
[  116.787433][  T324] scsi host0: Avago SAS based MegaRAID driver
[  117.081088][  T324] scsi 0:0:0:0: Direct-
Access     LENOVO   ST900MM0168      L587 PQ: 0 ANSI: 6

[1] https://lore.kernel.org/patchwork/cover/1078960/
