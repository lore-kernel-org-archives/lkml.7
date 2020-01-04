Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE269C32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA89C222C4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578172496;
	bh=aQkYv/od3M6ELDfON77dEIQpB8tvF3HasO5wg5XVGWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0+/uFkdMPlPgAmybqsBkIX4q9apmEZ+tnRBovrNN/1dHrJPNZPigzP8pKNtLzWDJF
	 p2OQnTXYqWvKoIxGMV9MheyRLtSkrtdlhPrSdUbyzspl0/JOmsi+LpZ249uQaSIHbD
	 lhn1gXdvCBsK/BvzXeRYyRYGURUsc9gfT8tZKJQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgADVOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:14:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33428 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgADVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:14:55 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so44737090ioh.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l6WjYhwErffAfIJqKX4almlPavimz+egXrq1mO0xKZc=;
        b=GI6hBGqreb2CVM9Ef88/CFQ6212g5Y/sa3/uLOCY+JQ73ZPLnheEA4Rb6BsBeAZ2jm
         1bpU+9KIu5DPcdFBf7heu4E84nJhfj3OO+nJMa+k86P6qCe1J42YCVNLRbjt1O0QQd6E
         qWIJpyaqIa43fWHAdfgbuLozF2FESzmE/KpmzhfFCHaQ2R26y4kTXyNzq7DuSOLtXXSj
         FIhxV9ISz1k+Bw89T7LBeGAeohuKH4TdGc/Tzgno0uYrY88U7hGK1h4SFBbm9uZrp2zG
         COSY01SOsqOqZuytz2SgJO/2nOYZpVi25YmqsxIJj383eURXvNjNuh9acmiDHV6oUkE8
         i9pg==
X-Gm-Message-State: APjAAAVpIcIo/hXWWBoX/FZpirAJTp/MmWHX9xtLqy/YFJ/3eLjAUPSM
        orB/ThWUQm22eLRJVmz/3XoUj7w=
X-Google-Smtp-Source: APXvYqwnO1jlVtVNS6tXxallv6VPwco3HesrB+i1A/hcFV7VB3J0wNG0dyy12/XQAQ8bNHOUfDSzRg==
X-Received: by 2002:a6b:7b41:: with SMTP id m1mr59034118iop.191.1578172494460;
        Sat, 04 Jan 2020 13:14:54 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j69sm22367891ilg.67.2020.01.04.13.14.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:14:53 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:14:53 -0700
Date:   Sat, 4 Jan 2020 14:14:53 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        rnayak@codeaurora.org, swboyd@chromium.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        dianders@chromium.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: rpmpd: Convert rpmpd bindings
 to yaml
Message-ID: <20200104211453.GA26611@bogus>
References: <20191220064823.6115-1-sibis@codeaurora.org>
 <20191220064823.6115-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220064823.6115-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 12:18:22 +0530, Sibi Sankar wrote:
> Convert RPM/RPMH power-domain bindings to yaml.
> 
> Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.txt  | 150 ----------------
>  .../devicetree/bindings/power/qcom,rpmpd.yaml | 170 ++++++++++++++++++
>  2 files changed, 170 insertions(+), 150 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
