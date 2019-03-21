Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1997FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79CE2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QbK5dU02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfCUTV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:21:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40078 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfCUTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:21:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id 3so4897618oir.7;
        Thu, 21 Mar 2019 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t93WzaFUeWx1n9VkwjYUEV2dlZf6SK4nK2VyxKxFM4I=;
        b=QbK5dU02jAl4VDJ+ThP2/Bo9LjpfZHJ6RZRFFlsMaO5wO3wdfHwyCI23dpD5ICuJgX
         e1CfNkGbMuz2MoI26Jadp4lsWe7JSQU+mYZRMn+JTAV4Ij2ou1AtJQsA8mVZaaIK3I27
         sOUTAXTVYQjanu0+LkUvbFLXElt5vQmfqxD//nHJQ13pmJHRV7mHDR+Ufx0MTWL+no3j
         b2wS/0akKCHi2NNI3cIUZTkyNm8sFVLnJkKZuXF9Hl00a2RNg78f9GaN8NjA9nwdTtTt
         YIluufo9OcHAywBcsfJWZPeZvWgR/OhtViyfkZ4dN+IDNrpCqJeMGzK/TKrYaYD0m4MV
         n9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t93WzaFUeWx1n9VkwjYUEV2dlZf6SK4nK2VyxKxFM4I=;
        b=COFvCgwOTkSH2UG9iX4p0g2c7rnpF1SUyiyG3tDviqiXUG1RkbW6WINbR4kMh8sUJ/
         cgMilWBMEmZP5pjvtlis3p1wnmCleZMkxrE3MxqXGJrLkZ4IKRzaTFpINnUvcyASySSv
         ryKTKlnAgu0nQv3aq5qAz8dY0m8mnwLwB5T0a62NZVF4K813Fb7gvph3aeENqcsgSEJ+
         mAaGojJWQ55X8SpGVTfBKJUi5OY4g1u0AOPiz2jpeKptUtE7HCMiH/0izd7QnOUIXuem
         vlWFXK+Jrt0lc5LJyHrwIAdoY6SAwWYDXeqncHL02qSz2lfPbCcjuGkbiIiVDRRSh2Ft
         6yMA==
X-Gm-Message-State: APjAAAXIJypYMFiTVz/KepOlgUi2yMQWj9VQW9/Rny6pPGDvH1ybd6qe
        eyhK0d5BeNfwhKc/e4RoooF21qXvyquMo+xi+SI=
X-Google-Smtp-Source: APXvYqyKN+PiBVrC2U+BHO2hJerCJJUq9pXAu/YXuG5Wrph7oT9kUzfRQmHf7z4SY7vQQrsjbL3gvdA6J67XTT2fip4=
X-Received: by 2002:aca:cf07:: with SMTP id f7mr678168oig.39.1553196085193;
 Thu, 21 Mar 2019 12:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190306212431.5779-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190306212431.5779-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 21 Mar 2019 20:21:14 +0100
Message-ID: <CAFBinCBtZfcRK-V3K-dBFc7SyG=cG0cunfV+AScqiGPA2-gGGg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc2: document the vbus-supply property
To:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, amelie.delaunay@st.com,
        felipe.balbi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 10:24 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Various boards have an external VBUS supply regulator. This regulator
> depends on the current mode of the controller which is defined as:
> - dr_mode set to either "host" or "peripheral" (fixed value)
> - dr_mode set to "otg", based on the OTG status the dwc2 controller
>   internally switches between "host" and "peripheral" mode (selection
>   happens at runtime)
>
> Based on the current mode the regulator has to be enabled or disabled:
> - host: provide power to the connected USB device, thus the regulator
>   has to be enabled
> - peripheral: the host device to which the controller is connected
>   provides power, thus the regulator has to be disabled
>
> Add the dt-bindings documentation for this property so .dts authors know
> that this property exists and how it behaves.
>
> Fixes: 531ef5ebea9639 ("usb: dwc2: add support for host mode external vbus supply")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
gentle ping as I may have sent this when most -next and -fixes trees
were closed (right before the v5.0 release)

it's not a change which is visible at runtime (users don't care) so
it's not urgent.
however, it still adds missing documentation which is useful when
writing .dts files with a dwc2 controller.


Regards
Martin
