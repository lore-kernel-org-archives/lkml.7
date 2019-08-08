Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50132C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BA12171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565274267;
	bh=GbxGK/XeU8Jq3BsD5vAhpYB5spmsW6zGX1dwrpsE5t4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UTvDy5es5khICKAZccrfipagBangvPzkI1SdGqLNL5EDbxEvPNJe5UsO1IXpEHVym
	 FG0bwSgR5LwzGLGvQSsBlNu2LPtrfSHxmSFPAOux9FHQ9XKChBGc+zhqpeRpgT+wIS
	 Fc6X215DJGtquK9c4et8hEPSKvsUasksRDC/kBBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfHHOYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbfHHOYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:24:25 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 415CB21881;
        Thu,  8 Aug 2019 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565274264;
        bh=GbxGK/XeU8Jq3BsD5vAhpYB5spmsW6zGX1dwrpsE5t4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aoIa7iW+xO03864JPGOTaZ0uKpmXzd9TyBhnV4ccOITEc6lK3zCzzIcNr094IVknO
         SQuc+rxdvYL1EOfaPJXKSJQIOp+iewyyYbOTwhFMc30yuSsfvlmlM4ZcjM9ygpk39e
         HVHroC/rC1LdgrNSETv7fVg+s4eQqHJ65iKv9yak=
Received: by mail-qt1-f180.google.com with SMTP id t12so3728727qtp.9;
        Thu, 08 Aug 2019 07:24:24 -0700 (PDT)
X-Gm-Message-State: APjAAAWmgtAQoM+T4yzXrfrrg8a3o/pZDJwCLfDXZDmFqrWMgROy1eLb
        9ekjxyl64TjgJthiRUPYTYTClvwJcZkV6uN3rA==
X-Google-Smtp-Source: APXvYqye2r+EAqTd1bwyViP0nnseaD8L/QzN64cUXepyshuKkd3QHF+cGD87GSZVBbS9vKtfQnvvObZlYmsjxVhLY5U=
X-Received: by 2002:ac8:23b3:: with SMTP id q48mr3395933qtq.110.1565274263456;
 Thu, 08 Aug 2019 07:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190805124037.10597-1-andyshrk@gmail.com> <CAL_JsqJ6_J1pR-MYK5kmUN5Q+tX32UNFqLW81tmBf=pYxtAmjg@mail.gmail.com>
 <CANbgqATvVSo_D-n_mW2hK2KEK_8cs3374ddB6C8GcZZwjMSoRQ@mail.gmail.com>
In-Reply-To: <CANbgqATvVSo_D-n_mW2hK2KEK_8cs3374ddB6C8GcZZwjMSoRQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Aug 2019 08:24:12 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1KVVube322GZXetVWdthrtWG=QiOTSnUg5aLbXjBuWg@mail.gmail.com>
Message-ID: <CAL_Jsq+1KVVube322GZXetVWdthrtWG=QiOTSnUg5aLbXjBuWg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add dts for Leez RK3399 P710 SBC
To:     Andy Yan <andyshrk@gmail.com>
Cc:     "heiko@sntech.de" <heiko@sntech.de>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 12:14 AM Andy Yan <andyshrk@gmail.com> wrote:
>
> Hi Rob:
>
> Rob Herring <robh+dt@kernel.org> =E4=BA=8E2019=E5=B9=B48=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:48=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Mon, Aug 5, 2019 at 6:40 AM Andy Yan <andyshrk@gmail.com> wrote:
>> >
>> > P710 is a RK3399 based SBC, designed by Leez [0].
>> >
>> > Specification
>> > - Rockchip RK3399
>> > - 4/2GB LPDDR4
>> > - TF sd scard slot
>> > - eMMC
>> > - M.2 B-Key for 4G LTE
>> > - AP6256 for WiFi + BT
>> > - Gigabit ethernet
>> > - HDMI out
>> > - 40 pin header
>> > - USB 2.0 x 2
>> > - USB 3.0 x 1
>> > - USB 3.0 Type-C x 1
>> > - TYPE-C Power supply
>> >
>> > [0]https://leez.lenovo.com
>>
>> I'm not really convinced Leez is a vendor. Looks like branding to me.
>> We have enough with company names changing, we don't need changing
>> brands too. Use 'lenovo'.
>>
>
> I had checked with Leez people before V1, they said Leez will run as an i=
ndependent company, so they don't want to
> give a lenovo label for this board.

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>
