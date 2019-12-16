Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1955C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8820A20726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vU2NvP/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLPFOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 00:14:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40774 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfLPFOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 00:14:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so2968422pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 21:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4tAJsQUYEH96QRekobXV8hZQE4YeKw/mZfBdVHuGi8Y=;
        b=vU2NvP/+ImU/+phWf6dm2B4B+y40+UqBMir5Sh0FtMyYKIrsC+cfe71kjekqouYf+Y
         EWFRtOadzJU4nj1tuIs84faGk80kJVpc67RvKb85hIRKc3RjsKzQIwMu/inAvJ3GIDKv
         Vlaavj9NwPX3PVEb9oO6axB4WGpzkYljw6SHFGTN5lOZ+cJWHnPNGzb+E0AQ2A9dfsFL
         97/vs13xxmYL0jzX2g8P4D4zSHvjH/M+FbPUQyGXEYix0mLUMPI2wVZ05qT92BI/xDir
         E5V0NHekfgqZ3Vo1Ak2FLhMo8moE0OkiZB08l5RHuPE3AH9GwvBbBWrlNcQovONqP6Q8
         WjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4tAJsQUYEH96QRekobXV8hZQE4YeKw/mZfBdVHuGi8Y=;
        b=nJNHAhKO2C/hWzyZhEtMgkA4W4u9WQq3/5UdkaBtFOfYPBE9emb6uCaZiw3otBN2ap
         0a0v9lzmG+H2qDEpSgRs300sb1d11T/0ndwE4C6wdl9EXkw7Q1cPaNN3FemWZTj5ksg7
         bznpepGH9e25neP+GrdpBYWJ79pW3VIL6YaIYTfTBwk4HTjOrdMrfV79Fa1nzZLu634V
         lD/PPya7xH+Hj6yZlpuPEJIWk2qtlfvWEvlJS9LdiLZdUXmDJnk7wy/9+2DSYlRjQj/j
         YKEPnVPa+SdLtu8hZn1rTrIhwdrkFaMqWI6rcbnpbsy2ATEpTX/KdNUZSXtDzUCvcG7U
         dD4A==
X-Gm-Message-State: APjAAAUnZOrR3G+ASTlckJO4NMPLqJSPK5wsHjPogfzGfw7AcR76h8iB
        SyE6+XZfG/n2u9zLkdINTJY4zQ==
X-Google-Smtp-Source: APXvYqzC5De4BPX/MiHF9SP05W5ga/3NbLK9xx+Hd08yHPq3qnxcx6z19dLTZJYraPd/Ky7SSiEDCA==
X-Received: by 2002:a62:3784:: with SMTP id e126mr14101294pfa.228.1576473270160;
        Sun, 15 Dec 2019 21:14:30 -0800 (PST)
Received: from localhost ([122.171.234.168])
        by smtp.gmail.com with ESMTPSA id m3sm19486667pgp.32.2019.12.15.21.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 21:14:28 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:44:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: Free static OPPs on errors while adding them
Message-ID: <20191216051426.pizsckvvgx7qxmpc@vireshk-i7>
References: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
 <20191129022706.rargieilar3dq3pg@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129022706.rargieilar3dq3pg@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-11-19, 07:57, Viresh Kumar wrote:
> On 18-11-19, 16:32, Viresh Kumar wrote:
> > The static OPPs aren't getting freed properly, if errors occur while
> > adding them. Fix that by calling _put_opp_list_kref() and putting their
> > reference on failures.
> > 
> > Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Stephen: Any inputs here on this series ?

Last ping before I queue them up :)

-- 
viresh
