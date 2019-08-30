Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2EDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B91623431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K2pR4YqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfH3WDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:03:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40216 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfH3WDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:03:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3so3944768pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=EnIXpwAIfyekw22wgx99HmUalWiPh7x+7uNWDpr4m5g=;
        b=K2pR4YqO5U71A8d7/ZSJnhEN61Q57gnxY1N86g9ZAJcYOsLAX3zsiWr7dUD7BU7jLf
         hSRoplf5AtIB3e8uMdK8raUmI9aLI2Y+prfm2ASCh3acb8Hu8m76DWvy4EBKrap9zaae
         5E9JnJm/GmuOw+LnUOwd8YEXFVvKTm1p5fdhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=EnIXpwAIfyekw22wgx99HmUalWiPh7x+7uNWDpr4m5g=;
        b=eWhlBmEYLfhshWYuzvIA+RMBM2+AOnQ5W56uzv/Yoq1VnWj49JALIXmiqnz3RQSnRd
         vUmzl7xsnxvdieaS4ip5NKGpY+7SNXJPp7TdOFCqfhTvRo8T9R8pLcg5dzsq3abZXk4a
         kmAyNJKk9e1Z9S1Wc8ufpZbpolMwwDQZw1lhbctf2Q5GMZAN5puJOknCrjM6c8BD6EFE
         KGD6qejFbYst9VL8V+1g/6QZpZ3Tf/ykkfafaW8kiMk/MA1GONr2i0JlGpqJfvwla1xy
         ny3lXQinYDlfKjOJJoRg1wygQFL3bUCNqpWutb5IL5Ey3GemfyJpb5/NKEdsX4y+bzAj
         jGwQ==
X-Gm-Message-State: APjAAAUxoXXdCGIsdhVaX95Kv5ey2bP1lmP5k4UgdGKMNf2Bp10POOzK
        IjklJTLkNz9vvjICi/YXqWFOnv4ZbDyZaw==
X-Google-Smtp-Source: APXvYqzU0MQ9yN8nzVcGsYuJjMci6Yqm58R5OG2ryZAbPSCU8fR2RU/hDxTWNsH2/geIfEuQjigbjw==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr18280350plp.245.1567202604286;
        Fri, 30 Aug 2019 15:03:24 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 138sm8700928pfw.78.2019.08.30.15.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 15:03:23 -0700 (PDT)
Message-ID: <5d699d2b.1c69fb81.6db46.76a9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d2e61fc.1c69fb81.afb7a.a64a@mx.google.com>
References: <20190604222939.195471-1-swboyd@chromium.org> <20190604223700.GE4814@minitux> <5cf6f4bb.1c69fb81.c39da.5496@mx.google.com> <CAFp+6iHZeawnz7Vfk3=Oox-GN_y6c-E9wMwc-qdp1bTOXgqjFQ@mail.gmail.com> <5cf82c6f.1c69fb81.9e342.dbda@mx.google.com> <CAFp+6iE8FUXxexKbYy=ak+se-pj1XXUZxTu5o=hJvg66V6+Rzw@mail.gmail.com> <5cfee60a.1c69fb81.584d9.cf12@mx.google.com> <7299c814-3d9f-c5d1-fe7b-44e05f8b4ec9@codeaurora.org> <5d2e61fc.1c69fb81.afb7a.a64a@mx.google.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add iommus property to qup1
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 30 Aug 2019 15:03:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-16 16:47:07)
> Quoting Vivek Gautam (2019-06-12 02:26:20)
> >=20
> >=20
> > On 6/11/2019 4:51 AM, Stephen Boyd wrote:
> > > hardware signal like the NS bit and/or the Execution Level. Hopefully
> > > it's a config and then our difference from MTP can be minimized.
> >=20
> > I don't think SMMU limits any such programming of SIDs. It's a design=20
> > decision
> > to program few SIDs in TZ/Hyp and allocate the corresponding context ba=
nks
> > and create respective mappings. You should be able to see these SMR=20
> > configurations
> > before kernel boots up. I use a simple T32 command -
> >=20
> > smmu.add "<name>" <smmu_type> <base_address>
> > smmu.streammaptable <name>
> >=20
> > e.g. for sdm845 apps_smmu
> >=20
> > smmu.add "apps" MMU500 a:0x15000000
> > smmu.StreamMapTable apps
> >=20
> > This dumps all the information regarding the smmu.
>=20
> Preferably I can see this by using devmem instead of jtag and T32. Do
> you know the address of the register? Otherwise I'll go dig into the
> documentation and try to figure it out.

And this won't really help me will it? I thought the stream ID was "fixed" =
by
hardware, so it seems sort of weird that we're talking about limiting it in
TZ/hyp. Here's the S2CR table from Cheza in case that is useful.

localhost ~ # mem
Welcome to mem interactive mode (featuring python!)

Available functions:
- r(addr) # Read a single 32-bit word (little endian).
- rm(addr, nbytes) # Read memory at the given addr as a string.
- w(addr, val) # Write a single 32-bit word (little endian).
- wm(addr, val) # Write a string to memory at the given addr.
>>> for x in range(64):
...     r(0x15000c00 + (x << 2))
...
0x00000000
0x00000000
0x00000001
0x00000002
0x00000003
0x00000004
0x00000005
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000
0x00020000

>=20
> >=20
> > >
> > > As far as I can tell, HLOS on SDM845 has always used GPI (yet another
> > > DMA engine) to do the DMA transfers. And the GPI is the hardware block
> > > that uses the SID of 0x6d6 above, so putting that into iommus for the
> > > geniqup doesn't make any sense given that GPI is another node. Can you
> > > confirm this is the case? Furthermore, the SID of 0x6c3 sounds untest=
ed?
> > > Has it ever been generated on SDM845 MTP?
> >=20
> > I will get back with this information.
> >=20
>=20
> Any update?

Any news?

