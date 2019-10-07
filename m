Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67683ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E39206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slYR0rzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfJGTbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:31:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41532 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfJGTbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:31:33 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so31180864ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhHD43hXAM9SN5EwDRubtVNLyNcRs0uw6jKCE0kbPZA=;
        b=slYR0rzBVighy9wsS87KqHGB1Hi3N1cVtMo4uSO8Yr5GpjOTEsuuMPuVswDb87+5p1
         x9w4g7+DUtvUrUS8uY7tBIUXL1V4cMpaqa5/ITeb5mlN648Ik4k2HqBCyjCaW9gYGiMV
         nvIpUQATjZ1AYfm3fhK3vAXYRg1NggGTAhAPByQ+vbQOaycsA7f/+9F7fhoHcCrTG6Wo
         ZJFDnBzMBZc+7tOHkCTpeobQGMImAiZdtpzTSSUbBsOoVNzkwctkeF343sKr7DPnewRU
         5uaZS/k5IL6EFMK3moKZvHUALe+7pUupGEThYv3rafxSisuebOqbFTJcXiNJutojWi96
         pn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhHD43hXAM9SN5EwDRubtVNLyNcRs0uw6jKCE0kbPZA=;
        b=iDl5ufmurKsCKrjsE26A0jSZVJvhergNZDYlbO/AW4RLapgJhV9bruiwi1t54DAm3V
         DBr7ixXN4LS9qLdP2Zek0A7wZiiruwqCqi6fBpYWz+p3arpzo5RdN2UTeq0y8QTfaVqX
         vzwV3TtzyJkKX5PRtWd7nMypOjROP6VoZAMziWd19wWM7mEIdfPclgT8p8wWY8cnfrbP
         jojZGu2QtUKWWHpqcXf0p0yWrAkcniLPnNLrJQiDbaf1H+L8rH2HM801RnxLScj6Syuq
         hUI4TOtHbCXloYr9iE6DlqWtjrv+qAGRRmtSVddEDT92c/PAqf6uq+2LkToyArswgbcw
         pwag==
X-Gm-Message-State: APjAAAXXG819gMVH6bjL526alt7qqzmeDI/RP6n2oDjylHz8pezSDXLW
        V1dkIyBTqMcaPDjyUy87bbs4HdI/+RznOu4XoDcTrUN+
X-Google-Smtp-Source: APXvYqzckjVc1ilft8G8VvPhGkDBvd534J+RWrtDg2sFhxeMdLxoUi/35pCNvQRY3B7t75p05RtnmurxyTtoRcWTdz0=
X-Received: by 2002:a6b:c8cf:: with SMTP id y198mr21700603iof.179.1570476692261;
 Mon, 07 Oct 2019 12:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191007154448.GA3818@C02WT3WMHTD6> <20191007175011.6753-1-tyaramer@gmail.com>
 <20191007182812.GB13149@C02WT3WMHTD6>
In-Reply-To: <20191007182812.GB13149@C02WT3WMHTD6>
From:   Tyler Ramer <tyaramer@gmail.com>
Date:   Mon, 7 Oct 2019 15:32:13 -0400
Message-ID: <CAKcoMVABYHMTPhHUyU_EvWFUxKPn4sqy-DSEM_vn=ctbkKD-UA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-pci: Shutdown when removing dead controller
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

Thanks for clarifying. I appreciate the comments.
