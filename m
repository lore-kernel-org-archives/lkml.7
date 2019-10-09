Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C8ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F07218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MNqqYHpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfJISoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:44:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42635 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbfJISoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:44:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so2644062oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80jcnPBLsOoks69yHo8g6YiW4RIC2Pi47/8pROpVuWc=;
        b=MNqqYHpMw01a7siHJTmNDsZU/gVtDJklrOtu9mitWMxnxA/AjOqQHWYUhBI6XkjxBp
         fb/0SUpv7f97S258loyt9/mP1quCcObSikIDKnzLPgYRkv0mTX1R+JLXdPDMs5nlPoNM
         hq2MsXJt/oJZugSpmImlMYOydesHrFM6MorA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80jcnPBLsOoks69yHo8g6YiW4RIC2Pi47/8pROpVuWc=;
        b=ri9KB5Qw+yVkAejAYw4SCU+LW9DxKgRIurAeWRg5Iej1vLZoVXO2N9uUZK1M5r2M6J
         NzHPeA0Cuzv4bfANUvgv8IFrb4ABtxvWIHuXQaDniRjrVHQioT+EJgJoMK1A53U7w8y7
         Yth6r5v0E3razdhZ7O9n96OE16z42293vPI7TURUp5zIrQshBAA/LYY/nNOvkG5VZK7F
         GMS4+DLBcGo8uxlbt7NmZm+TYULcM8A7gXC1Z4uq3p9nWlhkkYc9ENnkhKu+0uT2248Y
         SWssAmOo2ZDtujJwpoMv2oEP86jiyk/+0C4kHw2lXsYAYQnzEK2gpfdX4XzNcB1bFE/p
         wHBg==
X-Gm-Message-State: APjAAAW9mnJuoQa4yDIaywsi8xFDTDUarsddzmXtpEazOXKX/Zcl4LR2
        yQ9iMMvmpXUFC6+6nZkMSmfmP/11SLnCjwS9XUPW5Q==
X-Google-Smtp-Source: APXvYqxK3ZYbW7gmd9nE9xtV5IyS7KCU4ZqXAfWDOa71iD0fhMG/5Icn6oKm9z6SvhJQad7k7SDKuvifreNikeNYeVw=
X-Received: by 2002:aca:3a55:: with SMTP id h82mr3856687oia.128.1570646649343;
 Wed, 09 Oct 2019 11:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
 <20191009163235.GT16989@phenom.ffwll.local> <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
In-Reply-To: <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 9 Oct 2019 20:43:58 +0200
Message-ID: <CAKMK7uEtJRDhibWDv2TB2WrFzFooMWPSbveDD2N-rudAwvzVFA@mail.gmail.com>
Subject: Re: drm/amd/display: Add HDCP module - static analysis bug report
To:     "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 8:23 PM Lakha, Bhawanpreet
<Bhawanpreet.Lakha@amd.com> wrote:
>
> Hi,
>
> The reason we don't use drm_hdcp is because our policy is to do hdcp
> verification using PSP/HW (onboard secure processor).

i915 also uses hw to auth, we still use the parts from drm_hdcp ...
Did you actually look at what's in there? It's essentially just shared
defines and data structures from the standard, plus a few minimal
helpers to en/decode some bits. Just from a quick read the entire
patch very much looks like midlayer everywhere design that we
discussed back when DC landed ...
-Daniel

>
> Bhawan
>
> On 2019-10-09 12:32 p.m., Daniel Vetter wrote:
> > On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> >> Hi,
> >>
> >> Static analysis with Coverity has detected a potential issue with
> >> function validate_bksv in
> >> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> >> commit:
> >>
> >> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> >> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> >> Date:   Tue Aug 6 17:52:01 2019 -0400
> >>
> >>      drm/amd/display: Add HDCP module
> > I think the real question here is ... why is this not using drm_hdcp?
> > -Daniel
> >
> >>
> >> The analysis is as follows:
> >>
> >>   28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
> >>   29 {
> >>
> >> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> >>
> >> 1. overrun-local:
> >> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> >> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> >>
> >>   30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
> >>   31        uint8_t count = 0;
> >>   32
> >>   33        while (n) {
> >>   34                count++;
> >>   35                n &= (n - 1);
> >>   36        }
> >>
> >> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> >> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> >>
> >> struct mod_hdcp_message_hdcp1 {
> >>          uint8_t         an[8];
> >>          uint8_t         aksv[5];
> >>          uint8_t         ainfo;
> >>          uint8_t         bksv[5];
> >>          uint16_t        r0p;
> >>          uint8_t         bcaps;
> >>          uint16_t        bstatus;
> >>          uint8_t         ksvlist[635];
> >>          uint16_t        ksvlist_size;
> >>          uint8_t         vp[20];
> >>
> >>          uint16_t        binfo_dp;
> >> };
> >>
> >> variable n is going to contain the contains of r0p and bcaps. I'm not
> >> sure if that is intentional. If not, then the count is going to be
> >> incorrect if these are non-zero.
> >>
> >> Colin
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
