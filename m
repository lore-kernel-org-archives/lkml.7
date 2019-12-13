Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78BC7E09E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEE6247F4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Ohgf2p7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfLMShS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:37:18 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:37973 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbfLMShS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:37:18 -0500
Received: by mail-io1-f47.google.com with SMTP id v3so648513ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 10:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rSTbx4+Xnp8FvEJgiPQ5fFPbX8PvFRdBprtRWfCWCQ=;
        b=Ohgf2p7RcDyAO9x+7hqrHkTxJ+a7kT8vOKByrsrMwlsQyfiqsofPMz6dlNEaH2kFr/
         30OXQgmqBqqpNadNXtss0bPV2ZVcHODsCXvhDzcMWmbv1s3KgrYiRRQusO6bkbFDRp5r
         LKvKMn4BTmDY7od/XhpsXT23xIipONjzb6tpmba5Yg7opdrxn9JbPVo+73idK9kGsIF2
         nxFDLQAEjalQhqtduuADtXitKUuXf7FWRkHCJElsAxtG+37Ox7MhGWEh9v8dKVoLChhH
         vtTC4mmQqcAXBoutRncx9v8ysca09wIVNJ/BhTFVjArRy8gBLIIC18A4DbY6RDDKDnlb
         wsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rSTbx4+Xnp8FvEJgiPQ5fFPbX8PvFRdBprtRWfCWCQ=;
        b=V9v5vLExcqeadgGh3gpmrFmLDjEZ5VtZNMRAYnYRQzlIeMNbDxuaqFbZ62P6jc2Yg0
         j9xudaKNOLXe5GOt0Eyxm1mRspxQPMFfpjJHKK1mIW0TSwoEmMQYl7g8ZcICq9toxmsR
         wwH6xfhq9d3e0ZImYvzcDuGdzZe8LILVLqw6DYR/A/PIx08G1dxBxEbbedhdhU2uo5Wl
         Zudl3ccZUiXxk+UVV4Vnm7QyZlpx5YMno/yhluNrJ3nUccHJGq5knfRHQfhgNMKnd/Ka
         B2FnHN3LwQoZ2iSet6PgL/EXNpNF52jzlkELaEmdfTLjQrYSIhbnS8zvJIA7grejDiFz
         9Cvg==
X-Gm-Message-State: APjAAAVrrRHOoTbv8rVsS0FbgMc6bGkVgtjMw6u4ZgIq+wgxZ/NXKRrB
        jMVnavMEblIOLf2JYOU6qgL7/ZBoxG9AHzzHeJO4Pw==
X-Google-Smtp-Source: APXvYqwmEGW+SCoK781R1wHEyeHBJdMspwk5PrOmp57kqjQ+5c6ggfMA1Zq5gVwxNfGgc4rjMK4/bvTYtO3f/Xhf1Jc=
X-Received: by 2002:a5e:da0d:: with SMTP id x13mr7973581ioj.123.1576262237318;
 Fri, 13 Dec 2019 10:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 13 Dec 2019 10:37:06 -0800
Message-ID: <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Nov 19, 2019 at 7:45 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> This patch set is to recode the Mobiveil driver and add
> PCIe support for NXP Layerscape series SoCs integrated
> Mobiveil's PCIe Gen4 controller.

Can we get a respin for this on top of the 5.5 merge window material?
Given that it's a bunch of refactorings, many of them don't apply on
top of the material that was merged.

I'd love to see these go in sooner rather than later so I can start
getting -next running on ls2160a here.


-Olof
