Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27993C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0A4214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LS9R9Sdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfLLUqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:46:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39506 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfLLUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:46:02 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so66211ioh.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyPUkZySLXKgf9TnxUpOyot3YnU8ObDh2XPQK80y2jU=;
        b=LS9R9Sdxzil058X/36VJo8VobbVEGkMn+8e2lKrWNnX0ZwWoWWS/RVEY4XZV1UBYT5
         wPneNbx3H0ThwSxxHuzE+CeXB4Od8e+v5XHcwZOFHzMuh+umqL0iCvZHsV2vWs5kP5cj
         NyU3dRkDVH2rpW4CFkJYN0i8HAff/8TX8yXnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyPUkZySLXKgf9TnxUpOyot3YnU8ObDh2XPQK80y2jU=;
        b=bFoJUlG7tt8R2PRaSVMFtzIxqjTvmYMWp7EAVh5QLF9ry7fIzyrMfB6NKntx0pdi3w
         83RjU56aWKOadj6e8cYUuIX+yLbmqzWXDgwvaGIXXCyhDpp1UmoYwsQX/is8DdMlBpFP
         OZlBemiz/q3PRSCUsuSIjl/bZx3pfalVMgsImbkwDoYKclxnzK5bk7qoT1QfjIFKla1+
         9XqDQB5dp4oPKWvSjB+4aFR1ogfgpxlzVPO92iyFoeARtxfi01fb3KpzIGxJIJyEQCmA
         KQU9gtjfruD7mLyzJOFov4mUapZtKVnt6sctUfDoNhkprX5bBiKRZJ1kKMKucq6WXHKE
         dw9g==
X-Gm-Message-State: APjAAAW2BC8zyutDF5B7Gfajnwu1yQT2nPx3+eSRvGM6Ke+4eXvNAs7A
        itOcCWmI+9UYyQFpAu8xtlr7nuZqMV0=
X-Google-Smtp-Source: APXvYqyZXVUWTGPumvYIfUCtnVUAs1gzSCss7m7/VKWnhLcTDb/7O3AcYw6spZrkJWXE9PEEhcj5pg==
X-Received: by 2002:a6b:2bc2:: with SMTP id r185mr4531227ior.30.1576183561335;
        Thu, 12 Dec 2019 12:46:01 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id h202sm1499807iof.1.2019.12.12.12.45.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:45:59 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id b10so35870iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:45:59 -0800 (PST)
X-Received: by 2002:a5e:940f:: with SMTP id q15mr4341569ioj.218.1576183558931;
 Thu, 12 Dec 2019 12:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20191212115443.1.I55198466344789267ed1eb5ec555fd890c9fc6e1@changeid>
In-Reply-To: <20191212115443.1.I55198466344789267ed1eb5ec555fd890c9fc6e1@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Dec 2019 12:45:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XD2GKPc5qeMakvW8Ej9-y7n0Hi2qAie-gUM=DJOSv6sw@mail.gmail.com>
Message-ID: <CAD=FV=XD2GKPc5qeMakvW8Ej9-y7n0Hi2qAie-gUM=DJOSv6sw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Fix order of nodes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajeshwari <rkambl@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 12, 2019 at 11:55 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> +               pdc: interrupt-controller@b220000 {
> +                       compatible = "qcom,sc7180-pdc", "qcom,pdc";
> +                       reg = <0 0xb220000 0 0x30000>;

nit: when applying, maybe Bjorn / Andy could change 0xb220000 to
0x0b220000 to match the convention elsewhere in this file.  That's not
a new problem introduced in your patch, but it seems like it could be
part of the same patch and it feels like a waste to re-send just for
that.  ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
