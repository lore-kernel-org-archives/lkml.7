Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB05C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95C620848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okdWNIyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDMOI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:08:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44426 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDMOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 10:08:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so11408195ljg.11;
        Sat, 13 Apr 2019 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKT5GB5Ghpf/ZMLx0SwtFWwItbPP0uzf2UO8u/I5zR8=;
        b=okdWNIyPAszQjnLjZC929pHbomgf1hcz/Xr7CleHvxLAHDvHLDpD2z7cEk692iWDKh
         8HKAWjWU4tDJuggwkZys8uC6pNkP38dxRKRxY2er+blwdIbDV5lu5QuMGQFZVDhBiVlE
         XEcAPzeEemHsnrpJdHJnnRDdepucuUkeGMXn9AUCEWjQGFVVVqocAwNc0wcFurnwry0c
         2NYD4ltHR8G7SZkedyA1IG+ANq9o/PXPXY9OsyJuC1eK0qkFJufUX3WXvm8GPD014q/Z
         39flAINqK59d5h+72Z6bjphcHwFz31JWORBbJ1VJ1nHHnXZ2BYTIbbuYiHOaSXkq9jCY
         NuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKT5GB5Ghpf/ZMLx0SwtFWwItbPP0uzf2UO8u/I5zR8=;
        b=JHDxdytPT2AaMJejG1ZQaQbnttZcCI/YcW1YvAqlx9EONwO/V8u01ZSPdJU4M06OVb
         SoZcn5pJXfkDdCUmDFJankuPMBreRm3NcgVFLyWxrq3cGne4lScNOFItnb0n76Ubw3nK
         irTKRo8npqes05EQr/IlWO+xE7nJicBLbVr1VdTKsbLaNs1QQhh+WVzjZiftXVMtYfp9
         79OteNg/6eZMiw3JzWGZ0RxQihDnx3KeR1x2wvIUsXydgU5jTpTt6+QU/a56NocfCZm6
         Uec3gw5+Yzge2YYqfKhBrORyCtaCOtj6saSMph0QfR0gULw0VpO0V5RbXsxWzJpbLZ2K
         Rmfg==
X-Gm-Message-State: APjAAAXl3b+AoA6VpUvrvNMrQ8WVCKtnuQrpZ0/78qAy/HFBl5Rlt8K5
        6f6witab+4LxsEnsH1VhSFBIsUmM12wu2gtwiz8=
X-Google-Smtp-Source: APXvYqxn5ULx8bqG7TcsMr1XWpAMloBZKNXEiRznNnEGBKn2IVZmDAQ8ptJ5iu+8CJbDITiyInqFcdDysEgl159oFzo=
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr13445450ljj.63.1555164506269;
 Sat, 13 Apr 2019 07:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190411065440.GB26817@dragon> <1555161577-1533-1-git-send-email-kueffner.markus@gmail.com>
In-Reply-To: <1555161577-1533-1-git-send-email-kueffner.markus@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 13 Apr 2019 11:08:25 -0300
Message-ID: <CAOMZO5CbZg9Q8Ms9tXWL=8Q6hOfcJ4nRkHa8XV=hn8_psX96dw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-udoo: Add Pincfgs for OTG
To:     Markus Kueffner <kueffner.markus@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 10:20 AM Markus Kueffner
<kueffner.markus@gmail.com> wrote:
>
> Add Pincfgs to enable the i.MX6's OTG feature for UDOO
>
> Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
