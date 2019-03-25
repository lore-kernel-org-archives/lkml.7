Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2BC20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SMcubttW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfCYAUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:20:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40632 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfCYAUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:20:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so5089903pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H6F0jfN3QKdeUgxSbFVz+1v5BT05Mk/9KQ2E2ZVK9JI=;
        b=SMcubttWiAlkc1oNV/xyQND4SCMuLtGLKPKNe6m2sUkg5nq0GWZgltZ7zCvvKr683z
         vKTPcX2vA57V2jbzXxIzY7ul2sOE6Le6Jj3hD3qN1bDyiJE3opqgKdQcT/AgC6/VY8eI
         IrhxfRDDdoR2WeeMxj6MVFClBwy0RTMcVv/03phSxBdy/Kt1OjWvrHW3NZgtNwMxgIzS
         wumoV2QeJVilkWL71e8hFjFFPUPzxZ5E02kmWbjHXo1U3xIsY0bnB82j37e43M2vGcu1
         uN9K6jct7+0mhzKVr5xR7zOjJSLoJcwOryHjoIKZMC+xJXDAulHlfHPOh9q44XmUlKSj
         3mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H6F0jfN3QKdeUgxSbFVz+1v5BT05Mk/9KQ2E2ZVK9JI=;
        b=VojdM2mmA2ZR5Xx/W2ik6eiXs99GtIGtagIvV+dNbp9t5Ub0LoWW4JaWzskBYhheXz
         2ZRizQHIF/0E0US3N9QXn8EkIDLtFMlMV9+QsG/jVFXncV+VSsHp4wvKQE4IRexVGdIF
         APWS1Gz/2FkuPjmL0qle3w7oBd1Y6ID342Xf4PBc5AM9XwmanGtJjxsLsm9uQVKJP/vu
         019A8bbvtEYIqIXJuCNNtMqUfb3uyY+j+jbqe6g7bEjJXvgAYvp8nYRV0M2Gae/Ep2yd
         fI1LZ80GUiMk9vGX3o2O2bTsHMuC7j3PceaVNC/uCecKqaPWC4dchz2agXKHV1XO36DR
         x+RA==
X-Gm-Message-State: APjAAAUEpBfMh8H6fgZViQWSLdZ0EgkMfMkSmVw6XwSZLl+n5N6ZJbVA
        yXjCLAH9Nnbt+TnbvOQtesoeSw==
X-Google-Smtp-Source: APXvYqx886xWJu1IqCMsrRuW9w2rJPpUy/zJ9D9nunANZy1SJaKya7UQwU/Nak78yq2QPTYdTIILDg==
X-Received: by 2002:a17:902:a60c:: with SMTP id u12mr21273752plq.301.1553473244191;
        Sun, 24 Mar 2019 17:20:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z21sm20696977pfa.81.2019.03.24.17.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 17:20:43 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:20:42 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive EDAC
 driver and subcomponent
In-Reply-To: <1553082728-9232-2-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1903241704210.8028@viisi.sifive.com>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com> <1553082728-9232-2-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yash,

On Wed, 20 Mar 2019, Yash Shah wrote:

> DT documentation for EDAC driver added.
> DT documentation for subcomponent L2 cache controller also added.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/edac/sifive-edac.txt       | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/sifive-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/sifive-edac.txt b/Documentation/devicetree/bindings/edac/sifive-edac.txt
> new file mode 100644
> index 0000000..c0e3ac7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/sifive-edac.txt
> @@ -0,0 +1,40 @@
> +SiFive ECC Manager
> +This driver uses the EDAC framework to implement the SiFive ECC Manager.
> +
> +Required Properties:
> +- compatible : Should be "sifive,ecc-manager"

As you've probably seen, this is being discussed in a separate thread with 
Borislav, but it would be ideal if we could avoid adding DT nodes for 
non-existent hardware.  Let's see what the outcome of that other thread 
will be.

> +L2 Cache ECC
> +Required Properties:
> +- compatible: Should be "sifive,<chip>-ccache" and "sifive,ccache<version>".

We should only use chip-specific compatible strings for this IP block, 
like "sifive,fu540-c000-ccache".  Let's not use "sifive,ccache*" here for 
now.

> +  Supported compatible strings are:
> +  "sifive,fu540-c000-ccache" for the SiFive cache controller v0 as integrated
> +  onto the SiFive FU540 chip, and "sifive,ccache0" for the SiFive
> +  cache controller v0 IP block with no chip integration tweaks.

Same comment here.

> +  Please refer to sifive-blocks-ip-versioning.txt for details
> +- interrupt-parent: Must be core interrupt controller
> +- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals
> +- reg: Physical base address and size of L2 cache controller registers map
> +  A second range can indicate L2 Loosely Integrated Memory
> +
> +Example:
> +
> +eccmgr: eccmgr {
> +	compatible = "sifive,ecc-manager";

See above

> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	ranges;
> +
> +	l2-ecc@2010000 {
> +		compatible = "sifive,fu540-c000-ccache", "sifive,ccache0";

And as above

> +		interrupt-parent = <&plic0>;
> +		interrupts = <1 2 3>;
> +		reg = <0x0 0x2010000 0x0 0x1000 0x0 0x8000000 0x0 0x2000000>;
> +	};
> +};

- Paul
