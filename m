Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA31ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4290A218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="DPl0z3hl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406633AbfJQC0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:26:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41183 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJQC0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:26:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id v52so1286043qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYYIz0DpXt+S96zKsPkYJbopZGRxz9flW9WuWLOogaQ=;
        b=DPl0z3hlFDrtFfUjhG/QNSp37MnO5lnNjz+RDVaYKEe9dx44OSQaiUs6jPgU1mlu+d
         GQCin+43NLsVlgi9RzYf+tI/v8b9tJjEPefiv3E2pYhpEp/PDLCDXOXBc48gTlgbGATs
         0ZDFck9LGWXjDpiuxxN/KMfjk2ALdUgI6P2xLFRdBBCRKSkvrBWX7rxWV4d6qXRxf9Un
         z2b5jV5twiUT24rOl6BJCgI1A0bAXsL8BSPuzwFH2MSOD2QVZaGw6E8KNPIHMd+IFlV4
         mJ+1OEqgH/WqxY7vxSTcY4bGsgAVXkaOtc/BstJ24QyN0sm7QAWaa926M5fJWb3OLiC5
         Dd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYYIz0DpXt+S96zKsPkYJbopZGRxz9flW9WuWLOogaQ=;
        b=Bm5p5inp7iehC/e3+fodIdRdCXamdxjFjS7tH6jHvyR40B6G8BbKuFBpNsiy/prNwI
         EEDvWA/slCp3tWjzJ5/iSd1621dk2oD/K4FYbw6dp5bQPSI7kEZBr83pkkF6W76P4dTz
         9wWSfG/Cgh9q0a8UP2QHIY1X7aPKqt5gmV7NzgxIScJQv6YJkmIGTP4Z9OvSyqRsz+Ii
         9NPdmBrhOImP2lrxh36HrL8KNFRr1vhFn0VEOS+vm4YmfjdkBpCHEqa9ppj7RSRJymCu
         7XsVC63Rkbl0B9G9B3fatxBrfJ2nVfaT74Avrb+JLvDTfQOLciJEebBTXFvxtiTv1uuZ
         mPcA==
X-Gm-Message-State: APjAAAUvrmucT9luQZwqJzj5MNt0xOeqlh+9VXwxMN7HYIl3Ed+iup75
        fnDZ+ibmGiAjMEx+El8O+BE/K2GjrQsY6rALYyyZLQ==
X-Google-Smtp-Source: APXvYqyQj2ZLctUSSL3V9JNUsWb05JdfRipaPfh6FHbT8hGhFaGCyPxwpFtBc+PUDLv4I6g5Tcjv2ImmCdkpX+suV3c=
X-Received: by 2002:a0c:c792:: with SMTP id k18mr1397138qvj.154.1571279189073;
 Wed, 16 Oct 2019 19:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191016015408.11091-1-chiu@endlessm.com>
In-Reply-To: <20191016015408.11091-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 17 Oct 2019 10:26:18 +0800
Message-ID: <CAB4CAwen5y7Z4GU7YgpVafyGexxaMDLzrZ949t9p+LiZ9TxAPA@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: fix RTL8723BU connection failure issue after
 warm reboot
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 9:54 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> The RTL8723BU has problems connecting to AP after each warm reboot.
> Sometimes it returns no scan result, and in most cases, it fails
> the authentication for unknown reason. However, it works totally
> fine after cold reboot.
>
> Compare the value of register SYS_CR and SYS_CLK_MAC_CLK_ENABLE
> for cold reboot and warm reboot, the registers imply that the MAC
> is already powered and thus some procedures are skipped during
> driver initialization. Double checked the vendor driver, it reads
> the SYS_CR and SYS_CLK_MAC_CLK_ENABLE also but doesn't skip any
> during initialization based on them. This commit only tells the
> RTL8723BU to do full initialization without checking MAC status.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>

Sorry, I forgot to add Jes.

Chris
> ---
>
> Note:
>   v2: fix typo of commit message
>
>
