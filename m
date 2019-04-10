Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E56C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E1E206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="qk4XpOUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDJCjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:39:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40976 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfDJCjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:39:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so561203pgs.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kpCEf/Qq7tuBHkUCvzw9RDQhyuv+fkTrLJtMvQIPB04=;
        b=qk4XpOUrgdAyWaYDdG7h6tprWKEK6itk0//ZrqrqyoY7gjC+0AgDmpzNeW9N+4twsb
         PNeU7GmxnWKBUWcpK5Mu+MjTzeTgI5HNruxyPimpPtni+YYo2Mq946tsXYAwXnA4VM6c
         e6zR94qu1RzUUSsce4TQFBR9pXfg8IKhMptrM9q+VckxVJUdM08X79lwWhG4IesgnSVD
         y6/P0JoZSfEshzh8XDsNtF9tx8p/I+yW9F69pylWW6XVhov23qd57f092E3ucoyy+OZK
         VCxOdzbydInBLhlKaLwOXFsXKA2xWTm6IDHhrT0g2UFPICef5AweOOV66Vc9+Upgofiy
         gKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpCEf/Qq7tuBHkUCvzw9RDQhyuv+fkTrLJtMvQIPB04=;
        b=S+UisqIkAvFlP/RWIVa9FpSaBVOVkXSsLGbRhNlWvF3EZ6UWAzRz68Kh47+X94mi1X
         9kRpSD5om3+yR/wp6OHfpQAtp+S4iEbek0YGStCNEmZqeld48YU6/RtHJkGFKO/STpIy
         QgwjY61Xk0fN+z40sKBCTteSjz+LpK2BC6TBcvcQMEWrG5rDMPf8YwtYAUPjQKLIoWQI
         YhUna+tvEkOeTg+fRLlAzchKyROlVzOnx8MiC1+u+pbtrpmwjMr+8mjpOQz1rf0zvvPD
         ipXycnscML38FpWc7LuBN6LjzzTH0qf8/d2sSRrzria8fYT0iZ/qAVhaBtNCDERqFFxy
         NdzA==
X-Gm-Message-State: APjAAAVZe8TGckn6awUnhnaeD4rgt2GLCz2O2m8jit4HPJiAy0GQZmHx
        03uZSkMiE0Mgab7w9kkGY//53w==
X-Google-Smtp-Source: APXvYqw16sMRHvFYQ3DY42TI6+ZNAJ0fTb/DDxMV7h7al7Ra/c7r7BCU13HsEinvDxl29+Bqk/5WLQ==
X-Received: by 2002:a63:6988:: with SMTP id e130mr22004349pgc.150.1554863955782;
        Tue, 09 Apr 2019 19:39:15 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id c1sm40310406pgk.44.2019.04.09.19.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 19:39:15 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:39:11 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Huang Rui <huangruippp@gmail.com>
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, jiri@mellanox.com, ecree@solarflare.com,
        idosch@mellanox.com, petrm@mellanox.com,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        lirongqing@baidu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org
Subject: Re: [PATCH] net:bridge:always disable auto-tuning when the user
 specified MTU
Message-ID: <20190409193911.2d68a64d@shemminger-XPS-13-9360>
In-Reply-To: <20190410023208.25435-1-huangruiPPP@gmail.com>
References: <20190410023208.25435-1-huangruiPPP@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 02:32:08 +0000
Huang Rui <huangruippp@gmail.com> wrote:

> For example.
> My purpose is to create a bridge br0 and join eth0 into br0.
> if we use this following way, the auto-tuning flag will not be disabled.
> 
> If eth0's mtu is 1200
> step 1.brctl addbr br0
> step 2.brctl addif br0 eth0
> step 3.ifconfig br0 mtu 1200
> step 4.ifconfig eth0 mtu 1500
> 
> Result:
> br0's MTU: 1500, eth0's MTU: 1500
> 
> Expected:
> br0's MTU: 1200, eth0's MTU: 1500
> 
> I have specified br0's MTU,  but auto-min policy works. So the MTU is
> not the result what we expected.
> As expected, if i have specified bridge's MTU, it will set the flag:
> BROPT_MTU_SET_BY_USER in net_bridge_opts disabled and auto-min/max
> policy will not work.But in this case, because the dev_set_mtu return
> early, the BROPT_MTU_SET_BY_USER flag will not be disabled and
> auto-min/max policy will still work.
> 
> Signed-off-by: Huang Rui <huangruiPPP@gmail.com>

A bridge like this going to drop frames.
A frame received with MTU of 1200 will get dropped.
The proper way to do this is to change MTU of both interfaces to match.

