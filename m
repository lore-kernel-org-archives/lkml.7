Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B58C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5B2217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfC1IEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:04:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38503 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1IEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:04:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id q14so16347327edr.5;
        Thu, 28 Mar 2019 01:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YEN1kN4WJaqjJixV/q6wuTezAYQ/gVc9lpOqCf/XuM=;
        b=YtfmF0b/tcYOd5rIoY/f9rkPzEskmyGjektnM5wr5GVzKNKs61rMfsTaYFf9fVi0Ux
         pOK4MsRNeMZsOGzvkgzDwfLRZG7CcooOLdqNQUfCJobQIPP6E67bHxYh5VcFs4HdBukh
         7RKyRzFbfNmvcNoKIbwheU6pQWTsrsquQwOMXA4RTjDnuwlzhzXwcRb7wnBK1AV1Bn7T
         BmAnGNpp66WEhh/PgMfvGDOgPPFXueM1eGWLi52cKC4I8tkZOE0l6emEotMI1RUmbPSr
         SqsiiTry9vN90wftueegYefllLFZg5UR11i1FET5w3d5xcJk90T8nK0FhbxAyuXzGlqN
         NNPg==
X-Gm-Message-State: APjAAAVW1YPsB3ZyHVtlH2VkVVT7tLOkhTQemumzfzxf4xF2qs3FQ+dd
        uU73ry2rOkDx1B/l5Bik+EyMsJ6LLA8=
X-Google-Smtp-Source: APXvYqwRTQD1qzh16jB8u6f6c44hBzcojOZNDLyvk8/8lY99/TyCah4obpkEb6ix5P6Glt9PnPE9AQ==
X-Received: by 2002:a17:906:18a1:: with SMTP id c1mr17574726ejf.116.1553760286963;
        Thu, 28 Mar 2019 01:04:46 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id b17sm254282eju.64.2019.03.28.01.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 01:04:46 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id g3so18123924wrx.9;
        Thu, 28 Mar 2019 01:04:46 -0700 (PDT)
X-Received: by 2002:a5d:458f:: with SMTP id p15mr27500596wrq.188.1553760286032;
 Thu, 28 Mar 2019 01:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190327004837.10384-1-megous@megous.com>
In-Reply-To: <20190327004837.10384-1-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Mar 2019 16:04:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v65AzPpMSWwYuJ5ZOvZSC1pHftxStW6K=89qFV=qsHncUw@mail.gmail.com>
Message-ID: <CAGb2v65AzPpMSWwYuJ5ZOvZSC1pHftxStW6K=89qFV=qsHncUw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] ARM: dts: sun8i: a83t: Add missing cooling
 device properties for CPUs
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 8:49 AM megous via linux-sunxi
<linux-sunxi@googlegroups.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> This is inspired by the similar patch for H3. Original description
> applies, and is copied below:
>
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
>
> Add such missing properties.
>
> Fix other missing properties (clocks, clock-names) as well to make it all
> work.

Could you split this out into a separate patch? It actually touches more
lines than the primary part of your patch.

ChenYu
