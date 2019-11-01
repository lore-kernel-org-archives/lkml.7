Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56A7CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6EA217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/dyk5yK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfKARnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:43:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37142 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfKARnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:43:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24so1029813pfn.4;
        Fri, 01 Nov 2019 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QJl/9GvOTo1mXoprS9Z1FVuoJT7cvJ0SfTXW2ZwsvWU=;
        b=j/dyk5yKG+/Zb+2zjd8u2xn3vzhnpgHTuI0xH+uDSZ798ljUjQgKbUMa+y4AKD4szr
         CgKNJadkohLyHsfXr3XjvG8wEdsnapCo57hAincCLWN/bZgW/2PXLq1xqcg1W/6EWxlX
         8Q0zZtGSnPhMRXK92TNutM7SdHm2GaTJT1EiOdvEbX/utf+AMfyGYxWbnAGkN6djE494
         eHNyGrgpjH6Ar7SWoytBdfhd8Zbi6eiZPw1uRRTV4mx36oZ3kVA0j7mDDTgmfRf0Yty4
         K1Zbd3kSgqOy/yxgWwlbo/e8LYg/9UoTPCZ6G7uHuYn0I8fmFokfdibxNpc94c4tcFJK
         DLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJl/9GvOTo1mXoprS9Z1FVuoJT7cvJ0SfTXW2ZwsvWU=;
        b=VDGdPVPnlkzyonUAA6Gh8Fp68K5cDLlJzV9gzKvqqqbmprYs+OkEJ8NLq6QzK2Y6Ir
         P4urPrV7KPr6PP8MgJzsjXZ+jGmOK7Ln1v8Pd6guSZ2t1E9MHnuLUyM8KvZYn6ugvhWK
         mps5NiPuo1jx5F/jaU2SX4ToZxhtNTNqtFWw9AWG0MLKf/+Y79gViPHF7y0ddkTc0S6M
         8cVtgpjZ5lc/HZPSDq/Mrzs7Vb7tYIZpSt13avP1XbsC6Ecl8UZNL08tmhdqQPjKZtwI
         nqQa2iuIPprHn0gcT/TTzcGSuA5wCLQpg1f9tAgk6hqHZqcn72sehE9drbW3odYJEBKF
         AYhQ==
X-Gm-Message-State: APjAAAWro4wZVpy5fTkDc9H+TJvQNynl0qQCusEAT8G/r+jF4b92erRe
        zc4C64graGEbVxjnRj8PEk4=
X-Google-Smtp-Source: APXvYqzRiEfVYYVOG6O+ih3xK5Ax5k+9SP+dNi0+K0ffGqjJhG2LgDZzVmOsjy+yKL16LdvxRSyadg==
X-Received: by 2002:a65:4c41:: with SMTP id l1mr14902663pgr.163.1572630180944;
        Fri, 01 Nov 2019 10:43:00 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:200::1:e697])
        by smtp.gmail.com with ESMTPSA id a6sm9045892pja.30.2019.11.01.10.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 10:43:00 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:42:57 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Tao Ren <taoren@fb.com>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: add dtsi for Facebook AST2500
 Network BMCs
Message-ID: <20191101174257.GB13557@taoren-ubuntu-R90MNF91>
References: <20191021194820.293556-1-taoren@fb.com>
 <20191021194820.293556-2-taoren@fb.com>
 <CACPK8XfebA9PcpyWkofCJ5fAZ9ddUjQ4ZeCf73KXb51+k_+N1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfebA9PcpyWkofCJ5fAZ9ddUjQ4ZeCf73KXb51+k_+N1Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:12:10AM +0000, Joel Stanley wrote:
> On Mon, 21 Oct 2019 at 19:49, Tao Ren <taoren@fb.com> wrote:
> >
> > Introduce "facebook-netbmc-ast2500-common.dtsi" which is included by all
> > Facebook AST2500 Network BMC platforms. The major purpose is to minimize
> > duplicated device entries cross Facebook Network BMC dts files.
> >
> 
> > +
> > +&mac1 {
> > +       status = "okay";
> > +       no-hw-checksum;
> 
> Was this included to work around the IPv6 issue that Benh recently fixed?
> 
> If you can test your platform with
> 88824e3bf29a2fcacfd9ebbfe03063649f0f3254 applied and the
> no-hw-checksum property removed, please send a follow up to remove
> this property.
> 
> It's not doing any harm, but by cleaning it up there's less chance
> others blindly copy the same thing.
> 
> Thanks,
> 
> Joel

Yes. I'm planning to try the patch. Will send out a followup patch to
remove the line if everything goes fine.

Cheers,

Tao

> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> > +};
