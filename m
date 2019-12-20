Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D18C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA35206EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfZuZxlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfLTJ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:58:31 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38500 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfLTJ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:58:30 -0500
Received: by mail-ot1-f44.google.com with SMTP id d7so6840479otf.5;
        Fri, 20 Dec 2019 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74femySzIwPJDHG5x9zdNa+AfjyKAyPCNlMsQcYBmhs=;
        b=MfZuZxlt/5aTM+eWADTAw1+ssMbTLO93nEPqcsWwi/PUCtCdYBBhFq6E7twghkXe1r
         3hp+yhXgEhLdNM6yDFWsoqF0UQJYMvFLehRnFAl3EhwPF/6iUd7v5eIxRMCLrsEqTQcE
         XBYzzVrEKNlWwW7NqXkTst1JFiYNMcHIMQsY7U8IYPwqM+K6d26bjDgKuk9s2gXYSTsM
         WqWJpZAVCOk7XLCw/do4YsLvzuVHICVPZE7bnDmq/HSOPd5QXY3J8bzsK1WF5YqXE998
         QLU7JhuIYTf/2c2caV3odpCQxCTt55p17hrVFqe/W+Cr6y3NDfSoZgOuS2aWRN6bWFOX
         DJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74femySzIwPJDHG5x9zdNa+AfjyKAyPCNlMsQcYBmhs=;
        b=VYicgB35pXcpvgXzUgqVAHokVvkO4rpqHYHwfZWfNG6RnpAUEuDFTlWR5CBJQjKFVS
         27ktsCBMSoN1YgNavfkIKJfnMZT2O8xcsaH+bbleF2BsSLGWR/rsqCxfEq2H2rfII/we
         G2z27LxrevNqM9KqQUNpaThNN8fiAfhAT9+gd/V01+VuMUFDI0dPkR1n3QYW3MY56MSD
         HXuaGf0IsyPqbOHmNlXzsV75xM7wynP0BU8liTNdNFJ57h6eal0flxy25Q/f4HkKRbzS
         zAEPd2MMfByoh6XoMPJdire3+s01/8DhrFVd0U3ca/ww7ae+iAcqxXtZQueiLee2ONKc
         qSDg==
X-Gm-Message-State: APjAAAVMDwHvQrGcWma98ByrrUfYEIJDblG4Odjyly3/6vqCOtMQnoYM
        xUT+4zYCr943OJvlWCsCPV9VEwDWW7bxrG/D/aA=
X-Google-Smtp-Source: APXvYqxNwbRenNNC3ee/+YtenI0dYdUuu8d469Q65xkASBDJ4VTai2GdRpnIGeCbklPsIf5o+/BCp8RjQDL4Dgpv5gE=
X-Received: by 2002:a9d:478:: with SMTP id 111mr13874039otc.359.1576835909674;
 Fri, 20 Dec 2019 01:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20191014141718.22603-1-narmstrong@baylibre.com>
 <20191014141718.22603-2-narmstrong@baylibre.com> <20191023201141.GA21235@bogus>
 <CA+3zgmsJPsvXgsjDQKKrSG+UNdY3SK+hKCTD2X3hGG+OXejHig@mail.gmail.com>
 <CAKgpwJWU3jB0DWEKE09TOV+YLceBFJ75ZirAXQbuhj8v3FwjXg@mail.gmail.com>
 <c32007f5-88b9-45c5-b542-b1dc4dbc76ea@baylibre.com> <CAKgpwJVHF6Ytdt9kq5SwiixFDLym_UPG51aXag1nVVay0pzofQ@mail.gmail.com>
 <45212db9-e366-2669-5c0a-3c5bd06287f6@synopsys.com> <ce35b6d2-7ed1-be2d-6e38-4c6e89340a40@baylibre.com>
 <CA+3zgmtWQwdJG5NT-t7__Mqt5u_U3m4+HEL6p4PWxx5NES7_AQ@mail.gmail.com>
In-Reply-To: <CA+3zgmtWQwdJG5NT-t7__Mqt5u_U3m4+HEL6p4PWxx5NES7_AQ@mail.gmail.com>
From:   Tim <elatllat@gmail.com>
Date:   Fri, 20 Dec 2019 04:58:18 -0500
Message-ID: <CA+3zgmsAWRYTqT+Q6t73ikYmm=L2gLmB6PEOUqLuMULfUcPKUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for
 disabling SS instances in park mode
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is still good on 5.4 and 5.5, and the following network lag
was solved by separating the USB and NIC smp_affinity_list.

On Tue, Dec 10, 2019, 7:45 PM Tim <elatllat@gmail.com> wrote:
>
> Just writing to say;
> this patch is still performing well on 5.5.0-rc1, and
> there is no speed improvement by adding DWC3_GUCTL_NAK_PER_ENH_HS BIT(17)
>     I get up to 3890 ms second lag with "ping -s 5120 $IP" when
> copying between USB HDDs either way, but at least this patch stops the
> crashing.
