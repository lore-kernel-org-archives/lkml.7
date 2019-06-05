Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540FBC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEDC20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkcAKbCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFEEeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 00:34:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46649 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfFEEeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 00:34:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so11648410pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 21:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pc+c8eY7Iq/+7TtGxqa35YybGgmrc2UlNdR+JGfsU4M=;
        b=zkcAKbCn2gFSmlQi34ZZkufmznF9FSLA8mpn09NFi+m1OVsEL3ASGTnJeGNHnFXWpF
         UjsjvAoxGm35tZs+K1UjJ3uFX66rwlxbprNwUebASYISBOqSWsYyFiBFY+u/j3pKZfxl
         nvoI6PTX3Omm32LIyhKVoigr66Dr2E5jfhexllz0jb/TRGJXUP8TlAhA23uSle7R1YPh
         jcxLZaHBUKzgYSYSLPueb2ZeOznwlCyZUFSR7euf/85DAvWYrtG3/tSbpqbhhP9b6IWL
         b7h3q/xKdPOeSWQ7Aq6xE+fHQE6NpETOfHamY4ZRPguXOi9jyv13D007sR0cdqiLaXA8
         iDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pc+c8eY7Iq/+7TtGxqa35YybGgmrc2UlNdR+JGfsU4M=;
        b=H88a5gU3ohBeH4uqBd4537L4FScFhSae26M28nXlyb3W+XYKzGXYcarFSv7rcZsFwK
         w/Bl/uWeMBp8vDGtzEfQTzdQX7NEvykK+/FSwYvI6a91s+jOZqhxRQod6Gu/xsZjm8v0
         U18FT8s1KHWhak6ieXLpFelPYm0HXtgOK5o/tD2vo4++bfb5urijXkg7f5EjXMw/opq7
         rHqD1AmEOCiP9fZ143y/CRpO0gxGSVqm7HatZWtiQuctzUX5ME+wHcK8qdtfcH4EcmZh
         cenQDHJHuwP6hL58iVsNAQ57RHD37LooaYh9+9Hjce97f6jCjlqIkCIUA2M/vzzImDDa
         w3Tg==
X-Gm-Message-State: APjAAAW/cXjjW8/31wBMlQ9vfP2bREVSzqHXc5Y8x8M18x1BjPVuvacS
        xrnv7PFErwun9pHyymmaiuPtfw==
X-Google-Smtp-Source: APXvYqz9sXuQx/EU3mOB34oM3DKhkPDs+bF8LZHwDiH9jjJI+PMu78/upExQhosAA/9iTcdG7GuKnQ==
X-Received: by 2002:a17:90a:6505:: with SMTP id i5mr38438089pjj.13.1559709247265;
        Tue, 04 Jun 2019 21:34:07 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w187sm26524476pfb.4.2019.06.04.21.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 21:34:06 -0700 (PDT)
Date:   Tue, 4 Jun 2019 21:34:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     ohad@wizery.com, wendy.liang@xilinx.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH 0/3] Enhance virtio rpmsg bus driver buffer allocation
Message-ID: <20190605043452.GI22737@tuxbook-pro>
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31 Jan 07:41 PST 2019, Xiang Xiao wrote:

> Hi,
> This series enhance the buffer allocation by:
> 1.Support the different buffer number in rx/tx direction
> 2.Get the individual rx/tx buffer size from config space
> 
> Here is the related OpenAMP change:
> https://github.com/OpenAMP/open-amp/pull/155
> 

This looks pretty reasonable, but can you confirm that it's possible to
use new firmware with an old Linux kernel when introducing this?


But ever since we discussed Loic's similar proposal earlier I've been
questioning if the fixed buffer size isn't just an artifact of how we
preallocate our buffers. The virtqueue seems to support arbitrary sizes
of buffers and I see that the receive function in OpenAMP has been fixed
to put back the buffer of the size that was received, rather than 512
bytes. So it seems like Linux would be able to send whatever size
messages to OpenAMP it would handle it.

The question is if we could do the same in the other direction, perhaps
by letting the OpenAMP side do it's message allocation when it's
sending, rather than Linux pushing inbufs to be filled by the remote.

This would remove the problem of always having suboptimal buffer sizes.

Regards,
Bjorn

> Xiang Xiao (3):
>   rpmsg: virtio_rpmsg_bus: allow the different vring size for send/recv
>   rpmsg: virtio_rpmsg_bus: allocate rx/tx buffer separately
>   rpmsg: virtio_rpmsg_bus: get buffer size from config space
> 
>  drivers/rpmsg/virtio_rpmsg_bus.c  | 127 +++++++++++++++++++++++---------------
>  include/uapi/linux/virtio_rpmsg.h |  24 +++++++
>  2 files changed, 100 insertions(+), 51 deletions(-)
>  create mode 100644 include/uapi/linux/virtio_rpmsg.h
> 
> -- 
> 2.7.4
> 
