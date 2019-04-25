Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ED0C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467E0206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q2f7ZtoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfDYP3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:29:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34782 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbfDYP3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:29:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id c6so67124wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=md7QkDxGApMrbvv/uAr4AS9lY84Ygxp4p8hT/q+mrW0=;
        b=Q2f7ZtoOkWfC0Tpa2iIDv+cwwQrFsVLkvA0GWjSai/bVCSG7efaeUl9K5jFLS1kWq9
         VFrzYrZhIZxHN8v6PXA46aWU2zLGMLoePwXj/pyjIeUVOAwwSmTjucDgQlDZvuR4vMTQ
         EQGIdIcTSIoHr/f2T3cLPSdkqm1GWrEMGqcvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=md7QkDxGApMrbvv/uAr4AS9lY84Ygxp4p8hT/q+mrW0=;
        b=geyd0l4vxI6vY5J2VuFKekIQ8IgRSauZet/W5FcFyzT8m1L5sRA35Bhymn9kYW6eE8
         1j4cEudoYhmYsktZAW8em0hZBUeeqFxi6MUKNCFxyv1XThOROFejCfLxuPMdEwVFNZOp
         nBXIsJXfXyK74PbJGzpNAQvoepFUBq3DwFHIF7Oc3Dnkkv8y/5ynhix+eBesU0Otj5O+
         eCCm0OTFRb4OJPrM+X2zIv11nxQ54TO5fiJo3EzfPDsSt2ACT1eUlGHpa3TEOFFHabDd
         WAZbdEZH2UNRnCDfOpp/IdUtqacuIbmoY7IQ6bq+p4dHHJ+Y00F3sTVqNrIogX1Huy07
         jKVw==
X-Gm-Message-State: APjAAAWxe7BgYyfroM2ahOTAKGxfbQZLfSlvAL7LUidOX2Mij2Ut6cbj
        jJCOIbx2CnIEvP2/7/S7uufrxfIGnr9lpWE/yibabg==
X-Google-Smtp-Source: APXvYqxDdLSNPr8/o5gMZEMVxs1yVCxI2sHj+jw43CdbnXQSUwViSNax5T8VxqaY3LkQwq0Wg1Xo+OjS+KmQT4ToW0I=
X-Received: by 2002:adf:dbc1:: with SMTP id e1mr9581749wrj.203.1556206148709;
 Thu, 25 Apr 2019 08:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190405204257.87095-4-fletcherw@chromium.org>
 <20190415194557.9182-1-fletcherw@chromium.org> <20190418090714.GB6702@sirena.org.uk>
In-Reply-To: <20190418090714.GB6702@sirena.org.uk>
From:   Fletcher Woodruff <fletcherw@chromium.org>
Date:   Thu, 25 Apr 2019 09:28:42 -0600
Message-ID: <CAN-6NYbUOWwyJ-EaFGfpS0gzgGFaz81R=BdpgziowFVsvEf=KA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix jack detection for Chromebook Pixel
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 3:07 AM Mark Brown <broonie@kernel.org> wrote:
>
> I only have patch 1 here...

Apologies, patches 2/3 were unchanged so I did not resend. I'll add
them to the chain.
