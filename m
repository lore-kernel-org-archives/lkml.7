Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39BAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 23:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979FB2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 23:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hXpzVm1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfCWXFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 19:05:16 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50838 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfCWXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 19:05:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 13D9CC5F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 23:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mV6ts7sjbL8Q for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 18:05:13 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id DA57EC94
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 18:05:13 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id k5so4918819ioh.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 16:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=M39f93VirdxFfyLDm8TGN4KkJ/D6OrYW6FNDPRdsoq0=;
        b=hXpzVm1Vi3IyECfEYqJqA6Jh9VcQozNkU1jZr+kp092yd6Ns2IXXKVeEe91QG5P/fg
         iSMr2lXfLUIpVYTaDXmtMjQ6FN8ZVNFpcI6jodySeRJ7EkEI8KYy9331IIH8ARcgn4Cz
         /KN1yIuYki1mUAS7ShgYShJg4aqX2bvLddKfR3iyY9rwe4XtuZyXPOpjR8xFpFUUErFm
         AUmx3e2Jcldre5yCi+lqn2hwr7jOStFbiFgTnP01PmMZFc1GDZgSSHNpVGp7EJXesvni
         JhkQdKTE1DF51EKTf3a0KxxOKCNRL5L6wvqeNVZBj0n9FZIKQ8HUeWIFQ4C5BGZaejqi
         fCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M39f93VirdxFfyLDm8TGN4KkJ/D6OrYW6FNDPRdsoq0=;
        b=qO0f+FCHkJ9bGpzHGsAltsB0t2pEZQG9iL2/t+U6wuXLlJCiDlBI5g9xS9WtWPNIOd
         Np49zTEmDhwebJUQUlrFIF+k1JvOH+EIPXImIo26stfpDsTCgFId4x2tUGj1GHuzBxap
         KiVMUXzilFk6+XWcr4qha3BuNcRGkADl8myjM0DKRXs4B3W1592GzyJNFHAZ0gyZNMdh
         tJjtB0MMuhvP56mKk0FD9Dmfv1AzJUAWScqTdyV/eLicwTp3t+ujVqm3yWXWaX89GNvt
         KZkDewpD/+zccKFJHNqc9+yOEcW/JBPmRy1ga5QSuR7EoaQWu4/AGDve731NUJ/lxfdd
         LkCA==
X-Gm-Message-State: APjAAAW7WPl7se9bRsoLcCGjIDxFRcvYhDZ8N3QjnG+41mGFB/2kLx8E
        0gKEu1g007NQWTkhCEQSB2D35d9p2xISTf0tKZXDxIIJNwqOF0HhrN4+SNI+PreN3Oe2dteeaww
        D/e3vaWIKpgUFdWMlxxZTseSqN+xM
X-Received: by 2002:a02:b803:: with SMTP id o3mr12901716jam.142.1553382313151;
        Sat, 23 Mar 2019 16:05:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxRy/RATdJeTz9tCvOFxVuUAjEUEeLwm6tRT6f7ZYtahGgx6CBMK0AcrW9go43TZC+ZCehUpw==
X-Received: by 2002:a02:b803:: with SMTP id o3mr12901704jam.142.1553382312986;
        Sat, 23 Mar 2019 16:05:12 -0700 (PDT)
Received: from [128.101.106.66] (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id j10sm3660065itj.32.2019.03.23.16.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 16:05:12 -0700 (PDT)
Subject: Re: [PATCH] sound: rt5645: fix a NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, 20190315034833.25037-1-kjlu@umn.edu
References: <20190315034833.25037-1-kjlu@umn.edu>
From:   Aditya Pakki <pakki001@umn.edu>
Message-ID: <aab4eea2-2d6e-1a16-5b2a-47ac5f75e642@umn.edu>
Date:   Sat, 23 Mar 2019 18:05:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315034833.25037-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/19 10:48 PM, Kangjie Lu wrote:
> devm_kcalloc() may fail and return NULL. The fix returns ENOMEM
> in case it fails to avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  sound/soc/codecs/rt5645.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 9a0751978090..f842775dbf2c 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3419,6 +3419,9 @@ static int rt5645_probe(struct snd_soc_component *component)
>  		RT5645_HWEQ_NUM, sizeof(struct rt5645_eq_param_s),
>  		GFP_KERNEL);
>  
> +	if (!rt5645->eq_param)
> +		return -ENOMEM;
> +
>  	return 0;
>  }
>  


Friendly reminder, could someone review this patch ?

