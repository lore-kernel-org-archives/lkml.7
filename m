Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A7C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36E220705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEpDwj3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAHHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:33:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43309 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgAHHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:33:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id x6so1161223pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 23:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UqnEPALWHzZA1XyArIe54gSIpTfBlxJBhMMEH98tgUE=;
        b=UEpDwj3j2VI8L9aqT88S/h054nZlI+rPpR+RVksa4qB0/BkrDmo7PWRnGBnfMVpPAG
         0QgCFIB3H6aVWAN4MsySPOgKSPLx69qB6rr0Sb8m5YITjqWhWlntgj01rWc6AcFigyJB
         PZgQBRl3HLdR/QIpfDLhqbXF5J+6hC9Ck7L/qTqyz1HEW+Y59yG8NNx9/vVsu2GzwO99
         iOpCyt8jszQJI+8L/YjaEhFRh2izKxZYgJaERCP2dZbduV5jh/8jIjHKqloD9pfoAOH5
         mlyEgoognJTOGCQv8wLeclE6DYnk2zdS2leE9rT1jOe5jRJet78D8wjlHKlGrCPIgtuv
         wt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UqnEPALWHzZA1XyArIe54gSIpTfBlxJBhMMEH98tgUE=;
        b=Q1T4Y50t7NYG4q/wfwfjKrf0MpMk8IrW5R7IZ5ILxKKcITkM1Tvy0dPFY+EE8kab5H
         38nr92ZTcSW2FiiBdLGPg+Dhe8Cxwr8HChHpiaP17DhYpg97fgmPGjumKnBFo/SS/6Ys
         fKSLeoO+glOlKa9038PdKiZaKvPT+tNuF689BMv9KHLs+Q3+EWse3k9SF6ya9Fb7Q7Xj
         5WBJXGm4Gdgk37EjvwTBPgLI+6mP8dP16+ScSuAq4C4atR6o2CS3GiaPoTWKwue66/eY
         hA/FELYl/tMIKEw69yDr7uzmb3xhdVBjFqVGddZ5jO58x03CBUJ4Z5U+OvkcaEN37T8W
         BqPw==
X-Gm-Message-State: APjAAAXNGxNFo+9fcSOGTJKST0nUjmwjm+PyuOLkk9ukQMc0TexM1PDa
        cUXbJ0+RLSN+PDUJQex03CfirA==
X-Google-Smtp-Source: APXvYqxwVBPZqqbgaYvff2juBz4dLlvAIoJIWaijz/+a7wJ8MfYjW2y6dqFWKfa03fsQ9NmnU2HUZA==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr3530292pfp.97.1578468822078;
        Tue, 07 Jan 2020 23:33:42 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id s1sm2169870pgv.87.2020.01.07.23.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 23:33:41 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:03:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200108073338.4z6gktglduigfo5p@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107063616.a3qpepc46viejxhw@vireshk-i7>
 <20200107140449.GB20159@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107140449.GB20159@qmqm.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-20, 15:04, Michał Mirosław wrote:
> On Tue, Jan 07, 2020 at 12:06:16PM +0530, Viresh Kumar wrote:
> > Discard my earlier reply, it wasn't accurate/correct.
> > 
> > On 03-01-20, 20:36, Michał Mirosław wrote:
> > > When parsing OPP v2 table, unsupported entries return NULL from
> > > _opp_add_static_v2().
> > 
> > Right, as we don't want parsing to fail here.
> > 
> > > In this case node reference is leaked.
> > 
> > Why do you think so ?
> 
> for_each_available_child_of_node() returns nodes with refcount
> increased

I believe it also drops the refcount of the previous node everytime the loop
goes to the next element. Else we would be required do that from within that
loop itself, isn't it ?

-- 
viresh
