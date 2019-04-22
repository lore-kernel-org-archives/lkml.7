Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA66C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787CC20643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVAxXE6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfDVWa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:30:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33163 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbfDVWa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:30:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so6467947plo.0;
        Mon, 22 Apr 2019 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WhAlP1eCA3LwUEi7doooT5TYQHLk3Z+itBK1UMBvBGI=;
        b=eVAxXE6XXj/yhBO71VMe75lpPLztNR841zQf0v3bAsY3BHLiQbMHNZhJJUHfw2IA2e
         FtT2+s/CyChDK8JbK138ld4CCrTUhs10mFY7X7ceaeMjyD+Rb37sjSdxIqqUKtAa+1EJ
         3QhOBCCnFpoy+jAToCJW20sQMc+ru2XryCx4zMKF6R7ygj0R5qYYhsv75QLE6f4fleZH
         w+qLo5fvngk3yCjBC/uANERLsTxqkaqlYRihtrxxS6qU4iI7eokSTqQTrp0htsGjqqnW
         3xT5PPcnI6S4ra9JDTwOuav+RXM764xoeuckmrJ9nbzjnr4XrbS4kkLCsb845+taUymf
         8ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WhAlP1eCA3LwUEi7doooT5TYQHLk3Z+itBK1UMBvBGI=;
        b=BK0xpGxxpFCcNR3qSNx8BgjetTdyr+Y838/7sbEMlxVglfS97kb6W5v5oMclMf75uy
         Mk/8O/fxkiDuiFODut8kRmSZyqXZXIHImarpgvnq5R+qNRUh0HnPGM36UP+IX01KjKhA
         fSOINAlt/xnKZ8Ey1WmgWlt2BtzZjE2h0ciY2ZKJ1kO9ckVNNkOY2qnr0oOKdpuXPtaD
         JCjCZK3nBdApiNNYBZBW0galcP0fQqcVGcMGGfHU2jrKlw2f68auUAQxDmDQu5GGfhKc
         oLQlWZUEa/qTzRFjhD4Wm6Y0cMzkWczasLGNwEOhGTZ/l+7H+AlMSFtfsY6s7tw78aJk
         ofGw==
X-Gm-Message-State: APjAAAX9xHY/rpwnErxE0FWfh5Ko0QKql54W9MNwgAwJeHhUHbpy/I29
        WzincN1Bbmw/P6CZL8fDbOM=
X-Google-Smtp-Source: APXvYqxlUWbbwwMYdPeVz0oVZfHX6yOCUKZd8LXtMi+Fk4bcgAiLDcNO21LPIOrwAsHqVM7EVbz9iA==
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr22044961plo.123.1555972256960;
        Mon, 22 Apr 2019 15:30:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7sm16859669pgn.64.2019.04.22.15.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 15:30:56 -0700 (PDT)
Date:   Mon, 22 Apr 2019 15:30:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] docs: hwmon: remove the extension from .rst files
Message-ID: <20190422223055.GA16975@roeck-us.net>
References: <1555670867.6277.10.camel@suse.de>
 <a0f328bb0cc822c704ca0eab1c4b10ff4b1fd1cb.1555931685.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f328bb0cc822c704ca0eab1c4b10ff4b1fd1cb.1555931685.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 08:14:55AM -0300, Mauro Carvalho Chehab wrote:
> On almost all places, we're including ReST files without the
> extension.
> 
> Let's remove the extension here	as well, in order to use just
> one standard.
> 
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
