Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCFDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8FF20989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557377150;
	bh=u3QW9vBYid5Ezravg8TbV4VSKrkB0Jh23puiUanQIHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sks8oJUfuLtQg4t5PaqHn2HupcpCUMW0DQNdwzsD3vO6+cvSt+k1YXuvbZ4zKdyA9
	 dr9JFVa4TwiUiJqp+1Nq378AqJIXnQo7bwYVKSWF8Ivmy4u+SWWLSKcOhJVevArTrp
	 FFEKcRUnxDko/0lfFJbu12iXVe7W6/VFYbBZDwIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEIEpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 00:45:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45085 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfEIEps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 00:45:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so775581lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 21:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQ3ahBtrby00WGAyZWof9Vlr6BSMHsqFyhjQEamJnzE=;
        b=V1aIeV7NQDjmmXhVAKkywYFX6AKTuO6do8R9nS8zNOfezCIDk7mpi1oKUNpvDujRq7
         9tjfCPAh139UsCgLmGYasz6j3iOgjZuAB3H3fmE0Yk9elQxT5rGKkCd7f11W8OqmGil2
         BNo+a22azdGP+taAkZXgH3LYllXbknT3A7PHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQ3ahBtrby00WGAyZWof9Vlr6BSMHsqFyhjQEamJnzE=;
        b=XJ/X+6X5UFVGPaCVldcLChSXa4LSiVgaAdEUeDTbNeOMfencwWlMB1GR0A2AOL3r0U
         XaEzKYoujr8jn1GUJJGBjhJDIJy1psWanRWKTLbVLu+5uXQDoY+q2YwKmKSXaxRurwHN
         52/y95sfFNGkuviiJS5DrStWgpy58/CNRYg4fvpeOL7+ir9yuWPspRqvZcnZYoFdWWMJ
         y9xe0tJ+6inNx8/Jgd33LQeEWi3fL7ivWAQ6WxQTAEsuRR1bS1J4lHB/sH1iyiXQrbIu
         ch4kvu1mH0CigXSgGkZY2ZD0eEJl9VlJhOyvzgPXEtmlgTQVhL8f4JSjXZ4UpDJRPegl
         n2Jw==
X-Gm-Message-State: APjAAAW5OMEwRMVsGR52D/Feu2GTJd7extpRIrg7aK0hAvi6D8C+fwCu
        5c3vQcttdg5QIKV65EAbwJbEWHkl/sE=
X-Google-Smtp-Source: APXvYqyItNC7cMLP29yMRInHJ0+Ra6MDBn4nVlCWh6Xq3YQqnBg8eSg3KHtlKtMSLuz1BwZMVC+HYQ==
X-Received: by 2002:a2e:9812:: with SMTP id a18mr909811ljj.146.1557377146359;
        Wed, 08 May 2019 21:45:46 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q15sm158565lfh.59.2019.05.08.21.45.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 21:45:45 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id w23so526264lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 21:45:45 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr1028796lfg.88.1557377144919;
 Wed, 08 May 2019 21:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyFp5LZ6QO1TaDK5jSb5+2SCe3Rjmk0_juVfr-zfspBLg@mail.gmail.com>
In-Reply-To: <CAPM=9tyFp5LZ6QO1TaDK5jSb5+2SCe3Rjmk0_juVfr-zfspBLg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 21:45:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6imuGGw_4d6ywhu=0Kxr+H2S=hHavoDXYjN6o7SqMUg@mail.gmail.com>
Message-ID: <CAHk-=wg6imuGGw_4d6ywhu=0Kxr+H2S=hHavoDXYjN6o7SqMUg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.2-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Wed, May 8, 2019 at 8:28 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This is the main drm pull request for 5.2.

Thanks. I've merged it, but I got a couple of conflicts with fixes
(reverts) to mainline in the meantime.

The one to the i915 driver you seem to have applied again (after the
function was moved and renamed).

The one to the virtgpu driver, I really don't know if is needed any
more. I suspect I completely unnecessarily merged that
virtgpu_gem_prime_import_sg_table() function that came in because I
decided to do the merge of the revert.

It's a trivial function that just returns an error, and your tree just
leaves it as NULL, and I suspect my merge doesn't hurt, but it also
probably doesn't matter.

So you should check my merge.

Thanks,

                Linus
