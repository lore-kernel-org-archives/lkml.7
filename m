Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB549C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5E42190F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 06:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="OKzGoShI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfIAGzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 02:55:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36483 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIAGy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 02:54:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id p13so11473438wmh.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XYdPrFA2J3DTY7/lSVI62Ok0NzjOcwb2WpS7Q+toQmY=;
        b=OKzGoShINhalz+xKm+CUlIsJCCoXo0kDsFdyZFXd13Gy3f4GZAkV54LbRh4s2E737l
         OwQVUXYnFuJykltn1MyuVd6f8THnEfMKhyKC0rJ1FGsTUdAn5d0VPjXEe6OurH/Z70vp
         YAfpe9WGG00Cy9vpcqTJIw5OaLKHlkAKW/ECwLJ/H8LUd1yAktW1RzR+VLBK2TlpBHs2
         MzDdevMNh1a2y/scHMZM0CnKYRZLICvyaheJxZOzcuuVxcsDUPMlu95emX3sf7wZ4tLv
         AvW0UXaWjQcfFlZyKPv8IkFNCBxoN3gbxRiAEp7ck8+eGtvEH2+CjMv+LnxyXLZ0OsDH
         foCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYdPrFA2J3DTY7/lSVI62Ok0NzjOcwb2WpS7Q+toQmY=;
        b=ipbqzk3sRIBCVaomqLXcTlHJKP1HDbYWzJdVbnENTldf7Fd1JH3k/1mwKPvP4ix4+o
         LOAY11ns4cHGidBez1o0qwhiUcuBvXWWqVZwTpQSw95SL1L/FNWdBMBi+zLsttYsiHW7
         bkbcVk9Shzso7FD92VX56I6MlHXLFDjiaZN7Wmk/hxH1mC10ycF02Ngyba2l90262lf1
         dHuTEhMtUbmgcqnKuwiNe3ShcjwRgq8dg29/hcsYZqsdyeOH6aw17H+8wqsvvYcqKPPW
         4eX2HuwiISgH97eDWgZDD1hFa59c7bhG6T0TfnM4Is1Fz5ev1Bch5aOOAKFEM2fNrbTZ
         d8Bg==
X-Gm-Message-State: APjAAAUsExnyagW0s5k9jWwKib6RI3djyZzcLDLEFHFdzTtdzN5Vr3H2
        7vXzSv3/qVHm4/mNSY56eUR8gw==
X-Google-Smtp-Source: APXvYqxm9791UD67ea6Bd8CbecdlELTO2unl/ksZpVB6hzwZj3KIXEKeYQyxle8JIZILU1WXlfeKvQ==
X-Received: by 2002:a1c:a54a:: with SMTP id o71mr5634451wme.51.1567320897500;
        Sat, 31 Aug 2019 23:54:57 -0700 (PDT)
Received: from localhost (ip-78-45-163-186.net.upcbroadband.cz. [78.45.163.186])
        by smtp.gmail.com with ESMTPSA id c8sm10103425wrn.50.2019.08.31.23.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 23:54:57 -0700 (PDT)
Date:   Sun, 1 Sep 2019 08:54:56 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Ido Schimmel <idosch@idosch.org>,
        David Miller <davem@davemloft.net>,
        horatiu.vultur@microchip.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com,
        ivecera@redhat.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190901065456.GU2312@nanopsycho>
References: <20190829175759.GA19471@splinter>
 <20190829182957.GA17530@lunn.ch>
 <20190829193613.GA23259@splinter>
 <20190829.151201.940681219080864052.davem@davemloft.net>
 <20190830094319.GA31789@splinter>
 <20190831193556.GB2647@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831193556.GB2647@lunn.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Aug 31, 2019 at 09:35:56PM CEST, andrew@lunn.ch wrote:
>> Also, what happens when I'm running these application without putting
>> the interface in promisc mode? On an offloaded interface I would not be
>> able to even capture packets addressed to my interface's MAC address.
>
>Sorry for rejoining the discussion late. I've been travelling and i'm
>now 3/4 of the way to Lisbon.
>
>That statement i don't get. If the frame has the MAC address of the
>interface, it has to be delivered to the CPU. And so pcap will see it

1) you cannot go to slowpath for all such packets (route)
2) you might be interested to examine packets with other dest mac too.


>when running on the interface. I can pretty much guarantee every DSA
>driver does that.
>
>But to address the bigger picture. My understanding is that we want to
>model offloading as a mechanism to accelerate what Linux can already
>do. The user should not have to care about these accelerators. The
>interface should work like a normal Linux interface. I can put an IP
>address on it and ping a peer. I can run a dhcp client and get an IP
>address from a dhcp server. I can add the interface to a bridge, and
>packets will get bridged. I as a user should not need to care if this
>is done in software, or accelerated by offloading it. I can add a
>route, and if the accelerate knows about L3, it can accelerate that as
>well. If not, the kernel will route it.
>
>So if i run wireshark on an interface, i expect the interface will be
>put into promisc mode and i see all packets ingressing the interface.

Again, you are merging 2 things together:
1) rx filter - this is needed for bridge, ovs, others (tc)
	this is promisc setting
2) cpu trap - here one may be interested in:
     a) only packets ASIC traps to CPU by default (ARPs, STP, BGP, etc)
     b) all packets ingressing the port (note that those are only those
					 passed by rx filter)

Clearly 1) and 2) need separate knobs. In 2), there are valid usecases
for both a) and b). Only the user is the one who can tell which is he
interested in. This can't happen automagically.
Can we just have a knob for 2)?


>What the accelerator needs to do to achieve this, i as a user don't
>care.
>
>I can follow the argument that i won't necessarily see every
>packet. But that is always true. For many embedded systems, the CPU is
>too slow to receive at line rate, even when we are talking about 1G
>links. Packets do get dropped. And i hope tcpdump users understand
>that.
>
>For me, having tcpdump use tc trap is just wrong. It breaks the model
>that the user should not care about the accelerator. If anything, i
>think the driver needs to translate cBPF which pcap passes to the
>kernel to whatever internal format the accelerator can process. That
>is just another example of using hardware acceleration.
>
>   Andrew
