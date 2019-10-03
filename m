Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4DAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84361222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOU+nmwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfJCAcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:32:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44554 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJCAcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:32:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so625238pll.11;
        Wed, 02 Oct 2019 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o1TIRlC1z/dl/LTUyWy/efSVnkwk6x9140U6Si01wU4=;
        b=dOU+nmwudhqoZvQLG9+J/ACujOqfUk6xUL5AzEnVQuqWbp+uM123MXBhtPC18N6vnk
         zHbYAUe7qgd3VYaXnN9En7sQ3VUN/JwBgCF2cyuYnP+oOph1ykKI0XpT4DmCBQh6HOvF
         gv4/XbXBOVxt4qp6y7IvkXaETrfp/iKPkBZERx6glyDRmak7hYGYi5l2hX4Mo1vNCJ6B
         BXUFdpYyCMPK1Hu6ABW9a4iONhxrs+4yz5nUYhYYOmhVG2dOPhz5JDABMLwWW9EEzEwl
         XxvMKHtFCgq0okpqBr6GmQfjWlqHllMnW51+rsSgH/PIEnHa/7k6O9DwTLUOXOdJXHHF
         uFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o1TIRlC1z/dl/LTUyWy/efSVnkwk6x9140U6Si01wU4=;
        b=YQqaMgqozIq6kdAYlLfR6V0ycCnz0EVa75N0UUHgkyBi7gMao7XLgnhCRo7aYFBktX
         QB5eTg/NBGe6q7ctjTkTMiNWU46eo6687c16NoA8s2ZPvpWFYF1oR0dagg6s97LPRWDO
         H0qjz3xjeufJl7NRgFXPFEKKC9yWQQ7/NYaX4VtEdXxfGl9rRhhebtczQ7E+tBSITGSJ
         O/yS916CQjSw6j75syZFe7tWD+2qsXTxKIchQb7Trjo7CLJay0AQzoJWiRXnAWIJe4ZX
         jBNx4dpWhCSKKrna8hbOr9+Ej9kjdfQ8+B6qQI1bZvE7JA2cawqOHCuAgmgCYS1ZC5Vj
         7Uhw==
X-Gm-Message-State: APjAAAWwfnqoiRwYTHsiym26IHCKPdNnSvg44jFrnXNUvBVEvRNgDv7g
        VFmekdmaONkWJM55tOd492Q=
X-Google-Smtp-Source: APXvYqz0eDbafq0+btZpCwrNr/sFyFbRHLDE5SbJKcjXrxXqm9Iqp6uSCnsFE777PX9L+AXUY4u8kg==
X-Received: by 2002:a17:902:b949:: with SMTP id h9mr6895255pls.35.1570062749891;
        Wed, 02 Oct 2019 17:32:29 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e184sm630163pfa.87.2019.10.02.17.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 17:32:29 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:32:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 00/14] software node: add support for reference
 properties
Message-ID: <20191003003227.GA246700@dtor-ws>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Sep 10, 2019 at 10:12:17PM -0700, Dmitry Torokhov wrote:
> These series implement "references" properties for software nodes as true
> properties, instead of managing them completely separately.
> 
> The first 10 patches are generic cleanups and consolidation and unification
> of the existing code; patch #11 implements PROPERTY_EMTRY_REF() and friends;
> patch #12 converts the user of references to the property syntax, and patch
> #13 removes the remains of references as entities that are managed
> separately.

Now that merge window is over could you please take a look at the
series?

Thanks!

-- 
Dmitry
