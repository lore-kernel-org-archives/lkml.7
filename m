Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685A5C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B4920989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBSWmYZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEIPJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:09:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47018 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfEIPJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:09:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id k18so1798840lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kWAKK8WP4FdUrwf2u9IYb4uPnmyQHm6cwqnEBOHfHJY=;
        b=sBSWmYZWoM+6BpSnJ4geqHG3oHG1h6SunhGuXmjafljNOOSMrfsfJBAcXMhY1jimSO
         oOftSpC7Ul4LNSuJp/nsrU88fQ82yCaBe6uJynIjcchhOjfwo7CoHpCkdsO7LYWsWalJ
         v3tVWR8uuryZLmqVklUMK1dthEMNi55+oeUd8FjT53ybLy3uHYgLWA3oz0FOWxeMPWMM
         Ii52AvZWyTZXgWUS20+RXGR5HSTtQbe9Ko0pwasdYa2kcN1s7miZy4ayuHgTZnAkJL2M
         G5xg9Ytmx276Aa3MGW1qQGsAtwNsoaidDuqtewiuFnwHBqy9ZQ/wm6miLEionQWY5jOO
         SNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWAKK8WP4FdUrwf2u9IYb4uPnmyQHm6cwqnEBOHfHJY=;
        b=JK/vlk5jEKaSd/lLzlW3hu+LAiddnFWd41DbYa1siJZOhpAeoSPIctcbxMJCNK6eXE
         ftEWwkOoEwm1FirAg8vFp69lDiQhWl9FdZcxuK364PjL8+2Ivp+T0rhjm3I7qNu0w9Qm
         q9pj7Ny3P96VkQYgUnNZtfHm0lgrU+bjEnyge67fzZ39EXpPpZJMvC1GHOFyaA23YQ51
         QFp+unU/s+ktRC2iwAETsdhMqmCcP4Vjy1/fgpG5Ldn7PstrabHOCSKZz2fdz1Swjv9n
         5pX5t9He/Lg/F5umb0jqgoGkbUEDc13Kb0YccjYx0zVxHTuEKqeYQu38iMEA1s7VymCP
         PO7w==
X-Gm-Message-State: APjAAAW226lIQaKVvtW6zv0gXFcVv7X5tn14V5uzUKoa8njHHVcpmZOK
        p7jenkkhE65PEqIMrPAk2P8HChJu
X-Google-Smtp-Source: APXvYqzUG1kOTtAno/F8AbgnmfjezoT9TuQUrKWwA/13jdCCEPkg7oLNdfLEn3aDW7pxIryJkxCIeQ==
X-Received: by 2002:a19:196:: with SMTP id 144mr2978471lfb.35.1557414572716;
        Thu, 09 May 2019 08:09:32 -0700 (PDT)
Received: from mail-personal.localdomain (v902-597.aalto.fi. [130.233.10.104])
        by smtp.gmail.com with ESMTPSA id z4sm393048ljz.16.2019.05.09.08.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 08:09:31 -0700 (PDT)
Received: by mail-personal.localdomain (Postfix, from userid 1000)
        id 20C17602FC; Thu,  9 May 2019 18:09:29 +0300 (EEST)
Date:   Thu, 9 May 2019 18:09:29 +0300
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] rslib: RS decoder is severely broken
Message-ID: <20190509150929.GA309@mail-personal>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
 <alpine.DEB.2.21.1904041322160.1685@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904041322160.1685@nanos.tec.linutronix.de>
X-PGP-Key: https://keys.gnupg.net/pks/lookup?op=vindex&search=ferdinand.blomqvist%40gmail.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-04 13:24:05, Thomas Gleixner wrote:
>Ferdinand,
>
>On Sat, 30 Mar 2019, Ferdinand Blomqvist wrote:
>
>Thanks for providing that! I'm short of cycles to go through that right
>now, but will do in the foreseeable future. Feel free to remind me if I
>don't do so within two weeks.
>
>Thanks,
>
>	tglx
>

A gentle reminder.

-- 
Ferdinand Blomqvist
ferdinand.blomqvist[at]gmail.com
GPG key: 9EFB 7A2C 0432 4EC5 32BA FA61 CFE9 4164 93E8 B9E4
