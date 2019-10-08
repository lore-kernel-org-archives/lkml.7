Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173D8C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE5C20673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cszw21Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJHOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:22:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbfJHOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570544555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMpWj4uOPxcgbjJ4IsWoC4M5sQShlFz4NNLvVWf/x6o=;
        b=Cszw21RsBE2P8aVTe7ByjPE3OXu768c33Lf6s+jGwrRzqcpeyfCrvF2LWtAwhKPMXC2Adn
        bgOw/C2La2SEtla0gcAz0opspVDHhce8gpXBtDZapr5/0wAGPM6rnDM2ZfMpJBOA9WCUm8
        D5gRbMyHefonYwdNtpH5wDc8KSBWIq4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-DAMSSagpMD6PALxAVV3EIQ-1; Tue, 08 Oct 2019 10:22:33 -0400
Received: by mail-lf1-f72.google.com with SMTP id w193so2275453lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izWGXNhra/3fh2DCf3llnwEjW05viNBlyod0b16IslA=;
        b=NtFMET7yNImU3yBrof/SJJOWPNGHwK827qSIYn98yEkKoIk7jt5C9ku0khij7HjiEN
         /von2AqXE6xg/6izO7LCYWUIkqm/IKmnnvlr2ElYMAO7sOOEGjmIVRTKgMIKE1WG/knL
         B6bw4qOURpLGccaKdNaH7vjP9htigVvzarDOpDQkXYPR5f4Brx+V/fNGDNI+/X9r7FUS
         wzenvR2wSnkxS4eG18P2PxCTKpXdddKtW/zxr+jLY0HoZt62po/J6Elky/wVC+Jk1dWe
         GGX0GK88uxcMtkqFowCdrhhHDhGRK6m/Q9KCvY58Oy7q5DM2Hac0VTfduKw6glKfIXRA
         KiTw==
X-Gm-Message-State: APjAAAVln7KxcjvgvzEFCAwgaJ/JmXIrXDgEZ3UgB17/ytNSIN9sPCI4
        2rg37PGWP3mCJV5IVZkhUvGgzlYcIaMxl0J16bgyNyJcGDRBvZHOqDjYL28LtT6Cnb0WaLluSnz
        PKlryfSOr+S5p3CfppsEjaf5AX1ztAf7feBeCrCFV
X-Received: by 2002:a19:f617:: with SMTP id x23mr20131655lfe.97.1570544551405;
        Tue, 08 Oct 2019 07:22:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQ5BIwFckGkZoqMa3dajoTZI5b2H0V7PwZ9+q73PFB53Spl/+fGoimtc5lTyv7g1Hv5kaHN9PjZmq2Rci2J+I=
X-Received: by 2002:a19:f617:: with SMTP id x23mr20131648lfe.97.1570544551211;
 Tue, 08 Oct 2019 07:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191008123346.3931-1-mcroce@redhat.com> <20191008131518.GH25098@kadam>
In-Reply-To: <20191008131518.GH25098@kadam>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 8 Oct 2019 16:21:54 +0200
Message-ID: <CAGnkfhxefH+3YKDWQMCOYoj1skcq6rUmHuiHZQ-76YixFqbQjg@mail.gmail.com>
Subject: Re: [PATCH] staging: vchiq: don't leak kernel address
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org
X-MC-Unique: DAMSSagpMD6PALxAVV3EIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 3:16 PM Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>
> The subject doesn't match the patch.  It should just be "remove useless
> printk".
>
> regards,
> dan carpenter
>

Well, it avoids leaking an address by removing an useless printk.
It seems that GKH already picked the patch in his staging tree, but
I'm fine with both subjects, really,

Greg?

--=20
Matteo Croce
per aspera ad upstream

