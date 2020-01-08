Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4851FC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3F42072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LGhwTuIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgAHJ6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:58:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35261 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgAHJ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:58:32 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so2570673iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAtR7WNLGbja1kZFYbC1LM6r/2gOOz73oNIxwZf1sK8=;
        b=LGhwTuIZMsvckUaUhJ+tDGp6Y0jn0LYn/xbxleZUSDMkTwotTTy+1Fg5ZHuiCgbnuW
         ABixaa78LQAMQqSXxlOdTlfDx+n2+WrJQM9cCO+dERP4pTnItxTE5IlWAuVhshqD5D0f
         0ZiCF95TJ+fR3w2e37nT74ePbWYE2y6TFcorU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAtR7WNLGbja1kZFYbC1LM6r/2gOOz73oNIxwZf1sK8=;
        b=iA18eTLhNdjMy3rEYmEJMY+DhWqNB6ApP1/fUjIOGvLldl0CwU/ch+Wv1C+2lGw3ep
         JvzTJOLJcxtEUJ2daX8aDDgeGkzvAkXa5+AeTQTDXqFGBEIwyyj7r6fxwGYGNjUVCDHr
         EK4/cvekipg7kp/oAcmhRIQf3zbMgEcfI10dbydnE33fzJ6Ewvf4Z6Kx1Hq9Iq1QqaRl
         LzXfCvsUVdxjlNEvdbzmorhRrREM9RezY3ZVjpQC/vdOTmZFkVXdi3gp/50Xa8giiBrq
         0l2Xu1w13PXsQtXygWjAWcu0DL96+c8wiA9I7+epoB2AYSD0Wc4EJEdjXKNv4Y6/J8P5
         imIw==
X-Gm-Message-State: APjAAAVsEddOkp+dP8jkQ3pup+UWfVJGdaoUTpdfFqEbRXv/wv+pr4kd
        R9yeTE+Pv/P9qE+mNbZFipZJNQpzLifgnQL88Ep13A==
X-Google-Smtp-Source: APXvYqwH5rufYzM9JfRPQjj7bRhJ6sm9RgJQyx7qvhgpJjalHtt1/UbVPcBLfTvCu23laYbDf4TKavfcetdwMpGEoRY=
X-Received: by 2002:a6b:3845:: with SMTP id f66mr2819729ioa.102.1578477511547;
 Wed, 08 Jan 2020 01:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20200103064407.19861-1-michael.kao@mediatek.com> <20200103064407.19861-7-michael.kao@mediatek.com>
In-Reply-To: <20200103064407.19861-7-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 8 Jan 2020 17:58:05 +0800
Message-ID: <CAJMQK-hQ5BWp7isGDTz_Y4ttxfoM0guqfcAEFrh3Eq7SMcNM5w@mail.gmail.com>
Subject: Re: [PATCH v3,6/8] thermal: mediatek: mt8183: fix bank number settings
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 2:44 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> MT8183_NUM_ZONES should be set to 1
> because MT8183 doesn't have multiple banks.
>
> Fixes: a4ffe6b52d27 ("thermal: mediatek: add support for MT8183")
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
