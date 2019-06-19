Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B13C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772FA20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECyT4hmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfFSGgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:36:41 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:45150 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFSGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:36:40 -0400
Received: by mail-pf1-f181.google.com with SMTP id r1so9117305pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7hSEJgaNQ9TMaenqDYNV1rOFRRbekhYP1C35BGZnzIk=;
        b=ECyT4hmQ2TVUla0rWPI6s2jkMG691PcNBgN5UZC8rlJxhjIopsi+2ZU1rkQg/4hBJ/
         1DRRnfgKrREBYLmEqtJej1QPvx1WT15tUyGcSsD/piEfS7u1KfGH3/3IFnVCBKvk/+ox
         cwBmuKH7l0vufmNyYI+z0XM12eOViOl7ifEeswyY1IPxXawzGkRSqWv/NWqM1GmzSOvn
         Q9ez1tGX1A62fxOvxYvauaAuO/nJxZy7C4BNh3IpckmnTN93Dvo/7wnfwZMtB4i46JjW
         tz3wadamPlVz7T4xrM5duHtFHLs6SB2BNmvELhflwl++z7T1y2HIGfcONj3Z3mvp8yKs
         eTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7hSEJgaNQ9TMaenqDYNV1rOFRRbekhYP1C35BGZnzIk=;
        b=FEA4euPanyhPduiFMEGDRVtiV0XxAInPbKy3GM7obo3wf/V7hAlN8JW1xF1rC+8PgL
         L1f37E7pMd1UO535Ux/f1V1XpbI8CmUkfQSzOK330F9Qyz8BiDCgaoSjofrXfZ5TOyV/
         kyXamJhpZCnGojAgBAOQFFVtguCeh01Rk3HV6ovRa537066wVBtuhgVkAAC8Grv33Yry
         j2qR/nM+YYg3xoigoGN0Iel49O8Y0Ru21jUEHcxjtZvooew5nOivFalSUX5ZBUUCzfvy
         BLKtuz+131xEMpuWUI1VgBwj1V6gQZLOKOVhYmCg3WsPegqbQoFLBE7JaRrvAiTgl+ee
         7ACg==
X-Gm-Message-State: APjAAAXV4t1v8nJ+X9FCGU4nNsYWlEP18rFwBuSJfzvUzFxw4ddY0WK/
        QuTT2+ESSCs7OsBan4ESzTw=
X-Google-Smtp-Source: APXvYqyMWG1Y5CrVeT1G27wZCx7bmh+a8QBDE1WUW1wdkHv4qQJVDts0GqKH1NBdty/xYviDGi2KWg==
X-Received: by 2002:a62:778d:: with SMTP id s135mr53470023pfc.204.1560926200153;
        Tue, 18 Jun 2019 23:36:40 -0700 (PDT)
Received: from localhost ([175.223.10.253])
        by smtp.gmail.com with ESMTPSA id d132sm18688001pfd.61.2019.06.18.23.36.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 23:36:39 -0700 (PDT)
Date:   Wed, 19 Jun 2019 15:36:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: nouveau: DRM: GPU lockup - switching to software fbcon
Message-ID: <20190619063635.GA576@jagdpanzerIV>
References: <20190614024957.GA9645@jagdpanzerIV>
 <20190619050811.GA15221@jagdpanzerIV>
 <CAKb7UvhdN=RUdfrnWswT4ANK5UwPcM-upDP85=84zsCF+a5-bg@mail.gmail.com>
 <20190619054826.GA2059@jagdpanzerIV>
 <CAKb7UvgkEXtmJV67EXeBctgaOxM1D91fBbKw9oFMUaB1ZViZQg@mail.gmail.com>
 <20190619062714.GA11457@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619062714.GA11457@jagdpanzerIV>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/19 15:27), Sergey Senozhatsky wrote:
> [..]
> 
> > If all else fails, just remove nouveau_dri.so and/or boot with
> > nouveau.noaccel=1 -- should be perfect.
> 
> Can give it a try.

That has some impact on system responsiveness:

 CPU%		COMM
 339.7		firefox

Which is slightly less than perfect :)

	-ss
