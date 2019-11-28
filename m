Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE77C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2190215A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574905875;
	bh=2d1ytXs/am1u55JF6Ldp0bRyCRF+PpkRW3cmah9EPtU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0B4FLKzIkNdPC8AvvmmCSzBg/4866XLcfgWs0+h9ppE4nYOKOvsViOvgXGwG7BSub
	 ybZ0+Gxnl0py5Bliw/+43tWt6+UuIUhe/bUbrSF7GRBp4h3QV75EUBrF5FkOMOSA/f
	 6t37Uu+lYY70nc3NAUqks0iVaIXYllPKQSR6UjoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfK1BvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:51:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44981 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfK1BvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:51:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id g3so26577548ljl.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 17:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSpsmOKMn/O48LBUUrQ1uLf4PCDrcrylBzPfl36vaW4=;
        b=HKZjDm8rWodB8EJ++Bfhj8pyIRhnt6rHbi9iLTBmubir7V/H3ot6+UwhKaMf/AE9TE
         otYJAAzZU44px9b6r8FV0elKk5tJD9IFvkCYS6GL1WkiaXlnLrJ+urAUAopY4Jf2o13k
         27w6oL9CloZIsZW87L8ylCgNrRDHNFZ+7Okhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSpsmOKMn/O48LBUUrQ1uLf4PCDrcrylBzPfl36vaW4=;
        b=aZl3h3LpJzOdnyiGI7hKP1CBhkZ2TPMGTy38GyqCkQ7m4FoH+JaWMwo6tFKVoCtWk+
         EqMa1OPFRaOKNZrP9mZ2DjIQK8YraDjhgZPV4zCWgjc0Ta8nQAVslSLV0Ehqs6Je4x6R
         ckxeqUKjbS5gL1/PDmNxwfqA1qIs3gFxnjZhXuJmCYXrCVcusciNz2VHDcZzdrDn4+cp
         6+EOIlmhIlAQmG3OEhSwjREh2lMHayyzjfZhMuONb4/VD/UnvpqSjrkoW1c4vgO5GjLU
         /0OXNaeh4ENy8DV+xHxrl2aZmTwpD5z4LXapTDWlsc+K5gh72+yyC0aZfUMx2kWJYry/
         SYjg==
X-Gm-Message-State: APjAAAWKYT+ibKELB3LuB/A1bDhTGt4ndGDtt2lMwxuP4tZTwv8pGdSm
        XDkAIq7HTMaNEijktDd4cXKHTZiyPX0=
X-Google-Smtp-Source: APXvYqwg4iNpIgGa/Pp3a9eGOWZlbpxrY0Lwl/MJU2ku1DTFXE5H/zczpnA2X5UuV75BHIiPl/v7fg==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr302517ljj.114.1574905871864;
        Wed, 27 Nov 2019 17:51:11 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id x12sm601322ljd.92.2019.11.27.17.51.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 17:51:10 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id t5so26646215ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 17:51:10 -0800 (PST)
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr21585112ljh.48.1574905870426;
 Wed, 27 Nov 2019 17:51:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
In-Reply-To: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Nov 2019 17:50:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdhd69G1AiYTQKSB-RApOVbmzmAzO=+oW+yHO-NXLhkQ@mail.gmail.com>
Message-ID: <CAHk-=whdhd69G1AiYTQKSB-RApOVbmzmAzO=+oW+yHO-NXLhkQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.5-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 4:59 PM Dave Airlie <airlied@gmail.com> wrote:
>
> my sample merge is here:
> https://cgit.freedesktop.org/~airlied/linux/log/?h=drm-next-5.5-merged

Hmm. I think you missed a couple: you left a duplicate
intel_update_rawclk() around (it got moved into
intel_power_domains_init_hw() by commit 2f216a850715 ("drm/i915:
update rawclk also on resume"), and you left the "select
REFCOUNT_FULL" that no longer exists.

And apparently nobody bothered to tell me about the semantic conflict
with the media tree due to the changed calling convention of
cec_notifier_cec_adap_unregister(). Didn't that show up in linux-next?

Anyway, merged and pushed out,

            Linus
