Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5246BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB59206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcnIwPYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCKFtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:49:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42398 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfCKFtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:49:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id o9so3579666wrv.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ayKaE9kQB/6iWO2ETu56kVQWHz54VyHzvVNedzJQ4Fs=;
        b=tcnIwPYHnFbian0qH/0CiIgKHkpOjmvuaasgwROsY5h3XNtiG3M667cXhaOCVen2aH
         nrytxOkQRZ5OV6qGXlai85Dd9R9eKerj5IFTE/eXYDnn9ZzikYqMGrve5Xtr0scqx7AL
         UPfnzpiWuS8pdO6wNSdb20Ysz7s92vrDGAv2PJy2XSx8nCSbOoE4CkgLGxw5zt+K4hij
         iB+CSlc/gD5Uqyejozuzb+I587X2diWf1jHIzstM09o+JghGM5I2keZRpEks2blg4BCi
         COqOAjV1jOfb9RgFRGksZAE8sd+HWjnjJz4oOI2F/1dIHWr+suzJ3sTSFWnKdlmSaUrC
         bdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ayKaE9kQB/6iWO2ETu56kVQWHz54VyHzvVNedzJQ4Fs=;
        b=sxBscHLFAbKhy8Pryp5hu5Y5xllcE8cCghBQEcyPJsKeDECmPtRgqkVLGfiYSvJ+UW
         MaVJo+nAhJEvbP1tVh78ocpgq/zJbC33u/Ghk1QS1tktfEGgJEd7xWCx8eHVQJ6piJTl
         nxUONN2zzPGS/2Ke10e0nFzxeopr46twi6nRUbKatq408n/24UvojkJiXYcwJfkB8+Zw
         QMNrE0BzlMXYWoeJ2mB0MUSGVdsroIR6sOGiRQgiz4cU+FeJIMHp96VQO/fm57tkiMXN
         pFdiXcaY0DgRU5VTAetbD8WxxschkWHbgTSI9dzUtQ3FetuvtzJQ2w9gyJ9aqMhaRrYN
         S0vQ==
X-Gm-Message-State: APjAAAUB4maCOxXk5bRteMgGoCuR+WKQyJI2jS7fP1aSqVuXWpQYKcgL
        bzI8a5ihRtfL57q6bPZZtJWIJ7bOGVnSCjcskwVrSw==
X-Google-Smtp-Source: APXvYqz93q8sIUaI4NlkAHoIvEMShkbzTXD1yN38rZkpFiIdvDk2Fh4j2LBddVlUR26ZoZvn5Yv6C+zYRHSdSdp3u7g=
X-Received: by 2002:adf:e78d:: with SMTP id n13mr11953286wrm.75.1552283338292;
 Sun, 10 Mar 2019 22:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-4-git-send-email-john.stultz@linaro.org> <CA+M3ks6ga2-c2GRWDMdDnPDEFQ+0+QdxAUbSc--fKVHJNR6R6Q@mail.gmail.com>
In-Reply-To: <CA+M3ks6ga2-c2GRWDMdDnPDEFQ+0+QdxAUbSc--fKVHJNR6R6Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Sun, 10 Mar 2019 22:48:47 -0700
Message-ID: <CALAqxLW6zN+POBZgwKCgXLZwuSWtbhN=Ap6BDQBdDVhwA=WyaA@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/5 v2] dma-buf: heaps: Add system heap to dmabuf heaps
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 8:01 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
>
> Le mar. 5 mars 2019 =C3=A0 21:54, John Stultz <john.stultz@linaro.org> a =
=C3=A9crit :
> >
> > This patch adds system heap to the dma-buf heaps framework.
> >
> > This allows applications to get a page-allocator backed dma-buf
> > for non-contiguous memory.
> >
> > This code is an evolution of the Android ION implementation, so
> > thanks to its original authors and maintainters:
> >   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
> >
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Liam Mark <lmark@codeaurora.org>
> > Cc: Brian Starkey <Brian.Starkey@arm.com>
> > Cc: Andrew F. Davis <afd@ti.com>
> > Cc: Chenbo Feng <fengc@google.com>
> > Cc: Alistair Strachan <astrachan@google.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Switch allocate to return dmabuf fd
> > * Simplify init code
> > * Checkpatch fixups
> > * Droped dead system-contig code
>
> just few blank lines to remove.
>
> Reveiwed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Done! Thanks so much for the review!
-john
