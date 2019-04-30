Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA5C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B790B205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbHTatfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfD3NUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:20:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38297 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfD3NUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:20:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id e18so6861279lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxUTvEwj+NBZpurZ2Ig0gOAGnCDy3ToJRSMidXZgrwA=;
        b=nbHTatfrSBU52QO6/XAOdHj9n3sbWKACiGEOroIP1njriZJp1154c0zcMmUOEddftb
         RHJG5EOjKR045xHsmGwBRk25Zpt4plyqn/QjXipfndHY4PBSZlr5wG+o+/JwaTTPxM2T
         MhoVB9YsVgacvd6KF90nDt0wxErlKPxttItAjzHqChSUXtBUcL7DiCOtUiI8jtGV7l9u
         /GRXc024g7onhK63Wn5BuFgcj1Jpq59TJA3MVz5rJv+nnUP5E3LhdOkx2Z1fDCT5B/Ez
         8uTClrIbXDUjeJm3JKcRdmGlroD9T1vDJT8AYsYZwtLLO5K78rkzLewM9joqBiOrcpzh
         wTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxUTvEwj+NBZpurZ2Ig0gOAGnCDy3ToJRSMidXZgrwA=;
        b=Rz1IqRf7fU3HgBPP0aFWqz+Zc5mDRqmYp78uJ8XWzm86vbLOdNpxd5QUfNvyu3Q75J
         WeEp+n6W6KbetxZp7fK7gNb9VLlnQ0yR2V6zzCmIySIt/8fmKr0fzQnErGIcQgi+zdNy
         lpTkZECob3aKjWdXkp6SS8ax6u8xxK8WVQ0iL/iauV8O7tRgNKtn3IabimKi60Jx0dlz
         FPCu1u9/sv26TqZGfMX2u2jyeM7F1gwLqp1rDBY57BWpVk+tGE5y2YxJGdwcuPFtrLKA
         AmP3T7wRIIy2IGs5mpvkFVxM9vhGQCH/5IMMGmK8ohHco6NXMPcJpGcuftHl42docEkv
         81VA==
X-Gm-Message-State: APjAAAW2orGX5LMZX9HpcBw+CDyBevCLy1Smxi6kVmQ0XAtpugFptcBo
        tXFHhww0mlICTOdv/+gpQWCJFROsDjRrP8bNXrlMLg==
X-Google-Smtp-Source: APXvYqz6/C5cOSAi+LjOLFLkuA/ISsQ8fKMilHFI35qQ0Q11aqKw0onTyfbnQdSYNfhdSjCiVudD/DPj+qhrxqtjTUA=
X-Received: by 2002:a2e:3a0f:: with SMTP id h15mr35417830lja.194.1556630428902;
 Tue, 30 Apr 2019 06:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuZhS+QfgM0HrNm4B8Yb+0kwScxaURJDYXKPY-ML_L0cQ@mail.gmail.com>
 <35ebc45a-5894-e2ab-3a97-2ce3f7efda44@xs4all.nl>
In-Reply-To: <35ebc45a-5894-e2ab-3a97-2ce3f7efda44@xs4all.nl>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Apr 2019 18:50:17 +0530
Message-ID: <CA+G9fYuTpeu1MdLVe3ZNp3Bvx0c79mXwh2qun5MWseEweRO=FQ@mail.gmail.com>
Subject: Re: vidioc_g_edid: BUG: Unable to handle kernel NULL pointer
 dereference at virtual address 00000716
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        paul.kocialkowski@bootlin.com, ezequiel@collabora.com,
        treding@nvidia.com, niklas.soderlund+renesas@ragnatech.se,
        sakari.ailus@linux.intel.com,
        Hans Verkuil <hans.verkuil@cisco.com>, mchehab@kernel.org,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, 30 Apr 2019 at 12:58, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 4/30/19 9:10 AM, Naresh Kamboju wrote:
> > v4l2-compliance test running on linux stable 4.9 reported kernel bug.
> > The crash is pointing to kernel module "vivid.ko" which was loaded by
> > test case. (  modprobe vivid.ko)
> >
> >
>
> It's a CEC related bug, this vivid patch should fix it. It's a backport of
> commit ed356f110403 ("media: vivid: check if the cec_adapter is valid"). This
> commit was only backported to 4.12 and up since it didn't apply to older kernels.

I have tested this patch on x86_64 and confirms this works.
v4l2-compliance test runs to complete successfully.


>
> Feel free to post this patch (after testing!) to the stable mailinglist for
> inclusion into 4.9.

I will post this patch on stable mailing list.

>
> Regards,
>
>         Hans
>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> --- a/drivers/media/platform/vivid/vivid-vid-common.c   2019-04-30 09:23:37.296797292 +0200
> +++ b/drivers/media/platform/vivid/vivid-vid-common.c   2019-04-30 09:24:09.581261759 +0200
> @@ -841,6 +841,7 @@
>         if (edid->start_block + edid->blocks > dev->edid_blocks)
>                 edid->blocks = dev->edid_blocks - edid->start_block;
>         memcpy(edid->edid, dev->edid, edid->blocks * 128);
> -       cec_set_edid_phys_addr(edid->edid, edid->blocks * 128, adap->phys_addr);
> +       if (adap)
> +               cec_set_edid_phys_addr(edid->edid, edid->blocks * 128, adap->phys_addr);
>         return 0;
>  }


Best regards
Naresh Kamboju
