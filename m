Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DEC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C537E20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfYfer8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfD3PLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:11:17 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38478 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfD3PLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:11:17 -0400
Received: by mail-wr1-f45.google.com with SMTP id k16so21479869wrn.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PGiYlClgfBOJ5ohsDwi9C047d4chI2F/P2dOK60EZ0o=;
        b=TfYfer8CbMB5gDd86RRtlcFRd5FvMb8pvW6O1iyrHi8pUZ0V7ZsnagLGIr68rsSXOx
         VP5xbTv8+aUDBP7J4yPbz72Tm1F4ltBC44P+WlVDZowGnoNFkQ3Ug40TSkzk1I6i4RnY
         5jTQ/eRoC1NfOZbZQk0qPnszVHke9il+uCzyaV7ThsJ3IA/6HiuBqDJJQIMFt6ANSdCN
         0tJMzPz7dZLmbZ5kyZeUdbhiIcaScb6gOf9EQwpy6YRecYIeTrzJkVlz2T325VY4OfS1
         DHLZj/lqUt+2v1in4KC1q3d8BDwsPZw+DgJiyHrF94kRUKB8V24gKqgspKxacqn0qJGB
         TCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PGiYlClgfBOJ5ohsDwi9C047d4chI2F/P2dOK60EZ0o=;
        b=XqYBeodaQ70TipQ5KIlCJ40tv/6osn1fVKO/4nxOXaZ9QlJQtukHnrkBfD9AIoLESH
         zVKn9Eq1Lmr4Ndah5oJ1mBpzxovSsx7BRXh6GF7oOdpwStOzAnDArD0x+734x8tZN3g1
         hjApOgyE0XmamTgN0InKVLlhYaGO3YCaU2z3hvgmRLn3DOwZaEyy0+Yz5igeXvt7/d++
         Uu1gG3bphDMYMkAS5+ZbIBa/Kcptkw0UcpsF7XmV9RaFyQhWNDLxa8XcBEzLIN72U7eV
         gIIofnmsWTNFz/wzdzIu8gtdf+sFUuPK8VRZzGKSKYAP2gT65xZABWw1o2dY+s2ICTcd
         udSg==
X-Gm-Message-State: APjAAAX9i+V2LH8o20xDTxRjCZptd0dHTFLBsB2kI5eEuW2GO2S6n3kb
        9HiefqKmbmccFTesr/PGLn/2wLOe
X-Google-Smtp-Source: APXvYqx7Z4+dHK6NMNWA4hPj6Dlz0il52J7CeL+oP7a6/rDrPEe/wy2Ygzx8XZgTig1Q2rkJoYNP3w==
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr1257785wrw.86.1556637076046;
        Tue, 30 Apr 2019 08:11:16 -0700 (PDT)
Received: from L2122.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id o130sm3255004wmo.43.2019.04.30.08.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 08:11:14 -0700 (PDT)
From:   Daniele Palmas <dnlplm@gmail.com>
To:     sdias@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, truong@codeaurora.org,
        dnlplm@gmail.com
Subject: Re: MHI code review
Date:   Tue, 30 Apr 2019 17:10:58 +0200
Message-Id: <1556637058-22331-1-git-send-email-dnlplm@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
References: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sujeev,

> Hi Greg Kroah-Hartman\Arnd Bergmann and community
>
> Thank you for all the feedback, I believe I have addressed all the comments from previous
> patches. Also, I am excluding mhi network driver in this series. I still have some modifications
> to do.
>
> Please review the new patch series and share your feedback.
>
> Thanks again
>
> Sincerely,
> Sujeev

are you going to continue working on this series?

Can this series be used with PCIe SDX20/24/55 based modems?

If yes, it would really be important to have this integrated into an official kernel.

Thanks,
Daniele
