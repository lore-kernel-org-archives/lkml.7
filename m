Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA24AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A608208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z23mfVUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfFGV0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:26:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36530 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbfFGV0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:26:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so2950967ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6sGj4udjdudlOgOeP/H6pDDZcmuzFdAkSUlLYTz7Hc=;
        b=z23mfVUe0uLJ/lnbrCPAfFLlJoZeq+fXYSy3t319XR2mXsJF2HJBlsHc72bDowYPbr
         BKlcfggdOUpnzKEOcmo/gWDJBafNeMAp2aw7/FOy/CEMhLhZAkJiqltxY9gqYHhdPADe
         LWRluJiEIcw2pJBdRmdTdrAVM13WBgOAg9klKPj6zLBbvJjcvG0SF3UGpq5K05+1nydQ
         YVvrkZaXl+tnN/7TgP1T8xCinH9HAqs6lCo00edbK7wHMvW8WMzCuFvKYkfX8GduJi99
         j0wanfih+iwQg+9v0kDSq7XaxRBoHZrhq0vIpY4sKoaShnKX2Gdts7XNyc78ZgcYCS/j
         ih7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6sGj4udjdudlOgOeP/H6pDDZcmuzFdAkSUlLYTz7Hc=;
        b=E5hob0NtPhp9DiRpcqICc7nTOafW/KvplvyFl7VvVYXG44rvGl8eFkdfBfOguYBmtJ
         xhW+ohoLxdGy/KNp+xSk1l0HrpYw8rF5hrqitLmwXuvU6tfLHMPIuKt318MuhL1tjs8k
         90xp10bNg3BRykQDBnZnQUqShUnl8VD7ILLlo+IKa/JOCJfkti8b+hSvjhGkfZA5zWQH
         T6TpRwsOMQ+QV9d+2KMgL9OVeUL+QmjvDe6SWvMIJh9PLdo0NT3gsC5Ee3XvAM2lKMX/
         djSzoV7T+bgE0eqYcdfpx91upACcSQJfONQxbTi30FhXTjVXR8IFREpDuaIk/L7p9Abe
         xbMw==
X-Gm-Message-State: APjAAAXXfdUHlTqpc13Yn9MvJsFAcX00l7GrOmf/0QLYxqQW1hw3+EFg
        5xrDxVxruCgJWZp9L4vpaXPsyQzLL4b5eNUMJcBuEg==
X-Google-Smtp-Source: APXvYqwIajTpMSgCMZav18YPN+TlLmExrYklafV6rIWWxNFhS1pNAPS/UUbCntmRCn13SfjJkYCmG7CoaruMAno9FuY=
X-Received: by 2002:a2e:7508:: with SMTP id q8mr13158846ljc.165.1559942813429;
 Fri, 07 Jun 2019 14:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190604072001.9288-1-bjorn.andersson@linaro.org> <20190604072001.9288-2-bjorn.andersson@linaro.org>
In-Reply-To: <20190604072001.9288-2-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 23:26:46 +0200
Message-ID: <CACRpkdazzRV5XydKHmXRQiU2Mx+=HyRgNCEpNqsOsCdycXmMOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: qcom: sdm845: Expose ufs_reset as gpio
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:20 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> The ufs_reset pin is expected to be wired to the reset pin of the
> primary UFS memory but is pretty much just a general purpose output pinr
>
> Reorder the pins and expose it as gpio 150, so that the UFS driver can
> toggle it.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied.

Yours,
Linus Walleij
