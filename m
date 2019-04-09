Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BCBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229C52084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXNmispu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDIRQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:16:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39299 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDIRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:16:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so10161641otb.6;
        Tue, 09 Apr 2019 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugwwcelQXX27Uuz8eESGxew4eEEXDMpXez8jxg4o5Oo=;
        b=mXNmispu2md9LPdhXlqziBWdQERJI1xh2/zKDR4Ei5iSasOuIb9jCAVyGK6pRBq15F
         6EjZnV/DgcKzD64G04Qrzw2n+yWiVTLNaLwJIWDIaqz457/Pc+GvJIqz8W6MHYJ/y9HE
         yWCa7jPy9MDEoWuXHSCaJ8ReyH7S2UYczB/kdrAjPstRqB2cqFI2ZCT8/W1e0pSAat+b
         OmZ/E7QRcsTFBQCnslFxIzPtXIgl/7ua8V85Sog29MnHTwbN8mmz9B0Avf7ElnBkcvIe
         wB4CjJ5AFnJzZbWEwqXqjYyufXNX7hahFErO3a56zcdkoSWxLwol9n+QInVUv9XenLh2
         t32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugwwcelQXX27Uuz8eESGxew4eEEXDMpXez8jxg4o5Oo=;
        b=BE5lCx1QDPTKyTJnP7G3SH8l0ZrbBrHP5PBWpypX5riKRr5CvxQMmwpQ5ry1ieDsoa
         x/xvdoqlK0MJpqeZoe3wVU+M3t/HohPKTVPUQKdU3EfH3uh3jtIDhSef1U7i+rWYXKYn
         cl8LYxsTHj5f2qy5jsUS3ZOvLmLmJYnbZ/iUSVvdztDIzd5NetE747BQPnkdF6Wo5nwa
         6Hh1J8IuCWTl46gOds5ZgKvbT5CzZcAOVolByMGWsA+tVbV/DLDrXT5ZBNHld6nnrbfe
         JUSVrHppvFHh1J8J2AfmXC2xz4VUr1WBoCiwRVs4he1c0sMoTc49ZWPjO9VqbWCUlxTd
         6QOg==
X-Gm-Message-State: APjAAAUJtY0Nn2NqhSi6dS9NPBvC5VxlQCVkPq/7juuTdEKTUDdfIEnv
        BLIk9aGW6aBobrpdA0DJ3ccyOy8dBV2elbQ78to=
X-Google-Smtp-Source: APXvYqy6FJNI7CRso3bPkwMl/bCqGbOjaCod4bmL3bAjJ64Ll+XcJ3r1Nzs274+3M0SigNp84ZrXCfvNIty6Kx+UJvo=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr25001150otk.48.1554830174656;
 Tue, 09 Apr 2019 10:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <20190409144250.7237-5-TheSven73@gmail.com>
 <CAL_JsqJhefb3qmPN4Fn5zMz_UYFTRdPthqi4NNGMNqwNtSy76A@mail.gmail.com>
In-Reply-To: <CAL_JsqJhefb3qmPN4Fn5zMz_UYFTRdPthqi4NNGMNqwNtSy76A@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 9 Apr 2019 13:16:03 -0400
Message-ID: <CAGngYiX15ts+dr4MzvtHcEfasZCSK1Lok=PkVhqRwKtzWVnQtA@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] dt-bindings: anybus-controller: document
 devicetree binding
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:51 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> DT patches don't get in my queue if you don't CC DT list.
>

My apologies for the confusion. You already offered your tag to an
identical commit in v3:
https://lkml.org/lkml/2018/11/6/66

Am I ok to add it, given that nothing has changed in this particular commit?
