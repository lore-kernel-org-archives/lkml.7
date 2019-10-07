Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED8FC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47FF206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OVAe8zoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJGSvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:51:00 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40724 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJGSvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:51:00 -0400
Received: by mail-vk1-f193.google.com with SMTP id d126so3215225vkf.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Py90T7+TOHoY4y4lQF72qi6auVcn9VleVh+vvTZakMs=;
        b=OVAe8zoqFnXj2Iv/T3srEGEE1Kd0JS8O49MQyreVdxAUfbrHgl8+3b09Opie6N0kA4
         N7LebgCcZO00dhMKgEFV8FCEA5mkFivAHI9vNyglEltwMeYiiQBHPRCfwzMkoWZhdjlf
         jfGPvIvTAtt069I4+IeaPVd8GHxj5K2eRhizY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Py90T7+TOHoY4y4lQF72qi6auVcn9VleVh+vvTZakMs=;
        b=qfwbKABMf10MZBVnG88L5HzuSpKpN8D2oRx/5/zBcJcTuK8QQs1X32s1eBM5d7jTip
         +5I48DAzt0TOrMxskUM1qMUAhbrsvmDg2UEIPCm92Y9B+D5PCON4xnHHdsmSvP1jJbrC
         rM4XVjM3wbv4uLxmEkCrveOurB7JSMeviaoYtusfn3MrCYgd7mzSbSkBDgjJNQWg/kNy
         +48T1yIhF2ZaA+nYZrnvXjqF8SoJFL0XjihKtbNznDFjkuSdH7WSkEAY0URcPzCT3785
         Z5Zh4b9P75cPE0FjhyhCeJj9zrVRcJHl1mcGIjOSixyuOuFLxeJHAEgau0V/OD6jdKqh
         wksA==
X-Gm-Message-State: APjAAAU1itR6ZF5ZmIn4P94vksNsEJiSBRLvXfxxYUNNuOuM1M7rIHtG
        +cM0xfxtiYi72fhurtW+TVNR58bCNkuUe6CWqATvlg==
X-Google-Smtp-Source: APXvYqzKcYn+QyEkep5BPOvhXlmMCn4pYfv1ojDrA+z7FDOd4AW/2yHhLJhMd3ZbFPU80M3ZE1qO494JaRdPjJnSuk8=
X-Received: by 2002:a1f:cd81:: with SMTP id d123mr15355291vkg.21.1570474258651;
 Mon, 07 Oct 2019 11:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191007071610.65714-1-cychiang@chromium.org> <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
 <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net> <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com>
 <5d9b5b3e.1c69fb81.7203c.1215@mx.google.com>
In-Reply-To: <5d9b5b3e.1c69fb81.7203c.1215@mx.google.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 8 Oct 2019 02:50:31 +0800
Message-ID: <CAFv8Nw+x6V-995ijyws1Q36W1MpaP=kNJeiVtNakH-uC3Vgg9Q@mail.gmail.com>
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 11:35 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Cheng-yi Chiang (2019-10-07 06:58:41)
> >
> > Hi Guenter,
> > Thanks for the quick review.
> > I'll update accordingly in v2.
>
> I'd prefer this use the nvmem framework which already handles many of
> the requirements discussed here. Implement an nvmem provider and figure
> out how to wire that up to the kernel users. Also, please include a user
> of the added support, otherwise it is impossible to understand how this
> code is used.
>
Hi Stephen,
Thanks for the suggestion.
My usage is for Intel machine driver to read a string for speaker calibration.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1838091/4/sound/soc/intel/boards/cml_rt1011_rt5682.c#325

Based on the comments in this thread, its usage would look like

#define DSM_CALIB_KEY "dsm_calib"
static int load_calibration_data(struct cml_card_private *ctx) {
          char *data = NULL;
          int ret;
          u32 value_len;

          /* Read calibration data from VPD. */
          ret = vpd_attribute_read(1, DSM_CALIB_KEY,
                                         (u8 **)&data, &value_len);

          /* Parsing of this string...*/
}

It is currently pending on unmerged machine driver cml_rt1011_rt5682.c
in ASoC so I can not post it for review for now.

As for nvmem approach, I looked into examples of nvmem usage, and have
a rough idea how to do this.

1) In vpd.c, as it parses key and value in the VPD section, add nvmem cell  with
{
.name=key,
.offset=consumed,   // need some change in vpd_decodec.c to get the
offset of value in the section.
.bytes=value
}
Implement read function with vpd_section as context.

2) In vpd.c, register an nvm_device using devm_nvmem_register in
coreboot_driver's probe function vpd_probe.

3) As my use case does not use device tree, it is hard for ASoC
machine to access nvmem device. I am wondering if I can use
nvm_cell_lookup so machine driver can find the nvmem device using a
con_id. But currently the cell lookup API requires a matched device,
which does not fit my usage because there will be different machine
drivers requesting the value.
I think I can still workaround this by adding the lookup table in
machine driver. This would seem to be a bit weird because I found that
most lookup table is added in provider side, not consumer side. Not
sure if this is logically correct.

IMO the nvmem approach would create more complexity to support this
simple usage. Plus, the underlying assumption of accessing data with
offset in a buffer does not fit well with the already parsed VPD
values in a list of vpd_attrib_info. But if you strongly feel that
this is a better approach I can work toward this.

Thanks!
