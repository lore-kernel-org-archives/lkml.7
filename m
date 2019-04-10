Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A10C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9782063F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EX2ze/6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfDJR5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:57:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42850 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730819AbfDJR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:57:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id b74so1775574qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rvFEBtg/8gPu1SPiOVpApQWqwc7src0Ap4Z1oALjYi0=;
        b=EX2ze/6DAocz2055pAEWSuvrjiGWI6P2LQHdyigF9CLGW/hGVAATJVoaI/0ctLcV4p
         enIpOq3OsjgeA8tofJaLL/G7INTFaljBstYyl2dtzQ2+tO8g51e82gdwSW2QMmKRCqTI
         3pPJkL8xyfL8dscXwYCu6Nbn7laB9gzLT2OvxkZfq/yshCnZua1c8wGez0NEU5KQQZiD
         Voxe0O4fLF+XZTlTEImSY/9Exbls1e45eROXj0mBffWi+KfLZmkPKAd+Wl/kMxUXSObr
         tvtu8ZyWLHTA3a8QlfmAIJQkY9CODeqYg8XOAK/BU//Z0fcWRZeAJXJnUwVHoa4qLJzK
         62Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rvFEBtg/8gPu1SPiOVpApQWqwc7src0Ap4Z1oALjYi0=;
        b=thk4VFYIa2pU8SoelM1a3PmaMFwzpfP3I8MR33zg2t5vMFl4H3ojaY+c5SB+6T1j5y
         KiIyOvvgh47KCybEkMgA3jj26SdYsx+DBeDz6zfrntDjO7qnF4A291uOU5a6y3AmVPW6
         Zgo+bydgg1ccpKLifFooEk1Xfg+QGacchzel4a0x2X8JO5SCtow8Vz6TOXOGAVKXCxzy
         Eq512BGwoPpBrrMvICP32JhHWDHrkenf3Ruwhj5USdKjEo7e8SXqBh4YLi+z7XO6pIsB
         n5MQJhOkiLA5eVo8fu3Cc/217euIXdU+DO9Uew94b71yFPTreyI1S83/ZE+F5fBXOVqD
         7PnA==
X-Gm-Message-State: APjAAAXuXMwYjC3zLZu15YfiNFHyhkjrOcRO/AMh97x2UrP41ynFAG8M
        b0JNGExrm5gNIzyby3otOwvh5g==
X-Google-Smtp-Source: APXvYqzHjti7rsotzy6Brc9cjV0LRaZNbg9/rET8ZBSn3KNT+vhVW5zHbMjiwy2OOmzae5gN8kGBhw==
X-Received: by 2002:a37:b444:: with SMTP id d65mr34415956qkf.125.1554919029700;
        Wed, 10 Apr 2019 10:57:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id c21sm18785060qkm.8.2019.04.10.10.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 10:57:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hEHTA-00023n-9J; Wed, 10 Apr 2019 14:57:08 -0300
Date:   Wed, 10 Apr 2019 14:57:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v2 1/3] ftpm: dt-binding: add dts documentation for fTPM
 driver
Message-ID: <20190410175708.GM8997@ziepe.ca>
References: <20190409184958.7476-1-sashal@kernel.org>
 <20190409184958.7476-2-sashal@kernel.org>
 <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com>
 <20190410161949.GC11568@sasha-vm>
 <CAL_JsqJ0p8MsFe2HnqVHvdGyz=6P7dV++xj1d1TTgcobsFqpjg@mail.gmail.com>
 <20190410170316.GK8997@ziepe.ca>
 <20190410175359.GE11568@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410175359.GE11568@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 01:53:59PM -0400, Sasha Levin wrote:
> On Wed, Apr 10, 2019 at 02:03:16PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 10, 2019 at 12:01:37PM -0500, Rob Herring wrote:
> > > On Wed, Apr 10, 2019 at 11:19 AM Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > On Tue, Apr 09, 2019 at 04:18:29PM -0500, Rob Herring wrote:
> > > > >On Tue, Apr 9, 2019 at 1:50 PM Sasha Levin <sashal@kernel.org> wrote:
> > > > >>
> > > > >> The parameters are similar to the ones used by IBM's vTPM and the
> > > > >> various I2C tpm drivers.
> > > > >
> > > > >Bindings describe h/w (or firmware interfaces in this case), not drivers.
> > > > >
> > > > >>
> > > > >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > >>  .../bindings/security/tpm/tpm_ftpm_tee.txt          | 13 +++++++++++++
> > > > >>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
> > > > >>  2 files changed, 14 insertions(+)
> > > > >>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > > > >>
> > > > >> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > > > >> new file mode 100644
> > > > >> index 000000000000..20fca67a56c4
> > > > >> +++ b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > > > >> @@ -0,0 +1,13 @@
> > > > >> +Required properties:
> > > > >> +- compatible: should be "microsoft,ftpm"
> > > > >> +- linux,sml-base: 64-bit base address of the reserved memory allocated
> > > > >> +                 for the firmware event log
> > > > >> +- linux,sml-size: size of the memory allocated for the firmware event log
> > > > >
> > > > >Firmware is defining linux specific properties? What if I want to run
> > > > >BSD? We should use 'reg' here instead.
> > > >
> > > > This is based on already existing code that defines these names, see
> > > > tpm_read_log_of() in drivers/char/tpm/eventlog/of.c .
> > > 
> > > BTW, that probably needs updating to handle endianness correctly.
> > 
> > IIRC this legacy IBM code has broken endianness in the firmware..
> > 
> > All that stuff in read_log_of, and the related DT stuff, is historical
> > IBM special case-ness and should not be copied into new things.
> 
> The fTPM driver does not use it on it's own, so I guess I can just drop
> this patch then?

If your ARM system boots via EFI then it should pass the firmware
event log through EFI mechanisms, IIRC.

Otherwise maybe you could make a case for using this, but only if the
old IBM stuff is perfectly emulated, bugs and all.

Do you even have an event log?

Jason
