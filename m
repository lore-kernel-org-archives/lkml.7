Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5D620811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9hll5Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfC2AVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:21:21 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42012 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfC2AVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:21:21 -0400
Received: by mail-yb1-f193.google.com with SMTP id k123so246421ybf.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PQ2Fp0hnP01x3/hYrgH1f0ZWXIu6WHBdgbH0UORCo4=;
        b=D9hll5VhGg/rpsx+Z7qxEZt8RL3XQSjdRRmU0s3d8Vpb4ZxkZCkbfHsOmPVQJK5AjG
         HxAwGGwnszPcGtGnG3Ulyu5FJ78hjcTgKeDzZGVRjXDjvCt3oODANvk86V0ywhxy6jAv
         XZoszjen4+mtl2vt4uqErBCWF0mWHdjdHph31tlve2HJd3J932AmsT6ukX3g7DhE5csO
         usnzPRMNQhpWFgWFN+3Ra+AfIixtrPAkugPG3MQSth0wBuFM8rxucOYJ40Tn2hbu67im
         P+62i01HHr02pWwyoA0uwUpryD6xQezUyihiTGeT2ouCCsyprKIUtSdgv4dNiRxdOj2G
         Oj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PQ2Fp0hnP01x3/hYrgH1f0ZWXIu6WHBdgbH0UORCo4=;
        b=bLGQbE2t6ytR78xlFtAz75nf2+m7UQT7+QTWtrUPYxcNpAa6axSvdz2pM1PkVFiqnb
         4+IItf0r04G2ShAk76QjJBkLYZJhO1M2tWBbRbOVP3cxYYxxOWg/bfVhokhietbSDWfk
         yeUyBb7RSVUZaPqSekwtz6Sm/Uk3N8fsElOlmt1UJw28fPj7mPMs6mQZYlCg0EWOmkek
         F18lPyIvtxeyLjCKaAzjtLKkLuC4cX3UOBA4RVJPm/4VpWqkz30+tzaW5XhoAUFiR5aG
         1jvquRZliw5kirtgSqsV+KLPT9LWMgY+iYEx3hA2LgoHRnNZtj8qXbDFh9auUpWinY4E
         Gimg==
X-Gm-Message-State: APjAAAVsnTulQhJHejJIspW/JltfzjeVtvVvBoKDPzsNaxD3fXcR5N9L
        RHvmg47OBJeIlBI5eJU7MVbPRA==
X-Google-Smtp-Source: APXvYqzPwfSvOYZy8PCxQklcCF9WNZvoBP0eUnaU63haSF11oYMEGiz1atyv7x5+ASSL1uhzmjIymA==
X-Received: by 2002:a25:cc3:: with SMTP id 186mr4891293ybm.178.1553818880254;
        Thu, 28 Mar 2019 17:21:20 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id l144sm159927ywb.75.2019.03.28.17.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 17:21:19 -0700 (PDT)
Date:   Fri, 29 Mar 2019 08:21:09 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        shiwanglai@hisilicon.com
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: coresight: Support static funnel
Message-ID: <20190329002109.GC967@leoy-ThinkPad-X240s>
References: <20190328023509.22242-1-leo.yan@linaro.org>
 <20190328023509.22242-2-leo.yan@linaro.org>
 <4b0ecaee-a578-f328-7f62-8ca49f7729bb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0ecaee-a578-f328-7f62-8ca49f7729bb@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:24:35PM +0000, Suzuki K Poulose wrote:
> On 03/28/2019 02:35 AM, Leo Yan wrote:
> > Document DT binding for static (non-configurable) funnel and give an
> > example for it.
> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks for reviewing, Rob & Suzuki.
