Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033EEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AB321841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554755263;
	bh=F7Xo80dOld9EFHiLjPCYzWp2yWtcrk7zdLUjxBWACbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NGQlQFMV+HFvHpVC1TfvfwoYy32r7cosYC/R8d6QIg1XgMAx6s3zmWSplcOvpMz2T
	 IbD8gEsOtkQmQpn/612bW3eQmmDsnI4I8Co90JRJ5cqxyhGRoahlpPgVKVQRdiCqNa
	 Df65NfjMwEjHRlKcXz6J2eYSkdgwaVH3j9n1+ckU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfDHU1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfDHU1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:27:41 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820DE21841;
        Mon,  8 Apr 2019 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554755260;
        bh=F7Xo80dOld9EFHiLjPCYzWp2yWtcrk7zdLUjxBWACbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YUytDTB/k3GKB7F8zJ/bVbTEgc2uzf8Yjv7NulHLg4dcQ++WFxFDaePd0Qj+bxmZR
         KyeoPHpOvop6+2CFUd+/MkzdYYeNl0gZFUEU5h1BoSqw+FiL7PtVCylWfAsz/Co2Hi
         O1HDwMxD9RHuFva1lID0szjvl9qqhmDrg19H/TCE=
Received: by mail-ed1-f50.google.com with SMTP id s39so12927436edb.2;
        Mon, 08 Apr 2019 13:27:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVemRs8bvRLc2ZA6d1OwLkvcG3PMgsTr7ILAzHmO1NydQ2momjL
        g9mlqkRYFTu6nazm9NLImcTwZBk2nmie4ryBCJs=
X-Google-Smtp-Source: APXvYqwUAdSe5ErtUGVFN/QHcq17ah1Mx66HSCVuL9tQd9ae3iNaJv4P23uvs9Rp0uAoAIFocDI0qtAOUVqvAu8aBPo=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr14245415edr.194.1554755259123;
 Mon, 08 Apr 2019 13:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190402123123.915-1-nava.manne@xilinx.com> <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
 <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
 <d425bd61-238b-f085-f450-d052349878a8@xilinx.com> <20190408165109.GA6459@archbook>
In-Reply-To: <20190408165109.GA6459@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 8 Apr 2019 15:27:02 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
Message-ID: <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 11:51 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Michal,
>
> On Mon, Apr 08, 2019 at 04:36:15PM +0200, Michal Simek wrote:
> > On 08. 04. 19 16:17, Alan Tull wrote:
> > > On Mon, Apr 8, 2019 at 7:39 AM Nava kishore Manne <navam@xilinx.com> =
wrote:
> > >>
> > >> Hi Alan,
> > >>
> > >> Thanks for look into it and providing the ACK.
> > >> I got one minor comments from Moritz Fischer do you want me fix that=
 issue now or I can fix it later as it=E2=80=99s a minor comment?
> > >
> > > Please fix for Moritz comment.
> > >
> > >> In which kernel version i can expect this driver changes??
> > >
> > > Patch 2/3 and 3/3 are dependent on 1/3 which isn't a drivers/fpga
> > > thing, it's drivers/firmware.
> >
> > I can take it via arm-soc guys if you are ok with that.
> > Just need to have your ack in commits.
> > We have done it like this several times, IIRC reset, nvmem.
>
> I'm fine with you taking it through arm-soc. Alan?

Fine with me!

Alan

> I'll look at the other
> patches.
>
> Thanks,
> Moritz
