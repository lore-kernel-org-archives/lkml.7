Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC5AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516620869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDQF0/6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbfDRUOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:14:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41611 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732589AbfDRUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:14:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so2743862otb.8;
        Thu, 18 Apr 2019 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkOWSxCvCXN86Kl+6Ht/zzIVBNleGn8HFGz0E6FnAOk=;
        b=sDQF0/6uFVhsKOec1aDEx03vO47rjmRPpEDC6EyrVBPN4iu+M9lpGdy0KmK/44B6mz
         GvFWsx6eLvIdCDNRbN/KFrXiduKOkU247ud6OUTvY+gH+n6YJNrHt6OK8WxPokweJjBg
         pt/fqQAcDrtyKpW05DXrBPQdthoMsvneW4P9Ykp4VUBdsL+UFm5rUHVhDG5eHTjYSRwY
         ifpyG0cJ31EdbsyzXhs2uC5bU5NzC7rlfF9dGFNP8csSCCjCGb4AJyYlVr9LjNlC07NE
         kOaxmoMqsa0outYJ8dpTOHwnAY2L9lmLrxXxgwuvVpGxOIHHsVKOoq5/qcPP1yXARil9
         Kt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkOWSxCvCXN86Kl+6Ht/zzIVBNleGn8HFGz0E6FnAOk=;
        b=LmOI4jLUQbXjXCEwgHVWNeJRq744wJwwajQbhQ1rqumdEM9P6l6qig87pbLvfaRixB
         czE/IvQ2asXrXi27MT5Xp15x+WTl+4W+bjsoUjf356HgOCRihy9+Z7s/51dABcRZeW3f
         fpUut6N8jeqm5JKOtOg6S5xCZWwEOM0xpF6MBTjkdtA2dQqmj0eH+RjUkXDLLsb+/NY2
         qwgcpVX5/s/yiABk7LGBHHcRRBVz1kTymtM8jgS4CCh7beatHfLnUYxKM7iqLYOTdXin
         Eg2dwDxt1AXUyd/wZAiEM/TfsPP6W3VEfN4BnDxSabURRiVpw9/4VQUmTPg3594EZDFG
         W7ag==
X-Gm-Message-State: APjAAAXYvEwnWxQnC3qUnFQ9HKpwyO4Dp+jnNCgzPfgsEJ9E+8U/lqlw
        WFrnt09O3Fvq62bLVvlhA9XPYSIiF3Ph9xmNY5U=
X-Google-Smtp-Source: APXvYqxUT8MHt5wHF1cUkEfXT0YGG5Ud4Pz6WEJ20lcYFjzU/sDNcaCQ1z4g3ANOzQHIupSxPIzVp/cNMXwF+QG5/G4=
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr53591499otl.227.1555618485555;
 Thu, 18 Apr 2019 13:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190418160430.325165109@linuxfoundation.org> <20190418160436.162514132@linuxfoundation.org>
In-Reply-To: <20190418160436.162514132@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 18 Apr 2019 21:14:09 +0100
Message-ID: <CADVatmMYbPR2c2937DXHwJDy+Ve4ny47QVJDdbXJR5ftghyS6w@mail.gmail.com>
Subject: Re: [PATCH 4.14 68/92] appletalk: Fix use-after-free in atalk_proc_exit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Apr 18, 2019 at 7:25 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> [ Upstream commit 6377f787aeb945cae7abbb6474798de129e1f3ac ]

This has been fixed by 27da0d2ef998 ("appletalk: Fix compile regression").


-- 
Regards
Sudip
