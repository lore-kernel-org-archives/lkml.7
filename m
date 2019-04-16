Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBBBC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185BA2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZZpGBC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfDPHTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:19:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46423 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDPHTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:19:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so9846580pll.13;
        Tue, 16 Apr 2019 00:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=maYTJPDFiAHM03bcmvj+XEQpkIXIEFZsaqZU0DcmWyQ=;
        b=vZZpGBC7HcEWmDBeVyBsg0NlJvFIpTlwlRoBfnJ4++0yRgFhZdTQVhWJ9A0fsGWKLm
         MiQUPtc/FI+jfXgLUbHrQx2dD4NbcJUY0uBL6tPnGFaFIWunIDva+i9cFOnbyw790NKP
         ruPlFJZ+vqrLdORfE7mCQf4k+5tC4tpnMGOGgcLNIwhuAv4DIEDTv2Bt+RoYfKlJ0IjZ
         zJjiBdyntfu6jRivl1IYeZ6Il+0iebx65SPNqXS4o4LyN82SDF19RP36jNwrMMEuy00W
         tM45hLcvbF+/PIOR5svPPNwpbNZ4LrJtzx9FnpQ8DInNVj9FvCaLc9uekTnhF1J+I71G
         nmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=maYTJPDFiAHM03bcmvj+XEQpkIXIEFZsaqZU0DcmWyQ=;
        b=svD4gY51Jo7CRlGmvtikuf2kBrv/HLmXDheZY4OD2h0QA/L+tjrSsWVHSz2D0mITW2
         CVuAlYvaqYUZWXNTd9GHkyRdI0Vap3bhgAmryGQAcKGr2KHZAFKz8dxsyBUntM2hbfw6
         e0Lr9a3VTki9SdnpoR0pLp+oYQwKc1xr+qvvy7d6r002m4aRI8d4s7q678A0XODMdjKL
         S5+91J1A9Pp/e073H2X3258UMTAWV4H1pUogVKl+hxyajMn44eJXcBqYP8gOwhVypqOE
         JuVQ5mHeOKwzck1v944E+pK+Dz8PRTqYXseY7zp8vreHoZ7Al5B5SsR/MYblhaO6xd4O
         Cg/g==
X-Gm-Message-State: APjAAAXcA5sO+YwIzJT99otFkv5/Zag1FSvgT/U+7DckNJUh5U3Bl8xC
        2bLDL6g3T0D561oLoJu1AJuYNHR8yDtqHVtjeaU=
X-Google-Smtp-Source: APXvYqxS4nPAuMmDHVjo9KtqOrzWZ87wMsOs640s14Bg6TTb6KsZx8O9mevgTCzhUBwkunplrqvqbtHZNCUOqxN36pE=
X-Received: by 2002:a17:902:106:: with SMTP id 6mr37322071plb.98.1555399174959;
 Tue, 16 Apr 2019 00:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190410023208.25435-1-huangruiPPP@gmail.com> <20190409193911.2d68a64d@shemminger-XPS-13-9360>
 <87y34ijgil.fsf@mellanox.com> <b8c233dd-2ade-2305-47c6-731396a6f591@cumulusnetworks.com>
In-Reply-To: <b8c233dd-2ade-2305-47c6-731396a6f591@cumulusnetworks.com>
From:   =?UTF-8?B?6buE552/?= <huangruippp@gmail.com>
Date:   Tue, 16 Apr 2019 15:19:23 +0800
Message-ID: <CAKx2cEQCm4WrE7eu4+Q7Yc8QLB45fAjjiQdBNBvhWZZcridVTg@mail.gmail.com>
Subject: Re: [PATCH] net:bridge:always disable auto-tuning when the user
 specified MTU
To:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc:     Petr Machata <petrm@mellanox.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>, Jiri Pirko <jiri@mellanox.com>,
        "ecree@solarflare.com" <ecree@solarflare.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
        "amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
        Li Rongqing <lirongqing@baidu.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>,
        "bridge@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether use the current method to configure bridge's MTU or
add a notification in bridge's internal code and send a notification
when modify the bridge's MTU, we all need to add an additional
judgement in dev_set_mtu_ext's first if statement for bridge to
let the process not return early.

By the way, whether it is the expected result or the current result,
the MTU of the bridge will not be larger than the interface in the bridge.
Which scene will cause frame drop.

Nikolay Aleksandrov <nikolay@cumulusnetworks.com> =E4=BA=8E2019=E5=B9=B44=
=E6=9C=8810=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:05=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On 10/04/2019 13:34, Petr Machata wrote:
> >
> > Stephen Hemminger <stephen@networkplumber.org> writes:
> >
> >> On Wed, 10 Apr 2019 02:32:08 +0000
> >> Huang Rui <huangruippp@gmail.com> wrote:
> >>
> >>> For example.
> >>> My purpose is to create a bridge br0 and join eth0 into br0.
> >>> if we use this following way, the auto-tuning flag will not be disabl=
ed.
> >>>
> >>> If eth0's mtu is 1200
> >>> step 1.brctl addbr br0
> >>> step 2.brctl addif br0 eth0
> >>> step 3.ifconfig br0 mtu 1200
> >>> step 4.ifconfig eth0 mtu 1500
> >>>
> >>> Result:
> >>> br0's MTU: 1500, eth0's MTU: 1500
> >>>
> >>> Expected:
> >>> br0's MTU: 1200, eth0's MTU: 1500
> >>>
> >>> I have specified br0's MTU,  but auto-min policy works. So the MTU is
> >>> not the result what we expected.
> >>> As expected, if i have specified bridge's MTU, it will set the flag:
> >>> BROPT_MTU_SET_BY_USER in net_bridge_opts disabled and auto-min/max
> >>> policy will not work.But in this case, because the dev_set_mtu return
> >>> early, the BROPT_MTU_SET_BY_USER flag will not be disabled and
> >>> auto-min/max policy will still work.
> >>>
> >>> Signed-off-by: Huang Rui <huangruiPPP@gmail.com>
> >>
> >> A bridge like this going to drop frames.
> >> A frame received with MTU of 1200 will get dropped.
> >
> > That's true even if above you set br0's MTU to 1201, but then the
> > auto-tuning is disabled as expected. The problem is that setting MTU to
> > 1200 is perceived as a non-change, whereas it should instead be
> > perceived as a signal that the user takes over the MTU management.
> >
> >> The proper way to do this is to change MTU of both interfaces to match=
.
>
> The only problem is a lot of the network configuration software these day=
s
> sets the MTU by default and that would lead to disabling auto-tune by def=
ault.
> And since you haven't received a notification it means nothing has change=
d,
> but in this case state has changed for the bridge quietly. It could break=
 setups
> which rely on the auto-tune and it would do it quietly which won't be eas=
y to debug.
>
> Also as I said in my previously, I really don't like adding bridge-specif=
ic
> code in there. Another more ambitious approach would be to maybe always p=
ass the
> value to the drivers and let them deal with it, that would require going =
through all
> ndo_change_mtu users and also would still not solve the problem of not se=
nding
> a notification when there has been a state change (the bridge no longer a=
uto-tunes).
> Thus the bridge will probably have to emit *some* notification by itself.
>
> Perhaps this should've been a bridge option from the start instead of aut=
omatic
> decision but it's late for that now.
>
> Thanks,
>  Nik
