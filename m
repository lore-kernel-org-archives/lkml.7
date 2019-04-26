Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA6DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6EF2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556316467;
	bh=xSmoJfP98VuJlgf5DWzAH4lhHCQrHi/Kc3xKnpRTKWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jljsg2GFowKp0IGtDTB1yL0PLeMjfb1Cv+A/AaKYVK0ZLqPsGshd0lkkwL/JS2jEs
	 m3m0/0oLNV+6AISbzoVzYGz7buw8/yH3YtST14lQPdHgQyI/wOq9TItJPxLvPUuCRO
	 vCOiPNa4upnKYgrzI3dRisAxu19RKmO/BRoxsfrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfDZWHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:07:45 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:45228 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfDZWHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:07:45 -0400
Received: by mail-qt1-f174.google.com with SMTP id b3so5826826qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yPYRrG9s/7lAyx1N20LjlT8LSBeDr/iQP2GCwsC44PU=;
        b=HWwxhfPh72bjwxo192Lj8PzEwYJ6yi+l43DkTIDBJib94IOKjyLlQS9QIYVQupntZd
         2akJUC6oGuMJwBMmd3FDXWzGxFhSEkMYDr0gWj677gqsDajDLMcNyvPHvwOstPBc0Wpx
         d9YIh+w6bBRwI/rMA/A2Fqr5qCGoMtIchXNSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yPYRrG9s/7lAyx1N20LjlT8LSBeDr/iQP2GCwsC44PU=;
        b=YnK00o/Ly2xvKsubz8JNoi1ex07KJvAANpYicf9k9Pszp7214IkADbtspWJB/5fGcx
         BQFwOnrP/cRAmfb0iY1hfPn6gIdYnNr4OdWLYrd3c/FGPiBWR/GzyLPUiODBoMLB04zA
         4XXzkLs6Go8AYO0QirGOc38dw9F9OLptaq6EjHlY6geTTtqeHkM/H5mI6sBB9GgaMit0
         nlSbxtfgzlvpR+VvwaaxdESbNjsLMbb2WVyhOMy02Y7vR3HKKegeMDLedDSkUH8secME
         s2H+CNgi6UV8/Nlf8NgyhvuGsDVqWVVaH2pXd9X17F02p59WWPY1zoP3OAFeEWvkZ1Go
         iwKA==
X-Gm-Message-State: APjAAAVnUH90sqQJx7Htm+nMOFyzNG2L1xMPD9jlMrvvFqIgrbCo28UI
        a29bxZ9qct5bF9G/hx4PtYNhSQ==
X-Google-Smtp-Source: APXvYqzcJVA2IYIotl5LAERuj0g7ZYmdPpxqCKJwS3LfRJsl2JJuBYb2qauqTAO79r2YhEGIJHVa+A==
X-Received: by 2002:a0c:b5ef:: with SMTP id o47mr4782932qvf.142.1556316464494;
        Fri, 26 Apr 2019 15:07:44 -0700 (PDT)
Received: from chatter.i7.local (192-0-231-225.cpe.teksavvy.com. [192.0.231.225])
        by smtp.gmail.com with ESMTPSA id q125sm9046190qka.32.2019.04.26.15.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 15:07:44 -0700 (PDT)
Date:   Fri, 26 Apr 2019 18:07:42 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/10] arm64: unbreak DYNAMIC_DEBUG=y build with clang
Message-ID: <20190426220742.GA30708@chatter.i7.local>
References: <20190426130015.GA12483@archlinux-i9>
 <20190426190603.5982-1-linux@rasmusvillemoes.dk>
 <88270f30-fa5d-5bc5-931c-dc643ca8acc5@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <88270f30-fa5d-5bc5-931c-dc643ca8acc5@rasmusvillemoes.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:27:46PM +0200, Rasmus Villemoes wrote:
>On 26/04/2019 21.06, Rasmus Villemoes wrote:
>
>> Andrew, please apply and/or fold into 9/10.
>
>Hm, I'm getting bounces for Andrew's email address:
>
>                   The mail system
>
><akpm@mail.linuxfoundation.org>: host 172.17.192.39[172.17.192.39] said: 550
>    5.1.1 <akpm@mail.linuxfoundation.org>: Recipient address rejected: User
>    unknown in local recipient table (in reply to RCPT TO command)
>
>I think these fixups need to go through his tree as well. Any ideas
>what's going on?

OK, I see these, too. We'll fix it up, but the important bit here is 
that Andrew *is* getting all mail you send to his address. The bounces 
are from a secondary system that's supposed to have been removed from 
the forwarding destinations, but somehow is still getting copies of his 
mail.

-K
