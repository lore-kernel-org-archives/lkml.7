Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0625C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B8C2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcl/2T1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfDHQ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:26:25 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:41157 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfDHQ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:26:24 -0400
Received: by mail-ua1-f51.google.com with SMTP id l22so4499058uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNY9yXwINS0GCYfY4ljZK8M4WklQnQa/v1KKWj/elWo=;
        b=Rcl/2T1ZBTSgjCuWIkxytaCYa3Eg/N8WE7vujyL3W1nel4H6bGBeXWtQT4HMA1ma7T
         Wkr4jvLEBQtEPAQjjSSqCMYAs+L+ofsw94aShTv7rYnObC1Ic4WkstECd8cbrLoB4E2v
         PmryNJg9t2IOJ6vEMw/0W33XO0mwcc5+rTSs1j38AbpZDleTNJn4CuTR1uXDRjDo3gSA
         0k0Tyz6k2YS3ZLirnbCxlryg0AgwId3Rq76JQ43vv8oO/zxsCQ4x2ao7ABY4N9/Rfe6X
         hmup/dIMSbdmOdbSjfA8iMAxQKGQdvbCrzzD8H2f0gurJ8GFodZMG4fPdTfCCdHTR5t4
         IhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNY9yXwINS0GCYfY4ljZK8M4WklQnQa/v1KKWj/elWo=;
        b=AdP+xdKpd5abo/T6Mwrbz2dLhDXEqAgOLx/gepNdSY0xE+CgUOJLkxw/cF+E3eo00u
         SZcaAI+v4FgdWy+BhEek5QrFrOWY9L2DBVZrsy5y4GTrPn0Xlzb3Hpw/WZjb5eGnmLCk
         em4LMWebrQMxkyxEXHDL1byFrgX/ARjqEDb05MYFbDtD11SfqnFKfBj0vTg3uj+kBYfn
         hLEcYQJW2jwP+tl5kwyUrCVVq0J0MtGVXde7J13TmndaI8z+4JSoS3HxHx1WnNeHAdi7
         Uw1v4ErNw3n4CnFq3XNBqxmja6rwREQTReJgQppL46Mdzy17GtBCBvyzZVx8j3IChg6B
         EF/w==
X-Gm-Message-State: APjAAAUTvOjH5omSH3TwUcBBHzvEcDkoepr3z6elve14E84zFBNPGzp2
        iVu8MJToiGu1WXZo78g2fFRbwhKI87WabTHHU6k=
X-Google-Smtp-Source: APXvYqyvtN+eXKL9hugbTEuqErqkptfO42prTjg/TE03+znZc14xHdIzIb9pHNe2B4bSCxa0VjTw3hqpL7J9BlFoOkI=
X-Received: by 2002:ab0:7316:: with SMTP id v22mr15479203uao.90.1554740783484;
 Mon, 08 Apr 2019 09:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190314032047.15790-1-vichy.kuo@gmail.com> <20190319153114.GI59586@arrakis.emea.arm.com>
 <CAOVJa8HSB34ggku=96KAb6qju3G5-uGYFxCE6O2eQRMwU4bd1A@mail.gmail.com>
 <CAOVJa8Eefs7cEneNwV0VCrr8GLVb0AweJEb0Qo4TucgXTNuNWg@mail.gmail.com>
 <20190401153810.GC6884@fuggles.cambridge.arm.com> <CAOVJa8EcjQO2GuojwBxfFG25+T-z6BR6ytZBdcV2W2XusyW08g@mail.gmail.com>
 <20190403172429.GE17500@fuggles.cambridge.arm.com>
In-Reply-To: <20190403172429.GE17500@fuggles.cambridge.arm.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Tue, 9 Apr 2019 00:26:11 +0800
Message-ID: <CAOVJa8HuGFa7wwWW2W5pYaNxri9XP131DXjwox8cWMq_prXEcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] initrd: move initrd_start calculate within linear
 mapping range check
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Will:
>
> Maybe, but I don't think we've seen a patch which accomplishes that. I think
> I'll go ahead and commit the basic one-liner, then we can always improve it
> afterwards if somebody sends a patch. It's not like this is a fastpath.

Sorry for not showing the patches I try to explain to sir.
I will attach v3 patches for ur reference.

Thanks for ur kind help,
