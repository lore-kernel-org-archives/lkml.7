Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A67C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 08:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9F220820
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 08:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdXVx7Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393294AbfIUIeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 04:34:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36477 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393108AbfIUIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 04:34:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so8996487wrd.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zStaxsoeo6auhiqAbIDJnsQ/1nVLtBA7SNO4fTK543s=;
        b=tdXVx7TmgHKXedoGKVONdyFFRPVfMTpEmCtCE/svXLN+l9OOHFWcxEv1mvdnEhZCDw
         fTq7oTfItVagj7V7QPFNPlPcubzjLXUZX75t62YWE3KycfhO9MppvYxNBP0fgHHAsUL0
         F+tk3RwGlPPpyxzII6kr3Bjwi90TLl/fb16Mr9PrXlfKikckcv2oEaQ6DR8DFsG2oKgg
         6JjB9BnmJAXpzM1uNY4HiXX3Oo8Wwi9nxYD5HBlePHmJiY3dbqnmdgUIcTxiT0ItTRRB
         yuG2p6m8D67S214J6k2CrftiHt3cSvFvD6r1HuOxvDemkm40TXRV+nTaWURlkB58x6RE
         RQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zStaxsoeo6auhiqAbIDJnsQ/1nVLtBA7SNO4fTK543s=;
        b=m8gXLJKfE1E1PbI0EiMsfgMwL4CqAE8YgmtgmoYUJx3L7lO4tzJL6+nkOa41ipSzK4
         0pvpR1bnU4CkL9PmyYI28JETX01K8baWhbE3d8MmfpsOnWv9SfSANVnRVHXg1q/Y6nzK
         RTHqKwpa4IlXRbhZndz33+HMgu3mtYHJdelLfpvmiDY14ip3eNqaCq6Dkb6pcIyINHQw
         +8IqAiRlQ3l9joqcPk7dzW8QatsOJodL7yMzBoroc3ToRs3tnP6q8k9L43/XyQTJvHce
         3hGc4j/tU6KPXfKleHtsh8I9yvh6bQQ7qLMga4dGuwMfGBeYdtCfQQ9cya60hvkVNv8g
         qzsA==
X-Gm-Message-State: APjAAAXmw9jDV78kA2EQoE2ldKrkFs/Y/fTq4ku1cfkLCF6qQZjomelV
        ohJ/a0y+4R8v4+eCxBkF3w==
X-Google-Smtp-Source: APXvYqzgm2sR6AX5hwEUsQgFUFrr1dyNrnlvkSbOfjq9QV1NYuYG9N/DY2ZANZ0Inwd+oAj3kMbntw==
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr15024419wrm.15.1569054855881;
        Sat, 21 Sep 2019 01:34:15 -0700 (PDT)
Received: from avx2 ([46.53.254.141])
        by smtp.gmail.com with ESMTPSA id y186sm11226132wmd.26.2019.09.21.01.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 01:34:15 -0700 (PDT)
Date:   Sat, 21 Sep 2019 11:34:13 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: bump function name limit to 256 characters
Message-ID: <20190921083413.GA14409@avx2>
References: <20190920182503.GA15073@avx2>
 <20190920194035.mwsvz7nyc4peph2j@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920194035.mwsvz7nyc4peph2j@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:40:35PM -0500, Josh Poimboeuf wrote:
> On Fri, Sep 20, 2019 at 09:25:03PM +0300, Alexey Dobriyan wrote:
> > Fix the following warning:
> > 
> > net/core/devlink.o: warning: objtool: _ZL31devlink_nl_sb_tc_pool_bind_fillP7sk_buffP7devlinkP12devlink_portP10devlink_sbt20devlink_sb_pool_type15devlink_commandjji.constprop.0.cold(): parent function name exceeds maximum length of 128 characters
> 
> Hm, since when do we have mangled symbols in the kernel?

We don't, yet :-)
