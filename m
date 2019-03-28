Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985DCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621D620811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553795612;
	bh=IYxxt8vFvde6RSMt1zx7D1ssvSP58/f9aizVnEpb9Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=USm7sZGFJT25cgKVO81bRZDSFqO/X+cqkoPzzVlGPakGmy7WUUje7Jgc7ZFydcL1/
	 MVoOQHUQofd/fBISxObSPAILTRS0Ca7xbiMVSrO9EZA2D5ZC/z4KZnivJ3K8okQebg
	 5orRl2DXYPD1RnQKvAapUH10ktf50A0CXcLvYb4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfC1Rxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:53:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34094 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Rxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:53:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id k21so17816474otf.1;
        Thu, 28 Mar 2019 10:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0MH5RxWTzI66An3YJe7SRKxOobpt0IpUHE5VLv1BOM=;
        b=PR3kScBo135E6SWcVnb/m7TZnVvx3eOTY9xvJul8IzD8z2rL5+d6VBcB046R/ssUHA
         MA57RL6OAUEddwMcewk7a01sAuv/1k8Pimi4bTnqzS41TR+QhWjNR/lTS+YzGkOTXJxy
         qtVCTeyoWtcoW5sC8lKJkARKKH8RqhwH+2vG5x/D2rtFFsfaloeK7iaqMKM+6AL4zjcd
         5LQrhQaHQs9Eybv6gHSpn643YuRiZbMTMnqbcJv9dLUU229Lny8UGCseMIEtcb7dp3O6
         Fz6zK8rlLjq3dSlkiNaiNOCe0QbgX0E+m1+K2R/5rKGmEOUijFAAdQT4YI+4HCImaUfk
         Oa+w==
X-Gm-Message-State: APjAAAXtwxVS1xFz9F684BjsaIe4ALkW9xEGcno5x9Ys35h7zv9VrxP6
        9H7J/KlT8LGQUnoRR5GZ2A==
X-Google-Smtp-Source: APXvYqx/lhtxNFIZabAeBFr6cX1gAK85qC02J7wbQogY19gqcFUK4/wQGthph7wTSUZMN2aIck17nA==
X-Received: by 2002:a9d:6ad1:: with SMTP id m17mr30474484otq.108.1553795609971;
        Thu, 28 Mar 2019 10:53:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h8sm1733221oti.64.2019.03.28.10.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:53:29 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:53:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: iio: light: add vcnl4000 devicetree
 bindings
Message-ID: <20190328175328.GA19947@bogus>
References: <20190321154047.23236-1-angus@akkea.ca>
 <20190321154047.23236-4-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321154047.23236-4-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 08:40:45 -0700, "Angus Ainslie (Purism)" wrote:
> Document the vishay VCNL4000 devicetree bindings.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../bindings/iio/light/vcnl4000.txt           | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
