Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11493C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF19D20674
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555315980;
	bh=nYXErUULwrI6FTbhiwpQFvU5U8RCoRuOgMVT2d03klA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RVFsVH/lyam4rw/4z3mZzdQWNl6B0a0jlb/wbVjtOgNDYPvlfZNOF9mw8J9dlE/OI
	 /vvoz8DsxTYt+YTrXs5S/R2NUO30L7aimVWwRtioNsXbi2TejkgC3KNrkOUrueTeNp
	 g8UMfWu6LOX6//SEzDcfw4115Cbu0w7FNYZ9T12s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfDOIM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:12:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36171 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:12:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id o74so13659211ota.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 01:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jp9Ct7kE9hoKc1PJ6FbYrPaUnxTpMISs979+9+fnaJk=;
        b=uZZesK3/Ir2R2wxVhsDR1uBZ09Ckg6mmo15Ui74k50jXhjy7cyjCooruCD6/RabdHX
         +Mv2XKT/rlEqcg23CTU7kRPSeXrOH2y4sC4OwPlkqNEc0RsUDliNhzTGaz+LqJ8VilMH
         UMW9ny3ktZAEeOO/jxPUOS7hssbCIe18xdOK9XhQLU2oqfOM00dlHUPMQBYde95FpktB
         kwFK+tRtGfkPEQbZ5sPYBEv2wiRePz7JMhICXecPfE4D2CpKIVJIzp/D3NytKG8BMZsP
         6SJ+xGHTqRFX7cCHCC8N6BRIqNezoD12k4R4SSmVuXj/fADf4PQFce2a1MFeZBvZ7fzO
         +lpg==
X-Gm-Message-State: APjAAAXrP44e9/4WJ0trueuS5iaa7nh1PGifj/rLzZqegqWeRv1vOaH9
        rMyhkNWU6d5ET5DK3sE6MReb6kSpjfQJW75xIWY=
X-Google-Smtp-Source: APXvYqzDQb3Vp8dy1VqFCLO64EPri1ToHWioY+ALUPGQHATagVI80DoD8ASasmQwbZusYpsJxxuhGMag6EaIGv/Qdi0=
X-Received: by 2002:a9d:2dea:: with SMTP id g97mr26457688otb.20.1555315978232;
 Mon, 15 Apr 2019 01:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190412154819.oiztq2uf4teuxewn@macpro-scc.lancs.ac.uk>
In-Reply-To: <20190412154819.oiztq2uf4teuxewn@macpro-scc.lancs.ac.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Apr 2019 10:12:43 +0200
Message-ID: <CAJZ5v0hSTVHp43TtK9_yjcy2t2V9jSL6VyPJg9cQHE2SYBOejA@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: fix statics initilisation
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 5:48 PM Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>
> perl scripts/checkpatch.pl -f drivers/base/dd.c got red here:

Please note that checkpatch.pl is for new patches.  Running it against
the existing code base is questionable and so the results of that.
