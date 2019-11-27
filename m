Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422B6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EC4215F2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Knq8xPpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfK0WPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:15:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37703 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfK0WPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:15:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id e187so21018364qkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 14:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S28aJKh48BKiBgWTQ5c3AIqOWrMTL77reKx0HGN42uM=;
        b=Knq8xPpCM7iC4vFTo16t7nSRxPBM9EOsUHcbgzLTH2H62X63TlElp8KSiBfcoTwQ3x
         OFupolJROkQT0x7jxyvtxzW6poOnrm5IZYvdhSNELEc3O4Rct8LbI+jrbBFlUGZAtRNY
         jyRTNsdE3i+fwPBFjput71Kf/sYhbezETWnbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S28aJKh48BKiBgWTQ5c3AIqOWrMTL77reKx0HGN42uM=;
        b=n4bICSIPSzRogu/9mdp+eD7KtXpliJn38uC1yWQx6981d9jxGD7sdOhAmGDDKAHk6J
         mBpSFdfomm87zab2E/ZFzlHJy0sFc6YpDGsqKweF4AqkjH6bja44RgSC6emotejeW9VK
         rQciSbiFNNyuJwIhIRb+YVCgvs55yW1GsqThTp+qeA28Pwt5bX/OGzPe4MSIWbk4e1Fh
         jQpyNnsZkWckyQOrA+wDCENiLMVDEemzOpTusa+NSc4lhmAvkoNhGPmU/7yjV1wciRSR
         2T5LQiQOvVje8AFM+pBuw2j+GTyyaWom+YN9lC4OOfKx0+1Wrut3aER9KD1lLIUQXLMn
         00JQ==
X-Gm-Message-State: APjAAAU1oDJbWFWs32m6uamsy+qKpBYQbRBV9B6GTj42/I6tDavdx/vK
        QPwvYJy8L97RFGe5J1O8qFZyb5nFGKQfFeQdaodZrw==
X-Google-Smtp-Source: APXvYqw+lI2gNqmMyqvHmwdaGg+grL9DJrAF+1eAqBaEkkucQJzsqXLEN9B2etEvdO+y4xgXlz3TVtneoB0pJ0pWlR8=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr2568410qkg.331.1574892903624;
 Wed, 27 Nov 2019 14:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
 <1CEDCBDC-221C-4E5F-90E9-898B02304562@holtmann.org> <CANFp7mXNPsmfC_dDcxP1N9weiEFdogOvgSjuBLJSd+4-ONsoOQ@mail.gmail.com>
 <1CEB6B69-09AA-47AA-BC43-BD17C00249E7@holtmann.org> <CANFp7mU=URXhZ8V67CyGs1wZ2_N_jTk42wd0XveTpBDV4ir75w@mail.gmail.com>
 <6A053F1E-E932-4087-8634-AEC6DED85B7D@holtmann.org>
In-Reply-To: <6A053F1E-E932-4087-8634-AEC6DED85B7D@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 27 Nov 2019 14:14:52 -0800
Message-ID: <CANFp7mXV73bmSj5CK6GOuHcjgZ99b1h39r-yU2ckYaoFZXPdDg@mail.gmail.com>
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

On Tue, Nov 26, 2019 at 9:37 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > The series looks good to me.
>
> you also tested it on your hardware?
>
> Regards
>
> Marcel
>

I have tested it on my hardware and it looks good now.

Only problem is it looks like the documentation is slightly wrong:

+               brcm,bt-pcm-int-params = [1 2 0 1 1];
should be
+               brcm,bt-pcm-int-params = [01 02 00 01 01];
or
+               brcm,bt-pcm-int-params = /bits/ 8 <1 2 0 1 1>;

Thanks
Abhishek
