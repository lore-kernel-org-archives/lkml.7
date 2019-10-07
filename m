Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40547C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C6E206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570472850;
	bh=HbWmyAFnL1zqCg9rjyqJLwcFpHiCKTjpswDdNUpzodY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WSgHyeSsd/uCBHChXnAcFw96X0inXqmPqITM3uw+rSHUMO7YoarY0z/wcw/2ify3+
	 zLRsQQAnDonta/GiNfKsZSTuYNpPTw33qUzbgy3kX37Z1GVeklOt3OWHAuVPkkUj8Z
	 bRKrbgfJvyonJjiynhsTlD+RRq4uEEV8mZ07LOwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfJGS13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:27:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34515 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJGS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:27:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so635324wmc.1;
        Mon, 07 Oct 2019 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=suz6k0HPLihLeFdDPNbxBchocJGneApTO5mqjNjL2R4=;
        b=LuS2AmkinUUjO5mhUkNRYmLH2YnfROHoYRESsXkFY9kK1pFfutlWOBlOIwl/YuWQ0Z
         0rVIHfaYGfhd2eFC84wE4XyF5dTvIvMdOptF4VVd+DJVEbrTZaBwedxsZWjTl9DKze81
         KMv/vQ04FeMc4zz03tLmN82tu8PVR8AlOa/cuzXIpbOlNU7q57lTPZJpCaTUooW6ketp
         oau4/nV3UUSBc2CyDfnJRUKWY7lcwlToez93xXNx6wMvbEaGLivks0SOOGhZ4EHnby00
         yxwSg/ezSxQGqU6sAGQ5nVocPp1TUYnd5rnOl3IH1+7+FSO7yBU7WKC/QbaRAq5NISRI
         GbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=suz6k0HPLihLeFdDPNbxBchocJGneApTO5mqjNjL2R4=;
        b=pdE6nZ6qBPY6y+czxRiAWJqOgl/Q4W73uX106CPB6vPwEuYBkJJyIWACx734IIK9ec
         JI2pT1tba6Bz3KvYON9fb42g0MTCE4UedEGrdIEqR4EwEvLgztU9EwvXF6RUwWyBjA3Q
         ub0Ii8EnPALOEHk3w3WshoR3trnF4/hy/24iqmo5jc+75JV6orLJ79E6bjjGJMnJnvul
         H+d8PN5g4yCHA2V2c0mLmtpCKRZIpx8v+iAPfzCd1M4AIZfUTzkwZ73+M6gauRSb2SAN
         Tbi1mC+T/34puYHcS2G9WobHiU+ksXU/hqtomEr5L/Q3pSUrSCBtWjlMibk0Zi31sjgw
         Nr8g==
X-Gm-Message-State: APjAAAWLQ9DxApe8M++AB4oPslRx2fSbSCwyJYz33RmOSrtJYLZbOaNN
        j8sjrajtWFYWl9I1PZGjr4H99wBp
X-Google-Smtp-Source: APXvYqwbM/g8QlwLv9TiPwD+XX1XXfkrQjAfz4sDBARTvrZYtTGBRsDQKTcB+W+P7Kv2jvVHdVAeRQ==
X-Received: by 2002:a7b:c8d9:: with SMTP id f25mr405652wml.173.1570472846221;
        Mon, 07 Oct 2019 11:27:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g17sm7927581wrq.58.2019.10.07.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 11:27:25 -0700 (PDT)
Date:   Mon, 7 Oct 2019 20:27:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        jailhouse-dev@googlegroups.com
Subject: Re: [tip: x86/platform] x86/jailhouse: Enable platform UARTs only if
 available
Message-ID: <20191007182723.GB97660@gmail.com>
References: <20191007123819.161432-3-ralf.ramsauer@oth-regensburg.de>
 <157047270440.9978.1646295335019419258.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157047270440.9978.1646295335019419258.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Ralf Ramsauer <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/platform branch of tip:
> 
> Commit-ID:     dac59f1eb78123c3f0e497eb9870ac550c59debb
> Gitweb:        https://git.kernel.org/tip/dac59f1eb78123c3f0e497eb9870ac550c59debb
> Author:        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> AuthorDate:    Mon, 07 Oct 2019 14:38:19 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Mon, 07 Oct 2019 17:35:56 +02:00
> 
> x86/jailhouse: Enable platform UARTs only if available

Never mind this commit notification - I pulled the two commits for the 
time being, until Boris's feedback is addressed.

Thanks,

	Ingo
