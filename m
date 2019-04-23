Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13516C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36A82064A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555997733;
	bh=B0c4hCWF6jhx2nJ93Ll5X9Ivt+7TePv4OxAc4VvWtgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PknORn/q7kIUd56pLkRhuDGvgEe61hg6H1B15aq7T2xbweCeA6UZdwCchOX3nXOXk
	 e3YUi7Y3g7MOh8P6Lhy04DueEqTPwATZWq1sUOpJf+jC1TRYJQpsc+bItiX6f2m2T8
	 /mSJcSJwwLjofWyzfal/5ZQJdq4FnXMAZW6c03Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfDWFfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 01:35:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46859 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWFfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 01:35:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so12260270ljk.13;
        Mon, 22 Apr 2019 22:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QVi/9LSy5Y/cJKsiDw7f7ZK3OmiFbzyQvjtoszT3fA=;
        b=q0DKJ7m3WY93vB+aIb4+mJSpOqaiG8H/GsiM+63e0ERIUg03asDaO1ID18FmzSqp8u
         QSZhv4iBLlH3IsWhO5g6GstiDaZnfxUVTNT2iu3G7pa2o7R0SSGTrxgHkVZcTocBOnYr
         pT/gXfqrWLQNS0ihggH4+e4chZ45prwKfYpr0MUZiKC7iUDWaRkB1vHP/OoAeWDUBwmB
         7oklGGNMAzAwT+OV39Uc7D18p28FuMbbCLSpMyySJF038x0lSa1PD4e9gpCO8ZA11RDF
         LoPlk37H0kVRxHC2F/xUokhriDHSQ8qDlDD37xYTNDk3CBbTHxW9FispSkol+5HsP5nV
         gUxA==
X-Gm-Message-State: APjAAAVkoC4Swvu7JpDERmjtefMOmbIpdpNm9Y2IWSyrgxfzL0B3m5qG
        wtv5v51joEodeR1tXoWN1OCWVawO
X-Google-Smtp-Source: APXvYqxYs5eua1o3Zq3+f+jfa/4K7cv5jxk+8GzuqsNYNDw0JNz/wFivZNnRa39lJLF8co3w4xU36Q==
X-Received: by 2002:a2e:9151:: with SMTP id q17mr12209166ljg.87.1555997730228;
        Mon, 22 Apr 2019 22:35:30 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d22sm3427225lfm.57.2019.04.22.22.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 22:35:28 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hIo5g-0007Qw-VR; Tue, 23 Apr 2019 07:35:37 +0200
Date:   Tue, 23 Apr 2019 07:35:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 4.14 35/43] tty: fix NULL pointer issue when
 tty_port ops is not set
Message-ID: <20190423053536.GF28269@localhost>
References: <20190422194727.12495-1-sashal@kernel.org>
 <20190422194727.12495-35-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422194727.12495-35-sashal@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Mon, Apr 22, 2019 at 03:47:19PM -0400, Sasha Levin wrote:
> From: Fabien Dessenne <fabien.dessenne@st.com>
> 
> [ Upstream commit f4e68d58cf2b20a581759bbc7228052534652673 ]
> 
> Unlike 'client_ops' which is initialized to 'default_client_ops', the
> port operations 'ops' may be left to NULL.
> Check the 'ops' value before checking the 'ops->x' value.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>

Despite the commit message, this one doesn't really fix anything and has
been reverted in Greg's tree (not sure why hasn't shown up in linux-next
yet).

Johan
