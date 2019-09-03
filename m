Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EAAC41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB5221883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Wp8V5Z1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfICUQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:16:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33697 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfICUQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:16:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id l2so13954003oil.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fuNE/PbARI4X1SDUxOJdVor+kM6vEl0qwdmklg5gRIk=;
        b=Wp8V5Z1smuTXbcTb6H9dhtUg3fTNi/mBMD9NogWFulevqru5aJyg/yQzbZhd87dUxi
         GW/j6TPJ+e/rsZ29asl2NBU01ok4D9DELsYRWUfiS2R0LRUooQvzgulfFX9enb/cBznF
         xNn2mRFf723WAOBbPHUafZPHQ2U4e7jxWkRvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fuNE/PbARI4X1SDUxOJdVor+kM6vEl0qwdmklg5gRIk=;
        b=c01ofAK1EKH0sW9+Sn92PMC+mduIkLpkT94ah1FNYt42yJNp4fXXw0oUJsfWmDcqgH
         h8x0GFB+TMtiEPbbPjuZoCPWRMF96pzLUb1MCDwzKi3GjvclVkzDm3canDJQuSuWdX5z
         fEywJbxLCDX7SVprzxA6zUE/YL5ad45exhDV7/TwT4XzSF2E4oPdsjrOwgLS/ifgab47
         sfaWA1w4Ghqht/R9rW0h4QDbFl7HPBOqfDzInH1YGeQRK6WMJiFkisMk5ot0EdTKDkKu
         QJuejV/zP4vOuaEIu4VjiO4n8LzOE/3poDMKgr3fkTqh9ImpMr+0t8yspFSNlDGPWGlY
         di8w==
X-Gm-Message-State: APjAAAVBPPZHTjTe3pvrfzhePQij+Nx24TN5KnicQAm4Ouyou63sykLO
        wDhaiLBQkW52Lv+p+yzW4/AwrYyMG3MdrI1u/5HMpA==
X-Google-Smtp-Source: APXvYqybfiWx6mjrzM5ZXEiVGtvosvX11hiUT74UWVUuMP6ub2AGecgFs301Pxu/2I2tVSX5lPGvb8Ws7uu8YHor0Lc=
X-Received: by 2002:aca:e182:: with SMTP id y124mr820605oig.132.1567541792385;
 Tue, 03 Sep 2019 13:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190903162519.7136-1-sashal@kernel.org> <20190903162519.7136-44-sashal@kernel.org>
 <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net> <20190903170347.GA24357@kroah.com>
 <20190903200139.GJ5281@sasha-vm>
In-Reply-To: <20190903200139.GJ5281@sasha-vm>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 3 Sep 2019 22:16:21 +0200
Message-ID: <CAKMK7uFpBnkF4xABdkDMZ8TYhL4jg6ZuGyHGyVeBxc9rkyUtXQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch alignment
To:     Sasha Levin <sashal@kernel.org>, Dave Airlie <airlied@linux.ie>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Yu Zhao <yuzhao@google.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 10:01 PM Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, Sep 03, 2019 at 07:03:47PM +0200, Greg KH wrote:
> >On Tue, Sep 03, 2019 at 06:40:43PM +0200, Michel D=C3=A4nzer wrote:
> >> On 2019-09-03 6:23 p.m., Sasha Levin wrote:
> >> > From: Yu Zhao <yuzhao@google.com>
> >> >
> >> > [ Upstream commit 89f23b6efef554766177bf51aa754bce14c3e7da ]
> >>
> >> Hold your horses!
> >>
> >> This commit and c4a32b266da7bb702e60381ca0c35eaddbc89a6c had to be
> >> reverted, as they caused regressions. See commits
> >> 25ec429e86bb790e40387a550f0501d0ac55a47c &
> >> 92b0730eaf2d549fdfb10ecc8b71f34b9f472c12 .
> >>
> >>
> >> This isn't bolstering confidence in how these patches are selected...
> >
> >The patch _itself_ said to be backported to the stable trees from 4.2
> >and newer.  Why wouldn't we be confident in doing this?
> >
> >If the patch doesn't want to be backported, then do not add the cc:
> >stable line to it...
>
> This patch was picked because it has a stable tag, which you presumably
> saw as your Reviewed-by tag is in the patch. This is why it was
> backported; it doesn't take AI to backport patches tagged for stable...
>
> The revert of this patch, however:
>
>  1. Didn't have a stable tag.
>  2. Didn't have a "Fixes:" tag.
>  3. Didn't have the usual "the reverts commit ..." string added by git
>  when one does a revert.
>
> Which is why we still kick patches for review, even though they had a
> stable tag, just so people could take a look and confirm we're not
> missing anything - like we did here.
>
> I'm not sure what you expected me to do differently here.

Yeah this looks like fail on the revert side, they need to reference
the reverted commit somehow ...

Alex, why got this dropped? Is this more fallout from the back&forth
shuffling you're doing between your internal branches behind the
firewall, and the public history?

Also adding Dave Airlie.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
