Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7892C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B78921848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Rz/rPIy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfKFPcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:32:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:59251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbfKFPcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573054346;
        bh=GiiIhgBUTGJFic+FI6UJgeWlvOItAhL++J46ickbhNg=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=Rz/rPIy5Ax5ix3Dyn8AXepCuUzN5rQv6BAchJqwveDSFBB9nph96TeD12yg176QE8
         CRd4O0ewS1iH6vGVCZE9QwwyeGxP57Gc3oywGEV7/ZzvPEK+kP6aOcMSxJZlJyADrq
         A42daZdP4szqG85Y979j1prlxugcGDusEexypRW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1hkPWd2p0b-0105FF; Wed, 06
 Nov 2019 16:32:26 +0100
Message-ID: <d6f7fe9e15a5f6cae98b89bad8826a43be6ab87d.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Jan Kara <jack@suse.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Wed, 06 Nov 2019 16:32:23 +0100
In-Reply-To: <20191106143537.GI16085@quack2.suse.cz>
References: <20191025132700.GJ17610@dhcp22.suse.cz>
         <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
         <20191025135749.GK17610@dhcp22.suse.cz>
         <20191025140029.GL17610@dhcp22.suse.cz>
         <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
         <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
         <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
         <20191105182211.GA33242@cmpxchg.org>
         <20191106120315.GF16085@quack2.suse.cz>
         <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
         <20191106143537.GI16085@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:waigNbie1AqBRiW5XPbLt6zvxCfyaVnFGrhF3ElfAcas//+fLS4
 J+GWECsnLqkKE5e92XOrn1JZaPmj2i+MafyZyci9GDV8+7ytUAt962iGpIP7nk8M44YZ94q
 yj/tdC5oGXPXOyiWxVyY3enQJ51tM2aKuqWsthKbw70AmUbove863Qi3DUFAF0z1Nnv4jIS
 sPQcZSCDmhaYqMNahjZqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XPJ9aTDuOHY=:B0VcQTOH1i0tiZlmB209FR
 Sl9AS/v48S4VhpN/zoPxEZ8B/gAguY2iX8yk0maYwcqCXPyMZdG7T6Z5u66S+iRqfOASxYtVT
 0aZmZgUVIUITY5fwOwY3tlbPpp/UROqaxJcSEw5zdhRIsTvRg0VeaJEIBsGVKYB4ZqCxbdCYj
 aQvlIFvXmTYHAm5eHhCKOQ1yqc5AKw6N0nwGOvLzM99atOjTtB2igmMMGt6YLaHxIykikCgPO
 tkhFJcsmrV2T2hpsgVrpZwqNzYGX73naYsOigEIDLg8hEuxymWDxT5OEkHJc13aKz+rBWtOZb
 EnFYOYm7tRr2mPnT6oVka5DrdV/nawk9LDAgzIFYjHg9gNcCzXwZBT7dDEzxXCgZ1B4BV0BrC
 0aUlOtiKNa5wAY3fYc6OwmPMQmMO4sBEFBSCl5XHTqNWX34HSe7x58i5BqUquaDow0MYNCq0n
 rpWkEmQoaCKqb/sgOPZsMRKa9/Bi340ed5SksFNy+FHDXcuYmQgDhd5WNKPKiUPa3JSc/T4dZ
 SqLcmNBKtL2LdcIUS8AZ4mRAAuRiyJTMfCxKWGXNoucNWviguXWmC37zb9fr76UxS3mzBKAKt
 DPZsZVB7vF8XszKRv7QnqWjfDc+TGoBRxap8A5ZTjr7TQ5LQ3CdO7GhWAMs99JPS+cMufwin4
 Cgh98KcEFmpjJN5DZDX6rvjI/Bbg+H8jS1ftt458dQI6uFJ1rb7g0Vr9A5FsyhxUBEsvL5PBs
 xI+KZckAE0UpMp54SKgWGbuotlwS5ffremm7tRBtAkM19MTHUGstTSsZm4NMoSWeIoLycSOjr
 jPM8UTd8B3gHXAk7RoRfTrbyHATfYmhJ8UZHEzQpa3lxhMJpLziQgayWw9MdHMKFz5lQIeDJC
 wvvwusRyo/xEvVaGUW/tFjEATVXnBEE5CUEZpYL5DvLFjdk/XXngTPhNUXUioKInW8In8DlZo
 5hlGGDS9KYupkL4KMVbJT7QvJYF915e6ZevunMlp+gkgcSdwcVbxK0KsO851BO3OOYkhfs9y3
 /3FBNfYrbM0CJuCJPG4L9n18frv4rxIhBN6fVoQKTfVE63estrs8LbTJ3x/VU1v5+eTjIaGVK
 7mat56fg5yHve43hpZw4zH0cS6452LCSzvqA/tvb4HS6jhaJ518hpRDV2MxnuoS3+euLBdonW
 xt1mUD/YnpkNRK8NMAimoDIQaubRXiFpoRR6YzGu3FOjQrwhSolyq8gbptpmJUhLeDnzcIhdh
 kVe+OybIiVKOJ2B1pD9x71zc1RTOHRqp5YBEMeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 15:35 +0100, Jan Kara wrote:
> On Wed 06-11-19 14:45:43, Robert Stupp wrote:
> >
> > Yes, ra_pages=3D=3D0
>
> OK, thanks for confirmation!
>
> > 5637e22a2000-5637e22a3000 r--p 00000000 103:02
> > 49172550                  /home/snazy/devel/misc/zzz/test
>
> What kind of device & fs does your /home stay on? I don't recognize
> the major
> number...
>

It's ext4 on an NVMe SSD
Maybe it's of interest as well: my /tmp is on tmpfs


