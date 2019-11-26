Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D37C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E428120862
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AyMO8rPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZUkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:40:46 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39488 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKZUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:40:45 -0500
Received: by mail-qv1-f66.google.com with SMTP id v16so7912258qvq.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 12:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZS0DOzhdXc14SRcDepXoDm9fZsWuamRk2Ch1O62Y6M=;
        b=AyMO8rPj9LC6qYrwszqbZ4FAZrfDRjArzZAfENajH2/k54YS7qEovG3akaP1pfq998
         oupGI0fYi00PGvxzZzGMaLi+EWH6KEMUbqza6qlQCmZQCOsuqrj+BFPw02uFj6PZV+pN
         NErENlOUIIeSCg8QvAUE7qBGs8sCvr79sXlSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZS0DOzhdXc14SRcDepXoDm9fZsWuamRk2Ch1O62Y6M=;
        b=IMweprYciLBX5oz8R1UVFIwMkAX6RBrh2buGivxGZfbaBbseJ5ruNpljp7TSq6WqIk
         2G5+rIovApKZpnzRFuFwmT4v+ZmpjNx/rChECirt2qVhrgeDv9tJmNyAhQpli77+X3kc
         kKB0hYSoh/HXD6GYNhD80UIzmnuGGs5KeTwhqPOeRe0aFKicJRAfKgusSdCNjXpIVAcU
         OuYibDgsTGPUqFCZB6v/Tl0RkvfpNa060uMHLwes2kmp0CJ0u2vaeSvDnMUTvMbqzEfy
         zFuVTRbywbETduv9FTXsUveYv6Qnu9Y702dcnFOXIAHCCjp07ZmUQtoL2ndSz2Gg6TnT
         j1xQ==
X-Gm-Message-State: APjAAAWUYNtYJmjYmb5ti4uzn4unfcPZUB2g/5GI1OZUs1EMwJbweEDL
        rPUVeDIW9VIDcdlner4PtXoi4M6unRq7KWNbxp/n+w==
X-Google-Smtp-Source: APXvYqyHWYlmAddGhtDAqk04GEexsdJ04kAI1FRb4pWTtUfU042FjywMeWoKRVllBy2/VViLe4Hc7w3el+bRbeVWXlU=
X-Received: by 2002:ad4:568d:: with SMTP id bc13mr768895qvb.102.1574800844776;
 Tue, 26 Nov 2019 12:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
 <1CEDCBDC-221C-4E5F-90E9-898B02304562@holtmann.org> <CANFp7mXNPsmfC_dDcxP1N9weiEFdogOvgSjuBLJSd+4-ONsoOQ@mail.gmail.com>
 <1CEB6B69-09AA-47AA-BC43-BD17C00249E7@holtmann.org>
In-Reply-To: <1CEB6B69-09AA-47AA-BC43-BD17C00249E7@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 26 Nov 2019 12:40:34 -0800
Message-ID: <CANFp7mU=URXhZ8V67CyGs1wZ2_N_jTk42wd0XveTpBDV4ir75w@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Bluetooth: hci_bcm: Additional changes for BCM4354 support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marcel,

The series looks good to me.

Thanks
Abhishek

On Mon, Nov 25, 2019 at 11:19 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > It looks about the same as one of my earlier patch series. Outside a
> > few nitpicks, I'm ok with merging this.
>
> I fixed the nitpicks up and send a v2.
>
> However we should still work towards a generic description of Bluetooth PCM settings for all vendors. Any ideas are welcome.
>
> Regards
>
> Marcel
>
