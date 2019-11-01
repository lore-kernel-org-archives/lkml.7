Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FABC47E49
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369832086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="pZeGw3P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKATEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:04:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46753 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfKATEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:04:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so14210271qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhqExbZh5kPvj3K4NZnoOcF081VOsziHuz7IlqtxrcQ=;
        b=pZeGw3P0RHdQki9K0gEObnP8OHglDuZpmvPq+OFKsU6xgeQL13BnAHlulP/AXJaNhH
         ZwTok1P9GNkau5IjixzgvwHoRsMHZDO4mQHl58gONYUVmICu+ICmGAtlNEveE0COrV9y
         /Xa/uFFqFErQaCPkaMjXEPyOF3xZXKviJzxY5RswiEk3RU1cFRsNAAq86vhLr+M4iejN
         DUSzb9XHpmVLLc2pvB9NkEKqyofyX55556V+I2ArroDUo1pUEBLty4g6IEse0WyTjh8w
         PDU5nOG+jTcNTKTvoqF9nxDfT1BF6OsABjs+f7dv3bSZ1ICuWpkn9uNUWSuindYPhE30
         ehAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhqExbZh5kPvj3K4NZnoOcF081VOsziHuz7IlqtxrcQ=;
        b=MFPoml9BkmyWJMRxj3HpUzrciDmPZl0MnzzyAeG11uU+ZSPLCIMsYBOHu90HNU8/ng
         qGWRPE7NhGMC/SZqeSDlu2ygVMq1YXz6x2mp9FCPK/MXaqpzuiC2F1GTg2FQ2f7i+nlX
         gem016MNmhuzJ0R4zPjc522QYnOwa3sH+WWpve51wfQAneKPEWbXZpJ/GzNcJMtzUDFl
         3bgogC5tWh94D0voohNaNg5bfg1P00/4g4wnn/kE7ZmY2FnC+I+qNSq99WAY2qCFzpRS
         26N4Ip4wmpfwkOvmgf8IepvDjdxvtCzurZhbS8jsvk1eedLodOXE/sBOINDFR6rqUnk9
         UFFA==
X-Gm-Message-State: APjAAAXg0+lyCGOA1MuNAjndMEumQrPVCx3kuvTKXXpsz9D97R1pp4XW
        K2ivDRAzh6KZ7sXTLoqJ+WaoFmY7r5PFS2pdvDCafw==
X-Google-Smtp-Source: APXvYqzaVfaVFf4/E1qtu06OCKxRakja8j6eb7eFWaPT90bJMEaqpKJybo0BQto3pfGWV02Havz8W/MP/51N1VZFBBk=
X-Received: by 2002:a0c:c392:: with SMTP id o18mr11435117qvi.75.1572635077831;
 Fri, 01 Nov 2019 12:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
In-Reply-To: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Sat, 2 Nov 2019 00:34:01 +0530
Message-ID: <CAG=yYwmYCLOktQxhsyjarybbR+aF2Z3RuXVj4hfE5wD_6nJjNA@mail.gmail.com>
Subject: Re: PROBLEM: PCIe Bus Error atleast
To:     ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 2, 2019 at 12:15 AM Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:

> But i think when i tried again today i could not reprodu....
i do not know why, but now iam able to reproduce the error

more details follows
---------------------x------x------------------------------------------
GNU Make            4.2.1
Binutils            2.33.1
Util-linux          2.33.1
Mount                2.33.1
Linux C Library      2.29
Dynamic linker (ldd) 2.29
Procps              3.3.15
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.30
Udev                241
------------------------x-----------------x---------------------------

$gcc --version
gcc (Debian 9.2.1-14) 9.2.1 20191025
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

---------------------x----------x----------------------------------

-- 
software engineer
rajagiri school of engineering and technology
