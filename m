Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0E0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1B5206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="R4PQQSOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDZEiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:38:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42411 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfDZEiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:38:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so2424521wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 21:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XSLRr44YLkdq2LsCyuTPnlTs2ingRxoTOaZ2gfvZiG0=;
        b=R4PQQSOHwETZ7GCEsmh+7LRaoO5KkGLckgv61Np9Za6guwvbQGbLWrOzN75zCEBglT
         2l/XV7vApy5sm/Imh4WAvoqkFV6Fun4M7xvipTI7oUNSLgUrbrvz/dSDZIB1oQwnzvMp
         LRlX3GgnAgN+KWAfIOccDMNKJWsdkyyWRcZMkipQZqjsQDpnGZPBhcMa/fulJdwMDTL/
         wM7IWgyxa/GiE+xPQw2b5tK3d7jBDLHb0xMVE1VuDsbhWIiF9uACxGIMZnp605gwQzH2
         Z0Q9nW4cwTHYIWZmTfbQBOSbMO0I4hjFcRrRupAIvPyik4kAE8LIWVnCQtX8Q9wn0LSr
         xEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSLRr44YLkdq2LsCyuTPnlTs2ingRxoTOaZ2gfvZiG0=;
        b=IlsMKtgZd0b/dVcmlSzI0yRfAByFCyuDQdfroPhyQslT+Mnuh+swgBKD2Oj/uzo62J
         jRbryutCqrn9fAVmNywTOcVVSEAGkTrANl8Z6ZbaqHkSV6qFhuG7dQ0EOqZcBlsTafRM
         D+NVtBBNCzqjNhYW/hX55aU33Ai+K8zx9QHHkTSG8tmfRMLjSPgIn1aigiaUluRKkQQ3
         mRJF5oUrkFAIKUAL0ddX5783NI8/OiazWIIZXFLwBrMqqYPU37f73HJeF7yT1uAw95G6
         U2b5x2GHO7Akdm8S5YmBpSk++xrNrr4xo/zEmOVqlUi5Aj8+dHFjSCGllV0HrpRCOMRl
         gFrQ==
X-Gm-Message-State: APjAAAXchFFGJslnvuc0b2367mP+gHOnbShh+GbRdE/cX438pNq7pb5f
        kh/7T4gyaTEftgYOPqoVq49SGA==
X-Google-Smtp-Source: APXvYqwRwjAmAeCuimnHUd8Z3Dulka+KZMwxOwu52cFVE3MG0x/r9PNvpa7eWXsFcLgO47go5l1Bmg==
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr26911797wrn.229.1556253491394;
        Thu, 25 Apr 2019 21:38:11 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id o1sm33295827wmh.47.2019.04.25.21.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 21:38:10 -0700 (PDT)
Date:   Fri, 26 Apr 2019 06:38:09 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Message-ID: <20190426043809.GC2271@nanopsycho.orion>
References: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
 <20190425143847.417033ab@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425143847.417033ab@cakuba.netronome.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Apr 25, 2019 at 11:38:47PM CEST, jakub.kicinski@netronome.com wrote:
>On Thu, 25 Apr 2019 13:57:03 +0300, Moshe Shemesh wrote:
>> Different reporters have different rules in the driver and are being
>> created/destroyed during different stages of driver load/unload/running.
>> So during execution of a reporter recover the flow can go through
>> another reporter's destroy and create. Such flow leads to deadlock
>> trying to lock a mutex already held if the flow was triggered by devlink
>> recover command.
>> To avoid such deadlock, we execute the recover flow from a workqueue.
>> Once the recover work is done successfully the reporter health state and
>> recover counter are being updated.
>
>Naive question, why not just run the doit unlocked?  Why the async?

Hmm, you have a point here. That would be probably doable.
