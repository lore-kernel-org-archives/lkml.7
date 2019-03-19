Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16364213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHhJN/FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfCSNhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:37:21 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41739 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCSNhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:37:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id q128so15855641ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOobW9zFKL4YSuDlOkjTOcCq8u1pJUAt2sXI8P5uXDI=;
        b=CHhJN/FHFaQqVOaPQHeb2fDZTO2y0nbqYTvufH9sRkclP0iG1BlIsHQWCtcoIE18s0
         67E5cU26jo87OeRLhExfq3Cr8ZxPNFugQ3+IZUllStJTP0ugJWRxoAQ8/f2n4cy4lcBe
         Z2C2ZVEENowHBVs1/A99eBzog6Xagowij3bvNiUILi3g4holtMxBcPK7KuM2zjbENXpN
         sQwHmNGHhrmcVQWwGuiPKaePLl6zuRE7EP5QqkRWJP8+yCgU9jbQRchMHTsYS0Q1t77T
         J/o4ytwoGQC+NK+N3Zk/qStW+zZ510wJqnEBkmf1xOQdoTlZXDM9TLwnnl/hW1wFjjLx
         4bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOobW9zFKL4YSuDlOkjTOcCq8u1pJUAt2sXI8P5uXDI=;
        b=qzyuFJyEhCQe28Isiiph33C1kLCB35/7pkuEUtiX5WYHd4f+iohoo+B0M2bAjaMr0W
         Wz2V5vqYbuH1Zq9fQuExCYoqk75sOsjiEMY8LdHVo1pfgndLUrik3aNZf44LCvEPDb4M
         1rwnhLOnjSrX6bxJZtkWMSnO4bJXCth4Yq1H4z+6L90YOAA/midNSKD3TFUxBIFMFk4F
         ZKlI1AnB765H4oJ92giiiffZtLxSUeIjSs7uAxm/0oOzyimmU4TVr1Yxd+0fn/M4rYKg
         7ZugR7rJHkTtHiHRKvSqfocVFTMV0OSHgQiTCPmpA7KdvaUMM2Nzpa+Pz8qU3tt+1e+I
         Br8Q==
X-Gm-Message-State: APjAAAW+BtaFN1JP9//SXR3XJSSIgpDF+nfw40zTvltHLr4+gZUjmXuE
        jOmPfT8ybOxuarXRMIHu2LiwLmii9V6uy/zXaODPxw==
X-Google-Smtp-Source: APXvYqyHFTmMm0nzhXXUY843OGsdUobGSX666+rTVkpeZoYnPR1nilKVVHCKhUWGerhL7sD7VVJNhWn/sCa6FUs3ZXQ=
X-Received: by 2002:a81:63c4:: with SMTP id x187mr1886921ywb.443.1553002639519;
 Tue, 19 Mar 2019 06:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPCnQJ=zoWFU7YESpONjwRC4ccVo_StYbY=dgait-Yp4Ptb5=Q@mail.gmail.com>
In-Reply-To: <CAPCnQJ=zoWFU7YESpONjwRC4ccVo_StYbY=dgait-Yp4Ptb5=Q@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 19 Mar 2019 06:37:08 -0700
Message-ID: <CABXOdTe7gssZqHziUFjWQ5WROmMbHEVzej8j8toq1kkBrSQS+Q@mail.gmail.com>
Subject: Re: [BUG] cros_ec_debugfs causes a WARNING trace during suspend on
 ASUS C201
To:     Urja Rannikko <urjaman@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 19, 2019 at 3:37 AM Urja Rannikko <urjaman@gmail.com> wrote:
>
> Hi,
>
> I was testing 5.1-rc1 on my C201 when i found this, dmesg of a
> suspend/resume attached.
>
> Based on a quick look at the code it looks like the reason is that the
> suspend and resume calls try to cancel/schedule log_poll_work
> unconditionally but this device doesnt support reading the console log
> so the delayed work struct was never initialized.
>

Thanks a lot for the note. I'll send a fix later today.

Guenter

>
> --
> Urja Rannikko
