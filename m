Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF512C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E96D20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acEtyVqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407937AbfIXCsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:48:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36437 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389572AbfIXCsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:48:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so280583plr.3;
        Mon, 23 Sep 2019 19:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=deTOHyUuNbmlHO4aRp949wtOhcFU4gVUPh8sJQJUCQ4=;
        b=acEtyVqI1ptDNYGn6laviDUrBylL5GoPdDcuHygbZ+r0EG6dJgy3UhfejSjbj/MxY/
         pJo+0Pl8XVXXJsj7QoI6/Qng9qMCYChNMpBE5TfxDx8EMI29QMb1oOFKu75IjTwYNUA1
         GW9CIg+GUJAbOsi+aTfiA/a4NGmVsdPtl95NR6j0a3zMoa091keyiT2mQyvQyjIzawaT
         CErq+02tdfxO/i4eBlVu0q5HPQpSBDn98Ww9nDI8ztlF8C5w6fUPqtfDhvXNs2OXIO2r
         R9toIqwVwxXpPBXywaSEZhoOfbX/JM+pF+9/3x3Nh44napQ0D/vXSRvRstOt3bOQa0xA
         piWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=deTOHyUuNbmlHO4aRp949wtOhcFU4gVUPh8sJQJUCQ4=;
        b=NR67zeu3veXNKPsM5FNYxqNnvfK+dKTL/nfIvbcxdnCuQqA790T104qesxz7I12JWT
         pfp6nUPBeQl/QfZYNknMbIpaXgaJdldeK8CslFmnUORL2l1+uuupE0FQuUGJKf8JuJPW
         0bvaxIKNWXw1pJJ7IMpgmy/fmvk8lX/1ChTdXybSbDYDeKN4mu603ZVaG5Cfk5f0Swxk
         Cbkx8CnUfZqtqSXjlEPyPgMusW71ogK6phCLUZtgUVmpxZkUMkTGp38jXXjfDZ3ayyVe
         wEa5rSmj/b7nnals57jiIn9gKKk4Bn2yyyYBYXejAr3L7MPA6UEvmTYHTwiafGQiHjpq
         uLCQ==
X-Gm-Message-State: APjAAAW/oD1DeR3Nfd3unNHoZBRadz8kPMKqGThmoOBcVJhLTjIKIF9c
        WWZNWAm4UcWRaU7gv00GP3o=
X-Google-Smtp-Source: APXvYqwod2IWhSzAzWT7j2NclyNInJfApNQQnV0sqhYQNVBP35uINV509q2WmEDB4J1pRDnwm0n1fQ==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr442688plm.31.1569293309631;
        Mon, 23 Sep 2019 19:48:29 -0700 (PDT)
Received: from [10.230.28.130] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a17sm150278pfi.178.2019.09.23.19.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 19:48:28 -0700 (PDT)
Subject: Re: [PATCH V8 2/2] mailbox: introduce ARM SMC based mailbox
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1569287538-10854-1-git-send-email-peng.fan@nxp.com>
 <1569287538-10854-3-git-send-email-peng.fan@nxp.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1f01ea8e-8953-82ae-933c-721385dc0c13@gmail.com>
Date:   Mon, 23 Sep 2019 19:48:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569287538-10854-3-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 9/23/2019 6:14 PM, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This mailbox driver implements a mailbox which signals transmitted data
> via an ARM smc (secure monitor call) instruction. The mailbox receiver
> is implemented in firmware and can synchronously return data when it
> returns execution to the non-secure world again.
> An asynchronous receive path is not implemented.
> This allows the usage of a mailbox to trigger firmware actions on SoCs
> which either don't have a separate management processor or on which such
> a core is not available. A user of this mailbox could be the SCP
> interface.
> 
> Modified from Andre Przywara's v2 patch
> https://lore.kernel.org/patchwork/patch/812999/
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

[snip]

> +typedef unsigned long (smc_mbox_fn)(unsigned int, unsigned long,
> +				    unsigned long, unsigned long,
> +				    unsigned long, unsigned long,
> +				    unsigned long);
> +static smc_mbox_fn *invoke_smc_mbox_fn;

Sorry for spotting this so late, the only thing that concerns me here
with this singleton is if we happen to have both an arm,smc-mbox and
arm,hvc-mbox configured in the system, this would not work. I do not
believe this could be a functional use case, but we should probably
guard against that or better yet, move that into the arm_smc_chan_data
private structure?
-- 
Florian
