Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADABDC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7897A20656
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578095648;
	bh=qqqhD53FJQH6VLaWOnwg8HkeBiBPl0gqedxpzmFEhvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SoCQQdqS/9UVNu6hasCjoF1q5xTCSuHWYyYv+18Q/26B62F/TsDtR4Ygpk4sgRXSa
	 9EyRhbfst6J/vOKcdY/P1wktoKdMeCvKpFh1GST7R7/Wqu1vog/LMORrVszOG3BjFh
	 MjAc6lwRdB9S81Ds6gynpBKUP+rHQsK0wU/yLPIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgACXyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:54:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36347 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgACXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:54:04 -0500
Received: by mail-io1-f65.google.com with SMTP id r13so33009637ioa.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 15:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DLv6sevWK4SOmkrjtAjyOZj+Qda5b1Jn7x8aH9qo+K8=;
        b=al0LXXy/rNiLnrjLJtJG3Zb7rfKRRSb+Jy+6zPg+eqO+qkwUhtqmqB0GbGjrI9HkX1
         r6km4P1ZZ7nZxoIv/Ya6r895HvqnKg+9tABqgTOhRxbSEfDr2KHVQe+cIOCS2Sz/+LIY
         oLv7WymtXFl2vFQE2qgXiXgjcLJ8oIDXlAcOA8spxfbWSqyRllcWg747Cw5GZvTm9111
         Owwjoa/TWBtFqG7dnGI2nL+xOIh9MvnO+YVANZuXfgoj6KHRjINZlFrTdpBwN6ybWVtE
         Zy0o7nCPEQQ86JAcNjtOI0i4RZiMF6cxwLTleAWvf5zOwA3aZMxGZGgOSxmWsskWRSk+
         uTqg==
X-Gm-Message-State: APjAAAVJ3uE7QWwPsihVmk1rXkRZpO8vIqgtUpokQcNlm/notR6j/Dum
        XWsnq+MTrHxotkKXA+2L9YN0YrU=
X-Google-Smtp-Source: APXvYqyG+sMxZrmLVDhTXIJefUUjHdpoovPrXuXuHMy3m5ElvjbY4LtbRWbvS78JnJ0D8d1gbzvpow==
X-Received: by 2002:a02:cd12:: with SMTP id g18mr71128759jaq.76.1578095643490;
        Fri, 03 Jan 2020 15:54:03 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q6sm15308284ioj.49.2020.01.03.15.54.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:54:02 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 16:53:59 -0700
Date:   Fri, 3 Jan 2020 16:53:59 -0700
From:   Rob Herring <robh@kernel.org>
To:     pisa@cmp.felk.cvut.cz
Cc:     devicetree@vger.kernel.org, mkl@pengutronix.de,
        linux-can@vger.kernel.org, socketcan@hartkopp.net,
        wg@grandegger.com, davem@davemloft.net, mark.rutland@arm.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.jerabek01@gmail.com, ondrej.ille@gmail.com,
        jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com
Subject: Re: [PATCH v3 2/6] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Message-ID: <20200103235359.GA23875@bogus>
References: <cover.1576922226.git.pisa@cmp.felk.cvut.cz>
 <61533d59378822f8c808abf193b40070810d3d35.1576922226.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61533d59378822f8c808abf193b40070810d3d35.1576922226.git.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2019 at 03:07:31PM +0100, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt

Bindings are moving DT schema format now. Not something I'd require on a 
respin I've already reviewed, but OTOH it's been 10 months to respin 
from v2. So:

Reviewed-by: Rob Herring <robh@kernel.org>

If you have a v4, then please convert to a schema.

Rob
