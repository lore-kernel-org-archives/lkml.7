Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C994AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F0120863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EBTa0Bbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfCYMKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:10:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44729 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730988AbfCYMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:10:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so3093364ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gbdnwxsyaq97iQCUafgGL5JXQ/w5Y2o2mTntOt3fm5w=;
        b=EBTa0BbfezLE71AxQ7JPrG9Y9jz7eZCd4A0UWyQnAAD3xyxDj5N496268U78l2etgX
         YZYn8r+8YU+b/qhe6J1OwNqDYbxpKb3xD43z2l6hQu7Z8gpCVYHyvDSyOnDgN39tq0zl
         QnRBwlj6V9/vkbQZwR2HVVGUI3r9gj7Qb7hjP48p0xIZnsoVCtV0zlKooHwzM4z0jyFd
         iQTTTFuiS3V0o6uOb4EhHIPGs7xEpITg4hCmeP9K0953xO22mXXtkaFq77U2O21QYE2g
         ET47wHOFLw+Qxb4mFYH9rHPo9mzu9WXB1jDzP7ZVtBjxsW1eDryun1093Im4XNNd9GBp
         iUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gbdnwxsyaq97iQCUafgGL5JXQ/w5Y2o2mTntOt3fm5w=;
        b=oBNMe7sTc1TOGlYXIOS6oliaHmVvPB3Sz9g6xEYx5zjswjReZVmqE221LCrVzFn/N7
         ZfvsHqkkR71MsAEbB1r0aVupA5oYPzkr4vG24u2PEPMjr7y0YC3rmU07cpF9MVJ+NjK+
         y8AP11zWCRsG8cLEgnsmefL7xiMQ7oPHwbIhWJro0X3CCnSvziOt3Qc2wpyLPNuwdRPZ
         alf3whGQnxfl/d4rdjw5p8aBWr7ZhaI66cvJKB+Caued31LyZ02rLzybqAuB9aqhQK/h
         opAD/aHCJzoR3WdU001HH9uuq1+WG3ldz3avh+ivLVadBlQK5rVoyw2BxD7zklEl8+Jy
         1jtQ==
X-Gm-Message-State: APjAAAV967v+VmW9tSaoSV63KrKOU1YFuwEXdXb0KBo8dkj0/3le4NI+
        X4X1lHxuOz0CIdroHp0bbW+iWQFVu+Kt+6FgsFU3yg==
X-Google-Smtp-Source: APXvYqzWak45t1WHLVO1cDDvE/73sbvyQmCUK3nLR9o8/t5gyKuPjEIY08/E3rxfy8ilonoRbAO+24C9xClEix9Y+XQ=
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr12148154lji.127.1553515819051;
 Mon, 25 Mar 2019 05:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <mvmimwotn60.fsf@suse.de> <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
 <mvm5zsgp00d.fsf@suse.de> <CAJ2_jOHoNnBF2UwU6G1vdvNrJAUJdGL_RncRAOaXMWoS03cagA@mail.gmail.com>
 <CAJ2_jOFrXcxRS1oYOuYhtuRReTocmPKnoe5GO_3r_B1uAZb+xA@mail.gmail.com> <mvmmuljupwd.fsf@suse.de>
In-Reply-To: <mvmmuljupwd.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 25 Mar 2019 17:39:42 +0530
Message-ID: <CAJ2_jOFwDouMNAj8NxLX01bpLV+rG-rFsVh7e_e2ncCBX3qt_Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
To:     Andreas Schwab <schwab@suse.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:28 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 25 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > I have sent out the v11 patchset, you can test the heartbeat
> > application with that patchset.
> > You still need to make that DT file modification which you previously
> > did, using fsbl.bin
>
> Why can't the driver make use of sifive,approx-period?

Because as per the review comments and discussions, it has been
decided that the driver will make use of the conventional interface to
pass period settings instead of 'sifive,approx-period'.

For your reference:
https://lkml.org/lkml/2019/2/6/159

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
