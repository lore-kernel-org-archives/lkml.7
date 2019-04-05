Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE27C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3721852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRHdnaFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDEN1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:27:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45128 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:27:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id t15so534646lfl.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/S9ER+mMybWHdrmSHFBHrML8i6W0dz5O78OM+5/knRw=;
        b=YRHdnaFWUodEuWeUARP+rCdwZq8XcbPwq6g3QPYEnW2NWNSY8HvzUBfBZ2EldlbzvE
         atkdXtwm828V1OXDc3dGTHImD4wISmIlN8Tuz5unD4PdcE5m5M+yrzfNT45Cat765zKo
         Poewd9j6gEC1MKEQ7GH2VLsz7AuvVpsPzwKXklWcgR8xnTa5qh17lX9BUvBOPBWtJLJ7
         5+ub6EvUDXe50QS7/gF++BCk2FlTm8TSDZa2v/SfXgN9GikzqIwv+S1R5kN4q4oMm+5+
         p3/SA2sa6rWIpbFVDAvILsyWZRfGemNWREUK6SV6eZrJ6rWUv4hUGL3FXjpoUGNOeHET
         wYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/S9ER+mMybWHdrmSHFBHrML8i6W0dz5O78OM+5/knRw=;
        b=olJFQABt5QqIkLjw4ajG8PwWKpmuJiUgW+0rADNLrcU8LICNyqq+5CJBaGpQtUh3K2
         oMWQBGz2lAkHn3JGI4JF/lWqQnpcTvkDqfTfSVkJEVX0c2mgyphMPZoJOwDEeSMNkZA/
         4bL76lzmCYKdsmrf5Mbf1ArGUkQ9lILtGz/AeJlLj4Izmg06T1wr1IdpqeqAXR6N3UpN
         Dham7jfmmgtr+Bo1h2WVwy4Hf0q9/ST+n8bRN0OktwPyT49pmuw2uoGO8n29LoM3yT4a
         t3nJJw6vELvmTQFCl4dOn7g/WjdKzOBonbyFmWZvjgWei7uYjpPxNovhNF+dpllXJrgl
         ulvQ==
X-Gm-Message-State: APjAAAV0YQDJ3/2Zaf2BrRFRaj15cWkvbSjOiT1j/meZ+1LDp2PwvQ5U
        NdmIRRsl7foGJ7jTgU03SelV9BOljjsm78K6nNg=
X-Google-Smtp-Source: APXvYqyQxeNzbKtqpj7/NPLBVJQZrRZSeOLzYPb/XlFGrzcjjerB6SdvwGPfCDCLEBqsNuxHHbJhTuydaUEBqoJP00g=
X-Received: by 2002:a05:6512:c1:: with SMTP id c1mr1918814lfp.132.1554470820773;
 Fri, 05 Apr 2019 06:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-3-andradanciu1997@gmail.com> <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
 <CAOMZO5CZtJq65iUDN2Ao9zt=0_L0iXy-5eRCrHAzQb+3s5rxBA@mail.gmail.com> <e3bc6c00-d88d-d30a-28a1-a8c4e520ec5a@codeaurora.org>
In-Reply-To: <e3bc6c00-d88d-d30a-28a1-a8c4e520ec5a@codeaurora.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Apr 2019 10:26:49 -0300
Message-ID: <CAOMZO5Aa_z5V03hYG+=A2zgMNKU5kEPHU=uYH1v_6VD-47s9kg@mail.gmail.com>
Subject: Re: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX identifier
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Andra Danciu <andradanciu1997@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, timur@kernel.org,
        Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 10:24 AM Mukesh Ojha <mojha@codeaurora.org> wrote:

> you mean all lines to start with //, does not it look to noisy to eyes ?

Mark Brown's recommendation is to use // in all the initial block
lines instead of only in the SPDX one.
