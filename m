Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288F1C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB5F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YaXNNhpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFQLec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:34:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33423 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:34:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so15730279edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9vPSLa5+XLyQJw19zpdaml7fRJQhxguAtOgI7YT73oo=;
        b=YaXNNhpEEHuGAVVYKiFjcIjtnlRn+SX4KK6cHn4Pg7lywkMBTaTfMWwp9ZftE10ZTr
         nuJ/UU47huRRPPSztqkz4DT7OKeZiKaT3eRLIl1roljXdiZqjxVtFlg3kLPfsMBLX4Un
         7ceatCqEab2IpD+LDjdjSxFc3CPR7yAI7ByqoRuTM6zTdeKEHebGRoQcAkX8h/0DLvtx
         mU1LmYOU6smRlrahMdW/qJObnQsEC/dU3qrlVLLrj1wviK4LfngoI/syjUqsbWjuk/se
         mN/ZqzvXU79WwIu8OvQHKDBC0nfBXRps1lnFQdEllgWHSwdSXd1mJ+KOqrNNWMbWO75W
         khiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9vPSLa5+XLyQJw19zpdaml7fRJQhxguAtOgI7YT73oo=;
        b=pf2KEokoYzt9CUnhYG4lF/rXNr58WpcCY8011Ps/6sP2xR45u0A8eaG8+SUcDWXqQe
         dHumKglCiGpi7aat61+0B9enztnuoFzeNyQTwewFMf4KXHeIJVWfrK3BaEfViJnhvOJ0
         pUFaKpqn3fIwjhy3ML/aIyMygVwLYhrlAdgD8lc0L+LA7ryfEIujwlq+w33R38M9GESu
         hmbNy3yMaYajrJyyaGopRt8QB1gjytLeImAwbR+9Kufdn7HA+ohpEQaf9J2SwpLW8J+1
         UdihVd3ocJOQM83H5fOicsqpJrPsa8m/sOnVObdoeI5xKC7gPuJPCUYUgl9BwYHvcTka
         vLcw==
X-Gm-Message-State: APjAAAX6Cx+EYa3riVmllCqC2FZfhUx/gYfxyMmbQngjQl0Ws/cpy9Hd
        JurP19GAN4OrnWCr7ILHF2OMkw==
X-Google-Smtp-Source: APXvYqw1q+5ssz4QySIjZc498AMwl614ceV96qiEMFWPDNSLJ7oh7ctcvwS8zNJc5j4OHthaIvZI/Q==
X-Received: by 2002:a50:d0d6:: with SMTP id g22mr46189168edf.250.1560771269879;
        Mon, 17 Jun 2019 04:34:29 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id s5sm3434216edh.3.2019.06.17.04.34.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 04:34:29 -0700 (PDT)
Date:   Mon, 17 Jun 2019 04:34:28 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Andreas Schwab <schwab@suse.de>
cc:     Yash Shah <yash.shah@sifive.com>, davem@davemloft.net,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, ynezz@true.cz, sachin.ghadi@sifive.com
Subject: Re: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
In-Reply-To: <mvmh88o5xi5.fsf@suse.de>
Message-ID: <alpine.DEB.2.21.9999.1906170419010.19994@viisi.sifive.com>
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com> <mvmtvco62k9.fsf@suse.de> <alpine.DEB.2.21.9999.1906170252410.19994@viisi.sifive.com> <mvmpnnc5y49.fsf@suse.de> <alpine.DEB.2.21.9999.1906170305020.19994@viisi.sifive.com>
 <mvmh88o5xi5.fsf@suse.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Andreas Schwab wrote:

> On Jun 17 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:
> 
> > On Mon, 17 Jun 2019, Andreas Schwab wrote:
> >
> >> On Jun 17 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >> 
> >> > Looks to me that it shouldn't have an impact unless the DT string is 
> >> > present, and even then, the impact might simply be that the MACB driver 
> >> > may not work?
> >> 
> >> If the macb driver doesn't work you have an unusable system, of course.
> >
> > Why?
> 
> Because a system is useless without network.

From an upstream Linux point of view, Yash's patches should be an 
improvement over the current mainline kernel situation, since there's 
currently no upstream support for the (SiFive-specific) TX clock switch 
register.  With the right DT data, and a bootloader that handles the PHY 
reset, I think networking should work after his patches are upstream -- 
although I myself haven't tried this yet.


- Paul
