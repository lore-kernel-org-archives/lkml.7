Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08B5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D1022DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566334248;
	bh=CLdvCu9OTkLmY9GNZTZeTwKQtMhOX1Yrdx6oLUtZTnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VkhC3WtiQKV0x7SO7ZsuXSlr23kheGa/nbE3Aw5wfr1BzT51oJ2Nnn79Bf1hNSF0v
	 ClI3lxMLqnv3rNHSDU/zP/j7Spn2t/H4phNnjoNevf9qq4ZhZ4xT62Ut/Ki5WSAk1J
	 NrNMJ+0ijhES9D5/D5AKc6WmgZGI37VH6lT5GoqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfHTUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:50:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34176 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:50:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so15527otp.1;
        Tue, 20 Aug 2019 13:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eLoUGZm6D8m9/EJ/SkCyN6iwOIcb5VgQEWDNQI8zDKE=;
        b=fZ5enmOvP91Ks5N45qztcaExa/OV3qFg5xEjg1ZNEW9/SAUcW2OdgW1NzE0JOTyDDr
         Xe63+mza8LUupQ9448hVAGa4IUhoO2mHt66crid/XPUDcqLLW3+H0nlnHs+hew7J8D9W
         jqXIrbCu3ILavDy0DT4b/SYuvF0hUSkDOhCJTPYwMsmKJtfHDF8oc5txPbcC6QIRvcpS
         LgEdpKc6NZOy8mQv+0CJN8+zBDWSjza6i00ksagzMSbR+U7gi1jGgKewPd6U6AFfZ0x4
         3VhafMY3Vsfb0EjHLYSj4zGHDBNfwrDaeYqrSZxsqarNaenwd43UvF9jBOJ2t1pbifO9
         5NOw==
X-Gm-Message-State: APjAAAUOUv9WnPr4Msg0ncDLQZ/HGVFaSsQNDTu8AAR7+4IQJ9OjF7NE
        tGRn5eCBAY+1BLKszXgo2kwVKLk=
X-Google-Smtp-Source: APXvYqxtgnb5L4TBNkOwQTLKE63x8Ly0s6rJRJ76zgwVqBO3fZBKGhbNwbaaDrxl5C/q/AFZvQhQhA==
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr23049070otr.64.1566334245580;
        Tue, 20 Aug 2019 13:50:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s24sm7220113otd.81.2019.08.20.13.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 13:50:44 -0700 (PDT)
Date:   Tue, 20 Aug 2019 15:50:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: Document JZ47xx VPU auxiliary
 processor
Message-ID: <20190820205044.GA1223@bogus>
References: <20190729183109.18283-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729183109.18283-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 02:31:07PM -0400, Paul Cercueil wrote:
> Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
> Ingenic is a second Xburst MIPS CPU very similar to the main core.
> This document describes the devicetree bindings for this auxiliary
> processor.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Update TCSM0 address in example
> 
>  .../bindings/remoteproc/ingenic,vpu.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
> new file mode 100644
> index 000000000000..576f9e582780
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.txt
> @@ -0,0 +1,36 @@
> +* Ingenic JZ47xx auxiliary processor
> +
> +Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from Ingenic
> +is a second Xburst MIPS CPU very similar to the main core.
> +This document describes the devicetree bindings for this auxiliary processor.
> +
> +Required properties:
> +- compatible: Should be "ingenic,jz4770-vpu-rproc"
> +- reg: Must contain the registers location and length for:
> +  * the auxiliary processor,
> +  * the Tightly Coupled Shared Memory 0 (TCSM0),
> +  * the Tightly Coupled Shared Memory 1 (TCSM1),
> +  * the shared SRAM.
> +- reg-names: Must contain "aux", "tcsm0", "tcsm1", "sram".
> +- clocks: Clock specifier for the AUX and VPU clocks.
> +- clock-names: Must contain "aux", "vpu".
> +- interrupts: Interrupt specifier for the VPU hardware block.
> +
> +Example:
> +
> +vpu: cpu@132a0000 {

cpu is reserved for CPUs under /cpus/. Use video-codec or video-decoder 
or ?? It's not clear what type of video processing this does.

> +	compatible = "ingenic,jz4770-vpu-rproc";
> +
> +	reg = <0x132a0000 0x20 /* AUX */
> +		   0x132b0000 0x4000 /* TCSM0 */
> +		   0x132c0000 0xc000 /* TCSM1 */
> +		   0x132f0000 0x7000 /* SRAM */
> +	>;
> +	reg-names = "aux", "tcsm0", "tcsm1", "sram";
> +
> +	clocks = <&cgu JZ4770_CLK_AUX>, <&cgu JZ4770_CLK_VPU>;
> +	clock-names = "aux", "vpu";
> +
> +	interrupt-parent = <&cpuintc>;
> +	interrupts = <3>;
> +};
> -- 
> 2.21.0.593.g511ec345e18
> 
