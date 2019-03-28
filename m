Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5465521773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553791351;
	bh=jiexcAJ0ZTweIpchPtK1jbfqG/3F209MB/hi1F/P5uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qU9xAARHV5pWdJBwP68+CGLITemyytpZQHrMgmjH4GRFChz3ZPehzWdMDkKZilkFV
	 OJbSy3RkyEJc7iad+cN+n0MISnahuFNVaHNT0f/POEoCTsnc+CwNulKrXTBVUF1r12
	 sALLPoa4bTX0pHsxvWW6S1sJtKTG8K6t7vmng5xA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfC1Qm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:42:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34791 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1Qm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:42:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id k21so17593845otf.1;
        Thu, 28 Mar 2019 09:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8kycz9XMCF70bcxgp9Em595aphLAxz9oecWZA8qWQ2Q=;
        b=eYU7m1XYSRiT0l/rMN4Rvj0d0swJx03Yg66FmbsiowMgqZriIKLo9UaD7TBWN+wO1w
         jTGMaTV2m51zMUg5drVr+ftgv2rkBliNanxfQ6Kb925u9T6GNq7lIKFXKHDS6iBXbO6A
         da2F+XT+Eb2LJmAIm8TElLtn7LkUNS306KmMDb3LOC4QjxULAe+o4l59GitR1vS7GRDY
         SSCfFF/O4vZE6x0kk+bftMWTThm2ojlupmQDLHrrsYQTUQUzRJP9YK763LM6P1HPiQym
         nQ0ANdLSn6hsOCZv4Ud0QYJHT4vzfYHF8nGNQdzKza7U4Le63BXZqYbF8O8ZlMFtKcZu
         ilTA==
X-Gm-Message-State: APjAAAXJb2CFDRNUVzPEcHTa35jiLU9XWMsKQiDrljFNCWJRL4UsD4GC
        haAcQimTKplXmXM/56UPbStkQc0=
X-Google-Smtp-Source: APXvYqxv7MdMrX64tJDnNw1wUYoOniA5D3CckspVusDtcVPZN04xrvrR9fwbHCzlaXcUpxa7SbdmZg==
X-Received: by 2002:a05:6830:2094:: with SMTP id y20mr30870085otq.316.1553791348509;
        Thu, 28 Mar 2019 09:42:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c84sm9574459oia.41.2019.03.28.09.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:42:27 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:42:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4.1 armsoc/drivers/bus+gpio 2/5] dt-bindings: bus:
 Document moxtet bus binding
Message-ID: <20190328164226.GA8579@bogus>
References: <20190307125251.724-1-marek.behun@nic.cz>
 <20190307125251.724-3-marek.behun@nic.cz>
 <20190311225906.GA9056@bogus>
 <20190314150135.4362-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190314150135.4362-1-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 16:01:35 +0100, =?UTF-8?q?Marek=20Beh=C3=BAn?= wrote:
> This adds device tree binding documentation for the Moxtet bus, a bus
> via which the different modules connected to the Turris Mox router can
> be configured.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/bus/moxtet.txt        | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
