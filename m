Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C145ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257DF21835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570812832;
	bh=T3YRm+69DE1IuAAfklZBMAMakgcuUyWe+kKVcI+hwJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iFmsN8AlZRFpMQ9kZBzNIYCvgASCUXHzZtjrGX9fnLrkoR7R9vbvbfM3G3GDBf5Mf
	 lDk7/NSHU1OJHdxCowCI+lUbPemXCRas0eEkYP1BLfD6re0n1Vco8u0vXz1MGR9sD+
	 j3DC7ZYq1dMFnUOgWADM1OQ5UzyV4B9jxRpCRAmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfJKQxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:53:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47096 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJKQxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:53:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id k25so8536111oiw.13;
        Fri, 11 Oct 2019 09:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+XKxoI9VpM0Y86gFJFH44QIdHz4jpQag2jQU1HryGoI=;
        b=sUn3J1hOuQ0AWg5lmMzh36kRz5NcsgxmKuPFTKs+f9ssaU+2EuvtoR9oZx02OGXd8F
         YRM8bP3ZIr5q9hYRDJw4jwcL+i2eobhe8otbyHiZ0VBQvTuo1Ou7vS7L4S2ZutTSPJK1
         /a9lquIf7jnra+eev1yRB59Oi+IL9HMeqCjJexnWScnnECXJUmnwIgR6eRR8GogD1WIJ
         2F5kCth+YKoDKVgCvB4lWUNspL6xPqQWKIqYPo/dhjtTIgT/k/n4BwzlTV9BFpaEBfba
         aAcI13ghbZ5TCX8wGbck2nRSsKgOXgJtNpzh8vhXQF/YlVVpuqgJt3OwbHxcRxeGuM++
         KlxA==
X-Gm-Message-State: APjAAAVp0pzf/pjT1NERKwc1eAMk8fV7orJf1cPJTJttNEpCcT2wDi00
        P7s5RRP+CtkAHkdoQs+/sw==
X-Google-Smtp-Source: APXvYqyYET1+fTjJYIyVH/pXbQ1FdDUKmjrg95oxGL5k6oWwgKL6dHqyCHb3/OZD4qwDDFHOQLnKwg==
X-Received: by 2002:aca:490f:: with SMTP id w15mr13254293oia.159.1570812829223;
        Fri, 11 Oct 2019 09:53:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm2673691oiz.3.2019.10.11.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 09:53:48 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:53:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rajanv@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: Add bindings for Versal
 firmware
Message-ID: <20191011165347.GA4114@bogus>
References: <1570474343-21524-1-git-send-email-jolly.shah@xilinx.com>
 <1570474343-21524-2-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570474343-21524-2-git-send-email-jolly.shah@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Oct 2019 11:52:22 -0700, Jolly Shah wrote:
> ZynqMP firmware driver can be used for versal also.
> Add versal compatible string to zynqmp firmware driver
> doc.
> 
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
