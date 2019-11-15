Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64BFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAE32073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573829748;
	bh=l0ZDBUgWfmbcMnGvDCZ7zH6V+/efe8Ys3R4uJ25UugQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nr1i20cO9XiL7m5Wpau7iJ47ZVvBr1cwixR9Rp4lF4uwVUXaZL++mBdInLw32PXlW
	 Aa9BxqEqQ/HKB1N4G2t8oVvgxhR9IzOamil5kqhp/KxyQqwiSmV8Cg4G4GfX2wghgQ
	 mBoctRXDNuDz4A7nstQfe53wgYyZYpm0FrBQ/eOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfKOOzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:55:47 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:36396 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfKOOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:55:45 -0500
Received: by mail-qk1-f180.google.com with SMTP id d13so8300374qko.3;
        Fri, 15 Nov 2019 06:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zw8wOIY8mNW318y4fP6Jxq3gT3vqgJzWHMf4m4vqBkE=;
        b=LOwhHWT22OBlnSHpiAikAbBxvHi30RL+IBBMK3PZmWUq7XqPuvbKJEfQy7BEfPpdlv
         PDNIAjAA4N3FXDU8H58bSN56ATiyHLx4x8buRO+Hxlba3zpFVM2r4JpDGyuTGGGwi7aF
         FYRhIQMJkwzlYGlsYp/gg7t5RbyFY5War7OLnNH1qNaMHu47Q4FY0jB8nkU2JFHldK5K
         wq7+4tF720mjj22BlYNKBQe2Ofr4DGbLwH9EOy+rZqbjGNnlS1GSHHQT6vC8l0T12R6K
         26UFB0OGwj7m2Qzbvc6mS9htstuHMHdO2zhxhXzalpDma/QrGMslY9aCcRvKcNMt3Zqe
         07jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zw8wOIY8mNW318y4fP6Jxq3gT3vqgJzWHMf4m4vqBkE=;
        b=RUUxbGFXbNFFj48zH9Evgt4FKMJDeQ6g4h3PFC5N4ddgOO3LrHkxS1cD8Oyei+Gk2g
         7RTpX1pbswuDcB2bakhrerlm3TzSTiW43ueVsyRfGMNX3S62gvxz1Uveqkqo9IDMsI4+
         KlqKxaosMf0jOmWdqhcN5y60YYHVJ5s9IKveeDMdo9T5+VUQegqaEXlz5Ed3nqIuJInr
         XBcbV0DlghSCt/EM8z38Sn7VQzQv1fVnIO8F1H/jEqYCAwEucXukSf4+g+Tt6M4kiy1/
         CGylo0K91ZxCNusd4BNW6Lg9No7LiWMnbVMraAqj5wHN7JUvEauUImdqlDH3fnzD5Zr7
         LhNg==
X-Gm-Message-State: APjAAAV66JQsPZ7KgDkaYTa8pk9y7WgbnFIrdss86EUkiLjssH/ciF/6
        rlquKT0gIQTq7c9kGUY9pe4=
X-Google-Smtp-Source: APXvYqxvfDd/08vHSWuxUchxI2A1mnqwQYu5s1Qznz+IFc0+uV97tWZVqNkpauwAZaGlYwqT4+Gzvw==
X-Received: by 2002:a37:8d7:: with SMTP id 206mr12815144qki.238.1573829744197;
        Fri, 15 Nov 2019 06:55:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::4ef1])
        by smtp.gmail.com with ESMTPSA id j7sm4157196qkd.46.2019.11.15.06.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:55:43 -0800 (PST)
Date:   Fri, 15 Nov 2019 06:55:40 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
Message-ID: <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
 <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 07:26:21PM -0500, Qian Cai wrote:
> 
> 
> > On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> 
> Tejun, suppose you will take this patch via your tree together with the series or should I Cc Andrew who normally handle this file?

Patches in this area usually goes through Jens's block tree.

Thanks.

-- 
tejun
