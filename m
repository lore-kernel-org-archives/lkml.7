Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC8AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7192053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557248854;
	bh=xnEhFG+m6ScPDjEnN/7zBKPSN/wvYqvifU3Wwa0VGTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fs+6UfIYMUf3d7Fu0rZrB/6GRwwCz+kYj6fAst2mvO/Y9mJZM8WkECaOLOkzp8bU+
	 e0nsIKXherQ/llb2SUUh2K7wOxbb848cXdvCYbtrPoEF86Q8QVwBhQRxELsMou19BO
	 A7VoI3RlyfEdsBspz/nasUAvz5ly3aZT21n19k18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfEGRHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:07:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37582 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:07:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id 143so12955090oii.4;
        Tue, 07 May 2019 10:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WHdJL4zgiCckMC9QTbgttbrInYfGHIvnfQMkwfBuMjg=;
        b=A0TYtG1vAm+fvVHRI0JaDC0yV+7+dEHAerzyZDW7GgiezfLWJ5fqws+GMAtxJ+TuVO
         QjINHhY7cbmiDQbm+F+Ipxeag7CCxX0N2PzbkUvuPstuyyu4k3k1huAi2h3ylnUBsxfd
         cAtUVvG4bMZRoEpNQZugu89Otayekj/xxCvmdLtKvfqZtH3/RWR7YHgOGN2WSBvDLNTC
         neD/AvHWuHLb66UydEJw/8b9pb2RYtJsoHV0Q8YhvAnqwCBedzbo1z19WchmtDQUjWzh
         XHBoQL2vcZ+mRfJZImQTY5bfvk42iOt9muWFfhxBn9T99vyZvGz9hy/A2Oq/Cx9HBKeF
         PmcQ==
X-Gm-Message-State: APjAAAUUFFp1WqYZA/SiDpB00HGqgU9l0D7IeM2SPv+9HjxJTK26pSlG
        3cKY2eLGL3ZsIGCzEjdlmg==
X-Google-Smtp-Source: APXvYqyA1uFJ8vFfpoHclW92quG/D9l+3QhTPkFnfAtbJnqtWPuQwg6x6WkNCHZJuBkEIO3LopS+bw==
X-Received: by 2002:aca:4dc2:: with SMTP id a185mr879561oib.50.1557248852239;
        Tue, 07 May 2019 10:07:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm5331500otk.53.2019.05.07.10.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:07:31 -0700 (PDT)
Date:   Tue, 7 May 2019 12:07:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com,
        =?iso-8859-1?Q?Ga=EBl?= PORTAY <gael.portay@collabora.com>
Subject: Re: [PATCH v5 6/6] dt-bindings: devfreq: rk3399_dmc: Remove
 references of unexistant defines
Message-ID: <20190507170730.GA3315@bogus>
References: <20190502175820.25382-1-gael.portay@collabora.com>
 <20190502175820.25382-7-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502175820.25382-7-gael.portay@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 May 2019 13:58:20 -0400, =?UTF-8?q?Ga=C3=ABl=20PORTAY?= wrote:
> Those DDR related defines do not exist. Replace their references with
> their numerical constant.
> 
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
> 
> Changes in v5: New
> 
>  .../bindings/devfreq/rk3399_dmc.txt           | 73 +++++++++----------
>  1 file changed, 34 insertions(+), 39 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
