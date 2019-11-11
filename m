Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6137C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACB6206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrxyRkvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKKAi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:38:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46172 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKAi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 19:38:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id n23so9860409otr.13;
        Sun, 10 Nov 2019 16:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MITFevQWeaD5O2RIoepB+ZayRpQUR0r8MODVnsurmHw=;
        b=hrxyRkvuCqPmRi7dOr6QloTOriYLjemurMepZlY4zMaONRKmf056kDCZBXfufatBYT
         Mai7D42x0uoj2oUgL7U8hWi/jIGE3EuAq7I7/wIpIDvlFE10oEBMCxAJTS39t5h+7j6K
         OjShnzfNpkOzT2F/vE+X/QkXbfF6Qxsy9GbJtxOn8V0ZBtq/5g985Akok7ymRYpjyk9N
         npZZeL+0TWPrcRnHA4jmEmFcPB7q29Pag+derE8iJWjHs0txUquuoO8imPxADPumcpJx
         Xkr0qV5fXsDWD1r2ynDPlOC6ZjHhJrVA+OyFujJe8uMjC+TSwW+ghYYa5MB4gLiuii4I
         Urcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MITFevQWeaD5O2RIoepB+ZayRpQUR0r8MODVnsurmHw=;
        b=GZVOwgxEaVY8U9ExxgQ8F/kVe+MGsIvux86WQ2dF6a6iqve0xtv/lS9kasADetUvAp
         1Rfsp7gXRjhPQdMw8AmVaqNgn6aGS4j9/4VHIWfXk3d/vuWob7gKxBEs7xqsHzceECzS
         Kkbekz6ADgthudzl5U7ZNkPJga1QVNNt5eXAq0RaFuJ5vLtymW5rFC/3al30ftGFDEkh
         wgGBl4V8KDYEYkt10YTFZhT4FlA8VOvBXMhC1WuxLEXT73qHZLP1qVQhJD4Zv7kqU8uz
         mYDtfLr6ir6BSPuSBIFNnvU1utoGWgRZBeWn8hi6BKB1wxFX3iTZJKQE6IZxViWDrwJq
         co4w==
X-Gm-Message-State: APjAAAUnrCML2l5FDTKHfhNIwayOy3n/LzKD8E9M7tk+3ubrLYpSW3GV
        3epGTAEAdG0I4bTSSmvF24Lk3Gx9BD6U77g3GtA=
X-Google-Smtp-Source: APXvYqxe/TyVhscrKc4YzaCaKaXtvQ/H7LFIz4ExngxMQYvTn0rZl5BW6m1HBPuay1wW4pphbzjm7aq+P5J+K7PBqMM=
X-Received: by 2002:a05:6830:1149:: with SMTP id x9mr18153786otq.47.1573432707368;
 Sun, 10 Nov 2019 16:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com> <20191023201141.GA21235@bogus>
In-Reply-To: <20191023201141.GA21235@bogus>
From:   Tim <elatllat@gmail.com>
Date:   Sun, 10 Nov 2019 19:38:16 -0500
Message-ID: <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     balbi@kernel.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for working on this Neil,
Is there something that needs doing for this patch to make it into 5.3 or 5.4?
As previously mentioned the patch set fixes the issue on affected hardware;
    https://patchwork.kernel.org/patch/11164515/



On Wed, Oct 23, 2019 at 4:11 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 14, 2019 at 04:17:16PM +0200, Neil Armstrong wrote:
> > This patch updates the documentation with the information related
> > to the quirks that needs to be added for disabling all SuperSpeed XHCi
> > instances in park mode.
> >
> > CC: Dongjin Kim <tobetter@gmail.com>
> > Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> > Reported-by: Tim <elatllat@gmail.com>
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Sigh, what's one more to the never ending list of quirks...
>
> Acked-by: Rob Herring <robh@kernel.org>
