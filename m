Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7831C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D9421881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XaSSavAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfICCKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 22:10:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41861 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfICCKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 22:10:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id j10so106406qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 19:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=8YDLccInGWFdS69PIwuMSSYlryHoVdSUZ0l2DD25u48=;
        b=XaSSavAic+WaMS3qYO9pgU1eanGZSRHlvoBBUYcVCUO3lTBFIFFTII+TPYvVTLJbPe
         XmXBH03s4Ki5GjB80ExcmAGfZN72j5Vzv+dJskX8h99cBSQsIMZSIhW+p2kGL9dHzwbm
         34OSeO3gKKnMHNAM4gI4FBWufThv5RkZLZUQE5XFKT+eVCrT7ertViTMv9juEBGTVUz0
         EVWw66sTgL7xDPTAnxB3qfNQqmn6is9wctuAKV/TwzCb2jDuNkxWomFKJJG6SVQy4jM8
         qCWVUQKxYIuzmVJ5v7PSswIxJXEvPLk9I8w0KVBvDO51DyjPIzpbsWVRejyZhUMOF4Hc
         iKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=8YDLccInGWFdS69PIwuMSSYlryHoVdSUZ0l2DD25u48=;
        b=tECa0vph81/GaXogiBqcA0yaoo+bXzrEj5d4/3Qe+nH/6RhjxAaSsFQfCDodiYLWtL
         xknR+eh23ZxMF0jU5rrHwKdj9Z0MqpmL+L4cKBknb3FMEzfmNv8IJ0eji39qs4K0cxMm
         7r+R/AuT7hwrjTQ/7DsNL5oKSlsU5QCcEa5oeUY7Eup7WxdEVSoeseNHg3MZGtluCq8p
         tWjpUt7gUQPv72OcNGfiyerL3OzbVheWcOGTVMHGT+Id6KRfOkVTCXZoY6JrrqtZYe5t
         mvFLebnryNRA+mLOffxjQ+ooUplsBcME67tVgePhJxMwQuZyHIGqvAJ3rvYSeSAa3SWJ
         zbFw==
X-Gm-Message-State: APjAAAXHIaLVdguD5NqFhupeilRBKjaPTjGXYK6d5ZJ4c+Xo+2B1I7xo
        /EhDezo2P4FRHj7PgcP8ijXQmw==
X-Google-Smtp-Source: APXvYqxLPDAlLeyMbcJ66s5qx51UpP2ouQ1zTec9Dt4SRWeQgeDYKf/fWo/nLgpY5OFrjijmoQ7iwQ==
X-Received: by 2002:ac8:5204:: with SMTP id r4mr12538545qtn.332.1567476634260;
        Mon, 02 Sep 2019 19:10:34 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p126sm7897774qkc.84.2019.09.02.19.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 19:10:33 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: "Rework enabling/disabling of ATS for PCI masters" failed to compile
 on arm64
Message-Id: <63FF6963-E1D9-4C65-AD2E-0E4938D08584@lca.pw>
Date:   Mon, 2 Sep 2019 22:10:30 -0400
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        linux-arm-kernel@lists.infradead.org
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit =E2=80=9Ciommu/arm-smmu-v3: Rework =
enabling/disabling of ATS for PCI masters=E2=80=9D [1] causes a =
compilation error when PCI_ATS=3Dn on arm64.

[1] =
https://lore.kernel.org/linux-iommu/20190820154549.17018-3-will@kernel.org=
/

drivers/iommu/arm-smmu-v3.c:2325:35: error: no member named 'ats_cap' in =
'struct pci_dev'
        return !pdev->untrusted && pdev->ats_cap;
                                   ~~~~  ^

For example,

Symbol: PCI_ATS [=3Dn]
  =E2=94=82 Type  : bool
  =E2=94=82   Defined at drivers/pci/Kconfig:118
  =E2=94=82   Depends on: PCI [=3Dy]=20
  =E2=94=82   Selected by [n]:=20
  =E2=94=82   - PCI_IOV [=3Dn] && PCI [=3Dy]=20
  =E2=94=82   - PCI_PRI [=3Dn] && PCI [=3Dy]=E2=94=82 =20
  =E2=94=82   - PCI_PASID [=3Dn] && PCI [=3Dy] =E2=94=82 =20
  =E2=94=82   - AMD_IOMMU [=3Dn] && IOMMU_SUPPORT [=3Dy] && X86_64 && =
PCI [=3Dy] && ACPI [=3Dy]=
