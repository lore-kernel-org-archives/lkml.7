Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE9C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 05:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9706220869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 05:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw2scfNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfDUFn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 01:43:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36819 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfDUFn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 01:43:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so4360911plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 22:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vf9ZzTVGOZz/x/u6WwRzdjPAr0AAJXLHnSaULvX/H/w=;
        b=Lw2scfNo0pCLDnHe5tKXI1aDx1dZBT/8nWeqC51fPd20ooRM+ZfjnszD4D/nYW7qSk
         0LpDxFryk6cwbS+Q32nl4Af42GqFAkTGySqiSOskY9GAviCBk+icX3wzVH9xpVY/eu1l
         hYRITCuzQjo02Fld1Cgc0ZB90ItGXdVksFYCSzyO/K26Z9CEDL3nnS0jv2cMuY56G9sR
         gDPuG40RHiFBEF6tKCWtZ35NgdmsyU6AbVMb45gbBILuggu4rWJ8i05YaiBIgHtPbzl3
         roHL5VU5HxAJbcdA0xGH75qrE7ffR5u1LskYviPH4PG63AuP9lMON24OXolIK4XCqBbN
         NMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vf9ZzTVGOZz/x/u6WwRzdjPAr0AAJXLHnSaULvX/H/w=;
        b=pQOaxG4KjEPEEwN3SfrMB2Y5W/ObUA+TdN2HMKcw3rr/cJ0HvXOOVkpB34yQVylrd3
         KBjwqwKWi287OpXidME/ZX3Dsw0OoRlUpqHT2fNYSh+aJCF5g1deItPNRLfE0EWlMxkF
         dNk7xZoxZ1Rc5d7VDZmlhO9B2X6miJDXFr5/4i18ndC7KPX/JazuKMmJIzGk4m4xy5pY
         edDhDMLtgG4rLBVIo1mzGqIbbPkELDXZFapDWM5Glq6BnNJnk8BctvxOVMHrr2cSn2xO
         P5GpguczesQF0GApaoYV+/WZ1gNLct/piwm0ws01Pdw36R6AnVOf5+2rS+Gp2znlrwjW
         BLhQ==
X-Gm-Message-State: APjAAAUOxibxyiX5Y9dJ9x2mYXuuwNRHO3EINxqlWuj4RsojLnkCD8uX
        leOPAGRgUk9m68NiEIJGKL4=
X-Google-Smtp-Source: APXvYqycOfv25+7ZxLuykBETWy3HEdjzEHq93wNZ6mycPKFc0cEIlLQ9t0k9gcZp9nUbTt7WXyaEpw==
X-Received: by 2002:a17:902:70ca:: with SMTP id l10mr4608591plt.228.1555825435519;
        Sat, 20 Apr 2019 22:43:55 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r87sm15461428pfa.71.2019.04.20.22.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 22:43:55 -0700 (PDT)
Date:   Sat, 20 Apr 2019 22:43:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl: sai: Add support for runtime pm
Message-ID: <20190421054352.GB683@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420155846.10027-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 03:59:04PM +0000, Daniel Baluta wrote:
> @@ -898,6 +899,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sai);
>  
> +	pm_runtime_enable(&pdev->dev);

You will need pm_runtime_disable() somewhere, like remove().

Thanks
