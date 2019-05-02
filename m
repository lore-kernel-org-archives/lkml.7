Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A80C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DE32081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="chVr5+rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEBUiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:38:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38255 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEBUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:38:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so4303631wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lrixnVM86js4Eb2x8G4C6P3hreeXantaWGd2UDDA0cA=;
        b=chVr5+rx4uqvv9JnvlcF5hEY/uWkAw6trA21XiNjJM4Jt2jUlKrsKbdqpUxsscwFiM
         DDps73zEHXct78m5c4MWObS2Qgr8GRFVykEaAwqd/w+C2KRPyBU+SlhfpkiwxmB32WLV
         op/6cH604uZGyac0XM54UOCO5fmKaSVIV/MIYGLKQ/7VtkYldsYGmrTogxlPykX6ZI03
         fHpIIYFYT0zUKBDjpR1EGpbUCt7PJIDI7o0UG2B6PFG3eMGF7hGPrHll3Vl94tlzR/mK
         dbDwtpE+XA0+Wpl5foG7zpR+J0jSdwlMzGjj8x2ZQaqtj+xuoPGs6vOwJlQefJZI1BgU
         MZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lrixnVM86js4Eb2x8G4C6P3hreeXantaWGd2UDDA0cA=;
        b=rRPNqaUckkjF+JyKeSTxFoHxr6mRXze8OFQiDtxLMFH2X+IOxLU9CQwkpnirFIR1WN
         8sqGWhhEZnc4XTCvRd16s6jFhGLZNHJoU9NnH3SYcFQePN2sfzfr2uM2m/q9ZE6NsILK
         xnd/1j62W4Epkw/ioWj5KNHSywvJQ3J70Spq2uZ5UZnuTTJOlz9ISBZiXoQSbQT3eG66
         dmzXvJzr8bUkVunEgRjb1ymchToo8qKLQxNvuCb0wyKrQhyAIETq24l0KDD17/HQZyl2
         rXQPSWamrV/H54cwCKVS6SsuoKYpyjZILAFmu+mludZVEGashClD5p287lCyIG58aUvs
         LfnA==
X-Gm-Message-State: APjAAAV0DrnkyaGVV+AR1rtJlVpNb7G+3BHuorqPgUAu2N0uORcuhPz7
        y2EnU25DZ1hnuNK8H5PBpc8dgg==
X-Google-Smtp-Source: APXvYqzMuYXgDbCdRQnfO1fEHFQY4tfXKNvo0x646Idp9lJeKA7NbrZbvfLcGZ0zkrBCpXxYqigQAQ==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr3500868wmb.94.1556829531771;
        Thu, 02 May 2019 13:38:51 -0700 (PDT)
Received: from localhost (ip-89-177-126-50.net.upcbroadband.cz. [89.177.126.50])
        by smtp.gmail.com with ESMTPSA id b11sm433820wmh.29.2019.05.02.13.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:38:51 -0700 (PDT)
Date:   Thu, 2 May 2019 22:38:50 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Joergen Andreasen <joergen.andreasen@microchip.com>
Cc:     netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net/sched: act_police: move police
 parameters into separate header file
Message-ID: <20190502203850.GG2251@nanopsycho>
References: <20190502094029.22526-1-joergen.andreasen@microchip.com>
 <20190502094029.22526-2-joergen.andreasen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502094029.22526-2-joergen.andreasen@microchip.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, May 02, 2019 at 11:40:27AM CEST, joergen.andreasen@microchip.com wrote:
>Hardware offloading a policer requires access to it's parameters.
>This is now possible by including net/tc_act/tc_police.h.
>
>Signed-off-by: Joergen Andreasen <joergen.andreasen@microchip.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
