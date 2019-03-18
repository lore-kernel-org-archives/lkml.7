Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA2B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgDk5B/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCRL2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:28:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34458 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCRL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:28:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id k1so16130350wre.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a4doGWECzAdoH4DIANgLxT21jGEVCsDGKNKRlTBOk30=;
        b=bgDk5B/HagChofXlvB+Yi8rzcUn8HymHmMMaKADEjUq/Rro62Rf/xtE9ejsuCpBcRs
         24LdLks8BBbeY/sGbI3eS0Rm71AQEWjyxoVu0ucupz5xRIJAS9T5xfX4Vj/QFvLbvO8W
         1EdG9mU2r5pstcpXoD61INTpmSYn53l01LVru80VE+gZKxJDL/oSdnq0B1kKL9EqYCul
         rL5oVOlf+7Cp9ChMmKZ/QnzEYH4BgIvmZ9+CBtca2eH90AtF7y5kTX7C2wlZ7qd8DHAK
         OMr3RwbIXSpiF0gWU1QxtfmYLOd/WsJrty7S16q88162wGzceNfaGntKrXVcixhLa3qB
         IzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4doGWECzAdoH4DIANgLxT21jGEVCsDGKNKRlTBOk30=;
        b=KpTqOMp1i/gg6eG9oOBl5xoDWQUfgVCFtTAU1RH5N2PT36XgWR9R+3kK/jfC/xONTU
         qhMuXvuTQeN5c0CVrD9nCld1kbggAOKJzOmUxjwHoN45dZCmLnUSIHz3ZPMJxUosHCAp
         4o6GGqnGlHSpZ+95qhEjeuwnkex8dTNzWKsyvlVW3LW9vvso+nKhAsYZWrQpIouCXRmw
         c5aBMR60PyyhzkAy0JNO5BaHDufNVv8/s5l++e+fKM7CeoC66bmVMkLVMAclsu9HM3m0
         psmfRuIt/axHREOM72omXfAjtEwiwUykFy6jcJzVl5iEIf7U6Qv8WJvwNcPsG0YToR3Q
         jw/A==
X-Gm-Message-State: APjAAAUgsnFeFT6hf/1HmLRyKqh1yESV3IunD++UoJi0PsMGBSP1n4gZ
        2NsZrzQxLzPU4CjmqXbywa5dBg==
X-Google-Smtp-Source: APXvYqy2Dzm7GzoPse5AJO3QLfAlhdZzuRVcl2Nw1K9K3s4jsYzr0fCsPZ3qWNxk2IJIjm3cvdxKUw==
X-Received: by 2002:adf:c002:: with SMTP id z2mr7720149wre.177.1552908528320;
        Mon, 18 Mar 2019 04:28:48 -0700 (PDT)
Received: from apalos (ppp-94-64-206-130.home.otenet.gr. [94.64.206.130])
        by smtp.gmail.com with ESMTPSA id u4sm11311386wmb.25.2019.03.18.04.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 04:28:47 -0700 (PDT)
Date:   Mon, 18 Mar 2019 13:28:44 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Christian Neubert <christian.neubert.86@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Message-ID: <20190318112844.GA1708@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <874l85v8p6.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l85v8p6.fsf@FE-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory, 
> Hi Ilias,
>  
>  On jeu., mars 14 2019, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> 
> > Hello Christian,
> >> Hi,
> >> 
> >> I assume you use the 1000 MHz firmware. This does also not work on my Rev 7
> >> board. But I'm pretty sure this is not a problem of the patches, because if
> >> I take a newer kernel (4.19.20/27) without the patches it also does not
> >> work. A kernel 4.19.17 does work for me. My opinion on that is that this is
> >> another problem which does just occure now because now the cpu frequency
> >> scaling is working with the right frequencies.
> > I am not sure which firmware i am running, i did all my tests on 5.0.0 and
> > changing between governors worked fine without the patches
> 
> Curently my espressobin is broken so I tested the patches on the Armada
> 3700 DB and I didn't observe the issue you had.
> 
> The 3700 DB I used is configured to run at 800MHz.
> 
> Could you apply the following patch and sent me the boot log?
> 
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 26ed3c18a239..f814ade5cd80 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -452,14 +452,17 @@ static int clk_pm_cpu_set_parent(struct clk_hw *hw, u8 index)
>  
>         /* Set the parent clock for all the load level */
>         for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
> -               unsigned int reg, mask,  val,
> +               unsigned int reg, mask,  val, old,
>                         offset = ARMADA_37XX_NB_TBG_SEL_OFF;
>  
>                 armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
>  
>                 val = index << offset;
>                 mask = ARMADA_37XX_NB_TBG_SEL_MASK << offset;
> +               regmap_read(base, reg, &old);
>                 regmap_update_bits(base, reg, mask, val);
> +               pr_err("%s old=%X -> val=0x%X load_level=%d\n",
> +                      __func__, old,  val, load_level);
>         }
>         return 0;
>  }
> 
> 
> 
[   14.909524] clk_pm_cpu_set_parent old=28004840 -> val=0x6000000 load_level=0
[   14.916424] clk_pm_cpu_set_parent old=2E004840 -> val=0x600 load_level=1
[   14.923315] clk_pm_cpu_set_parent old=8880A8C0 -> val=0x6000000 load_level=2
[   14.930572] clk_pm_cpu_set_parent old=8E80A8C0 -> val=0x600 load_level=3


Let me know if you need anything else

Regards
/Ilias
