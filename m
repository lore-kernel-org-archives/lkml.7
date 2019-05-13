Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1FAC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126E620879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557769882;
	bh=ynIKTWN06OJPzN5vGj2a4r/O71RyIvtDR+im2Rc3yoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rHLWXeAu4asIdUEJO9aALAySXgG0LFrtJIc5wylvJ/U700/BYGwYj8BOAReQCyQgH
	 fKRV3uuvCovoaPWBWL7OkyMEu4K8S/9lZsmUtZajPhuSawl8aXwv3VEOhw63xB/gYe
	 /gOIBJ3TltVQxaNhmGBlW8AJO3tzBmqVeZmrtn0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfEMRvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:51:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45711 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbfEMRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:51:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id t24so3894762otl.12;
        Mon, 13 May 2019 10:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4N4IZgDvzO5+VbOkAL+/qLpzVDWLu+YalUcmqAEWjc=;
        b=jnwFH8UA94RdkkU6CHRBw5rimQjGO2zj1ZuICVrlxgXiYjbYUK7b4LtF+ejfmo22Xk
         bQ8BAJ4rBW+Th20chDf3J2ld2TBO4Ea1V8N5rq77Re59zvMe119k9q9dUWuGtEIu+AJ2
         tEEL3cUgWwkbMa6caJM7A2pQ5rB0uXJt0txXF95VpKGvT3NvwuFzv2/mDX+SiqvwhMwa
         paDQqNHWNdIfdpUSsrfqN/ddMFwILEmcFaP4oqCaboGhvY6K0Sut+Qiy75qKqAqp337Z
         t2ZvJabIsA6TiViBzrqWktAQxwJsyp3mWuSplsf2gJjoaeMnc5XGJncL4btRv5MBYpnv
         HyvA==
X-Gm-Message-State: APjAAAXpsXPy9aeV7ZsgMHqDpRRTHm7/+vTwyt9kr08r9OQIr+WxfNcz
        n6onuQ8x3atYt5Cp8mHvoA==
X-Google-Smtp-Source: APXvYqyi6vDqkZOF8NsHPlQ7yDvigtmGZCYFZkAc4wdlsemMKX21ODIa4vUe8/dokESav8OUMfKvnw==
X-Received: by 2002:a9d:6d8c:: with SMTP id x12mr11381060otp.34.1557769878486;
        Mon, 13 May 2019 10:51:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x21sm576703otk.4.2019.05.13.10.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:51:17 -0700 (PDT)
Date:   Mon, 13 May 2019 12:51:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [PATCH v3 4/6] dt-bindings: soc/fsl: qe: document new
 fsl,qe-snums  binding
Message-ID: <20190513175117.GA22288@bogus>
References: <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
 <20190513111442.25724-1-rasmus.villemoes@prevas.dk>
 <20190513111442.25724-5-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513111442.25724-5-rasmus.villemoes@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 11:14:58 +0000, Rasmus Villemoes wrote:
> Reading table 4-30, and its footnotes, of the QUICC Engine Block
> Reference Manual shows that the set of snum _values_ is not
> necessarily just a function of the _number_ of snums, as given in the
> fsl,qe-num-snums property.
> 
> As an alternative, to make it easier to add support for other variants
> of the QUICC engine IP, this introduces a new binding fsl,qe-snums,
> which automatically encodes both the number of snums and the actual
> values to use.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> Rob, thanks for the review of v2. However, since I moved the example
> from the commit log to the binding (per Joakim's request), I didn't
> add a Reviewed-by tag for this revision.
> 
>  .../devicetree/bindings/soc/fsl/cpm_qe/qe.txt       | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
