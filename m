Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE6FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A04D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jNo5WGDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfDJRDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:03:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37924 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfDJRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:03:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so3736168qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3S3EtzvI72IztZ1OecbcYhWottrkySxyyi6Vj03NVHg=;
        b=jNo5WGDEjci/sBFz88NZUSV1BNp9SwSmK+dVLGLE5nLOXa3ytE+LQ+0Wb1uFLlGfe5
         ShS/+GnDeFNStQpmP4wN4yO0WIMh0jMVyfO+BAW5GVyDAHEhQ6mfm4d7hgBpz9HT6EmZ
         zty6S6z0xO2MgN4SEyCLd9rYAp95JZqxgVQ0qS8vxRIrCpn/A4htKD8qyskGkIPRN3Ot
         wPouNwN7Xbhtb1CEg9ksnIvG00uym8jlIaR6ZqdEDrv3QBbUF3of7lfWc77DWsmaImoD
         5glwh0kMkg3RFgSVyhbjyuFE9sXlqBeX64WaUoRDeuDLPZRSp5k/2nokH42ynT/5tLEa
         81lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3S3EtzvI72IztZ1OecbcYhWottrkySxyyi6Vj03NVHg=;
        b=SZqXRchfVg+hRsY0UQi+97ZlK+FfJ9FbxgtDsrxGSdOjM4+PQIrTiYxP/X/5k0PsBz
         Qf6N9CwqRYQU6l2hkp9/SggZ8bYmPVzaPqISmv/2hjM83gTZl5Mm6d/Ku7yKh7FgNY3v
         XfZo5FAtjajf3zvXzAKMBgTZ4SqEqFR1cJwEfsX4K9MnZ9BZHKZfdbKFL2ilvYF7yjXQ
         6aCKKquJNdLQTGryiGMMeVtCzmV+lZMcRqTZfVMmfB6LaFRC71TKNTbVtskcPu38SXS8
         v3dNo/ovYR/Dz6e98MBYgZiInDs201lqn+Yu/6OfWAh1bXqHqGXUD6e5UEYKmI7Jv5Gk
         IKdA==
X-Gm-Message-State: APjAAAXA2whbBpCncXG8DfluaCgOKrxOxkEWdzUMtB69lmV2o29BXxZh
        aesIX8AHV6FGxrsC185Wof2bmg==
X-Google-Smtp-Source: APXvYqyca4r7fdowtvFUi4zx06RO6WTnatbNC4NrwBytBQkNptGP9xQOgCYQuVVSQbgu8RXxewSJsg==
X-Received: by 2002:ac8:1a6d:: with SMTP id q42mr35959956qtk.129.1554915797573;
        Wed, 10 Apr 2019 10:03:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x14sm23410371qtc.44.2019.04.10.10.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 10:03:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hEGd2-00042L-5H; Wed, 10 Apr 2019 14:03:16 -0300
Date:   Wed, 10 Apr 2019 14:03:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
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
Message-ID: <20190410170316.GK8997@ziepe.ca>
References: <20190409184958.7476-1-sashal@kernel.org>
 <20190409184958.7476-2-sashal@kernel.org>
 <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com>
 <20190410161949.GC11568@sasha-vm>
 <CAL_JsqJ0p8MsFe2HnqVHvdGyz=6P7dV++xj1d1TTgcobsFqpjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ0p8MsFe2HnqVHvdGyz=6P7dV++xj1d1TTgcobsFqpjg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:01:37PM -0500, Rob Herring wrote:
> On Wed, Apr 10, 2019 at 11:19 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Tue, Apr 09, 2019 at 04:18:29PM -0500, Rob Herring wrote:
> > >On Tue, Apr 9, 2019 at 1:50 PM Sasha Levin <sashal@kernel.org> wrote:
> > >>
> > >> The parameters are similar to the ones used by IBM's vTPM and the
> > >> various I2C tpm drivers.
> > >
> > >Bindings describe h/w (or firmware interfaces in this case), not drivers.
> > >
> > >>
> > >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >>  .../bindings/security/tpm/tpm_ftpm_tee.txt          | 13 +++++++++++++
> > >>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
> > >>  2 files changed, 14 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > >> new file mode 100644
> > >> index 000000000000..20fca67a56c4
> > >> +++ b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > >> @@ -0,0 +1,13 @@
> > >> +Required properties:
> > >> +- compatible: should be "microsoft,ftpm"
> > >> +- linux,sml-base: 64-bit base address of the reserved memory allocated
> > >> +                 for the firmware event log
> > >> +- linux,sml-size: size of the memory allocated for the firmware event log
> > >
> > >Firmware is defining linux specific properties? What if I want to run
> > >BSD? We should use 'reg' here instead.
> >
> > This is based on already existing code that defines these names, see
> > tpm_read_log_of() in drivers/char/tpm/eventlog/of.c .
> 
> BTW, that probably needs updating to handle endianness correctly.

IIRC this legacy IBM code has broken endianness in the firmware..

All that stuff in read_log_of, and the related DT stuff, is historical
IBM special case-ness and should not be copied into new things.

Jason
