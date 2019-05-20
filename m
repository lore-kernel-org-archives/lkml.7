Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD603C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AD3216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIgqA34B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfETTeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:34:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36218 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfETTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:34:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10so11224211lfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9ITMxVND7TQM+g+6pEVeU/JLpge3jRTL6p4c69ICJA=;
        b=OIgqA34BopBfqQiofsYsrtjbOBqKE9XZqviEiQ4QLuwdx7FX9ZwxnQqc4C3mpSP3/l
         SknMDrdaM/Qh4g9293/juFm7089elMIr8qShFuk9+MQWh2ajzMfwYKtKlq5wDuSikvV5
         LM1NgKzW4jSxLoDcqR5HYf0b06m3J4U2/uqV8rLbEwnc7yBLmJdeP4cvkGM1W4CiWhcK
         zQdaQcd1Azo8UIfz7hYNZ0ce4Di5MWVX24I1S7u2j9nmGQHwdDAcLJ8PbcQv8wHd8R7c
         b1bIZGJXrRkmKl3pWT1yjoDjCXQK3TpCmOCdPzXB5Axwa5/knF7QC/cwOV73gFMWhfs3
         Inyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9ITMxVND7TQM+g+6pEVeU/JLpge3jRTL6p4c69ICJA=;
        b=BfZlLBfJXNRRtRrsA0Ilm/qz1R/GLZISP8NERKzB1uCE/15EQ7OoiIqasxk7b9wMKh
         giYlDBMCOo3BSGAbkfWH9/OkzbjK0tELikgRJo618ueLguGq+Ipe9mk/gkh4yDMoB1UE
         iUH2wYy5lyHWE9scXPzBnzr4R3nHtan2+QihNN1/QE1E/29utaoHxr1bjENG16ty2Zhp
         iNVuzzWQgm0zV2qTKlq4zy0RqJgoEKngG+svErrSDHriEqH5irVdwdHd2O21HFF/sedg
         5tux2S66f18kByuu8SbPsl+cOGGSZEyA9OgVMiT/iEZer1lYfggMe3Pi1bC4i4ZJPpH4
         Cm1w==
X-Gm-Message-State: APjAAAWnrKTWvme1lcpW1tUL2JM6mFHJe35fWNbvuO1FbQEn59NitWZ8
        wmpijM7ANRI9bu6u2Qm4TjctSUWuW8TouThFa7c7aw==
X-Google-Smtp-Source: APXvYqzjWakqyKEkbWeUEdXLhk9w1xj9/qqW2dtreRWsh05HwyaQVBgbTpHlrHFel0iQl/npRvFqJ+PqJOlZrXDexGY=
X-Received: by 2002:a19:4acf:: with SMTP id x198mr36952093lfa.7.1558380847567;
 Mon, 20 May 2019 12:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190515144210.25596-1-daniel.baluta@nxp.com> <20190515144210.25596-3-daniel.baluta@nxp.com>
 <CAOMZO5A6Gv5k3up0AtKrhQPyMLMe_8SXift68KEP2J+j8D_cJg@mail.gmail.com> <CAEnQRZDazHW173hzERz+RiOAsiRQNVNOQihz8Lz=+Bp5cZzgpQ@mail.gmail.com>
In-Reply-To: <CAEnQRZDazHW173hzERz+RiOAsiRQNVNOQihz8Lz=+Bp5cZzgpQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 May 2019 16:34:03 -0300
Message-ID: <CAOMZO5BaviYxv_9fmEKxhFNZbvCZSBt4qj__OOiBFvxMMvd5sA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 7:12 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> <reduce audience to linux-imx>
>
> Shengjiu,
>
> Can you help me with this? Specifically: I couldn't find the schematic
> showing the
> exact connection pins between SAI and wm8524 codec.
>
> I looked into our internal tree and the wm8524 codec always handles
> CLK_SAIX_ROOT
> but Fabio has a good point. This clock doesn't feeds the codec.
>
> Unless, we can really look into the schematics and prove it otherwise.

Yes, I just checked and the devicetree patch is correct. Sorry for the
confusion.
