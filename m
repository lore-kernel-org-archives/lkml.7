Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7875EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C542148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742273;
	bh=g1kQSYdS/XUqn4yw6Aq0XA9opiewGkY+gtqPXwZBqjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xxF48JqJ3/mp5db1LqABqHVunDw+9tJhl8tBu+jywVx8FMhkQGFfb9w5OK0tK9xjy
	 k6RxLSnsnR1c2DH6sS7GhfDskzXEVsMipW0yWXJ3y9cbrk1z5MydtWCJ50mT76xNGT
	 I71eP+l84TN8Umbdz0tg8D6NNE4isTahgJSVhNSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbfDHQvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:51:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38921 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfDHQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:51:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so4830151pfo.6;
        Mon, 08 Apr 2019 09:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Oqary7Or5UZveMNzjPbp0eAcEqPbGi+YmFP+qZqLgiM=;
        b=DBIS7Xj7xl90P8qTRti4TiOxv44bcKYVUHMolb/tDcrZ0OcStHrnrVwc4SCD7ksNNf
         XO0E31QdeIzUrrabxUKCO0UERVcjw8v0mLzkY9ARK9MiXA9uoeSX4Vl1vWJvMytkr+NK
         ydlNMQ0u7u8b184pV7XCUoMEqQeEsuGqVatjcU+RbbZmMtFRGq2O6c8NGIWwO5wpYWTy
         YtMxLzaLA6herB10K6zivFl3xJPgx0hLFwLATIY7v65w1QT2ZwnnKnIMOEBusKixY0Lp
         dbXrtUpGtYiL9w9KAFwgPrbXjRMiSR9fU/ylMh23agPx4x11RrrNT1C9OpLKNki0YHuc
         LX7g==
X-Gm-Message-State: APjAAAXOJ29gzFCVfAf08VmbqakYmQEoMGXcmwHgo3s6JKPnibpcYdpJ
        lcvJretP2dDBpGJzNMdP190=
X-Google-Smtp-Source: APXvYqwndDsodgltn0BUMxHhkWZJrUrasWeRJUsP9LRXWqzhGpI29uAwyt8rkWF0vUWNrhx/kmg1ZQ==
X-Received: by 2002:a63:2c06:: with SMTP id s6mr29583620pgs.245.1554742270588;
        Mon, 08 Apr 2019 09:51:10 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id i15sm43635086pfd.162.2019.04.08.09.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 09:51:10 -0700 (PDT)
Date:   Mon, 8 Apr 2019 09:51:09 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Alan Tull <atull@kernel.org>,
        Nava kishore Manne <navam@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
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
Subject: Re: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Message-ID: <20190408165109.GA6459@archbook>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
 <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
 <d425bd61-238b-f085-f450-d052349878a8@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d425bd61-238b-f085-f450-d052349878a8@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Mon, Apr 08, 2019 at 04:36:15PM +0200, Michal Simek wrote:
> On 08. 04. 19 16:17, Alan Tull wrote:
> > On Mon, Apr 8, 2019 at 7:39 AM Nava kishore Manne <navam@xilinx.com> wrote:
> >>
> >> Hi Alan,
> >>
> >> Thanks for look into it and providing the ACK.
> >> I got one minor comments from Moritz Fischer do you want me fix that issue now or I can fix it later as it’s a minor comment?
> > 
> > Please fix for Moritz comment.
> > 
> >> In which kernel version i can expect this driver changes??
> > 
> > Patch 2/3 and 3/3 are dependent on 1/3 which isn't a drivers/fpga
> > thing, it's drivers/firmware.
> 
> I can take it via arm-soc guys if you are ok with that.
> Just need to have your ack in commits.
> We have done it like this several times, IIRC reset, nvmem.

I'm fine with you taking it through arm-soc. Alan? I'll look at the other
patches.

Thanks,
Moritz
