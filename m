Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3ECC04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B857214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfEHLuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:50:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40145 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbfEHLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:50:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id w20so595137qka.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ILuFhvHSobbaZ61Z9yuK/cqA3RsgkCbpEkcFgIAzV04=;
        b=ELCF5O/JnvP9N6it5sVmiNrsYnLnK9o3KmQDXJz00S7KvuoRyvVZ7DmnzTR0+LBCdm
         4O0f3+J4iIA+tz6jssYvieHWSaWcsWJdeHenm8vsLO8ny6F1nRNV8c3at6q7dZiTVNmJ
         tEuXmXVUoOBD0S2WpLUmXd89sT5rOOUI00Xn0Lw1aU4ZSY30PA5tMZiYnH709JJI8QU2
         tDhBdLXxfzQMZh1W0OwMa3DMKn1lkfQ+QZKMpoUtWSPaXQypF3eMzfW15cClXcPqB6T7
         aDVPi7V6/IS/SuBYNoJSUDpp/1M+tzQD2NhZA7Ph9D4Ir/K7hTVLx3BUGzvugyYT/ihI
         pfmQ==
X-Gm-Message-State: APjAAAVSIGB/1Tw8tLudnoxrTFTpIykQ/vPTE4iXgkGff+lD2xMegzZd
        NFJUon/bGYNumEmJrj90+COxQQ==
X-Google-Smtp-Source: APXvYqw/MWdlCkD4aez13QH65u02WSZBNk5ZO4nwkw4pcFO6/moSDLKhPxlAykIrFyRxzn7JLISyEw==
X-Received: by 2002:a05:620a:1449:: with SMTP id i9mr7104388qkl.4.1557316243422;
        Wed, 08 May 2019 04:50:43 -0700 (PDT)
Received: from localhost ([177.183.215.2])
        by smtp.gmail.com with ESMTPSA id k63sm8766688qkf.97.2019.05.08.04.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:50:42 -0700 (PDT)
Date:   Wed, 8 May 2019 08:50:40 -0300
From:   Flavio Leitner <fbl@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openvswitch: Replace removed NF_NAT_NEEDED with
 IS_ENABLED(CONFIG_NF_NAT)
Message-ID: <20190508115040.GR3494@p50>
References: <20190508065232.23400-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508065232.23400-1-geert@linux-m68k.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 08:52:32AM +0200, Geert Uytterhoeven wrote:
> Commit 4806e975729f99c7 ("netfilter: replace NF_NAT_NEEDED with
> IS_ENABLED(CONFIG_NF_NAT)") removed CONFIG_NF_NAT_NEEDED, but a new user
> popped up afterwards.
> 
> Fixes: fec9c271b8f1bde1 ("openvswitch: load and reference the NAT helper.")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Thanks!

Acked-by: Flavio Leitner <fbl@redhat.com>

