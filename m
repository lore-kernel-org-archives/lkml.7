Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF93C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9A020644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2wgrcn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfEHOAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:00:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35980 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHOAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:00:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10so7953499lfl.3;
        Wed, 08 May 2019 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/RecR1rW1Fa0qI6BI1+pt6K3HhV2pBmhpGAgExuqbY=;
        b=L2wgrcn2RiTzWJjzdGGcMAb+4QdFdbfv7w8yr7/jq/AyXXSC1UuRhwj81kUm+XSp08
         /+xIPWJxKHjiHhtkoeviJm508XOZVu+yOEpbrifTUS8Irciqenk4VPkGMzSl+hxZM885
         zpCqTSQvFAoKFMVX+VEGd9oJ799+2MNAJ2rnHJxi9D13GUjGm7aARgGMk8OtlQ1ZCBkN
         wUidMrnLD6uY5Ceb6P2wTPSFwt13gBNrQBZqosMabY0xQHf0g3YN7qKOyarGLZDjQ7C5
         r3urgB+BS7fCu61cRNyEALPsxpwGPTWeL+gBChiu+m1g30t2Skuc01HzijLzYk38Uetq
         ZSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/RecR1rW1Fa0qI6BI1+pt6K3HhV2pBmhpGAgExuqbY=;
        b=im2xt58P5C2BfXG+BYcnXO/IeE2qttf+rF1kKvL0XQG8Ggl2SWZr98IKqacQRqgkU5
         ve3jHwr3DF1BrS5gieOxw8fi/A32lKYJzVSTxMY0tjzBg1F8mFBtWFQ763KoNZ47JTDR
         r93Z6oyja47ltfJRShC8JRjI2X8TLCahyFPSSUg519MIRsI/IsEXXaPfJttVfbgAwf3i
         PzWlZyqLHLib0Nrsq8nHzDkKxfKvBo7MnyvHcLT6nu6lHoQKX8m7B7Y8Yay1dGnJhOM/
         4fHH/NxtmrpkJ/6WpAcf301X6wsn+oFeZWNJZo8bk8f/vdceV0MZFSM0ZwZxGeUoX3At
         varA==
X-Gm-Message-State: APjAAAWZD+vZj/0xtX1EtxGcX0BumpaUx4XXFYi2iLuD3KO4Gq0TunL9
        WfC6/TGCpvBqfJOzDP5aeefxRuGnOJQukqXcll0=
X-Google-Smtp-Source: APXvYqxMDcI05V7rcIBs5a7w8JUvRxFOrjR60YX9s3Rv9Xs80DYwGhyEUHG0vD4vgHhscWzVmIVX7t76kWq//3P6SXs=
X-Received: by 2002:a19:c746:: with SMTP id x67mr20053219lff.152.1557324006896;
 Wed, 08 May 2019 07:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190508135501.17578-1-pramod.kumar_1@nxp.com> <20190508135501.17578-3-pramod.kumar_1@nxp.com>
In-Reply-To: <20190508135501.17578-3-pramod.kumar_1@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 May 2019 11:00:14 -0300
Message-ID: <CAOMZO5C=dAN0LkhbTqCApmhv1msxAC8B2=u6D0gtC2KYV7T-HQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] add dts file to enable support for ls1046afrwy board.
To:     Pramod Kumar <pramod.kumar_1@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pramod,

On Wed, May 8, 2019 at 10:56 AM Pramod Kumar <pramod.kumar_1@nxp.com> wrote:

> +&fman0 {
> +       ethernet@e0000 {

You have passed @e0000 without a corresponfing reg entry.

This causes dtc build warnings with W=1.

Please make sure you don't introduce new W=1 warnings.
