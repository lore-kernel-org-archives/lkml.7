Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A5AC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC212082F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxTQsHEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfHUBaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:30:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44568 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHUBaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:30:21 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so1254817iop.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ql4bDp9akkC2eYEgVdQtfHfIcbcIz1+2SiZ0bqUwLUw=;
        b=OxTQsHEP0dDqmmVMCe3oBUxWQwvJO5G99idissr/h4II8KuDkg6jf/s1TRHFy83rhW
         EISzsvSYe/tpDyywmNyAKh6Nwb4saSN2QzJY3N4LIdaFx6mgmQDtLaGMqHGG7Yh6ROLN
         0AhDzhKVCt9I8083AFvCKaT4sNSq7W+44lync4/MFsF9+Yi4RwtLZbeTiaFr2tsEar0y
         T9mFcEo3kYf403ZrnU8psSaa3wIU50mKa7w/kMW7W8z7EitaqSLs1RfIhKmhbGAOqFoy
         rlLtgkdev+TEMMSw1uMkn2wdc7gwqRKua0oWcnY7EzoOlTooQj125wKlfe2MEy0G2l59
         CISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ql4bDp9akkC2eYEgVdQtfHfIcbcIz1+2SiZ0bqUwLUw=;
        b=EolRkH4CXzkSdSwoR8tPvfjOoLtx0FZSIdIZ4mJcRIDsPuzyGFdvThqgGiYPoPRIQS
         NCBvh3Eum4xX5a8INgEJ9XAmD9a6Anjws9JWidYYCsFQchzg5I78UZ5Ce0iPef3R4ow9
         tJmgdbI7ZvFyBL8Kjq86txTjWrBxe3tpc/c6GG98SRra2Yj8M0mxgixuj6BwC/sG6T+1
         IAEQEddxJ3da/el7c66co9Zx7FRLwbUWBGsgNnMArDObLJSKeRtUX7X2VRK98wl8G31z
         sikwj7E/rIxDg19/PUc2/Anf5PNb/utYi4xQs6t3AIwTNY4jtPV5dIK+/qJDaehf+KxO
         VlYw==
X-Gm-Message-State: APjAAAWuSCEBFF7SbTF/6HMHVq4otOeTQyfSAV8t9sEyrBmaXUuH+LtZ
        wIOFWILa5QOPuZ5DT+6sLeIE0wCEbOJCIX+fRO0=
X-Google-Smtp-Source: APXvYqxM7PuKzWWFvwyH4B0/s2RGGx7iGV2vBmZvO23sXqMNw+GwHtyU2euHgmpvq14IJTaYOpR+mUk769oZAdR6qAk=
X-Received: by 2002:a5d:9711:: with SMTP id h17mr2795781iol.280.1566351020454;
 Tue, 20 Aug 2019 18:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190820030804.8892-1-andrew.smirnov@gmail.com> <d735e851-cddf-f069-37f1-d27b013f3213@free.fr>
In-Reply-To: <d735e851-cddf-f069-37f1-d27b013f3213@free.fr>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 20 Aug 2019 18:30:08 -0700
Message-ID: <CAHQ1cqFpZ9beTJHLfdveUuYKks52GRD7ccnXLXudxmnd5Dk7Dw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-cfu1: Slow I2C0 down to 100kHz
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 7:41 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 20/08/2019 05:08, Andrey Smirnov wrote:
>
> > Fiber-optic module attached to the bus is only rated to work at
> > 100kHz, so drop the bus frequncy to accomodate that.
>
> s/100kHz/100 kHz
> s/frequncy/frequency
> s/accomodate/accommodate
>

Will fix in v2.

Thanks,
Andrey Smirnov
