Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2737C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8833821721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="JXoo/8gX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfH3Fjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:39:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55046 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfH3Fjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:39:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id k2so4488734wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 22:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1wp+VbzCUI59xGci2FOifBql4duIgf397Nuhms2TWPw=;
        b=JXoo/8gXstErUb06GTBgBKo3rcv4zI2kdi/h0lc8RbMOAMNzDfThaJr4PFXLmrX3sK
         AkLbNdedylvq0GU3OcPOFuBY9Wc+pm8HHZBFhb8huSmSkEVZUXN44qggDKok0BAQMufK
         DsSYjhw23UyGTcrn6D1+ZJ3O+n2N2kYiQaFTvw12epR+aEfrQSA5BvDbIzSa0ahl0AwC
         XvlwOtwkxHnx4hGmJyzwFN70cRgEOyoF0rMi36AqUpDjOsI2kz2/lcWeiYS772N+jXGx
         I8dAgQ7/X5g3iBSq/ydYAwL+Z61l8jGIS4iv+1wduc3mxo012PmSiGYEEu+HnupJ00/U
         ta6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1wp+VbzCUI59xGci2FOifBql4duIgf397Nuhms2TWPw=;
        b=PmLQoZcKMJQOq/DdUnaqWbXBVpZxR0nE9NaQ1fSeelZA1JEMXfSM932zXdMuPoJ250
         TvdLQDhG7K4OwAArfBv3/o6RzLnubVK4KO2Kg3X8YBHu3LISnTG41VOpbkAF7nzr0bHI
         uz/TRxuXLge1YnMbSW9M0Wu7yYX7c5i3q6BgAQ1Uw1LxyFL2PsljmBkmt6eFD+FcRxSZ
         b4lsc+p4pzblsuaRky++fxJTzz0srI53urXyKl1s6DXLN0ZdIgmJZIPtL1jmtdMZircM
         ezAn5J54VrumOqRzMkII+u7KJN+y4z8xyXUl261Y62oUZDCg2r3cIryI8Pszyg7+U2Lo
         2BVA==
X-Gm-Message-State: APjAAAUQd/gWCXci4WQyUuzUIGKNry4NU/hSQvNLUnXgHodwFBant/tw
        EHUpOmIk+DtwI3Flrl0P3LBdxQ==
X-Google-Smtp-Source: APXvYqxFCvnEHwY5tbZHKnNs7cuHJXoQI8Z4jPbpqM6vDshHknFkniltgX66RuHTLBF+5UPAyk9+qA==
X-Received: by 2002:a1c:ca0c:: with SMTP id a12mr15418773wmg.71.1567143581424;
        Thu, 29 Aug 2019 22:39:41 -0700 (PDT)
Received: from localhost (ip-78-45-163-186.net.upcbroadband.cz. [78.45.163.186])
        by smtp.gmail.com with ESMTPSA id r16sm8358227wrc.81.2019.08.29.22.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 22:39:40 -0700 (PDT)
Date:   Fri, 30 Aug 2019 07:39:40 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Miller <davem@davemloft.net>
Cc:     idosch@idosch.org, andrew@lunn.ch, horatiu.vultur@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        allan.nielsen@microchip.com, ivecera@redhat.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190830053940.GL2312@nanopsycho>
References: <20190829175759.GA19471@splinter>
 <20190829182957.GA17530@lunn.ch>
 <20190829193613.GA23259@splinter>
 <20190829.151201.940681219080864052.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829.151201.940681219080864052.davem@davemloft.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Aug 30, 2019 at 12:12:01AM CEST, davem@davemloft.net wrote:
>From: Ido Schimmel <idosch@idosch.org>
>Date: Thu, 29 Aug 2019 22:36:13 +0300
>
>> I fully agree that we should make it easy for users to capture offloaded
>> traffic, which is why I suggested patching libpcap. Add a flag to
>> capable netdevs that tells libpcap that in order to capture all the
>> traffic from this interface it needs to add a tc filter with a trap
>> action. That way zero familiarity with tc is required from users.
>
>Why not just make setting promisc mode on the device do this rather than
>require all of this tc indirection nonsense?

Because the "promisc mode" would gain another meaning. Now how the
driver should guess which meaning the user ment when he setted it?
filter or trap?

That is very confusing. If the flag is the way to do this, let's
introduce another flag, like IFF_TRAPPING indicating that user wants
exactly this.


>
>That's the whole point of this conversation I thought?
