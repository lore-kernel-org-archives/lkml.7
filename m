Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396B7C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B1E20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIZgDebU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfCaMTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:19:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53832 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:19:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so7237919wmj.3;
        Sun, 31 Mar 2019 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BDf0GcN8eemQB0L/8K+hBKesr4IMYa5WWt4sIPWiNeI=;
        b=gIZgDebUhq6UNsaHpK0sPaIoffoojQAgBakLCKSj0bBTHGA8Om4r/dIPo8qmE6yCvj
         pW5jWQu+nPsdWB+E3+nPiDdKNsT2lV95WuhSwsyLsoxGAKs59vNQ7Q0612hG53SOFXPW
         OUaWWKUFK8zJ5VaqJ02q5WfOG9GKhgtJxWlIB1wQ+v3P2sDYDe2tmpNHF6ZMZSfE5sDC
         CM8OW1uhV65A3NG+9twpgq/vjzCrTueNe2/GyiIulL2bMfNlxbPTQNtO1Y2fDkGGJMIl
         n5IkIahoeSSyjBVcyi/172S3TdsYBMREWohlgWfEIMgrkKsyLLmqoBdx2Xxm1IScpH1w
         qG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDf0GcN8eemQB0L/8K+hBKesr4IMYa5WWt4sIPWiNeI=;
        b=EcQvEMCP1SuFuupBeEqsRD5yGq3K0+TKyuu6D4VI4SR8G681FJqLWzJznXCbSKfbJU
         qYs+t3GeXKGFzLU124N/G7YpvfGtXkIlN8zoo0rh/F8PE9bqwS8uUNbAvlxg0nAUMFOK
         ZVU29bBtiE8+ZAujKEphvP457WnAX0+eQW4zafZYHxEWcJyXVJliN4BbTVBkOV5+IWaL
         L/LZTZiWqfiK/oOtnSQGPwd+IMTApV384QXC60KIg4IyWq7fhmsHeAv11VxwQf75KzJh
         eZHfb2E6yUecNdHr9PPHvD8wuKLQcy/5L4eZKKDVucQuF6qWCj8SSsV4tljbL9j/wJzt
         lEQw==
X-Gm-Message-State: APjAAAW39iupme9qgpQEH8OP+N/x5JQXmi2Uwpy6tp1GfUNsfVOH7sfg
        eKvNn/Or0/v76aXdZdtKxp4=
X-Google-Smtp-Source: APXvYqzt0ZdNhofhgtc3NQ7fTymcguNyCyfWoRy9sahlPeQZTp2zQPoTZNWcSpBT55g3sTVF6xK+sw==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr9405546wma.139.1554034750525;
        Sun, 31 Mar 2019 05:19:10 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id v16sm11473602wru.76.2019.03.31.05.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:19:09 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:19:07 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/8] fbdev: sm712fb: fix brightness control on reboot,
 don't set SR30.
Message-ID: <20190331121907.npu4kehmgxmmf44j@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-3-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-3-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:24:58AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), rebooting with
> sm712fb framebuffer driver would cause the role of brightness up/down
> button to swap.
> 
> Experiments showed the FPR30 register caused this behavior. Moreover,
> even if this register don't have side-effect on other systems, over-
> writing it is also highly questionable, since it was originally
> configurated by the motherboard manufacturer by hardwiring pull-down
> resistors to indicate the type of LCD panel. We should not mess with
> it.
> 
> Stop writing to the SR30 (a.k.a FPR30) register.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
