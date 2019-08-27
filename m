Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC61217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566937585;
	bh=15M1BkluzZdDH0MDgQ/qeKc3RQSd4gxd011zkUE6rW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FEjjg3u0McWaiUFiQgyI8Mgpw2GkATb/gRIXSqeO+HZHAyEsNlEKSSPYhyNktV+M1
	 pgnMaQ1CnuUJGr8a9B/CHHdCCHYb8hm6mrhHQ2HhY9UT1wBFBQXNWztpYA1a5ubLAx
	 iaOd1RG+ZqQKiNytUPoYvpapJWyG3+ohaFKgzuNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfH0U0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:26:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40062 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0U0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:26:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id h21so289496oie.7;
        Tue, 27 Aug 2019 13:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJafdp9XsI7mzj3hJGruH3bP4YYXWdgduJkXKPlsaeA=;
        b=t/HqgTuZWCYoWAWDhP7wvUgnl5kQ6iZ2E0Wn+ywqMHBwT0OY4N8n3+dn/Xm+qOL7eR
         COWk2Hps8v+TnqyO9O3z0NKgcrsZh73ILhbET5QPzipVd0WDeMd7p8M3QpROXDc1vdxE
         1PTL62JdJ4szSlztIlaHp0IuobaRiagmHPNLm/OiGS5xiEuCTZPViYKeYptznbxZZ6J2
         nZdoFFPwf70noNnEJF3G2LqYYjw+m9Nn3OrckejlU3NdqoBMTkS8XGmWoqfPjYH0ixui
         6M6tefCphawVOtXw64YW9xti/ZG+g284SzBsTQU3KVLj/Glc3ssVfKFim4dqD6wUpzng
         u+KA==
X-Gm-Message-State: APjAAAUpwG19Uo3GA2ny736t0f7qQ1NJ2/GaWl6Zkl9citMvyxornPrG
        ahhK39JZ8ZPYkhqx8x0qew==
X-Google-Smtp-Source: APXvYqyKie8vatTjl5awxYMdKBNp12v/B6SKJjd+ugH9yGwI/S8MRo4Z3W0w2zAQDAC2/ZrDzebOpg==
X-Received: by 2002:aca:5152:: with SMTP id f79mr393628oib.124.1566937582955;
        Tue, 27 Aug 2019 13:26:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r13sm73551oic.56.2019.08.27.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 13:26:22 -0700 (PDT)
Date:   Tue, 27 Aug 2019 15:26:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: serial: Document Freescale LINFlexD
 UART
Message-ID: <20190827202621.GA703@bogus>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
 <20190823191115.18490-7-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823191115.18490-7-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 19:11:40 +0000, Stefan-gabriel Mirea wrote:
> From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> 
> Add documentation for the serial communication interface module (LINFlexD),
> found in two instances on S32V234.
> 
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
